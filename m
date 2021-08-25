Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD43C4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 00:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F1D161176
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 00:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbhHYAud (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 20:50:33 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64773 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbhHYAuc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 20:50:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 96605F2918;
        Tue, 24 Aug 2021 20:49:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=6us9BwJVrKTZJznMsnE43n+PSO6IQ9yJWHGCLJvPx6k=; b=HC8c
        q5yYD/6cQCJa+uMktKlkz87nDRsDkj8NdQ2qIXC2cuq2EkdEZNmuRRG9FS6kpiHi
        8pNheLJldAxXwJ2YgN4SvjtPL2PlcYImx0RCzZkp7BKb6KgOiCYxMmzQIslbd/RM
        EkvRnEa7+3AMLsdVSVx32liD52+68fIqYcKQNig=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D8ACF2917;
        Tue, 24 Aug 2021 20:49:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1B8FAF2916;
        Tue, 24 Aug 2021 20:49:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] macos: safeguard git maintenance against highly
 concurrent operations
References: <pull.1024.git.1629819840.gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 17:49:46 -0700
Message-ID: <xmqqwnoajql1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 586D65B2-053E-11EC-9072-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Please note that this patch series conflicts with lh/systemd-timers,
> although in a trivial way: the latter changes the signature of
> launchctl_schedule_plist() to lose its cmd parameter. The resolution is to
> adjust the conflicting code to lose the cmd parameter, and also drop it from
> launchctl_list_contains_plist() (and define it in the same way as
> launchctl_boot_plist() does). I assume that lh/systemd-timers will advance
> to next pretty soon; I plan on rebasing this patch series on top of it at
> that stage.

Sounds like a plan.

Here is my attempt to merge lh/systemd-timers into the result of
applying these two to 'master', with focus on the top part of the
launchctl_schedule_plist().  Sanity-checking is appreciated.

diff --cc builtin/gc.c
index 22e670b508,6a57d0fde5..0000000000
--- i/builtin/gc.c
+++ w/builtin/gc.c
@@@ -1593,48 -1678,26 +1678,50 @@@ static int launchctl_remove_plist(enum 
  	return result;
  }
  
- static int launchctl_remove_plists(const char *cmd)
+ static int launchctl_remove_plists(void)
  {
- 	return launchctl_remove_plist(SCHEDULE_HOURLY, cmd) ||
- 		launchctl_remove_plist(SCHEDULE_DAILY, cmd) ||
- 		launchctl_remove_plist(SCHEDULE_WEEKLY, cmd);
+ 	return launchctl_remove_plist(SCHEDULE_HOURLY) ||
+ 	       launchctl_remove_plist(SCHEDULE_DAILY) ||
+ 	       launchctl_remove_plist(SCHEDULE_WEEKLY);
  }
  
 +static int launchctl_list_contains_plist(const char *name, const char *cmd)
 +{
 +	int result;
 +	struct child_process child = CHILD_PROCESS_INIT;
 +	char *uid = launchctl_get_uid();
 +
 +	strvec_split(&child.args, cmd);
 +	strvec_pushl(&child.args, "list", name, NULL);
 +
 +	child.no_stderr = 1;
 +	child.no_stdout = 1;
 +
 +	if (start_command(&child))
 +		die(_("failed to start launchctl"));
 +
 +	result = finish_command(&child);
 +
 +	free(uid);
 +
 +	/* Returns failure if 'name' doesn't exist. */
 +	return !result;
 +}
 +
- static int launchctl_schedule_plist(const char *exec_path, enum schedule_priority schedule, const char *cmd)
+ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priority schedule)
  {
 -	FILE *plist;
 -	int i;
 +	int i, fd;
  	const char *preamble, *repeat;
  	const char *frequency = get_frequency(schedule);
  	char *name = launchctl_service_name(frequency);
  	char *filename = launchctl_service_filename(name);
 +	struct lock_file lk = LOCK_INIT;
 +	static unsigned long lock_file_timeout_ms = ULONG_MAX;
 +	struct strbuf plist = STRBUF_INIT, plist2 = STRBUF_INIT;
 +	struct stat st;
++	const char *cmd = "launchctl";
  
 -	if (safe_create_leading_directories(filename))
 -		die(_("failed to create directories for '%s'"), filename);
 -	plist = xfopen(filename, "w");
 -
++	get_schedule_cmd(&cmd, NULL);
  	preamble = "<?xml version=\"1.0\"?>\n"
  		   "<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">\n"
  		   "<plist version=\"1.0\">"
@@@ -1687,38 -1750,13 +1774,38 @@@
  		/* unreachable */
  		break;
  	}
 -	fprintf(plist, "</array>\n</dict>\n</plist>\n");
 -	fclose(plist);
 +	strbuf_addstr(&plist, "</array>\n</dict>\n</plist>\n");
  
 -	/* bootout might fail if not already running, so ignore */
 -	launchctl_boot_plist(0, filename);
 -	if (launchctl_boot_plist(1, filename))
 -		die(_("failed to bootstrap service %s"), filename);
 +	if (safe_create_leading_directories(filename))
 +		die(_("failed to create directories for '%s'"), filename);
 +
 +	if ((long)lock_file_timeout_ms < 0 &&
 +	    git_config_get_ulong("gc.launchctlplistlocktimeoutms",
 +				 &lock_file_timeout_ms))
 +		lock_file_timeout_ms = 150;
 +
 +	fd = hold_lock_file_for_update_timeout(&lk, filename, LOCK_DIE_ON_ERROR,
 +					       lock_file_timeout_ms);
 +
 +	/*
 +	 * Does this file already exist? With the intended contents? Is it
 +	 * registered already? Then it does not need to be re-registered.
 +	 */
 +	if (!stat(filename, &st) && st.st_size == plist.len &&
 +	    strbuf_read_file(&plist2, filename, plist.len) == plist.len &&
 +	    !strbuf_cmp(&plist, &plist2) &&
 +	    launchctl_list_contains_plist(name, cmd))
 +		rollback_lock_file(&lk);
 +	else {
 +		if (write_in_full(fd, plist.buf, plist.len) < 0 ||
 +		    commit_lock_file(&lk))
 +			die_errno(_("could not write '%s'"), filename);
 +
 +		/* bootout might fail if not already running, so ignore */
- 		launchctl_boot_plist(0, filename, cmd);
- 		if (launchctl_boot_plist(1, filename, cmd))
++		launchctl_boot_plist(0, filename);
++		if (launchctl_boot_plist(1, filename))
 +			die(_("failed to bootstrap service %s"), filename);
 +	}
  
  	free(filename);
  	free(name);
