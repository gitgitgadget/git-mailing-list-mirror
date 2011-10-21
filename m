From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Add simple test for Git::config_path() in t/t9700-perl-git.sh
Date: Fri, 21 Oct 2011 20:42:44 +0200
Message-ID: <20111021184202.26990.45856.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Cord Seele <cowose@googlemail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Cord Seele <cowose@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 20:43:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHK4D-00057z-Ik
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 20:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834Ab1JUSnh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Oct 2011 14:43:37 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38260 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804Ab1JUSng (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 14:43:36 -0400
Received: by bkbzt19 with SMTP id zt19so5162136bkb.19
        for <git@vger.kernel.org>; Fri, 21 Oct 2011 11:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=+cAOUDRl0yu1IHNypQz3Nph9DCBaGYKwDnLaNVh+QsA=;
        b=qiOQRQluLnKrOxsNyjl6iJOPmS++DIjJTgo2md6KVV7BSw4QW5sbfyIqXG6k43RKB3
         nf9ylJ3+WqyIQKqzdQyL/DwOkSixT+VEa2cVDxRIxhj3IW05X1amDSWjFkxZX9nK+9K9
         5dHF9FwZAxhrXUf/m2rysBh3YLhGVrllymcE8=
Received: by 10.204.7.199 with SMTP id e7mr11335547bke.40.1319222614774;
        Fri, 21 Oct 2011 11:43:34 -0700 (PDT)
Received: from localhost.localdomain (abwe57.neoplus.adsl.tpnet.pl. [83.8.228.57])
        by mx.google.com with ESMTPS id v20sm2553364faf.1.2011.10.21.11.43.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Oct 2011 11:43:33 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p9LIgirA027051;
	Fri, 21 Oct 2011 20:42:55 +0200
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184077>

Tests "~/foo" path expansion and multiple values.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 t/t9700-perl-git.sh |    6 +++++-
 t/t9700/test.pl     |    4 ++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index 3787186..435d896 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -43,7 +43,11 @@ test_expect_success \
      git config --add test.booltrue true &&
      git config --add test.boolfalse no &&
      git config --add test.boolother other &&
-     git config --add test.int 2k
+     git config --add test.int 2k &&
+     git config --add test.path "~/foo" &&
+     git config --add test.pathexpanded "$HOME/foo" &&
+     git config --add test.pathmulti foo &&
+     git config --add test.pathmulti bar
      '
 
 # The external test will outputs its own plan
diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 13ba96e..3b9b484 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -33,6 +33,10 @@ is($r->config_int("test.int"), 2048, "config_int: integer");
 is($r->config_int("test.nonexistent"), undef, "config_int: nonexistent");
 ok($r->config_bool("test.booltrue"), "config_bool: true");
 ok(!$r->config_bool("test.boolfalse"), "config_bool: false");
+is($r->config_path("test.path"), $r->config("test.pathexpanded"),
+   "config_path: ~/foo expansion");
+is_deeply([$r->config_path("test.pathmulti")], ["foo", "bar"],
+   "config_path: multiple values");
 our $ansi_green = "\x1b[32m";
 is($r->get_color("color.test.slot1", "red"), $ansi_green, "get_color");
 # Cannot test $r->get_colorbool("color.foo")) because we do not
