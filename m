From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: Re: [PATCH v6 00/16] daemon-win32
Date: Thu, 4 Nov 2010 10:52:37 +0200 (EET)
Message-ID: <alpine.DEB.2.00.1011041026160.31519@cone.home.martin.st>
References: <1288801894-1168-1-git-send-email-kusmabite@gmail.com> <877hgunmdc.fsf@fox.patthoyts.tk> <AANLkTin2BCxDoKhDCSgSRG1eVUGVeQh6Bq_=FfAe0M_M@mail.gmail.com> <AANLkTim4_5dgPGcw5B3U-3UH63REL4QWsWPV=mDSJJ6D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463810048-1082330510-1288860775=:31519"
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org,
	gitster@pobox.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 04 09:59:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDvfq-0002z9-CW
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 09:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181Ab0KDI7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 04:59:54 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:55615 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754133Ab0KDI7x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 04:59:53 -0400
Received: from dsl-tkubrasgw1-ffc4c100-75.dhcp.inet.fi (88.193.196.75) by jenni2.inet.fi (8.5.122)
        id 4C333077041EBE53; Thu, 4 Nov 2010 10:52:55 +0200
X-X-Sender: martin@cone.home.martin.st
In-Reply-To: <AANLkTim4_5dgPGcw5B3U-3UH63REL4QWsWPV=mDSJJ6D@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160698>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463810048-1082330510-1288860775=:31519
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 3 Nov 2010, Erik Faye-Lund wrote:

> On Wed, Nov 3, 2010 at 11:18 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> > On Wed, Nov 3, 2010 at 10:11 PM, Pat Thoyts
> > <patthoyts@users.sourceforge.net> wrote:
> >> Erik Faye-Lund <kusmabite@gmail.com> writes:
> >>
> >>>Here's hopefully the last iteration of this series. The previous version
> >>>only got a single complain about a typo in the subject of patch 14/15, so
> >>>it seems like most controversies have been settled.
> >>
> >> I pulled this win32-daemon branch into my msysgit build tree and built
> >> it. I get the following warnings:
> >>
> >>    CC daemon.o
> >> daemon.c: In function 'service_loop':
> >> daemon.c:674: warning: dereferencing pointer 'ss.124' does break strict-aliasing rules
> >> daemon.c:676: warning: dereferencing pointer 'ss.124' does break strict-aliasing rules
> >> daemon.c:681: warning: dereferencing pointer 'ss.124' does break strict-aliasing rules
> >> daemon.c:919: note: initialized from here
> >> daemon.c:679: warning: dereferencing pointer 'sin_addr' does break strict-aliasing rules
> >> daemon.c:675: note: initialized from here
> >> daemon.c:691: warning: dereferencing pointer 'sin6_addr' does break strict-aliasing rules
> >> daemon.c:682: note: initialized from here
> >>
> >
> > Yeah, I'm aware of these. I thought those warnings were already
> > present in the Linux build, but checking again I see that that's not
> > the case. Need to investigate.
> >
> 
> OK, it's the patch "daemon: use run-command api for async serving"
> that introduce the warning. But looking closer at the patch it doesn't
> seem the patch actually introduce the strict-aliasing violation, it's
> there already. The patch only seems to change the code enough for GCC
> to start realize there's a problem. Unless I'm misunderstanding
> something vital, that is.
> 
> Anyway, here's a patch that makes it go away, I guess I'll squash it
> into the next round.
> 
> diff --git a/daemon.c b/daemon.c
> index 6eee570..d636446 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -1159,14 +1159,13 @@ int main(int argc, char **argv)
>  	}
> 
>  	if (inetd_mode || serve_mode) {
> -		struct sockaddr_storage ss;
> -		struct sockaddr *peer = (struct sockaddr *)&ss;
> -		socklen_t slen = sizeof(ss);
> +		struct sockaddr sa;
> +		socklen_t slen = sizeof(sa);
> 
> -		if (getpeername(0, peer, &slen))
> -			peer = NULL;
> -
> -		return execute(peer);
> +		if (getpeername(0, &sa, &slen))
> +			return execute(NULL);
> +		else
> +			return execute(&sa);
>  	}
> 
>  	if (detach) {

As you noticed later yourself, this is not right. You can get any kind of 
sockaddr back from getpeername. I'm not sure if any spec mandates that a 
"normal" sockaddr_in should fit into the base sockaddr, or if that just 
happens by coincidence or sheer luck.

// Martin
---1463810048-1082330510-1288860775=:31519--
