Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6F70208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 08:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbeHHLJx (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 07:09:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40968 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbeHHLJw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 07:09:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id j5-v6so1267100wrr.8
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 01:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fJzul7av3sB4yTc/NMmW0VZCs7TWMOr5/uAw69wgCTY=;
        b=nJtlhciE89sY9LJjpYiZ9TwleUV+jQrbZzZCdw1zb8hh2qG7o+egwKW54b4GuE59VU
         iXs99VkMbfz53H15iAxBufjW045Pajg1FLejszR0WSpyVJRAFCaUErI6I+eKNt3QSF6c
         9FmNm2BZ54PNUtfS0Omsu0BMF7+I8RmwVgKt0C5EafPMlsOQBuXzjQFUFKD97Fp3iwVF
         LzarVWFktX+O5SascpA2/Sk4jNDUGxUIQswOpeMe+cUI/R3+js4hMdzsX8lCKeNUced2
         waAUeQCawC2Vaey/ahj6CcbKlEww+Jpli+thZI0c2WWczCHz7TchAisF/ZNrAHjBmvy4
         92ow==
X-Gm-Message-State: AOUpUlGWzxBOSeBuRSuHt9wUoF00zRdPeqjKkwZt3JcGVaWwh8gnDkvR
        1KJdfzlrtVa1nkXhCR7n3CWMYcQknJoo6w==
X-Google-Smtp-Source: AA+uWPzDFKlus8xKhS5a42eKhkoOZTJOaGY/TKI62ZQU9lxMN1NAXc8Z739Yu9DBqq+yw7BbuSOdmA==
X-Received: by 2002:adf:e3c5:: with SMTP id k5-v6mr1318145wrm.94.1533718268360;
        Wed, 08 Aug 2018 01:51:08 -0700 (PDT)
Received: from skisela-redhat.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c129-v6sm6440173wmh.2.2018.08.08.01.51.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Aug 2018 01:51:07 -0700 (PDT)
From:   Sebastian Kisela <skisela@redhat.com>
To:     git@vger.kernel.org
Cc:     skisela@redhat.com
Subject: [PATCH 1/2] git-instaweb: support Fedora/Red Hat apache module path
Date:   Wed,  8 Aug 2018 10:49:18 +0200
Message-Id: <20180808084918.3424-2-skisela@redhat.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180808084918.3424-1-skisela@redhat.com>
References: <xmqqftzpkesb.fsf@gitster-ct.c.googlers.com>
 <20180808084918.3424-1-skisela@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fedora-derived systems, the apache httpd package installs modules
under /usr/lib{,64}/httpd/modules, depending on whether the system is
32- or 64-bit.  A symlink from /etc/httpd/modules is created which
points to the proper module path.  Use it to support apache on Fedora,
CentOS, and Red Hat systems.

Written with assistance of Todd Zullinger <tmz@pobox.com> and
Junio C Hamano <gitster@pobox.com>.

Signed-off-by: Sebastian Kisela <skisela@redhat.com>
---
 git-instaweb.sh | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 47e38f34c..675add184 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -326,13 +326,17 @@ EOF
 }
 
 apache2_conf () {
-	if test -z "$module_path"
-	then
-		test -d "/usr/lib/httpd/modules" &&
-			module_path="/usr/lib/httpd/modules"
-		test -d "/usr/lib/apache2/modules" &&
-			module_path="/usr/lib/apache2/modules"
-	fi
+	for candidate in \
+		/etc/httpd \
+		/usr/lib/apache2 \
+		/usr/lib/httpd ;
+	do
+		if test -d "$candidate/modules"
+		then
+			module_path="$candidate/modules"
+			break
+		fi
+	done
 	bind=
 	test x"$local" = xtrue && bind='127.0.0.1:'
 	echo 'text/css css' > "$fqgitdir/mime.types"
-- 
2.14.4

