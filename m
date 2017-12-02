Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9284720A40
	for <e@80x24.org>; Sat,  2 Dec 2017 12:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751675AbdLBMU5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 07:20:57 -0500
Received: from smtpo.poczta.interia.pl ([217.74.65.238]:35758 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751568AbdLBMU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 07:20:56 -0500
X-Interia-R: Interia
X-Interia-R-IP: 199.127.226.61
X-Interia-R-Helo: <localhost>
Received: from localhost (unknown [199.127.226.61])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by www.poczta.fm (INTERIA.PL) with ESMTPSA;
        Sat,  2 Dec 2017 13:20:51 +0100 (CET)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
        Stefan Beller <sbeller@google.com>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <stlman@poczta.fm>
Subject: [PATCH v2] git-gui: Prevent double UTF-8 conversion
Date:   Sat,  2 Dec 2017 13:20:46 +0100
Message-Id: <20171202122046.6033-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20171128102126.20864-1-l.stelmach@samsung.com>
Content-Transfer-Encoding: 8bit
X-Interia-Antivirus: OK
X-IPL-POID: 4
X-IPL-SAS-SPAS: 1.4
X-IPL-SAS-UREP: 0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1512217255;
        bh=Lr54HrRJA/yi9MZQgpRfZIopxfM0fkgXsrnb9p0jHm4=;
        h=X-Interia-R:X-Interia-R-IP:X-Interia-R-Helo:From:To:Cc:Subject:
         Date:Message-Id:X-Mailer:MIME-Version:Content-Type:In-Reply-To:
         Content-Transfer-Encoding:X-Interia-Antivirus:X-IPL-POID:
         X-IPL-SAS-SPAS:X-IPL-SAS-UREP;
        b=aNn8BtE/wa6AeHQwWTasP+RBaRRsXiEe5phORFD90ZgiQUHgy8nWblh43XdOrbyks
         hQTfmh/YtoVabIGtTSKbvOiLcTiVZwFCVmqk7QaWCpx6Sn5UsR1hAzIShQZ+3UzPsC
         RKnQ8N2pnq7oQR3rGSqgE0r72rSqzGsB4y6NCY7A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert author's name from the UTF-8 (or any other) encoding in
load_last_commit function the same way commit message is converted.

Amending commits in git-gui without such conversion breaks UTF-8
strings. For example, "\305\201ukasz" (as written by git cat-file) becomes
"\303\205\302\201ukasz" in an amended commit.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 git-gui/lib/commit.tcl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
index 83620b7cb..f820c24bf 100644
--- a/git-gui/lib/commit.tcl
+++ b/git-gui/lib/commit.tcl
@@ -34,9 +34,7 @@ You are currently in the middle of a merge that has not been fully completed.  Y
 					lappend parents [string range $line 7 end]
 				} elseif {[string match {encoding *} $line]} {
 					set enc [string tolower [string range $line 9 end]]
-				} elseif {[regexp "author (.*)\\s<(.*)>\\s(\\d.*$)" $line all name email time]} {
-					set commit_author [list name $name email $email date $time]
-				}
+				} elseif {[regexp "author (.*)\\s<(.*)>\\s(\\d.*$)" $line all name email time]} { }
 			}
 			set msg [read $fd]
 			close $fd
@@ -44,7 +42,9 @@ You are currently in the middle of a merge that has not been fully completed.  Y
 			set enc [tcl_encoding $enc]
 			if {$enc ne {}} {
 				set msg [encoding convertfrom $enc $msg]
+				set name [encoding convertfrom $enc $name]
 			}
+			set commit_author [list name $name email $email date $time]
 			set msg [string trim $msg]
 		} err]} {
 		error_popup [strcat [mc "Error loading commit data for amend:"] "\n\n$err"]
-- 
2.11.0

