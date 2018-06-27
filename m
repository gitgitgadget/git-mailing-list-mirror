Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E78E21F516
	for <e@80x24.org>; Wed, 27 Jun 2018 04:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751740AbeF0E4k (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 00:56:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52499 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751486AbeF0E4j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 00:56:39 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 31026E8217
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 00:56:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id; s=sasl; bh=h+3UiNtWyyNnqlbcyU9wKTEx9Mw
        =; b=FXALFQGcP5Ec5DseW82UbW+bpygHSnUBqJfRiA34kwFAJqf1ZdcH269atoA
        n+BnuVNjQcy8/gsDHsQ0Yy5G/zMbXDmee7/9Exr8PVlJKmLFi00KBmHsnEQtrh6p
        6ZPuqfmK/p2hKRz6qO1p5dN5h4cW/3q0njwjxSvXsODeuUNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id; q=dns; s=sasl; b=iVq0tEzumBfr8+Zxf2Rbjusv6c2+W
        Rg9llEizaGyz3gwv37zk2GsQVleT1nzeTYyoUVrouaTj8lNtISb178Asz+jpMCoN
        /Ii0qpSmSz0+Bh50M3nC84dIKv+p9h2M6Y1xR+MqSyXqAIqS29HRvyyA7Z0W2AcJ
        qNR+ZJhYMYRsi0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A30FE8216
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 00:56:39 -0400 (EDT)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.87.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 95651E8215
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 00:56:38 -0400 (EDT)
From:   Todd Zullinger <tmz@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] doc: substitute ETC_GIT(CONFIG|ATTRIBUTES) in generated docs
Date:   Wed, 27 Jun 2018 00:56:37 -0400
Message-Id: <20180627045637.13818-1-tmz@pobox.com>
X-Mailer: git-send-email 2.18.0
X-Pobox-Relay-ID: 79AE2182-79C6-11E8-B9AD-40570C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace `$(prefix)/etc/gitconfig` and `$(prefix)/etc/gitattributes` in
generated documentation with the paths chosen when building.  Readers of
the documentation should not need to know how `$(prefix)` was defined.

It's also more consistent than sometimes using `$(prefix)/etc/gitconfig`
and other times using `/etc/gitconfig` to refer to the system-wide
config file.

Update the SYNOPSIS of gitattributes(5) to include the system-wide
config file as well.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
I noticed this while looking to update gitattributes.txt to
note the system-wide config file.  I tested with and without
RUNTIME_PREFIX as well as make gitattributes.5 from within
Documentation.  I believe all methods do the right thing.

I couldn't figure out a good way to have asciidoc expand the
attributes inside of a "`" literal, so I changed to the "+"
form.  There might be a better way to do this, passing subs=
in asciidoc.conf, but I wasn't clear on where that would
fit.  I tested with asciidoc and not asciidoctor.

 Documentation/Makefile          | 13 +++++++++++++
 Documentation/config.txt        |  4 ++--
 Documentation/git-config.txt    | 10 +++++-----
 Documentation/git.txt           |  4 ++--
 Documentation/gitattributes.txt |  4 ++--
 5 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d079d7c73a..75af671798 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -95,6 +95,7 @@ DOC_MAN7 = $(patsubst %.txt,%.7,$(MAN7_TXT))
 
 prefix ?= $(HOME)
 bindir ?= $(prefix)/bin
+sysconfdir ?= $(prefix)/etc
 htmldir ?= $(prefix)/share/doc/git-doc
 infodir ?= $(prefix)/share/info
 pdfdir ?= $(prefix)/share/doc/git-doc
@@ -205,6 +206,18 @@ DEFAULT_EDITOR_SQ = $(subst ','\'',$(DEFAULT_EDITOR))
 ASCIIDOC_EXTRA += -a 'git-default-editor=$(DEFAULT_EDITOR_SQ)'
 endif
 
+ifndef ETC_GITCONFIG
+ETC_GITCONFIG = $(sysconfdir)/gitconfig
+endif
+ETC_GITCONFIG_SQ = $(subst ','\'',$(ETC_GITCONFIG))
+ASCIIDOC_EXTRA += -a 'etc-gitconfig=$(ETC_GITCONFIG_SQ)'
+
+ifndef ETC_GITATTRIBUTES
+ETC_GITATTRIBUTES = $(sysconfdir)/gitattributes
+endif
+ETC_GITATTRIBUTES_SQ = $(subst ','\'',$(ETC_GITATTRIBUTES))
+ASCIIDOC_EXTRA += -a 'etc-gitattributes=$(ETC_GITATTRIBUTES_SQ)'
+
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1  =
 
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1cc18a828c..ed903b60bd 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -5,7 +5,7 @@ The Git configuration file contains a number of variables that affect
 the Git commands' behavior. The `.git/config` file in each repository
 is used to store the configuration for that repository, and
 `$HOME/.gitconfig` is used to store a per-user configuration as
-fallback values for the `.git/config` file. The file `/etc/gitconfig`
+fallback values for the `.git/config` file. The file +{etc-gitconfig}+
 can be used to store a system-wide default configuration.
 
 The configuration variables are used by both the Git plumbing
@@ -2815,7 +2815,7 @@ configuration files (e.g. `$HOME/.gitconfig`).
 
 Example:
 
-/etc/gitconfig
+{etc-gitconfig}
   push.pushoption = a
   push.pushoption = b
 
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 18ddc78f42..0d5ea5b58e 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -114,10 +114,10 @@ See also <<FILES>>.
 
 --system::
 	For writing options: write to system-wide
-	`$(prefix)/etc/gitconfig` rather than the repository
+	+{etc-gitconfig}+ rather than the repository
 	`.git/config`.
 +
-For reading options: read only from system-wide `$(prefix)/etc/gitconfig`
+For reading options: read only from system-wide +{etc-gitconfig}+
 rather than from all available files.
 +
 See also <<FILES>>.
@@ -263,7 +263,7 @@ FILES
 If not set explicitly with `--file`, there are four files where
 'git config' will search for configuration options:
 
-$(prefix)/etc/gitconfig::
+{etc-gitconfig}::
 	System-wide configuration file.
 
 $XDG_CONFIG_HOME/git/config::
@@ -310,11 +310,11 @@ ENVIRONMENT
 GIT_CONFIG::
 	Take the configuration from the given file instead of .git/config.
 	Using the "--global" option forces this to ~/.gitconfig. Using the
-	"--system" option forces this to $(prefix)/etc/gitconfig.
+	"--system" option forces this to {etc-gitconfig}.
 
 GIT_CONFIG_NOSYSTEM::
 	Whether to skip reading settings from the system-wide
-	$(prefix)/etc/gitconfig file. See linkgit:git[1] for details.
+	{etc-gitconfig} file. See linkgit:git[1] for details.
 
 See also <<FILES>>.
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
index dba7f0c18e..6a4646f991 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -567,10 +567,10 @@ for further details.
 
 `GIT_CONFIG_NOSYSTEM`::
 	Whether to skip reading settings from the system-wide
-	`$(prefix)/etc/gitconfig` file.  This environment variable can
+	+{etc-gitconfig}+ file.  This environment variable can
 	be used along with `$HOME` and `$XDG_CONFIG_HOME` to create a
 	predictable environment for a picky script, or you can set it
-	temporarily to avoid using a buggy `/etc/gitconfig` file while
+	temporarily to avoid using a buggy +{etc-gitconfig}+ file while
 	waiting for someone with sufficient permissions to fix it.
 
 `GIT_FLUSH`::
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 92010b062e..528de42593 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -7,7 +7,7 @@ gitattributes - Defining attributes per path
 
 SYNOPSIS
 --------
-$GIT_DIR/info/attributes, .gitattributes
+{etc-gitattributes}, $GIT_DIR/info/attributes, .gitattributes
 
 
 DESCRIPTION
@@ -93,7 +93,7 @@ for a single user should be placed in a file specified by the
 Its default value is $XDG_CONFIG_HOME/git/attributes. If $XDG_CONFIG_HOME
 is either not set or empty, $HOME/.config/git/attributes is used instead.
 Attributes for all users on a system should be placed in the
-`$(prefix)/etc/gitattributes` file.
++{etc-gitattributes}+ file.
 
 Sometimes you would need to override a setting of an attribute
 for a path to `Unspecified` state.  This can be done by listing
-- 
2.18.0

