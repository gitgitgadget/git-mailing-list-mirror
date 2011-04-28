From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 15:37:08 +0200
Message-ID: <20110428133708.GA31383@elte.hu>
References: <7voc3r5kzn.fsf@alter.siamese.dyndns.org>
 <20110428062717.GA952@elte.hu>
 <BANLkTik_2sHZ0OTgQeHpRnpmNsAmT=sAcA@mail.gmail.com>
 <20110428093703.GB15349@elte.hu>
 <BANLkTim+Kk_ah_4+pQKCi8bXtA8thRVRjQ@mail.gmail.com>
 <4DB93D16.4000603@cs.helsinki.fi>
 <BANLkTimD7KZz4fS0QynPui7-JQS10AkLtg@mail.gmail.com>
 <4DB941CD.2050403@cs.helsinki.fi>
 <BANLkTik-uk-mpdHZxcz8Nem=nEzED_tuJg@mail.gmail.com>
 <20110428123617.GA2062@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 15:38:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFRQ7-0004i3-0O
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 15:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756262Ab1D1NiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 09:38:09 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:39194 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752302Ab1D1NiI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 09:38:08 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1QFRP6-0004gI-Dy
	from <mingo@elte.hu>; Thu, 28 Apr 2011 15:37:12 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 5DB533E2514; Thu, 28 Apr 2011 15:37:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110428123617.GA2062@elie>
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172364>


* Jonathan Nieder <jrnieder@gmail.com> wrote:

> Hi,
> 
> A side note for amusement.
> 
> Erik Faye-Lund wrote:
> 
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -681,13 +681,17 @@ extern char *sha1_pack_name(const unsigned char *sha1);
> >  extern char *sha1_pack_index_name(const unsigned char *sha1);
> >  extern const char *find_unique_abbrev(const unsigned char *sha1, int);
> >  extern const unsigned char null_sha1[20];
> > -static inline int is_null_sha1(const unsigned char *sha1)
> > +static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
> >  {
> > -	return !memcmp(sha1, null_sha1, 20);
> > +	/* early out for fast mis-match */
> > +	if (*sha1 != *sha2)
> > +		return *sha1 - *sha2;
> > +
> > +	return memcmp(sha1 + 1, sha2 + 1, 19);
> >  }
> 
> On the off-chance that sha1 and sha2 are nicely aligned, a more
> redundant
> 
> 	if (*sha1 != *sha2)
> 		return *sha1 - *sha2;
> 
> 	return memcmp(sha1, sha2, 20);
> 
> would take advantage of that (yes, this is just superstition, but it
> somehow seems comforting anyway).

Your variant also makes the code slightly more compact as the sha1+1 and sha2+1 
addresses do not have to be computed. I'll re-test and resend this variant.

Thanks,

	Ingo
