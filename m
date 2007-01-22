From: Junio C Hamano <junkio@cox.net>
Subject: Re: Meaning of "fatal: protocol error: bad line length character"?
Date: Mon, 22 Jan 2007 11:45:29 -0800
Message-ID: <7vy7nusv52.fsf@assigned-by-dhcp.cox.net>
References: <17842.1385.366750.915767@lisa.zopyra.com>
	<7vk5zh7b7d.fsf@assigned-by-dhcp.cox.net>
	<7vfya57ast.fsf@assigned-by-dhcp.cox.net>
	<17842.29542.229557.460473@lisa.zopyra.com>
	<7vbqkt78n7.fsf@assigned-by-dhcp.cox.net>
	<7v7ivh77md.fsf@assigned-by-dhcp.cox.net>
	<17845.2402.105688.56648@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 20:45:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H956v-0007ax-AT
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 20:45:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbXAVTpd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 14:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbXAVTpc
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 14:45:32 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:61202 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932137AbXAVTpa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 14:45:30 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070122194530.BBSU9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Mon, 22 Jan 2007 14:45:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id EKlo1W0041kojtg0000000; Mon, 22 Jan 2007 14:45:48 -0500
To: Bill Lear <rael@zopyra.com>
In-Reply-To: <17845.2402.105688.56648@lisa.zopyra.com> (Bill Lear's message of
	"Mon, 22 Jan 2007 12:58:42 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37439>

Bill Lear <rael@zopyra.com> writes:

> He has an active update hook in his public repo, to send notices to
> his collaborators when his work is ready for them to pull, but we
> looked through it and don't see any printing to stdout.

Just a hunch.

Does the bash start-up sequence for the user emit something to
stdout?

The attached patch on the local side (i.e. the one that pushes)
dumps "garbage" you are getting on the line from the remote
side, to help diagnosing the problem.


diff --git a/pkt-line.c b/pkt-line.c
index b4cb7e2..9bb1c90 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -101,6 +101,16 @@ int packet_read_line(int fd, char *buffer, unsigned size)
 			len += c - 'A' + 10;
 			continue;
 		}
+		error("protocol error: bad line length character");
+		fprintf(stderr, "<<<<<\n%.*s", 4, linelen);
+		while (1) {
+			char buf[1024];
+			int cnt = xread(fd, buf, sizeof(buf));
+			if (cnt <= 0)
+				break;
+			fprintf(stderr, "%.*s", cnt, buf);
+		}
+		fprintf(stderr, "\n>>>>>\n");
 		die("protocol error: bad line length character");
 	}
 	if (!len)
