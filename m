From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v10 1/5] command-list: prepare machinery for upcoming "common groups" section
Date: Thu, 21 May 2015 15:13:05 +0200
Message-ID: <1432213989-3932-2-git-send-email-sebastien.guimmara@gmail.com>
References: <1432213989-3932-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>, gitster@pobox.com,
	=?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 15:13:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvQHz-0001fi-2i
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 15:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755878AbbEUNNW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2015 09:13:22 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:34901 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755633AbbEUNNS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 09:13:18 -0400
Received: by wgfl8 with SMTP id l8so85271258wgf.2
        for <git@vger.kernel.org>; Thu, 21 May 2015 06:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GuyjFC0LgoetjbU9+kAq+/hvxN2CF97Js6W60LxoBO4=;
        b=nG5sCVvk9heFAQy5bialBoyw7JrxAbNYcPW4JZzaiuwCJklvIImglZ3XXdw6is+loU
         rBHn+GO7ndqYGbyx8BLKZ5avj0gTnCPyZtmGunqptlLXjOwu8mCok6A6EQ3LPTW5wPKk
         Z9taA85EySLKn4wkFY7FaQfRMIinwohvjRKe2CyiDruBUECxvrvn0pHLB9cN6EqpuH95
         MPxPcxfCju8emv0aKmWZblOe3yBuuduAxpZqqaQqK4asUImpyfOp2xiXJ3g36bdU6V8x
         v9vtqj0wPeL+649HR2c7Rx+LrFDHw8VdWlXD546dgcknX0f8O0fvw4FSY47CoFvBtL3j
         tD4A==
X-Received: by 10.180.73.236 with SMTP id o12mr52250000wiv.56.1432213997726;
        Thu, 21 May 2015 06:13:17 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id fb3sm2816361wib.21.2015.05.21.06.13.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 May 2015 06:13:17 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.GIT
In-Reply-To: <1432213989-3932-1-git-send-email-sebastien.guimmara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269585>

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
 Documentation/cmd-list.perl         | 4 ++++
 Documentation/howto/new-command.txt | 4 +++-
 Makefile                            | 5 +++--
 command-list.txt                    | 2 +-
 4 files changed, 11 insertions(+), 4 deletions(-)

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
diff --git a/Documentation/howto/new-command.txt b/Documentation/howto/=
new-command.txt
index d7de5a3..6d772bd 100644
--- a/Documentation/howto/new-command.txt
+++ b/Documentation/howto/new-command.txt
@@ -95,7 +95,9 @@ your language, document it in the INSTALL file.
 that categorizes commands by type, so they can be listed in appropriat=
e
 subsections in the documentation's summary command list.  Add an entry
 for yours.  To understand the categories, look at git-commands.txt
-in the main directory.
+in the main directory.  If the new command is part of the typical Git
+workflow and you believe it common enough to be mentioned in 'git help=
',
+map this command to a common group in the column [common].
=20
 7. Give the maintainer one paragraph to include in the RelNotes file
 to describe the new feature; a good place to do so is in the cover
diff --git a/Makefile b/Makefile
index 323c401..655740d 100644
--- a/Makefile
+++ b/Makefile
@@ -2455,7 +2455,7 @@ check-docs::
 		esac ; \
 		test -f "Documentation/$$v.txt" || \
 		echo "no doc: $$v"; \
-		sed -e '/^#/d' command-list.txt | \
+		sed -e '1,/^### command list/d' -e '/^#/d' command-list.txt | \
 		grep -q "^$$v[ 	]" || \
 		case "$$v" in \
 		git) ;; \
@@ -2463,7 +2463,8 @@ check-docs::
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
index 54d8d21..181a9c2 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -1,4 +1,4 @@
-# List of known git commands.
+### command list (do not change this line)
 # command name                          category [deprecated] [common]
 git-add                                 mainporcelain common
 git-am                                  mainporcelain
--=20
2.4.0.GIT
