Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1E8C0015E
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 16:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjF0QTr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 12:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjF0QT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 12:19:26 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB5C35BC
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 09:19:13 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 6841C5A210;
        Tue, 27 Jun 2023 16:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1687882752;
        bh=CYaHfmG4GhZYVys0Wlv+KNo1dX7f2BsmB4EGN61z3Hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=gR8tRIcsRQNNuMkhx2ROCgetE7EYuz65qxtic6wkJrwUCXxeNuoyzhA5F2EE7bfi/
         daYo/T0SF3xg5fhAETrIU93usVimx2+ya7bVI1O7ZurqTs+U+pdPT4oRRcojCMis59
         9VT4r8rttTQrwfQNesGWee7+tIBg5gTDYN6t0di8Ug811FoYqmKPQb0Zds56usIq1G
         fdEgkSNrIoIdQzGgjiMQ1TN6XCbdkc4jDaICoR443ajU+jfAsPlFYEFctVZzu331Jg
         doqRp0wjJeLkhFxn8M2wooS7YNcuX4pC14IKYSsx/vX2MfbzrRQOGcyE3scF5puAYM
         fqkdiZSldGZ8aZLsMmao/Ig4uNEV3//dVFY+sUidcvv5aeDGfhPM7D2owyrLjfe9SH
         3a0GZrd56p1B5tf55+5Y9CBhZb2LGGyWQqMJNJcZaQ6uaDCi4Ox9HkousGxBj24xJk
         Neno9WdjAjzQmw9F6Ve9IQjEg5CFAJXCkAey7IUogrZG1hfqDva
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v3 0/8] Additional variables for git var
Date:   Tue, 27 Jun 2023 16:18:54 +0000
Message-ID: <20230627161902.754472-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8
In-Reply-To: <20230622195059.320593-1-sandals@crustytoothpaste.net>
References: <20230622195059.320593-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On many Unix systems, we have a good idea where Git's configuration
files and the shell it uses are located.  However, there are some
systems where that's not the case, such as Windows and with Homebrew,
where the expected files might be found in another location.

Right now, programs who would like to access things like the system
gitattributes or config file have to guess where the distributor of Git
placed these files, and with runtime relocation, it's not even
guaranteed that these will be in a fixed place from invocation to
invocation.  As a result, we need a way to query Git about the location
of these files.

This series introduces five new configuration variables that refer to
the shell path, the system and global gitattributes files, and the
system and global config files.  The global values are not technically
needed, since they should be computable from the environment alone, but
they are added to make life easier for users.

My intention is that this is the last round of this series, but if folks
have other comments, please let me know.

Changes since v2:
* Pick up Peff's patch.
* Rename function arguments.
* Mark unused function arguments as unused.

Changes since v1:
* Format variables with C99 initializers.
* Minimize use of temporary files in the tests.
* Remove debugging statement.
* Avoid grep where possible in tests.
* Duplicate memory rather than optionally choosing whether to free data.
* Add and document test_file_is_executable.
* Possibly more things which I have forgotten.

Jeff King (1):
  var: mark unused parameters in git_var callbacks

brian m. carlson (7):
  t: add a function to check executable bit
  var: add support for listing the shell
  var: format variable structure with C99 initializers
  var: adjust memory allocation for strings
  attr: expose and rename accessor functions
  var: add attributes files locations
  var: add config file locations

 Documentation/git-var.txt |  23 ++++++
 attr.c                    |  14 ++--
 attr.h                    |   9 ++
 builtin/var.c             | 167 +++++++++++++++++++++++++++++++++-----
 t/README                  |   6 ++
 t/t0007-git-var.sh        | 100 +++++++++++++++++++++++
 t/test-lib-functions.sh   |   9 ++
 7 files changed, 301 insertions(+), 27 deletions(-)

Range-diff against v2:
-:  ---------- > 1:  5ed9f04f5b var: mark unused parameters in git_var callbacks
1:  20b7b85e98 = 2:  e7b676b6ae t: add a function to check executable bit
2:  7d92b4155f ! 3:  eae2f049cc var: add support for listing the shell
    @@ Documentation/git-var.txt: endif::git-default-pager[]
      linkgit:git-commit-tree[1]
     
      ## builtin/var.c ##
    -@@ builtin/var.c: static const char *default_branch(int flag)
    +@@ builtin/var.c: static const char *default_branch(int ident_flag UNUSED)
      	return git_default_branch_name(1);
      }
      
    -+static const char *shell_path(int flag)
    ++static const char *shell_path(int ident_flag UNUSED)
     +{
     +	return SHELL_PATH;
     +}
3:  29c338d59c = 4:  884f7a2967 var: format variable structure with C99 initializers
4:  2a2a762c44 ! 5:  c609b0a05c var: adjust memory allocation for strings
    @@ builtin/var.c
      
      static const char var_usage[] = "git var (-l | <variable>)";
      
    --static const char *editor(int flag)
    -+static char *committer(int flag)
    +-static const char *editor(int ident_flag UNUSED)
    ++static char *committer(int ident_flag)
      {
     -	return git_editor();
    -+	return xstrdup_or_null(git_committer_info(flag));
    ++	return xstrdup_or_null(git_committer_info(ident_flag));
      }
      
    --static const char *sequence_editor(int flag)
    -+static char *author(int flag)
    +-static const char *sequence_editor(int ident_flag UNUSED)
    ++static char *author(int ident_flag)
      {
     -	return git_sequence_editor();
    -+	return xstrdup_or_null(git_author_info(flag));
    ++	return xstrdup_or_null(git_author_info(ident_flag));
      }
      
    --static const char *pager(int flag)
    -+static char *editor(int flag)
    +-static const char *pager(int ident_flag UNUSED)
    ++static char *editor(int ident_flag UNUSED)
     +{
     +	return xstrdup_or_null(git_editor());
     +}
     +
    -+static char *sequence_editor(int flag)
    ++static char *sequence_editor(int ident_flag UNUSED)
     +{
     +	return xstrdup_or_null(git_sequence_editor());
     +}
     +
    -+static char *pager(int flag)
    ++static char *pager(int ident_flag UNUSED)
      {
      	const char *pgm = git_pager(1);
      
    @@ builtin/var.c
     +	return xstrdup(pgm);
      }
      
    --static const char *default_branch(int flag)
    -+static char *default_branch(int flag)
    +-static const char *default_branch(int ident_flag UNUSED)
    ++static char *default_branch(int ident_flag UNUSED)
      {
     -	return git_default_branch_name(1);
     +	return xstrdup_or_null(git_default_branch_name(1));
      }
      
    --static const char *shell_path(int flag)
    -+static char *shell_path(int flag)
    +-static const char *shell_path(int ident_flag UNUSED)
    ++static char *shell_path(int ident_flag UNUSED)
      {
     -	return SHELL_PATH;
     +	return xstrdup(SHELL_PATH);
5:  c0c5c59df9 = 6:  d029af8675 attr: expose and rename accessor functions
6:  49a04bd142 ! 7:  334df489f0 var: add attributes files locations
    @@ builtin/var.c
      #include "config.h"
      #include "editor.h"
      #include "ident.h"
    -@@ builtin/var.c: static char *shell_path(int flag)
    +@@ builtin/var.c: static char *shell_path(int ident_flag UNUSED)
      	return xstrdup(SHELL_PATH);
      }
      
    -+static char *git_attr_val_system(int flag)
    ++static char *git_attr_val_system(int ident_flag UNUSED)
     +{
     +	if (git_attr_system_is_enabled()) {
     +		char *file = xstrdup(git_attr_system_file());
    @@ builtin/var.c: static char *shell_path(int flag)
     +	return NULL;
     +}
     +
    -+static char *git_attr_val_global(int flag)
    ++static char *git_attr_val_global(int ident_flag UNUSED)
     +{
     +	char *file = xstrdup(git_attr_global_file());
     +	if (file) {
7:  a8b4d9396b ! 8:  abf079a923 var: add config file locations
    @@ Documentation/git-var.txt: GIT_ATTR_SYSTEM::
      linkgit:git-commit-tree[1]
     
      ## builtin/var.c ##
    -@@ builtin/var.c: static char *git_attr_val_global(int flag)
    +@@ builtin/var.c: static char *git_attr_val_global(int ident_flag UNUSED)
      	return NULL;
      }
      
    -+static char *git_config_val_system(int flag)
    ++static char *git_config_val_system(int ident_flag UNUSED)
     +{
     +	if (git_config_system()) {
     +		char *file = git_system_config();
    @@ builtin/var.c: static char *git_attr_val_global(int flag)
     +	return NULL;
     +}
     +
    -+static char *git_config_val_global(int flag)
    ++static char *git_config_val_global(int ident_flag UNUSED)
     +{
     +	struct strbuf buf = STRBUF_INIT;
     +	char *user, *xdg;
    @@ builtin/var.c: static char *git_attr_val_global(int flag)
      };
      static struct git_var git_vars[] = {
      	{
    - 		.name = "GIT_COMMITTER_IDENT",
    - 		.read = committer,
    -+		.multivalued = 0,
    - 	},
    - 	{
    - 		.name = "GIT_AUTHOR_IDENT",
    - 		.read = author,
    -+		.multivalued = 0,
    - 	},
    - 	{
    - 		.name = "GIT_EDITOR",
    - 		.read = editor,
    -+		.multivalued = 0,
    - 	},
    - 	{
    - 		.name = "GIT_SEQUENCE_EDITOR",
    - 		.read = sequence_editor,
    -+		.multivalued = 0,
    - 	},
    - 	{
    - 		.name = "GIT_PAGER",
    - 		.read = pager,
    -+		.multivalued = 0,
    - 	},
    - 	{
    - 		.name = "GIT_DEFAULT_BRANCH",
    - 		.read = default_branch,
    -+		.multivalued = 0,
    - 	},
    - 	{
    - 		.name = "GIT_SHELL_PATH",
    - 		.read = shell_path,
    -+		.multivalued = 0,
    - 	},
    - 	{
    - 		.name = "GIT_ATTR_SYSTEM",
    - 		.read = git_attr_val_system,
    -+		.multivalued = 0,
    - 	},
    - 	{
    +@@ builtin/var.c: static struct git_var git_vars[] = {
      		.name = "GIT_ATTR_GLOBAL",
      		.read = git_attr_val_global,
    -+		.multivalued = 0,
    -+	},
    + 	},
     +	{
     +		.name = "GIT_CONFIG_SYSTEM",
     +		.read = git_config_val_system,
    -+		.multivalued = 0,
     +	},
     +	{
     +		.name = "GIT_CONFIG_GLOBAL",
     +		.read = git_config_val_global,
     +		.multivalued = 1,
    - 	},
    ++	},
      	{
      		.name = "",
      		.read = NULL,
    -+		.multivalued = 0,
    - 	},
    - };
    - 
     @@ builtin/var.c: static void list_vars(void)
      
      	for (ptr = git_vars; ptr->read; ptr++)
