Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D0521F463
	for <e@80x24.org>; Fri, 13 Sep 2019 01:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfIMBwu (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 21:52:50 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58658 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726694AbfIMBwu (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Sep 2019 21:52:50 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:9d62:8fc3:cc7d:8629])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6DAA260448;
        Fri, 13 Sep 2019 01:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1568339567;
        bh=NJIPAhKOpaodxxJNPtLOwVoYs9yZXdy2r5I3YXcdWu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=XWDPSyFcKzJUcofInTKyX8voQ1bGLLJza3GRw/SC08Hp5yYCScjYxGjJq1bf0vHVN
         Way/8Tss1PogvHn+hvnKqjY/ktnQ/tIWYCnlaIonY/VEHqSxx5gN696g9RW+r5AD26
         k7qvJONqjc0YL34a8p6YYLQtCn1Z6PH0OFJ4+iItff/tPRc6E5+vmskuEPQ3fTG2uP
         tPRclGu4t+tKWeEgXfXBIeF/FyxsS3gKJjX6BpPOP7VMxqc+YeOOqxk3zzC56Xodiw
         sQ30H0P2tYWLz5bgNq+M/km3WcmDO2hQ/cpbEiUnpHPFsFiSOyVN6ZZnu9H4xLlifl
         NCkT/a6mKg0DIpaqc4PUL4J77o96T6BqcfFYf+BBDrlytuNEyT5L87uznxiCZppNei
         cL2dmH9/OlJXrQYPjHYRWfxcsvagiE4fsB2zFChwmVWGwInT4G7P90qyDdGnGThRb4
         sX/GVjh4z0jr8JK+329Jmo0iMlBGfbOK4GAoOsj/VDdm0NH5UVp
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] Documentation: fix build with Asciidoctor 2
Date:   Fri, 13 Sep 2019 01:52:40 +0000
Message-Id: <20190913015240.686522-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.237.gc6a4ce50a0
In-Reply-To: <20190906232947.GJ11334@genre.crustytoothpaste.net>
References: <20190906232947.GJ11334@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our documentation toolchain has traditionally been built around DocBook
4.5.  This version of DocBook is the last DTD-based version of DocBook.
In 2009, DocBook 5 was introduced using namespaces and its syntax is
expressed in RELAX NG, which is more expressive and allows a wider
variety of syntax forms.

Asciidoctor, one of the alternatives for building our documentation,
moved support for DocBook 4.5 out of core in its recent 2.0 release and
now only supports DocBook 5 in the main release.  The DocBoook 4.5
converter is still available as a separate component, but this is not
available in most distro packages.  This would not be a problem but for
the fact that we use xmlto, which is still stuck in the DocBook 4.5 era.

xmlto performs DTD validation as part of the build process.  This is not
problematic for DocBook 4.5, which has a valid DTD, but it clearly
cannot work for DocBook 5, since no DTD can adequately express its full
syntax.  In addition, even if xmlto did support RELAX NG validation,
that wouldn't be sufficient because it uses the libxml2-based xmllint to
do so, which has known problems with validating interleaves in RELAX NG.

Fortunately, there's an easy way forward: ask Asciidoctor to use its
DocBook 5 backend and tell xmlto to skip validation.  Asciidoctor has
supported DocBook 5 since v0.1.4 in 2013 and xmlto has supported
skipping validation for probably longer than that.

We also need to teach xmlto how to use the namespaced DocBook XSLT
stylesheets instead of the non-namespaced ones it usually uses.
Normally these stylesheets are interchangeable, but the non-namespaced
ones have a bug that causes them not to strip whitespace automatically
from certain elements when namespaces are in use.  This results in
additional whitespace at the beginning of list elements, which is
jarring and unsightly.

We can do this by passing a custom stylesheet with the -x option that
simply imports the namespaced stylesheets via a URL.  Any system with
support for XML catalogs will automatically look this URL up and
reference a local copy instead without us having to know where this
local copy is located.  We know that anyone using xmlto will already
have catalogs set up properly since the DocBook 4.5 DTD used during
validation is also looked up via catalogs.  All major Linux
distributions distribute the necessary stylesheets and have built-in
catalog support, and Homebrew does as well, albeit with a requirement to
set an environment variable to enable catalog support.

On the off chance that someone lacks support for catalogs, it is
possible for xmlto (via xmllint) to download the stylesheets from the
URLs in question, although this will likely perform poorly enough to
attract attention.  People still have the option of using the prebuilt
documentation that we ship, so happily this should not be an impediment.

Finally, we need to filter out some messages from other stylesheets that
when invoking dblatex in the CI job.  This tool strips namespaces much
like the unnamespaced DocBook stylesheets and prints similar messages.
If we permit these messages to be printed to standard error, our
documentation CI job will because we check standard error for unexpected
output.  Due to dblatex's reliance on Python 2, we may need to revisit
its use in the future, in which case this problem may go away, but this
can be delayed until a future patch.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/Makefile    | 4 +++-
 Documentation/manpage.xsl | 3 +++
 ci/test-documentation.sh  | 2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/manpage.xsl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 76f2ecfc1b..d94f47c5c9 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -197,11 +197,13 @@ ifdef USE_ASCIIDOCTOR
 ASCIIDOC = asciidoctor
 ASCIIDOC_CONF =
 ASCIIDOC_HTML = xhtml5
-ASCIIDOC_DOCBOOK = docbook45
+ASCIIDOC_DOCBOOK = docbook5
 ASCIIDOC_EXTRA += -acompat-mode -atabsize=8
 ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
 ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
 DBLATEX_COMMON =
+XMLTO_EXTRA += --skip-validation
+XMLTO_EXTRA += -x manpage.xsl
 endif
 
 SHELL_PATH ?= $(SHELL)
diff --git a/Documentation/manpage.xsl b/Documentation/manpage.xsl
new file mode 100644
index 0000000000..ef64bab17a
--- /dev/null
+++ b/Documentation/manpage.xsl
@@ -0,0 +1,3 @@
+<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
+	<xsl:import href="http://docbook.sourceforge.net/release/xsl-ns/current/manpages/docbook.xsl" />
+</xsl:stylesheet>
diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index d49089832d..b3e76ef863 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -8,6 +8,8 @@
 filter_log () {
 	sed -e '/^GIT_VERSION = /d' \
 	    -e '/^    \* new asciidoc flags$/d' \
+	    -e '/stripped namespace before processing/d' \
+	    -e '/Attributed.*IDs for element/d' \
 	    "$1"
 }
 
