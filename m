From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v8 1/5] command-list: prepare machinery for upcoming "common groups" section
Date: Mon, 18 May 2015 21:18:13 +0200
Message-ID: <1431976697-26288-2-git-send-email-sebastien.guimmara@gmail.com>
References: <1431976697-26288-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sunshine@sunshineco.com,
	=?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 21:18:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuQYW-0000u6-HZ
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 21:18:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882AbbERTSZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 May 2015 15:18:25 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:34038 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754673AbbERTSX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 15:18:23 -0400
Received: by wguv19 with SMTP id v19so138720769wgu.1
        for <git@vger.kernel.org>; Mon, 18 May 2015 12:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6U5saSE+ofQExkpmm9XfgiI02siUccpSqDTs76aW/Ew=;
        b=oMo9IlJLhF3GXhUtNxIj8nI4++rFinXw8eSzHjccmoL63SKJ7NiGpPD6SzKvpI5hLp
         myknoNgDVnv0in2Q4zv4EH0VE3e2vMpqjDaK/XazAJ7zTQ/RC+nBqYSjVzbrrjmqiiWv
         S/pOFkn2NmJjOdXKDQXy1orkE7Nj2Ws/6kBWbq40RZFDoTyX46WWeFZgBwpooFjAu6WI
         jJWcC2fCBWzRvCEpGkn6K0GvP+q+ZYI0oS1hqaaOicCrazqRjjtxUfU3Lqory3wlLQWQ
         sMf7JSf9XuB8FUB2oNXxgL17imB4UkTpnwKSEizqbF1OsmbOT1Jy+jonnCidVR+8/Di2
         eZiA==
X-Received: by 10.180.73.1 with SMTP id h1mr1761972wiv.90.1431976702287;
        Mon, 18 May 2015 12:18:22 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id z12sm18259450wjq.12.2015.05.18.12.18.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 12:18:21 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.GIT
In-Reply-To: <1431976697-26288-1-git-send-email-sebastien.guimmara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269304>

=46rom: Eric Sunshine <sunshine@sunshineco.com>

The ultimate goal is for "git help" to classify common commands by
group. Toward this end, a subsequent patch will add a new "common
groups" section to command-list.txt preceding the actual command list.
As preparation, teach existing command-list.txt parsing machinery, whic=
h
doesn't care about grouping, to skip over this upcoming "common groups"
section.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
---
 Documentation/cmd-list.perl | 4 ++++
 Makefile                    | 5 +++--
 command-list.txt            | 3 ++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index 04f9977..5aa73cf 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -38,6 +38,10 @@ sub format_one {
 	}
 }
=20
+while (<>) {
+	last if /^### command list/;
+}
+
 my %cmds =3D ();
 for (sort <>) {
 	next if /^#/;
diff --git a/Makefile b/Makefile
index 25a453b..5ed0acf 100644
--- a/Makefile
+++ b/Makefile
@@ -2454,7 +2454,7 @@ check-docs::
 		esac ; \
 		test -f "Documentation/$$v.txt" || \
 		echo "no doc: $$v"; \
-		sed -e '/^#/d' command-list.txt | \
+		sed -e '1,/^### command list/d' -e '/^#/d' command-list.txt | \
 		grep -q "^$$v[ 	]" || \
 		case "$$v" in \
 		git) ;; \
@@ -2462,7 +2462,8 @@ check-docs::
 		esac ; \
 	done; \
 	( \
-		sed -e '/^#/d' \
+		sed -e '1,/^### command list/d' \
+		    -e '/^#/d' \
 		    -e 's/[ 	].*//' \
 		    -e 's/^/listed /' command-list.txt; \
 		$(MAKE) -C Documentation print-man1 | \
diff --git a/command-list.txt b/command-list.txt
index 54d8d21..609b344 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -1,4 +1,5 @@
-# List of known git commands.
+# do not molest the next line
+### command list
 # command name                          category [deprecated] [common]
 git-add                                 mainporcelain common
 git-am                                  mainporcelain
--=20
2.4.0.GIT
