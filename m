From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Reencode committer info to utf-8 before formatting mail header
Date: Fri, 12 Jan 2007 17:43:28 -0800
Message-ID: <7vmz4nog5b.fsf@assigned-by-dhcp.cox.net>
References: <871wm08kcu.fsf@morpheus.local>
	<7vd55jrj38.fsf@assigned-by-dhcp.cox.net>
	<7vr6tzogp4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 13 02:43:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5Xvg-0001ef-P4
	for gcvg-git@gmane.org; Sat, 13 Jan 2007 02:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161170AbXAMBna (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Jan 2007 20:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161178AbXAMBna
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jan 2007 20:43:30 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:63266 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161170AbXAMBna (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jan 2007 20:43:30 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070113014329.DQAZ7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Fri, 12 Jan 2007 20:43:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ARid1W00P1kojtg0000000; Fri, 12 Jan 2007 20:42:37 -0500
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
In-Reply-To: <7vr6tzogp4.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 12 Jan 2007 17:31:35 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36737>

Side note.  The previous patch does not help if your commit were
made in non UTF-8 with not too recent git; the code assumes that
commit messages without the new "encoding" headers are in UTF-8.

We might want to help transitioning people by doing something
like this on top of the previous patch.  Then when dealing with
an ancient commit (sorry, I am not saying commits older than 3
weeks are ancient -- but it will be 6 months from now ;-), you
can override that default by setting an environment variable.

---
diff --git a/commit.c b/commit.c
index 9b2b842..a1b5705 100644
--- a/commit.c
+++ b/commit.c
@@ -692,8 +692,12 @@ static char *logmsg_reencode(const struct commit *commit,
 	if (!*output_encoding)
 		return NULL;
 	encoding = get_header(commit, "encoding");
-	if (!encoding)
-		encoding = utf8;
+	if (!encoding) {
+		if (getenv("GIT_OLD_COMMIT_ENCODING"))
+			encoding = strdup(getenv("GIT_OLD_COMMIT_ENCODING"));
+		else
+			encoding = utf8;
+	}
 	if (!strcmp(encoding, output_encoding))
 		out = strdup(commit->buffer);
 	else
