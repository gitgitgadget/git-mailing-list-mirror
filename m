From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: Re: [PATCH v6 00/16] daemon-win32
Date: Thu, 4 Nov 2010 11:35:15 +0200 (EET)
Message-ID: <alpine.DEB.2.00.1011041118200.31519@cone.home.martin.st>
References: <1288801894-1168-1-git-send-email-kusmabite@gmail.com> <877hgunmdc.fsf@fox.patthoyts.tk> <AANLkTin2BCxDoKhDCSgSRG1eVUGVeQh6Bq_=FfAe0M_M@mail.gmail.com> <AANLkTim4_5dgPGcw5B3U-3UH63REL4QWsWPV=mDSJJ6D@mail.gmail.com>
 <AANLkTin6_RLBJZKDaDViZ2_v7_LKpyoyvofowArx9sas@mail.gmail.com> <AANLkTinS2PLD3qwHpf491J3bDjXO8PxF96KdF=fz9a8o@mail.gmail.com> <alpine.DEB.2.00.1011041053120.31519@cone.home.martin.st> <AANLkTimzS1tnykzjoywaLdBUi4zhwzUC6bght0-vnaGO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463810048-1547006210-1288863341=:31519"
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org,
	gitster@pobox.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 10:35:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDwEe-0005hc-Ew
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 10:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780Ab0KDJfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 05:35:51 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:34069 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752690Ab0KDJfu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 05:35:50 -0400
Received: from dsl-tkubrasgw1-ffc4c100-75.dhcp.inet.fi (88.193.196.75) by kirsi2.inet.fi (8.5.122)
        id 4C33307D044F80CA; Thu, 4 Nov 2010 11:35:41 +0200
X-X-Sender: martin@cone.home.martin.st
In-Reply-To: <AANLkTimzS1tnykzjoywaLdBUi4zhwzUC6bght0-vnaGO@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160706>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463810048-1547006210-1288863341=:31519
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Thu, 4 Nov 2010, Erik Faye-Lund wrote:

> On Thu, Nov 4, 2010 at 9:58 AM, Martin Storsjö <martin@martin.st> wrote:
> > On Thu, 4 Nov 2010, Erik Faye-Lund wrote:
> >
> >> On Thu, Nov 4, 2010 at 1:06 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> >> >
> >> > Stuffing all of sockaddr, sockaddr_in and sockaddr_in6 (when built
> >> > with IPv6 support) in a union and passing that around instead does
> >> > seem to fix the issue completely. I don't find it very elegant, but
> >> > some google-searches on the issue seems to reveal that this is the
> >> > only way of getting rid of this. Any other suggestions, people?
> >> >
> >>
> >> Just for reference, this is the patch that fixes it. What do you think?
> >>
> >> diff --git a/daemon.c b/daemon.c
> >> index 941c095..8162f10 100644
> >> --- a/daemon.c
> >> +++ b/daemon.c
> >> @@ -902,9 +903,15 @@ static int service_loop(struct socketlist *socklist)
> >>
> >>               for (i = 0; i < socklist->nr; i++) {
> >>                       if (pfd[i].revents & POLLIN) {
> >> -                             struct sockaddr_storage ss;
> >> +                             union {
> >> +                                     struct sockaddr sa;
> >> +                                     struct sockaddr_in sai;
> >> +#ifndef NO_IPV6
> >> +                                     struct sockaddr_in6 sai6;
> >> +#endif
> >> +                             } ss;
> >>                               unsigned int sslen = sizeof(ss);
> >> -                             int incoming = accept(pfd[i].fd, (struct sockaddr *)&ss, &sslen);
> >> +                             int incoming = accept(pfd[i].fd, &ss.sa, &sslen);
> >>                               if (incoming < 0) {
> >>                                       switch (errno) {
> >>                                       case EAGAIN:
> >> @@ -915,7 +922,7 @@ static int service_loop(struct socketlist *socklist)
> >>                                               die_errno("accept returned");
> >>                                       }
> >>                               }
> >> -                             handle(incoming, (struct sockaddr *)&ss, sslen);
> >> +                             handle(incoming, &ss.sa, sslen);
> >>                       }
> >>               }
> >>       }
> >
> > As you say yourself, it's not elegant at all - sockaddr_storage is
> > intended to be just that, an struct large enough to fit all the sockaddrs
> > you'll encounter on this platform, with all fields aligned in the same way
> > as all the other sockaddr structs. You're supposed to be able to cast the
> > sockaddr struct pointers like currently is done, although I'm not familiar
> > with the strict aliasing stuff well enough to know if anything else would
> > be required somewhere.
> >
> 
> Strict aliasing isn't exactly about the structure being large enough
> or not, it's only being able to access a particular piece of memory
> through one type only (unless specificly marked with "union").
> sockaddr_storage is an attempt at fixing the storage-problem without
> addressing the type punning problem, which doesn't help us much.

Given this, does that mean that all code that uses sockaddr_storage 
directly without a union, and casting pointers to this struct into 
sockaddr, sockaddr_in and sockaddr_in6 is incorrect with regards to strict 
aliasing?

That is, even this example from RFC 2553 is faulty:

      struct sockaddr_storage __ss;
      struct sockaddr_in6 *sin6;
      sin6 = (struct sockaddr_in6 *) &__ss;

> > I didn't see any of these hacks in the v7 patchset - did the warning go
> > away by itself there?
> >
> 
> The strict aliasing problem was (as I described earlier, and you
> pointed out later in your email) already present in the code. All the
> patch did, was modify the code enough to make GCC realize it.
> 
> Since the code is removed by a later patch ("daemon: get remote host
> address from root-process"), I figured adding a union just to remove
> it was just noisy. So instead I changed the code enough for the
> warning to go away again. It turned out that it was the assignment of
> NULL to "peer" that triggered the warning, so I made two calls to
> execute() instead, one that pass NULL and one that pass "peer".
> 
> Then in "daemon: get remote host address from root-process" which
> causes a similar strict-aliasing issue (this time I'm the one who
> introduced it, since the handle() code-path doesn't derefence "addr"),
> I fixed it with a union.

Ah, I didn't see that one. Ok, that explains it.

The union solution is correct although not pretty, while the one changing 
it to a bare sockaddr was wrong, which was what caught my attention. :-)

> So a nice end-result of v7 is that we're good with strict aliasing,
> which means that it's not safe(er) to compile git-daemon on GCC with
> -O3.

Actually, couldn't there still be similar strict aliasing violations left 
that GCC hasn't realized yet?

// Martin
---1463810048-1547006210-1288863341=:31519--
