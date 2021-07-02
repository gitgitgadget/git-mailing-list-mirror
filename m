Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CE8C11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 14:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 120316142E
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 14:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhGBO3R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 10:29:17 -0400
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:33926 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232882AbhGBO3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 10:29:16 -0400
Received: from coruscant.lhuard.fr (unknown [IPv6:2a01:e0a:465:5440:796c:f829:f2b6:ea8e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id 76FA54A58B1;
        Fri,  2 Jul 2021 16:26:36 +0200 (CEST)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1625235997; bh=O8mzmSVM01P9MX1EJ2l447uZlOhfXZ1dn4in8ud6tbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Nx0VCBM2Etv3ow6iUDsRLklkAP2NbR3pO2PGKDydyoakACG6z2r9CLWe/0JLLpe2k
         vIw1MNRoAnzgcNDdC7QTf7K1CPfZl9brI7AClt3xs8N0hwYGzWvK2ra5VztuHjOWPr
         FVXCPy+yCO5PP32g+OA2ZxeykOV6M02LGvZ73FEk=
From:   =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?L=C3=A9na=C3=AFc=20Huard?= <lenaic@lhuard.fr>
Subject: [PATCH v7 0/3] maintenance: add support for systemd timers on Linux
Date:   Fri,  2 Jul 2021 16:25:53 +0200
Message-Id: <20210702142556.99864-1-lenaic@lhuard.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210612165043.165579-1-lenaic@lhuard.fr>
References: <20210612165043.165579-1-lenaic@lhuard.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Please find hereafter a new reroll of my patchset to add support for
systemd timers on Linux for the `git maintenance start` command.

The changes compared to the previous version address the remarks
raised during the previous review.

The patches are:

* cache.h: Introduce a generic "xdg_config_home_for(…)" function

  This patch introduces a function to compute configuration files
  paths inside $XDG_CONFIG_HOME.
  It is used in the latest patch of this series to compute systemd
  unit files location.

  This patch is unchanged compared to its previous version.

* maintenance: `git maintenance run` learned `--scheduler=<scheduler>`

  This patch adds a new parameter to the `git maintenance run` to let
  the user choose a scheduler.

  This patch contains the following changes compared to its previous
  version:

  * `is_crontab_available` was not returning directly `is_available`
    under tests condition (when `GIT_TEST_MAINT_SCHEDULER` is set).
    This was indeed a bug as it means `cron` could be invoked by tests
    whereas it should be mocked.
    This is now fixed and `is_crontab_available` now has exactly the
    same behavior as the `is_systemd_timer_available` function that is
    introduced in the last patch.

  * The `get_schedule_cmd` function that centralizes the testing logic
    is now prefixed by a comment block describing its behavior and the
    expected values for the `GIT_TEST_MAINT_SCHEDULER` environment
    variable.

  * The help message for the `--scheduler` option of the `git
    maintenance start` command has been reworded following Eric’s
    suggestion.
    I’ve however kept the “When combined with the `start` subcommand…”
    opening to keep consistency with the other options documented on
    the same page.

  * `resolve_auto_scheduler` function has been renamed
    `resolve_scheduler` and it is now returning a value instead of
    altering its parameter.

* maintenance: add support for systemd timers on Linux

  This patch implements the support of systemd timers on top of
  crontab scheduler on Linux systems.

  The changes in this patch are only followups of changes mentioned in
  the previous patch:
  * `resolve_scheduler` is now returning a value instead of altering
  its parameter.

Best wishes,
Lénaïc.


Lénaïc Huard (3):
  cache.h: Introduce a generic "xdg_config_home_for(…)" function
  maintenance: `git maintenance run` learned `--scheduler=<scheduler>`
  maintenance: add support for systemd timers on Linux

 Documentation/git-maintenance.txt |  57 +++
 builtin/gc.c                      | 597 ++++++++++++++++++++++++++----
 cache.h                           |   7 +
 path.c                            |  13 +-
 t/t7900-maintenance.sh            | 110 +++++-
 5 files changed, 706 insertions(+), 78 deletions(-)

Diff-intervalle contre v6 :
-:  ---------- > 1:  899b11ed5b cache.h: Introduce a generic "xdg_config_home_for(…)" function
1:  604627f347 ! 2:  f3e2f0256b maintenance: `git maintenance run` learned `--scheduler=<scheduler>`
    @@ Documentation/git-maintenance.txt: OPTIONS
      
     +--scheduler=auto|crontab|launchctl|schtasks::
     +	When combined with the `start` subcommand, specify the scheduler
    -+	to use to run the hourly, daily and weekly executions of
    ++	for running the hourly, daily and weekly executions of
     +	`git maintenance run`.
    -+	The possible values for `<scheduler>` depend on the system: `crontab`
    -+	is available on POSIX systems, `launchctl` is available on
    -+	MacOS and `schtasks` is available on Windows.
    -+	By default or when `auto` is specified, a suitable scheduler for
    -+	the system is used. On MacOS, `launchctl` is used. On Windows,
    -+	`schtasks` is used. On all other systems, `crontab` is used.
    ++	Possible values for `<scheduler>` are `auto`, `crontab` (POSIX),
    ++	`launchctl` (macOS), and `schtasks` (Windows).
    ++	When `auto` is specified, the appropriate platform-specific
    ++	scheduler is used. Default is `auto`.
     +
      
      TROUBLESHOOTING
    @@ builtin/gc.c: static const char *get_frequency(enum schedule_priority schedule)
      	}
      }
      
    ++/*
    ++ * get_schedule_cmd` reads the GIT_TEST_MAINT_SCHEDULER environment variable
    ++ * to mock the schedulers that `git maintenance start` rely on.
    ++ *
    ++ * For test purpose, GIT_TEST_MAINT_SCHEDULER can be set to a comma-separated
    ++ * list of colon-separated key/value pairs where each pair contains a scheduler
    ++ * and its corresponding mock.
    ++ *
    ++ * * If $GET_TEST_MAINT_SCHEDULER is not set, return false and leave the
    ++ *   arguments unmodified.
    ++ *
    ++ * * If $GET_TEST_MAINT_SCHEDULER is set, return true.
    ++ *   In this case, the *cmd value is read as input.
    ++ *
    ++ *   * if the input value *cmd is the key of one of the comma-separated list
    ++ *     item, then *is_available is set to true and *cmd is modified and becomes
    ++ *     the mock command.
    ++ *
    ++ *   * if the input value *cmd isn’t the key of any of the comma-separated list
    ++ *     item, then *is_available is set to false.
    ++ *
    ++ * Ex.:
    ++ *   GIT_TEST_MAINT_SCHEDULER not set
    ++ *     ┏━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
    ++ *     ┃ Input ┃                     Output                      ┃
    ++ *     ┃ *cmd  ┃ return code │       *cmd        │ *is_available ┃
    ++ *     ┣━━━━━━━╋━━━━━━━━━━━━━┿━━━━━━━━━━━━━━━━━━━┿━━━━━━━━━━━━━━━┫
    ++ *     ┃ "foo" ┃    false    │ "foo" (unchanged) │  (unchanged)  ┃
    ++ *     ┗━━━━━━━┻━━━━━━━━━━━━━┷━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━━━━━━━┛
    ++ *
    ++ *   GIT_TEST_MAINT_SCHEDULER set to “foo:./mock_foo.sh,bar:./mock_bar.sh”
    ++ *     ┏━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
    ++ *     ┃ Input ┃                     Output                      ┃
    ++ *     ┃ *cmd  ┃ return code │       *cmd        │ *is_available ┃
    ++ *     ┣━━━━━━━╋━━━━━━━━━━━━━┿━━━━━━━━━━━━━━━━━━━┿━━━━━━━━━━━━━━━┫
    ++ *     ┃ "foo" ┃    true     │  "./mock.foo.sh"  │     true      ┃
    ++ *     ┃ "qux" ┃    true     │ "qux" (unchanged) │     false     ┃
    ++ *     ┗━━━━━━━┻━━━━━━━━━━━━━┷━━━━━━━━━━━━━━━━━━━┷━━━━━━━━━━━━━━━┛
    ++ */
     +static int get_schedule_cmd(const char **cmd, int *is_available)
     +{
     +	char *item;
    @@ builtin/gc.c: static int schtasks_schedule_task(const char *exec_path, enum sche
     +	int is_available;
     +	struct child_process child = CHILD_PROCESS_INIT;
     +
    -+	if (get_schedule_cmd(&cmd, &is_available) && !is_available)
    -+		return 0;
    ++	if (get_schedule_cmd(&cmd, &is_available))
    ++		return is_available;
     +
     +	strvec_split(&child.args, cmd);
     +	strvec_push(&child.args, "-l");
    @@ builtin/gc.c: static int crontab_update_schedule(int run_maintenance, int fd, co
     +	enum scheduler scheduler;
     +};
     +
    -+static void resolve_auto_scheduler(enum scheduler *scheduler)
    ++static enum scheduler resolve_scheduler(enum scheduler scheduler)
     +{
    -+	if (*scheduler != SCHEDULER_AUTO)
    -+		return;
    ++	if (scheduler != SCHEDULER_AUTO)
    ++		return scheduler;
     +
      #if defined(__APPLE__)
     -static const char platform_scheduler[] = "launchctl";
    -+	*scheduler = SCHEDULER_LAUNCHCTL;
    -+	return;
    ++	return SCHEDULER_LAUNCHCTL;
     +
      #elif defined(GIT_WINDOWS_NATIVE)
     -static const char platform_scheduler[] = "schtasks";
    -+	*scheduler = SCHEDULER_SCHTASKS;
    -+	return;
    ++	return SCHEDULER_SCHTASKS;
     +
      #else
     -static const char platform_scheduler[] = "crontab";
    -+	*scheduler = SCHEDULER_CRON;
    -+	return;
    ++	return SCHEDULER_CRON;
      #endif
     +}
      
    @@ builtin/gc.c: static int crontab_update_schedule(int run_maintenance, int fd, co
     +	if (scheduler == SCHEDULER_INVALID)
     +		BUG("invalid scheduler");
     +	if (scheduler == SCHEDULER_AUTO)
    -+		BUG("resolve_auto_scheduler should have been called before");
    ++		BUG("resolve_scheduler should have been called before");
     +
     +	if (!scheduler_fn[scheduler].is_available())
     +		die(_("%s scheduler is not available"),
    @@ builtin/gc.c: static int crontab_update_schedule(int run_maintenance, int fd, co
     +	struct option options[] = {
     +		OPT_CALLBACK_F(
     +			0, "scheduler", &opts.scheduler, N_("scheduler"),
    -+			N_("scheduler to use to trigger git maintenance run"),
    ++			N_("scheduler to trigger git maintenance run"),
     +			PARSE_OPT_NONEG, maintenance_opt_scheduler),
     +		OPT_END()
     +	};
    @@ builtin/gc.c: static int crontab_update_schedule(int run_maintenance, int fd, co
     +	if (argc)
     +		usage_with_options(builtin_maintenance_start_usage, options);
     +
    -+	resolve_auto_scheduler(&opts.scheduler);
    ++	opts.scheduler = resolve_scheduler(opts.scheduler);
     +	validate_scheduler(opts.scheduler);
     +
      	if (maintenance_register())
2:  29628b5a92 ! 3:  0ea5b2fc45 maintenance: add support for systemd timers on Linux
    @@ Documentation/git-maintenance.txt: OPTIONS
     ---scheduler=auto|crontab|launchctl|schtasks::
     +--scheduler=auto|crontab|systemd-timer|launchctl|schtasks::
      	When combined with the `start` subcommand, specify the scheduler
    - 	to use to run the hourly, daily and weekly executions of
    + 	for running the hourly, daily and weekly executions of
      	`git maintenance run`.
    - 	The possible values for `<scheduler>` depend on the system: `crontab`
    --	is available on POSIX systems, `launchctl` is available on
    --	MacOS and `schtasks` is available on Windows.
    -+	is available on POSIX systems, `systemd-timer` is available on Linux
    -+	systems, `launchctl` is available on MacOS and `schtasks` is available
    -+	on Windows.
    - 	By default or when `auto` is specified, a suitable scheduler for
    - 	the system is used. On MacOS, `launchctl` is used. On Windows,
    --	`schtasks` is used. On all other systems, `crontab` is used.
    -+	`schtasks` is used. On Linux, `systemd-timer` is used if user systemd
    -+	timers are available, otherwise, `crontab` is used. On all other systems,
    -+	`crontab` is used.
    +-	Possible values for `<scheduler>` are `auto`, `crontab` (POSIX),
    +-	`launchctl` (macOS), and `schtasks` (Windows).
    +-	When `auto` is specified, the appropriate platform-specific
    +-	scheduler is used. Default is `auto`.
    ++	Possible values for `<scheduler>` are `auto`, `crontab`
    ++	(POSIX), `systemd-timer` (Linux), `launchctl` (macOS), and
    ++	`schtasks` (Windows). When `auto` is specified, the
    ++	appropriate platform-specific scheduler is used; on Linux,
    ++	`systemd-timer` is used if available, otherwise
    ++	`crontab`. Default is `auto`.
      
      
      TROUBLESHOOTING
    @@ builtin/gc.c: static enum scheduler parse_scheduler(const char *value)
      	else if (!strcasecmp(value, "launchctl"))
      		return SCHEDULER_LAUNCHCTL;
      	else if (!strcasecmp(value, "schtasks"))
    -@@ builtin/gc.c: static void resolve_auto_scheduler(enum scheduler *scheduler)
    - 	*scheduler = SCHEDULER_SCHTASKS;
    - 	return;
    +@@ builtin/gc.c: static enum scheduler resolve_scheduler(enum scheduler scheduler)
    + #elif defined(GIT_WINDOWS_NATIVE)
    + 	return SCHEDULER_SCHTASKS;
      
     +#elif defined(__linux__)
     +	if (is_systemd_timer_available())
    -+		*scheduler = SCHEDULER_SYSTEMD;
    ++		return SCHEDULER_SYSTEMD;
     +	else if (is_crontab_available())
    -+		*scheduler = SCHEDULER_CRON;
    ++		return SCHEDULER_CRON;
     +	else
     +		die(_("neither systemd timers nor crontab are available"));
    -+	return;
     +
      #else
    - 	*scheduler = SCHEDULER_CRON;
    - 	return;
    + 	return SCHEDULER_CRON;
    + #endif
     
      ## t/t7900-maintenance.sh ##
     @@ t/t7900-maintenance.sh: test_xmllint () {
-- 
2.32.0

