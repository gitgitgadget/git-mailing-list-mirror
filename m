From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v11 1/5] command-list: prepare machinery for upcoming "common groups" section
Date: Thu, 21 May 2015 19:39:18 +0200
Message-ID: <1432229962-21405-2-git-send-email-sebastien.guimmara@gmail.com>
References: <1432229962-21405-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>, gitster@pobox.com,
	=?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 19:41:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvUSw-0000nj-1D
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 19:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756084AbbEURke convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2015 13:40:34 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34757 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756027AbbEURk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 13:40:29 -0400
Received: by wicmc15 with SMTP id mc15so19944268wic.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 10:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Qf7h9IbQHbHSqZrZ/SzpTchOgfsUHatmqe4lOfpNZ7k=;
        b=JY3cOeeFvA3yM7b7b2hToA0DHZ0ZK5C7xQqNQC//oLjWpztOaWRajeY1rcSXGThVGG
         3CGSUpdsOG4FT3ltMYTLX0FXmKinTYUfgHr7IN9OSjX1gP9YQcWvickYu26i31qH08KK
         LEi5bvAsoDipCsFAaowk9EL2oP0XsiDQqLEq40eK/O81cXPl6nxsGPEwgi9DoO5znqtt
         rwjdAcuqIUiLNR/K+tO6dQsvmCQuJWonS8L6GskQqib0Raqgh42eAHhT4B+jYkLQ4rQ1
         3NHlW8pSxse0n+hkmHag3cYxVZUVYTWvdNssyb/3ARbGQ3VRHoJwfl2IJry21f3Uwefh
         FrOw==
X-Received: by 10.194.109.167 with SMTP id ht7mr7255680wjb.60.1432230027002;
        Thu, 21 May 2015 10:40:27 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id v3sm3660231wix.8.2015.05.21.10.40.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 May 2015 10:40:26 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.GIT
In-Reply-To: <1432229962-21405-1-git-send-email-sebastien.guimmara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269626>

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
 command-list.txt            | 2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

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
