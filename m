Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A845EB64DC
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 19:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjFZTA6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 15:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjFZTA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 15:00:56 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79013F2
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 12:00:52 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:5e4a:89fa:93b9:2058])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 3E99D5A1A8;
        Mon, 26 Jun 2023 19:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1687806051;
        bh=4utuC41RFnKmMallQj4+gZEs03Z/lDXoAKbb/EHPnFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=U+U6qi2y28UUf722D7qNw/5Z4xo0HLicfJsrhE4gcVt2tyoIN7eRgZlNRZN7zYkCs
         T2YmVg2PHMsJreEAdnPzQ5joVmLj0LzV848YqwxvtTmkGG0GvlPOCwOkrG+goS6ewq
         yLIDSdaObkCMdkOND3t7qR5+aaQoKolmEbWG9Rft4o7uJsCPUo8WxdKidXZD6UTs2e
         tRHJw0TUKYq7/GPbhjyji6sCnVlTbGsYTFVNlZbMSDJG7T0FWJh5kqqYGvNAJSi+ys
         FFFIE56sRYcTlpay2H9eky15n0p0TJ+hZuq8tmBkmHkON1jpwSeJRMW1wwYRWekJOG
         N4rXUMeSiCWURkjxXes9yjcIXsSCFBCDAGt/4V1ouXc2l3MmnHkjR4INKrihtX9GM9
         +Ix4llJBdisMgmtdEOwQrTWnksJ3QwW7F5V9aumPyKamGR9sVzWoWIIuJM+aNuzBdq
         zr+cD4HM1xgpJf3EgHBZLHcmKj9TFZSZ7aDd4qmcs8t7jcppvmu
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2 0/7]  Additional variables for git var
Date:   Mon, 26 Jun 2023 19:00:01 +0000
Message-ID: <20230626190008.644769-1-sandals@crustytoothpaste.net>
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

I have adopted most of the changes suggested, but I have specifically
not adopted the use of `.` in our tests instead of `$(pwd)`.  That
breaks the tests on Windows, the functionality of which has already been
the major portion of the time spent on this series despite careful
forethought about functionality there, and as a non-Windows user, I'm
simply not capable of or interested in futzing around with it more.
Parties who are unhappy with that are invited to send a follow-up patch
after this series lands.

Changes since v1:
* Format variables with C99 initializers.
* Minimize use of temporary files in the tests.
* Remove debugging statement.
* Avoid grep where possible in tests.
* Duplicate memory rather than optionally choosing whether to free data.
* Add and document test_file_is_executable.
* Possibly more things which I have forgotten.

brian m. carlson (7):
  t: add a function to check executable bit
  var: add support for listing the shell
  var: format variable structure with C99 initializers
  var: adjust memory allocation for strings
  attr: expose and rename accessor functions
  var: add attributes files locations
  var: add config file locations

 Documentation/git-var.txt |  23 +++++
 attr.c                    |  14 +--
 attr.h                    |   9 ++
 builtin/var.c             | 178 +++++++++++++++++++++++++++++++++-----
 t/README                  |   6 ++
 t/t0007-git-var.sh        | 100 +++++++++++++++++++++
 t/test-lib-functions.sh   |   9 ++
 7 files changed, 312 insertions(+), 27 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  20b7b85e98 t: add a function to check executable bit
1:  441dc45a86 ! 2:  7d92b4155f var: add support for listing the shell
    @@ t/t0007-git-var.sh: test_expect_success 'get GIT_SEQUENCE_EDITOR with configurat
      '
      
     +test_expect_success POSIXPERM 'GIT_SHELL_PATH points to a valid executable' '
    -+	git var GIT_SHELL_PATH >shell &&
    -+	test -x "$(cat shell)"
    ++	shellpath=$(git var GIT_SHELL_PATH) &&
    ++	test_path_is_executable "$shellpath"
     +'
     +
     +# We know in this environment that our shell will be one of a few fixed values
     +# that all end in "sh".
     +test_expect_success MINGW 'GIT_SHELL_PATH points to a suitable shell' '
    -+	git var GIT_SHELL_PATH >shell &&
    -+	grep "sh\$" shell
    ++	shellpath=$(git var GIT_SHELL_PATH) &&
    ++	case "$shellpath" in
    ++	*sh) ;;
    ++	*) return 1;;
    ++	esac
     +'
     +
      # For git var -l, we check only a representative variable;
2:  3b6935f226 < -:  ---------- var: add attributes files locations
-:  ---------- > 3:  29c338d59c var: format variable structure with C99 initializers
-:  ---------- > 4:  2a2a762c44 var: adjust memory allocation for strings
-:  ---------- > 5:  c0c5c59df9 attr: expose and rename accessor functions
-:  ---------- > 6:  49a04bd142 var: add attributes files locations
3:  6a2b5494dd ! 7:  a8b4d9396b var: add config file locations
    @@ Documentation/git-var.txt: GIT_ATTR_SYSTEM::
      linkgit:git-commit-tree[1]
     
      ## builtin/var.c ##
    -@@ builtin/var.c: static const char *git_attr_val_global(int flag)
    +@@ builtin/var.c: static char *git_attr_val_global(int flag)
      	return NULL;
      }
      
    -+static const char *git_config_val_system(int flag)
    ++static char *git_config_val_system(int flag)
     +{
     +	if (git_config_system()) {
     +		char *file = git_system_config();
    @@ builtin/var.c: static const char *git_attr_val_global(int flag)
     +	return NULL;
     +}
     +
    -+static const char *git_config_val_global(int flag)
    ++static char *git_config_val_global(int flag)
     +{
     +	struct strbuf buf = STRBUF_INIT;
     +	char *user, *xdg;
    @@ builtin/var.c: static const char *git_attr_val_global(int flag)
     +
      struct git_var {
      	const char *name;
    - 	const char *(*read)(int);
    + 	char *(*read)(int);
     +	int multivalued;
    - 	int free;
      };
      static struct git_var git_vars[] = {
    --	{ "GIT_COMMITTER_IDENT", git_committer_info, 0 },
    --	{ "GIT_AUTHOR_IDENT",   git_author_info, 0 },
    --	{ "GIT_EDITOR", editor, 0 },
    --	{ "GIT_SEQUENCE_EDITOR", sequence_editor, 0 },
    --	{ "GIT_PAGER", pager, 0 },
    --	{ "GIT_DEFAULT_BRANCH", default_branch, 0 },
    --	{ "GIT_SHELL_PATH", shell_path, 0 },
    --	{ "GIT_ATTR_SYSTEM", git_attr_val_system, 1 },
    --	{ "GIT_ATTR_GLOBAL", git_attr_val_global, 1 },
    -+	{ "GIT_COMMITTER_IDENT", git_committer_info, 0, 0 },
    -+	{ "GIT_AUTHOR_IDENT",   git_author_info, 0, 0 },
    -+	{ "GIT_EDITOR", editor, 0, 0 },
    -+	{ "GIT_SEQUENCE_EDITOR", sequence_editor, 0, 0 },
    -+	{ "GIT_PAGER", pager, 0, 0 },
    -+	{ "GIT_DEFAULT_BRANCH", default_branch, 0, 9 },
    -+	{ "GIT_SHELL_PATH", shell_path, 0, 0 },
    -+	{ "GIT_ATTR_SYSTEM", git_attr_val_system, 0, 1 },
    -+	{ "GIT_ATTR_GLOBAL", git_attr_val_global, 0, 1 },
    -+	{ "GIT_CONFIG_SYSTEM", git_config_val_system, 0, 1 },
    -+	{ "GIT_CONFIG_GLOBAL", git_config_val_global, 1, 1 },
    - 	{ "", NULL },
    + 	{
    + 		.name = "GIT_COMMITTER_IDENT",
    + 		.read = committer,
    ++		.multivalued = 0,
    + 	},
    + 	{
    + 		.name = "GIT_AUTHOR_IDENT",
    + 		.read = author,
    ++		.multivalued = 0,
    + 	},
    + 	{
    + 		.name = "GIT_EDITOR",
    + 		.read = editor,
    ++		.multivalued = 0,
    + 	},
    + 	{
    + 		.name = "GIT_SEQUENCE_EDITOR",
    + 		.read = sequence_editor,
    ++		.multivalued = 0,
    + 	},
    + 	{
    + 		.name = "GIT_PAGER",
    + 		.read = pager,
    ++		.multivalued = 0,
    + 	},
    + 	{
    + 		.name = "GIT_DEFAULT_BRANCH",
    + 		.read = default_branch,
    ++		.multivalued = 0,
    + 	},
    + 	{
    + 		.name = "GIT_SHELL_PATH",
    + 		.read = shell_path,
    ++		.multivalued = 0,
    + 	},
    + 	{
    + 		.name = "GIT_ATTR_SYSTEM",
    + 		.read = git_attr_val_system,
    ++		.multivalued = 0,
    + 	},
    + 	{
    + 		.name = "GIT_ATTR_GLOBAL",
    + 		.read = git_attr_val_global,
    ++		.multivalued = 0,
    ++	},
    ++	{
    ++		.name = "GIT_CONFIG_SYSTEM",
    ++		.read = git_config_val_system,
    ++		.multivalued = 0,
    ++	},
    ++	{
    ++		.name = "GIT_CONFIG_GLOBAL",
    ++		.read = git_config_val_global,
    ++		.multivalued = 1,
    + 	},
    + 	{
    + 		.name = "",
    + 		.read = NULL,
    ++		.multivalued = 0,
    + 	},
      };
      
     @@ builtin/var.c: static void list_vars(void)
    @@ builtin/var.c: static void list_vars(void)
     +			} else {
     +				printf("%s=%s\n", ptr->name, val);
     +			}
    - 			if (ptr->free)
    - 				free((void *)val);
    + 			free(val);
      		}
    + }
     
      ## t/t0007-git-var.sh ##
     @@ t/t0007-git-var.sh: test_expect_success 'GIT_ATTR_GLOBAL points to the correct location' '
    @@ t/t0007-git-var.sh: test_expect_success 'GIT_ATTR_GLOBAL points to the correct l
     +	test_must_fail env GIT_CONFIG_NOSYSTEM=1 git var GIT_CONFIG_SYSTEM &&
     +	(
     +		sane_unset GIT_CONFIG_NOSYSTEM &&
    -+		git var GIT_CONFIG_SYSTEM >path &&
    -+		test "$(cat path)" != "" &&
    -+		GIT_CONFIG_SYSTEM=/dev/null git var GIT_CONFIG_SYSTEM >path &&
    ++		systempath=$(git var GIT_CONFIG_SYSTEM) &&
    ++		test "$systempath" != "" &&
    ++		systempath=$(GIT_CONFIG_SYSTEM=/dev/null git var GIT_CONFIG_SYSTEM) &&
     +		if test_have_prereq MINGW
     +		then
    -+			test "$(cat path)" = "nul"
    ++			test "$systempath" = "nul"
     +		else
    -+			test "$(cat path)" = "/dev/null"
    ++			test "$systempath" = "/dev/null"
     +		fi &&
    -+		GIT_CONFIG_SYSTEM="$TRASHDIR/gitconfig" git var GIT_CONFIG_SYSTEM >path &&
    -+		test "$(cat path)" = "$TRASHDIR/gitconfig"
    ++		systempath=$(GIT_CONFIG_SYSTEM="$TRASHDIR/gitconfig" git var GIT_CONFIG_SYSTEM) &&
    ++		test "$systempath" = "$TRASHDIR/gitconfig"
     +	)
     +'
     +
    @@ t/t0007-git-var.sh: test_expect_success 'GIT_ATTR_GLOBAL points to the correct l
     +		echo "$TRASHDIR/.config/git/config" >expected &&
     +		echo "$TRASHDIR/.gitconfig" >>expected &&
     +		test_cmp expected actual &&
    -+		GIT_CONFIG_GLOBAL=/dev/null git var GIT_CONFIG_GLOBAL >path &&
    ++		globalpath=$(GIT_CONFIG_GLOBAL=/dev/null git var GIT_CONFIG_GLOBAL) &&
     +		if test_have_prereq MINGW
     +		then
    -+			test "$(cat path)" = "nul"
    ++			test "$globalpath" = "nul"
     +		else
    -+			test "$(cat path)" = "/dev/null"
    ++			test "$globalpath" = "/dev/null"
     +		fi &&
    -+		GIT_CONFIG_GLOBAL="$TRASHDIR/gitconfig" git var GIT_CONFIG_GLOBAL >path &&
    -+		test "$(cat path)" = "$TRASHDIR/gitconfig"
    ++		globalpath=$(GIT_CONFIG_GLOBAL="$TRASHDIR/gitconfig" git var GIT_CONFIG_GLOBAL) &&
    ++		test "$globalpath" = "$TRASHDIR/gitconfig"
     +	)
     +'
     +
    @@ t/t0007-git-var.sh: test_expect_success 'git var -l lists config' '
     +		export GIT_EDITOR &&
     +		echo "GIT_EDITOR=$GIT_EDITOR" >expected &&
     +		git var -l >var &&
    -+		cat var &&
     +		sed -n -e "/^GIT_EDITOR/,\$p" var | head -n 3 >actual &&
     +		test_cmp expected actual
     +	)
