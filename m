From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v9 1/5] command-list: prepare machinery for upcoming "common groups" section
Date: Wed, 20 May 2015 21:22:57 +0200
Message-ID: <1432149781-24596-2-git-send-email-sebastien.guimmara@gmail.com>
References: <1432149781-24596-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sunshine@sunshineco.com, gitster@pobox.com,
	=?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 21:23:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv9aT-0002WQ-AJ
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 21:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753302AbbETTXX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2015 15:23:23 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36435 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbbETTXW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 15:23:22 -0400
Received: by wizk4 with SMTP id k4so166473082wiz.1
        for <git@vger.kernel.org>; Wed, 20 May 2015 12:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lDb07jrT2PxOI5Wtz0qeMWLT2vIC7/dpkJhXlCvBE5A=;
        b=f9taPp9EmLUNdxWcm0UYIXopTGS+9NMjchShBrEcO0Vj6yJJPAfZLvU/chhhrVHCUj
         q/uRbSyRzOVWFOlCjzOn1ydDNtUTmYlnmUQ7mSOpbiCTMFTtCJGk1xDyumRsKnPRSMC9
         P6Sl56WQMX2+XlayrUIEvs7BHZu3gROgBfIyeo72tYugIkOIdy5HTBD/ujrbZN5FEjpr
         5iAq9btp6jDxMEPZ2BbClerF/0nq44v+cMsi5G4s/89iThkVwTiTaMGWtDo2L6LfE+Hx
         zPFFepzUNbivd/k5Bh48mPIpHRgNNz+r7NyTDLGwWr14r/YB4fiZI5ruNCfxlpm4WLHa
         rzYA==
X-Received: by 10.194.205.225 with SMTP id lj1mr67752137wjc.138.1432149800981;
        Wed, 20 May 2015 12:23:20 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id bm9sm28320276wjc.21.2015.05.20.12.23.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 May 2015 12:23:20 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.GIT
In-Reply-To: <1432149781-24596-1-git-send-email-sebastien.guimmara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269497>

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
