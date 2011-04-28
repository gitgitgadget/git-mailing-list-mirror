From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 12:19:02 +0200
Message-ID: <20110428101902.GA17257@elte.hu>
References: <20110427225114.GA16765@elte.hu>
 <7voc3r5kzn.fsf@alter.siamese.dyndns.org>
 <20110428062717.GA952@elte.hu>
 <BANLkTik_2sHZ0OTgQeHpRnpmNsAmT=sAcA@mail.gmail.com>
 <20110428093703.GB15349@elte.hu>
 <BANLkTim+Kk_ah_4+pQKCi8bXtA8thRVRjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 12:19:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFOKB-0003CM-Pn
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 12:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757536Ab1D1KTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 06:19:50 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:39049 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750817Ab1D1KTu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 06:19:50 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1QFOJN-0000MI-LX
	from <mingo@elte.hu>; Thu, 28 Apr 2011 12:19:11 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 5DFDB3E250D; Thu, 28 Apr 2011 12:18:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTim+Kk_ah_4+pQKCi8bXtA8thRVRjQ@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172346>


* Erik Faye-Lund <kusmabite@gmail.com> wrote:

> 2011/4/28 Ingo Molnar <mingo@elte.hu>:
> >
> > * Erik Faye-Lund <kusmabite@gmail.com> wrote:
> >
> >> > Secondly, the combined speedup of the cached case with my two patches
> >> > appears to be more than 30% on my testbox so it's a very nifty win from two
> >> > relatively simple changes.
> >>
> >> That speed-up was on ONE test vector, no? There are a lot of other uses of
> >> hash-comparisons in Git, did you measure those?
> >
> > I picked this hash function because it showed up in the profile (see the
> > profile i posted). There's one other hash that mattered as well in the profile,
> > see the lookup_object() patch i sent yesterday.
> 
> My point was that the 30% improvement was in "git gc", which is not
> the only important use-case. How does this affect other git commands?

In a followup mail i measured git fsck, which showed a speedup too. (despite 
being mostly dependent on external libraries to do most of the processing)

If you'd like to see other things tested please suggest a testcase that you 
think uses these hashes extensively, i don't really know what the slowest (and 
affected) Git commands are - git gc is the one *i* notice as being pretty slow 
(for good reasons).

> >> from the exception handler, others doesn't. So this patch is pretty much
> >> guaranteed to cause a crash in some setups.
> >
> > If unsigned char arrays are allocated unaligned then that's another bug i
> > suspect that should be fixed.
> 
> We can't. The compiler decides the alignment of variables on the stack. Some 
> compilers / compiler-setting pairs might align char-arrays, while others 
> might not.

Even if that were true it can be solved: you'd need to declare the sha1 not as 
a char array but as a u32 * array or so. We do have control over the alignment 
of data structures, obviously.

> > Unaligned access on x86 is not free either - there's cycle penalties.
> >
> > Alas, i have not seen these sha1 hash buffers being allocated unaligned (in 
> > my very limited testing). In which spots are they allocated unaligned?
> 
> Like I said above, it can happen when allocated on the stack. But it can also 
> happen in malloc'ed structs, or in global variables. An array is aligned to 
> the size of it's base member type. But malloc does worst-case-allignment, 
> because it happens at run-time without type-information.

Well, should we ready be ready to throw up our hands as if we didnt have 
control over the alignment of objects and have to accept suboptimal code as a 
result? We do have control over that.

In any case, i'll retract the null case as it really isnt called that often in 
the tests i've done - updated patch below - it simply falls back on to hashcmp.

Thanks,

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

diff --git a/cache.h b/cache.h
index 2674f4c..39fa9cd 100644
--- a/cache.h
+++ b/cache.h
@@ -675,14 +675,24 @@ extern char *sha1_pack_name(const unsigned char *sha1);
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
+		if (*sha1 != *sha2)
+			return *sha1 - *sha2;
+	}
+
+	return 0;
 }
-static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
+
+static inline int is_null_sha1(const unsigned char *sha1)
 {
-	return memcmp(sha1, sha2, 20);
+	return !hashcmp(sha1, null_sha1);
 }
+
 static inline void hashcpy(unsigned char *sha_dst, const unsigned char *sha_src)
 {
 	memcpy(sha_dst, sha_src, 20);
