From: Mike Hommey <mh@glandium.org>
Subject: [PATCH v4 09/11] connect: use "-l user" instead of "user@" on ssh command line
Date: Tue,  3 May 2016 17:50:50 +0900
Message-ID: <1462265452-32360-10-git-send-email-mh@glandium.org>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
 <1462265452-32360-1-git-send-email-mh@glandium.org>
Cc: gitster@pobox.com, tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 10:51:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axW34-0004la-2x
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 10:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821AbcECIvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 04:51:08 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:51960 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755799AbcECIu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 04:50:58 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1axW2e-0008R5-LL; Tue, 03 May 2016 17:50:52 +0900
X-Mailer: git-send-email 2.8.1.16.gaa70619.dirty
In-Reply-To: <1462265452-32360-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293338>

While it is not strictly necessary, it makes the connect code simpler
when there is user.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c        | 12 ++++--------
 t/t5601-clone.sh | 52 ++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 48 insertions(+), 16 deletions(-)

This is entirely optional.

diff --git a/connect.c b/connect.c
index 2c5b722..0cec822 100644
--- a/connect.c
+++ b/connect.c
@@ -812,14 +812,10 @@ struct child_process *git_connect(int fd[2], const char *url,
 				argv_array_push(&conn->args, port);
 			}
 			if (user) {
-				struct strbuf userandhost = STRBUF_INIT;
-				strbuf_addstr(&userandhost, user);
-				strbuf_addch(&userandhost, '@');
-				strbuf_addstr(&userandhost, host);
-				argv_array_push(&conn->args, userandhost.buf);
-				strbuf_release(&userandhost);
-			} else
-				argv_array_push(&conn->args, host);
+				argv_array_push(&conn->args, "-l");
+				argv_array_push(&conn->args, user);
+			}
+			argv_array_push(&conn->args, host);
 		} else {
 			transport_check_allowed("file");
 		}
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index c1efb8e..98fe861 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -464,38 +464,74 @@ test_expect_success 'clone ssh://host.xz:22/~repo' '
 '
 
 #IPv6
-for tuah in ::1 [::1] [::1]: user@::1 user@[::1] user@[::1]: [user@::1] [user@::1]:
+for tah in ::1 [::1] [::1]:
+do
+	ehost=$(echo $tah | sed -e "s/1]:/1]/ "| tr -d "[]")
+	test_expect_success "clone ssh://$tah/home/user/repo" "
+	  test_clone_url ssh://$tah/home/user/repo $ehost /home/user/repo
+	"
+done
+
+for tuah in user@::1 user@[::1] user@[::1]: [user@::1] [user@::1]:
 do
 	ehost=$(echo $tuah | sed -e "s/1]:/1]/ "| tr -d "[]")
+	ehost=${ehost#user@}
 	test_expect_success "clone ssh://$tuah/home/user/repo" "
-	  test_clone_url ssh://$tuah/home/user/repo $ehost /home/user/repo
+	  test_clone_url ssh://$tuah/home/user/repo '-l user $ehost' /home/user/repo
 	"
 done
 
 #IPv6 from home directory
-for tuah in ::1 [::1] user@::1 user@[::1] [user@::1]
+for tah in ::1 [::1]
+do
+	eah=$(echo $tah | tr -d "[]")
+	test_expect_success "clone ssh://$tah/~repo" "
+	  test_clone_url ssh://$tah/~repo $eah '~repo'
+	"
+done
+
+for tuah in user@::1 user@[::1] [user@::1]
 do
 	euah=$(echo $tuah | tr -d "[]")
+	eah=${euah#user@}
 	test_expect_success "clone ssh://$tuah/~repo" "
-	  test_clone_url ssh://$tuah/~repo $euah '~repo'
+	  test_clone_url ssh://$tuah/~repo '-l user' $eah '~repo'
 	"
 done
 
 #IPv6 with port number
-for tuah in [::1] user@[::1] [user@::1]
+for tah in [::1]
+do
+	eah=$(echo $tah | tr -d "[]")
+	test_expect_success "clone ssh://$tah:22/home/user/repo" "
+	  test_clone_url ssh://$tah:22/home/user/repo '-p 22' $eah /home/user/repo
+	"
+done
+
+for tuah in user@[::1] [user@::1]
 do
 	euah=$(echo $tuah | tr -d "[]")
+	eah=${euah#user@}
 	test_expect_success "clone ssh://$tuah:22/home/user/repo" "
-	  test_clone_url ssh://$tuah:22/home/user/repo '-p 22' $euah /home/user/repo
+	  test_clone_url ssh://$tuah:22/home/user/repo '-p 22 -l user' $eah /home/user/repo
 	"
 done
 
 #IPv6 from home directory with port number
-for tuah in [::1] user@[::1] [user@::1]
+for tah in [::1]
+do
+	eah=$(echo $tah | tr -d "[]")
+	test_expect_success "clone ssh://$tah:22/~repo" "
+	  test_clone_url ssh://$tah:22/~repo '-p 22' $eah '~repo'
+	"
+done
+
+for tuah in user@[::1] [user@::1]
 do
 	euah=$(echo $tuah | tr -d "[]")
+	eah=${euah#user@}
 	test_expect_success "clone ssh://$tuah:22/~repo" "
-	  test_clone_url ssh://$tuah:22/~repo '-p 22' $euah '~repo'
+	  test_clone_url ssh://$tuah:22/~repo '-p 22 -l user' $eah '~repo'
 	"
 done
 
-- 
2.8.1.16.gaa70619.dirty
