From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] log_ref_write() -- do not chomp reflog message at
 the first LF
Date: Sun, 29 Jul 2007 12:57:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707291248560.14781@racer.site>
References: <724DFB31-0471-4A5E-95DF-F5F74876AC77@lrde.epita.fr>
 <7v8x90sp25.fsf@assigned-by-dhcp.cox.net> <20070728083536.540e471d.seanlkml@sympatico.ca>
 <7vodhwptba.fsf@assigned-by-dhcp.cox.net> <20070728092914.48f6305c.seanlkml@sympatico.ca>
 <7vk5skps1g.fsf@assigned-by-dhcp.cox.net> <20070728101156.20304d11.seanlkml@sympatico.ca>
 <7vd4ycp8ff.fsf@assigned-by-dhcp.cox.net> <7vzm1gnhin.fsf@assigned-by-dhcp.cox.net>
 <7vvec4nhfk.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sean <seanlkml@sympatico.ca>, Benoit SIGOURE <tsuna@lrde.epita.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 13:57:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF7Oy-0008BT-15
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 13:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757845AbXG2L5b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 07:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757219AbXG2L5a
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 07:57:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:39497 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752160AbXG2L5a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 07:57:30 -0400
Received: (qmail invoked by alias); 29 Jul 2007 11:57:27 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp058) with SMTP; 29 Jul 2007 13:57:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Av/Zs8sEAnyA+J3vD4YJ2hsz6J0AwEeS1j+kvYc
	a3PSZtEtQme6SP
X-X-Sender: gene099@racer.site
In-Reply-To: <7vvec4nhfk.fsf_-_@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54108>

Hi,

On Sat, 28 Jul 2007, Junio C Hamano wrote:

> A reflog file is organized as one-line-per-entry records, and we
> enforced the file format integrity by chomping the given message
> at the first LF.  This changes it to convert them to SP, which
> is more in line with the --pretty=oneline format.

Would it not be better to chop off before the first "\n", and just append 
"..."?  IOW something like

-- snip --
 refs.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 2694e70..554436b 100644
--- a/refs.c
+++ b/refs.c
@@ -1043,7 +1043,7 @@ static int log_ref_write(const char *ref_name, const unsigned char *old_sha1,
 	unsigned maxlen, len;
 	int msglen;
 	char *log_file, *logrec;
-	const char *committer;
+	const char *committer, *postmsg;
 
 	if (log_all_ref_updates < 0)
 		log_all_ref_updates = !is_bare_repository();
@@ -1088,15 +1088,16 @@ static int log_ref_write(const char *ref_name, const unsigned char *old_sha1,
 				break;
 		if (*msg) {
 			const char *ep = strchr(msg, '\n');
-			if (ep)
+			if (ep) {
 				msglen = ep - msg;
-			else
+				postmsg = (ep[1] && !isspace(ep[1])) ? "..." : NULL;
+			} else
 				msglen = strlen(msg);
 		}
 	}
 
 	committer = git_committer_info(-1);
-	maxlen = strlen(committer) + msglen + 100;
+	maxlen = strlen(committer) + msglen + 100 + 3;
 	logrec = xmalloc(maxlen);
 	len = sprintf(logrec, "%s %s %s\n",
 		      sha1_to_hex(old_sha1),
@@ -1104,6 +1105,10 @@ static int log_ref_write(const char *ref_name, const unsigned char *old_sha1,
 		      committer);
 	if (msglen)
 		len += sprintf(logrec + len - 1, "\t%.*s\n", msglen, msg) - 1;
+	if (postmsg) {
+		len += strlen(postmsg);
+		strcat(logrec + len - 1, postmsg);
+	}
 	written = len <= maxlen ? write_in_full(logfd, logrec, len) : -1;
 	free(logrec);
 	if (close(logfd) != 0 || written != len)
-- snap --

It is not like the reflog messages have to be very verbose; they only have 
to give a hint what the commit was about, and the commit name is the 
important information.

What do you think?

Ciao,
Dscho
