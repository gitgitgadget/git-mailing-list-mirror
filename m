From: Samuel Tardieu <sam@rfc1149.net>
Subject: [PATCH] Add MIME information to outgoing email
Date: Thu, 13 Mar 2008 17:40:19 +0100
Message-ID: <1205426419-4594-1-git-send-email-sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=fixed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Samuel Tardieu <sam@rfc1149.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 13 17:51:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZqe3-0005dF-Uh
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 17:51:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753901AbYCMQu2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Mar 2008 12:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753022AbYCMQu1
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 12:50:27 -0400
Received: from zaphod.rfc1149.net ([88.191.14.223]:55688 "EHLO
	mail.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbYCMQu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 12:50:27 -0400
X-Greylist: delayed 598 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Mar 2008 12:50:27 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.rfc1149.net (Postfix) with ESMTP id 8A917E204F;
	Thu, 13 Mar 2008 17:40:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from mail.rfc1149.net ([127.0.0.1])
	by localhost (zaphod.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tT+kJRg1vjck; Thu, 13 Mar 2008 17:40:20 +0100 (CET)
Received: from dawn.rfc1149.net (unknown [192.168.9.2])
	by mail.rfc1149.net (Postfix) with ESMTP id 27EEBE1CA6;
	Thu, 13 Mar 2008 17:40:20 +0100 (CET)
Received: by dawn.rfc1149.net (Postfix, from userid 1000)
	id 9D2978065; Thu, 13 Mar 2008 17:40:19 +0100 (CET)
X-Mailer: git-send-email 1.5.4.4.653.g7cf1e.dirty
Organisation: RFC1149 (see http://www.rfc1149.net/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77103>

Add MIME-Version/Content-Type/Content-Transfer-Encoding headers in
messages generated with git-format-patch. Without it, messages generate=
d
without using --attach or --inline didn't have any content type informa=
tion.

I got hit with this problem yesterday when sending a patch to linux-ker=
nel
with a commit message containing the name "P=C3=A1draig" in it. Moreove=
r,
the mailing-list software added an incorrect ISO-8859-1 encoding inform=
ation
which mangled P=C3=A1draig's name.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
---
 log-tree.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 608f697..0dacf63 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -198,7 +198,16 @@ void log_write_email_headers(struct rev_info *opt,=
 const char *name,
 			 opt->no_inline ? "attachment" : "inline",
 			 name);
 		opt->diffopt.stat_sep =3D buffer;
-	}
+	} else {
+		static char buffer[1024];
+		snprintf(buffer, sizeof(buffer) - 1,
+			 "%s"
+			 "MIME-Version: 1.0\n"
+			 "Content-Type: text/plain; charset=3DUTF-8; format=3Dfixed\n"
+			 "Content-Transfer-Encoding: 8bit\n",
+			 extra_headers ? extra_headers : "");
+		extra_headers =3D buffer;
+	};
 	*subject_p =3D subject;
 	*extra_headers_p =3D extra_headers;
 }
--=20
1.5.4.4.653.g7cf1e.dirty
