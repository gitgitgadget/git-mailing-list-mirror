From: =?utf-8?q?Adeodato=20Sim=C3=B3?= <dato@net.com.org.es>
Subject: [PATCH] Really make the LF after reset in fast-import optional
Date: Fri,  7 Mar 2008 21:22:17 +0100
Message-ID: <1204921337-5204-1-git-send-email-dato@net.com.org.es>
References: <20080305210715.GA10686@chistera.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 07 21:23:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXj5y-0007gv-S6
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 21:23:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757833AbYCGUWc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Mar 2008 15:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757436AbYCGUWc
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 15:22:32 -0500
Received: from gluck.debian.org ([192.25.206.10]:39347 "EHLO gluck.debian.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756750AbYCGUWc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 15:22:32 -0500
Received: from localhost ([127.0.0.1] helo=chistera.yi.org)
	by gluck.debian.org with esmtp (Exim 4.50)
	id 1JXj5I-0007A9-Bl; Fri, 07 Mar 2008 13:22:29 -0700
Received: from userid 1000 by plumber with local (Exim 4.69) 
	  id 1JXj57-0001MH-NY; Fri, 07 Mar 2008 21:22:17 +0100
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <20080305210715.GA10686@chistera.yi.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76519>

cmd_from() ends with a call to read_next_command(), which is needed
when using cmd_from() from commands where from is not the last element.

With reset, however, "from" is the last command, after which the flow
returns to the main loop, which calls read_next_command() again.

Because of this, always set unread_command_buf in cmd_reset_branch(),
even if cmd_from() was successful.

Add a test case for this in t9300-fast-import.sh.

Signed-off-by: Adeodato Sim=C3=B3 <dato@net.com.org.es>
---
 fast-import.c          |    3 ++-
 t/t9300-fast-import.sh |    2 ++
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 7f197d5..655913d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2291,7 +2291,8 @@ static void cmd_reset_branch(void)
 	else
 		b =3D new_branch(sp);
 	read_next_command();
-	if (!cmd_from(b) && command_buf.len > 0)
+	cmd_from(b);
+	if (command_buf.len > 0)
 		unread_command_buf =3D 1;
 }
=20
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index cceedbb..c4f4465 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -869,6 +869,8 @@ zcommits
 COMMIT
 reset refs/tags/O3-2nd
 from :5
+reset refs/tags/O3-3rd
+from :5
 INPUT_END
=20
 cat >expect <<INPUT_END
--=20
1.5.4.3

