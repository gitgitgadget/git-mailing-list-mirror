From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Ensure that SSH runs in non-interactive mode
Date: Sun, 20 Jul 2008 11:23:13 -0700
Message-ID: <7v63r0bejy.fsf@gitster.siamese.dyndns.org>
References: <1216487215-6927-1-git-send-email-fredrik@dolda2000.com>
 <1216490252.10694.58.camel@koto.keithp.com>
 <1216491512.3911.9.camel@pc7.dolda2000.com>
 <alpine.DEB.1.00.0807201214060.3305@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Tolf <fredrik@dolda2000.com>,
	Keith Packard <keithp@keithp.com>, git@vger.kernel.org,
	"Edward Z. Yang" <edwardzyang@thewritingpot.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 20 20:27:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKddA-0000lW-Ef
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 20:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbYGTSX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 14:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751686AbYGTSX2
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 14:23:28 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57699 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbYGTSX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 14:23:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DBA22345BC;
	Sun, 20 Jul 2008 14:23:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 311D1345B8; Sun, 20 Jul 2008 14:23:15 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F18A4896-5688-11DD-83FE-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89206>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Ah, right. Would it be OK to add the `-x' flag to ssh instead?
>
> I think this would be the correct way, together with "-T".
>
>> I imagine that that might make git less portable to SSH implementations 
>> other than OpenSSH, but I don't know if that is considered a problem.
>
> Well, this was to be expected, after what I wrote in response to 3. in
> http://thread.gmane.org/gmane.comp.version-control.git/76650/focus=2598
>
> Reality always catches up with you, and here again we see that plink and 
> other siblings of OpenSSH should be best handled with scripts, preferably 
> ones that strip out options they do not recognize.
>
> IOW something like
>
> -- snip --
> #!/bin/bash
>
> plinkopt=
> while test $# != 0
> do
> 	case "$1" in
> 	-p)
> 		plinkopt="$plinkopt -P $2"
> 		shift
> 	;;
> 	-*)
> 		# unrecognized; strip out
> 	;;
> 	*)
> 		break
> 	;;
> 	esac
> 	shift
> done
>
> exec plink $plinkopt "$@"
> -- snap --

I think that is a very sensible approach, but just like we have a few
"built-in" function-header regexps with customization possibilities for
the user, we might want to:

 * Have that "-x", "-T" in the command line we generate for OpenSSH;

 * Allow users to specify OpenSSH substitute via a configuration and/or
   environment variable, and have them use your script; and

 * Have a built-in logic for selected and common "OpenSSH substitute",
   e.g. plink.

There is no reason to make users suffer an extra redirection for common
enough alternatives.

Here is to get it started...

 connect.c |   30 +++++++++++++++++++++++++++---
 1 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/connect.c b/connect.c
index 574f42f..c72dd9e 100644
--- a/connect.c
+++ b/connect.c
@@ -599,12 +599,36 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 	conn->argv = arg = xcalloc(6, sizeof(*arg));
 	if (protocol == PROTO_SSH) {
 		const char *ssh = getenv("GIT_SSH");
+		const char *ssh_basename;
 		if (!ssh) ssh = "ssh";
 
+		ssh_basename = strrchr(ssh, '/');
+		ssh_basename = ssh_basename ? (ssh_basename + 1) : ssh;
+
 		*arg++ = ssh;
-		if (port) {
-			*arg++ = "-p";
-			*arg++ = port;
+		/*
+		 * Make sure to enlarge conn->argv if you add more
+		 * paremeters here.
+		 *
+		 * We know how to invoke a few ssh implementations
+		 * ourselves.
+		 */
+		if (!strcmp(ssh_basename, "plink")) {
+			if (port) {
+				*arg++ = "-P";
+				*arg++ = port;
+			}
+		} else {
+			/*
+			 * This is for stock OpenSSH, but you can have
+			 * your custom wrapper script to parse this
+			 * and invoke other ssh implementations after
+			 * rearranging parameters as well.
+			 */
+			if (port) {
+				*arg++ = "-p";
+				*arg++ = port;
+			}
 		}
 		*arg++ = host;
 	}
