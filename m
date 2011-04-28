From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 08:27:17 +0200
Message-ID: <20110428062717.GA952@elte.hu>
References: <20110427225114.GA16765@elte.hu>
 <7voc3r5kzn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 08:31:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFKkY-0001D7-Fv
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 08:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753963Ab1D1Gat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 02:30:49 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:36029 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753876Ab1D1Gas (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 02:30:48 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1QFKh8-0003qa-5k
	from <mingo@elte.hu>; Thu, 28 Apr 2011 08:27:24 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id EC8DD3E250F; Thu, 28 Apr 2011 08:27:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7voc3r5kzn.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx2.mail.elte.hu: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.3.1
	-2.0 BAYES_00               BODY: Bayes spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172318>


* Junio C Hamano <gitster@pobox.com> wrote:

> Ingo Molnar <mingo@elte.hu> writes:
> 
> > +static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
> >  {
> > -	return !memcmp(sha1, null_sha1, 20);
> > +	int i;
> > +
> > +	for (i = 0; i < 20; i++, sha1++, sha2++) {
> > +		if (*sha1 != *sha2) {
> > +			if (*sha1 < *sha2)
> > +				return -1;
> > +			return +1;
> > +		}
> > +	}
> > +
> > +	return 0;
> 
> This is very unfortunate, as it is so trivially correct and we shouldn't
> have to do it.  If the compiler does not use a good inlined memcmp(), this
> patch may fly, but I fear it may hurt other compilers, no?

Well, i used a very fresh GCC version:

  gcc version 4.6.0 20110419 (Red Hat 4.6.0-5) (GCC)

And used a relatively fresh CPU as well. So given how compiler and CPU versions 
trickle down to users and how long they live there Git will live with this 
combination for years to come.

Secondly, the combined speedup of the cached case with my two patches appears 
to be more than 30% on my testbox so it's a very nifty win from two relatively 
simple changes.

Should a compiler ever turn this into suboptimal code again we can revisit the 
issue once more - it's not like we *can* keep the compiler from messing up the 
assembly output! :-) ...

> > +static inline int is_null_sha1(const unsigned char *sha1)
> >  {
> > -	return memcmp(sha1, sha2, 20);
> > +	const unsigned long long *sha1_64 = (void *)sha1;
> > +	const unsigned int *sha1_32 = (void *)sha1;
> 
> Can everybody do unaligned accesses just fine?

I have added some quick debug code and none of the sha1 pointers (in my 
admittedly very limited) testing showed misaligned pointers on 64-bit systems.

On 32-bit systems the pointer might be 32-bit aligned only - the patch below 
implements the function 32-bit comparisons.

But is_null_sha1() is not called that often in the tests i've done so we could 
keep it untouched as well.

Thanks,

	Ingo

diff --git a/cache.h b/cache.h
index 2674f4c..427ad5a 100644
--- a/cache.h
+++ b/cache.h
@@ -675,14 +675,32 @@ extern char *sha1_pack_name(const unsigned char *sha1);
 extern char *sha1_pack_index_name(const unsigned char *sha1);
 extern const char *find_unique_abbrev(const unsigned char *sha1, int);
 extern const unsigned char null_sha1[20];
-static inline int is_null_sha1(const unsigned char *sha1)
+
+static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
 {
-	return !memcmp(sha1, null_sha1, 20);
+	int i;
+
+	for (i = 0; i < 20; i++, sha1++, sha2++) {
+		if (*sha1 != *sha2) {
+			if (*sha1 < *sha2)
+				return -1;
+			return +1;
+		}
+	}
+
+	return 0;
 }
-static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
+
+static inline int is_null_sha1(const unsigned char *sha1)
 {
-	return memcmp(sha1, sha2, 20);
+	const unsigned int *sha1_32 = (void *)sha1;
+
+	if (sha1_32[0] || sha1_32[1] || sha1_32[2] || sha1_32[3] || sha1_32[4])
+		return 0;
+
+	return 1;
 }
+
 static inline void hashcpy(unsigned char *sha_dst, const unsigned char *sha_src)
 {
 	memcpy(sha_dst, sha_src, 20);
