From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 17:14:09 +0200
Message-ID: <20110428151409.GA32025@elte.hu>
References: <20110428062717.GA952@elte.hu>
 <BANLkTik_2sHZ0OTgQeHpRnpmNsAmT=sAcA@mail.gmail.com>
 <20110428093703.GB15349@elte.hu>
 <BANLkTim+Kk_ah_4+pQKCi8bXtA8thRVRjQ@mail.gmail.com>
 <4DB93D16.4000603@cs.helsinki.fi>
 <BANLkTimD7KZz4fS0QynPui7-JQS10AkLtg@mail.gmail.com>
 <4DB941CD.2050403@cs.helsinki.fi>
 <BANLkTik-uk-mpdHZxcz8Nem=nEzED_tuJg@mail.gmail.com>
 <20110428123617.GA2062@elie>
 <20110428133708.GA31383@elte.hu>
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
X-From: git-owner@vger.kernel.org Thu Apr 28 17:17:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFSyM-0003JJ-IV
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 17:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933231Ab1D1PRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 11:17:36 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:38126 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933127Ab1D1PRf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 11:17:35 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1QFSuz-0003JG-7w
	from <mingo@elte.hu>; Thu, 28 Apr 2011 17:14:18 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 532263E250D; Thu, 28 Apr 2011 17:14:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110428133708.GA31383@elte.hu>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172366>


* Ingo Molnar <mingo@elte.hu> wrote:

> * Jonathan Nieder <jrnieder@gmail.com> wrote:
> 
> > Hi,
> > 
> > A side note for amusement.
> > 
> > Erik Faye-Lund wrote:
> > 
> > > --- a/cache.h
> > > +++ b/cache.h
> > > @@ -681,13 +681,17 @@ extern char *sha1_pack_name(const unsigned char *sha1);
> > >  extern char *sha1_pack_index_name(const unsigned char *sha1);
> > >  extern const char *find_unique_abbrev(const unsigned char *sha1, int);
> > >  extern const unsigned char null_sha1[20];
> > > -static inline int is_null_sha1(const unsigned char *sha1)
> > > +static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
> > >  {
> > > -	return !memcmp(sha1, null_sha1, 20);
> > > +	/* early out for fast mis-match */
> > > +	if (*sha1 != *sha2)
> > > +		return *sha1 - *sha2;
> > > +
> > > +	return memcmp(sha1 + 1, sha2 + 1, 19);
> > >  }
> > 
> > On the off-chance that sha1 and sha2 are nicely aligned, a more
> > redundant
> > 
> > 	if (*sha1 != *sha2)
> > 		return *sha1 - *sha2;
> > 
> > 	return memcmp(sha1, sha2, 20);
> > 
> > would take advantage of that (yes, this is just superstition, but it
> > somehow seems comforting anyway).
> 
> Your variant also makes the code slightly more compact as the sha1+1 and sha2+1 
> addresses do not have to be computed. I'll re-test and resend this variant.

Seems to perform measurably worse:

 #
 # Open-coded loop:
 #
 Performance counter stats for './git gc' (10 runs):

       2358.560100 task-clock               #    0.763 CPUs utilized            ( +-  0.06% )
             1,870 context-switches         #    0.001 M/sec                    ( +-  3.09% )
               170 CPU-migrations           #    0.000 M/sec                    ( +-  3.54% )
            38,230 page-faults              #    0.016 M/sec                    ( +-  0.03% )
     7,513,529,543 cycles                   #    3.186 GHz                      ( +-  0.06% )
     1,634,103,128 stalled-cycles           #   21.75% of all cycles are idle   ( +-  0.28% )
    11,068,971,207 instructions             #    1.47  insns per cycle        
                                            #    0.15  stalled cycles per insn  ( +-  0.04% )
     2,487,656,519 branches                 # 1054.735 M/sec                    ( +-  0.03% )
        59,233,604 branch-misses            #    2.38% of all branches          ( +-  0.09% )

        3.092183093  seconds time elapsed  ( +-  3.49% )

 #
 # Front test + memcmp:
 #
 Performance counter stats for './git gc' (10 runs):

       2723.468639 task-clock               #    0.833 CPUs utilized            ( +-  0.22% )
             1,751 context-switches         #    0.001 M/sec                    ( +-  2.02% )
               167 CPU-migrations           #    0.000 M/sec                    ( +-  1.23% )
            38,230 page-faults              #    0.014 M/sec                    ( +-  0.03% )
     8,684,682,538 cycles                   #    3.189 GHz                      ( +-  0.21% )
     2,062,906,208 stalled-cycles           #   23.75% of all cycles are idle   ( +-  0.60% )
     9,019,624,641 instructions             #    1.04  insns per cycle        
                                            #    0.23  stalled cycles per insn  ( +-  0.04% )
     1,771,179,402 branches                 #  650.340 M/sec                    ( +-  0.04% )
        75,026,810 branch-misses            #    4.24% of all branches          ( +-  0.04% )

        3.271415104  seconds time elapsed  ( +-  1.97% )

So i think the open-coded loop variant i posted is faster.

The key observation is that there's two cases that matter to performance:

 - the hashes are different: in this case the front test catches 99% of the cases
 - the hashes are *equal*: in this case the open-coded loop performs better than the memcmp

My patch addresses both cases.

Thanks,

	Ingo
