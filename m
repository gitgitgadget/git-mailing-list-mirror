From: "Medve Emilian" <Emilian.Medve@freescale.com>
Subject: RE: git-daemon
Date: Mon, 19 Nov 2007 15:49:36 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E27017BCC8D@az33exm24.fsl.freescale.net>
References: <598D5675D34BE349929AF5EDE9B03E27017BCC42@az33exm24.fsl.freescale.net> <7vbq9pnac2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 19 23:50:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuFRI-0006OB-6g
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 23:50:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752396AbXKSWtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 17:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752262AbXKSWtn
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 17:49:43 -0500
Received: from de01egw01.freescale.net ([192.88.165.102]:64796 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752405AbXKSWtm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Nov 2007 17:49:42 -0500
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id lAJMncFv008907
	for <git@vger.kernel.org>; Mon, 19 Nov 2007 15:49:39 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net [10.64.32.14])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id lAJMnbLH015112
	for <git@vger.kernel.org>; Mon, 19 Nov 2007 16:49:37 -0600 (CST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <7vbq9pnac2.fsf@gitster.siamese.dyndns.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git-daemon
thread-index: Acgq+tx+fCPK5YYbQ4OMWxWRjzoLIQAAqzrQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65513>

Hello Junio,


v1.5.3.6 works but the HEAD of master and next don't. I considered the
patches below but they seemed harmless. I think the problem comes form
upload-pack (and below it). Weirdly enough running git-daemon standalone
seems to work fine. Cloning over ssh or on the same file system seems to
work fine too.

I was hoping somebody can repeat the experiment (build the latest master
or maint) and invalidate my experience.


Cheers,
Emil.


> -----Original Message-----
> From: Junio C Hamano [mailto:gitster@pobox.com] 
> Sent: Monday, November 19, 2007 4:24 PM
> To: Medve Emilian
> Cc: git@vger.kernel.org
> Subject: Re: git-daemon
> 
> "Medve Emilian" <Emilian.Medve@freescale.com> writes:
> 
> > It seems that something changed since maint/v.1.5.3.6 such that on
> > master and next git-daemon doesn't seem to be working 
> anymore in inetd
> > mode. Can somebody please confirm this?
> 
> Sorry, I cannot quite parse.  Do you mean:
> 
> 	master and next used to work.  Recently 'maint' was
> 	merged to them after v1.5.3.6 was cut.  master and next
> 	does not work anymore after that.
> 
> Or do you mean:
> 
> 	maint (specifically at v1.5.3.6) works, but master and
> 	next contain more changes on top of them, and they do
> 	not work.
> 
> In either case, the only change to the daemon code between
> v1.5.3.5 and master is this one:
> 
> commit c67359be45be74e1056d6293c6bb09ee6d00a54a
> Author: Gerrit Pape <pape@smarden.org>
> Date:   Mon Nov 5 09:16:22 2007 +0000
> 
>     git-daemon: fix remote port number in log entry
>     
>     The port number in struct sockaddr_in needs to be 
> converted from network
>     byte order to host byte order (on some architectures).
>     
>     Signed-off-by: Gerrit Pape <pape@smarden.org>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  daemon.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/daemon.c b/daemon.c
> index 660e155..b8df980 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -540,7 +540,7 @@ static int execute(struct sockaddr *addr)
>  		if (addr->sa_family == AF_INET) {
>  			struct sockaddr_in *sin_addr = (void *) addr;
>  			inet_ntop(addr->sa_family, 
> &sin_addr->sin_addr, addrbuf, sizeof(addrbuf));
> -			port = sin_addr->sin_port;
> +			port = ntohs(sin_addr->sin_port);
>  #ifndef NO_IPV6
>  		} else if (addr && addr->sa_family == AF_INET6) {
>  			struct sockaddr_in6 *sin6_addr = (void *) addr;
> @@ -550,7 +550,7 @@ static int execute(struct sockaddr *addr)
>  			inet_ntop(AF_INET6, 
> &sin6_addr->sin6_addr, buf, sizeof(addrbuf) - 1);
>  			strcat(buf, "]");
>  
> -			port = sin6_addr->sin6_port;
> +			port = ntohs(sin6_addr->sin6_port);
>  #endif
>  		}
>  		loginfo("Connection from %s:%d", addrbuf, port);
> 
> I do not see anything wrong in it.  The "port" variable is very
> local to this function and is used only for that loginfo() call
> at the end of the context.  So I am quite puzzled.
> 
> We have another irrelevant style change that is full of things
> like this, but I do not think that makes any behaviour
> difference either.
> 
> @@ -406,7 +406,8 @@ static struct daemon_service daemon_service[] = {
>  	{ "receive-pack", "receivepack", receive_pack, 0, 1 },
>  };
>  
> -static void enable_service(const char *name, int ena) {
> +static void enable_service(const char *name, int ena)
> +{
>  	int i;
>  	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
>  		if (!strcmp(daemon_service[i].name, name)) {
