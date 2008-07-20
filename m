From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Ensure that SSH runs in non-interactive mode
Date: Sun, 20 Jul 2008 20:57:48 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807202035090.3305@eeepc-johanness>
References: <1216487215-6927-1-git-send-email-fredrik@dolda2000.com> <1216490252.10694.58.camel@koto.keithp.com> <1216491512.3911.9.camel@pc7.dolda2000.com> <alpine.DEB.1.00.0807201214060.3305@eeepc-johanness> <7v63r0bejy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Tolf <fredrik@dolda2000.com>,
	Keith Packard <keithp@keithp.com>, git@vger.kernel.org,
	"Edward Z. Yang" <edwardzyang@thewritingpot.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 20:58:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKe6d-0008Lh-Nh
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 20:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbYGTS5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 14:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbYGTS5A
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 14:57:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:46723 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750702AbYGTS5A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 14:57:00 -0400
Received: (qmail invoked by alias); 20 Jul 2008 18:56:58 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp018) with SMTP; 20 Jul 2008 20:56:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19IR/EIIahII/GBEwbV/s+ldc4J51/u2C1tBRg12M
	B3VuoG3teBsBYS
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7v63r0bejy.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89215>

Hi,

On Sun, 20 Jul 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Ah, right. Would it be OK to add the `-x' flag to ssh instead?
> >
> > I think this would be the correct way, together with "-T".
> >
> >> I imagine that that might make git less portable to SSH implementations 
> >> other than OpenSSH, but I don't know if that is considered a problem.
> >
> > Well, this was to be expected, after what I wrote in response to 3. in
> > http://thread.gmane.org/gmane.comp.version-control.git/76650/focus=2598
> >
> > Reality always catches up with you, and here again we see that plink and 
> > other siblings of OpenSSH should be best handled with scripts, preferably 
> > ones that strip out options they do not recognize.
> >
> > IOW something like
> >
> > -- snip --
> > #!/bin/bash
> >
> > plinkopt=
> > while test $# != 0
> > do
> > 	case "$1" in
> > 	-p)
> > 		plinkopt="$plinkopt -P $2"
> > 		shift
> > 	;;
> > 	-*)
> > 		# unrecognized; strip out
> > 	;;
> > 	*)
> > 		break
> > 	;;
> > 	esac
> > 	shift
> > done
> >
> > exec plink $plinkopt "$@"
> > -- snap --
> 
> I think that is a very sensible approach, but just like we have a few
> "built-in" function-header regexps with customization possibilities for
> the user, we might want to:
> 
>  * Have that "-x", "-T" in the command line we generate for OpenSSH;
> 
>  * Allow users to specify OpenSSH substitute via a configuration and/or
>    environment variable, and have them use your script; and
> 
>  * Have a built-in logic for selected and common "OpenSSH substitute",
>    e.g. plink.
> 
> There is no reason to make users suffer an extra redirection for common
> enough alternatives.
> 
> Here is to get it started...

How about this instead?

-- snipsnap --
diff --git a/connect.c b/connect.c
index 574f42f..7e7f4d3 100644
--- a/connect.c
+++ b/connect.c
@@ -603,7 +603,8 @@ struct child_process *git_connect(int fd[2], const char *url
 
 		*arg++ = ssh;
 		if (port) {
-			*arg++ = "-p";
+			const char *opt = getenv("GIT_SSH_PORT_OPTION");
+			*arg++ = opt ? opt : "-p";
 			*arg++ = port;
 		}
 		*arg++ = host;
