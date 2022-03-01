Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FACC433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 14:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbiCAO7o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 09:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbiCAO7l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 09:59:41 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7EA1AF0D
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 06:58:44 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 009943F47FA;
        Tue,  1 Mar 2022 09:58:44 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 917313F4096;
        Tue,  1 Mar 2022 09:58:43 -0500 (EST)
Subject: Re: [PATCH v5 06/30] fsmonitor--daemon: add a built-in fsmonitor
 daemon
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
 <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
 <bdd7334da3162ce77c216d61ce9d979f12637ac5.1644612979.git.gitgitgadget@gmail.com>
 <220225.865yp27e1c.gmgdl@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <ffcd037b-256c-2e4b-79b7-ae725ad17c04@jeffhostetler.com>
Date:   Tue, 1 Mar 2022 09:58:42 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <220225.865yp27e1c.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/25/22 5:46 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Feb 11 2022, Jeff Hostetler via GitGitGadget wrote:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Create a built-in file system monitoring daemon that can be used by
>> the existing `fsmonitor` feature (protocol API and index extension)
>> to improve the performance of various Git commands, such as `status`.
>>
>> The `fsmonitor--daemon` feature builds upon the `Simple IPC` API and
>> provides an alternative to hook access to existing fsmonitors such
>> as `watchman`.
>>
>> This commit merely adds the new command without any functionality.
>>
[...]
>> +
>> +#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
>> +
>> +int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
>> +{
>> +	const char *subcmd;
>> +
>> +	struct option options[] = {
>> +		OPT_END()
>> +	};
>> +
>> +	git_config(git_default_config, NULL);
>> +
>> +	argc = parse_options(argc, argv, prefix, options,
>> +			     builtin_fsmonitor__daemon_usage, 0);
>> +	if (argc != 1)
>> +		usage_with_options(builtin_fsmonitor__daemon_usage, options);
>> +	subcmd = argv[0];
>> +
>> +	die(_("Unhandled subcommand '%s'"), subcmd);
>> +}
>> +
>> +#else
>> +int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
>> +{
>> +	struct option options[] = {
>> +		OPT_END()
>> +	};
>> +
>> +	if (argc == 2 && !strcmp(argv[1], "-h"))
>> +		usage_with_options(builtin_fsmonitor__daemon_usage, options);
>> +
>> +	die(_("fsmonitor--daemon not supported on this platform"));
>> +}
>> +#endif
> 
> 
> I brought this up in another thread in how this series interacts with
> another, but this patch below on top of "seen" would allow you to catch
> parse_options() BUGs on Linux, even if you don't have a no-OSX
> non-Windows backend yet:
> 	
> 	diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
> 	index 591433e897d..62c0b1d486b 100644
> 	--- a/builtin/fsmonitor--daemon.c
> 	+++ b/builtin/fsmonitor--daemon.c
> 	@@ -18,7 +18,6 @@ static const char * const builtin_fsmonitor__daemon_usage[] = {
> 	 	NULL
> 	 };
> 	
> 	-#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
> 	 /*
> 	  * Global state loaded from config.
> 	  */
> 	@@ -63,6 +62,7 @@ static int fsmonitor_config(const char *var, const char *value, void *cb)
> 	
> 	 	return git_default_config(var, value, cb);
> 	 }
> 	+#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
> 	
> 	 /*
> 	  * Acting as a CLIENT.
> 	@@ -1492,6 +1492,8 @@ static int try_to_start_background_daemon(void)
> 	 	}
> 	 }
> 	
> 	+#endif
> 	+
> 	 int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
> 	 {
> 	 	const char *subcmd;
> 	@@ -1532,6 +1534,7 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
> 	 		return -1;
> 	 	}
> 	
> 	+#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
> 	 	if (!strcmp(subcmd, "start"))
> 	 		return !!try_to_start_background_daemon();
> 	
> 	@@ -1543,20 +1546,8 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
> 	
> 	 	if (!strcmp(subcmd, "status"))
> 	 		return !!do_as_client__status();
> 	-
> 	 	die(_("Unhandled subcommand '%s'"), subcmd);
> 	-}
> 	-
> 	 #else
> 	-int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
> 	-{
> 	-	struct option options[] = {
> 	-		OPT_END()
> 	-	};
> 	-
> 	-	if (argc == 2 && !strcmp(argv[1], "-h"))
> 	-		usage_with_options(builtin_fsmonitor__daemon_usage, options);
> 	-
> 	 	die(_("fsmonitor--daemon not supported on this platform"));
> 	-}
> 	 #endif
> 	+}
> 
> I.e. we can be a less zealous when setting the ifdef boundaries, and
> it's actually less code as well.
> 

Yes, it would be possible to distribute the ifdef throughout the file
and avoid duplicating the function declaration, but I'm not sure that
that adds any clarity or readability.

In my version, I have a stub version of the cmd_fsmonitor__daemon()
function and it is very clear that it does nothing when the feature
is not supported on a platform.  The rest of the source file is
concerned with supporting the feature.  And no interweaving of ifdefs
throughout the file is required.

Your version sets us up for future problems inside the body of the
cmd_ function.  For example, any static function called in the
supported portion of the function would also need to be ifdef'd
(as you have indicated).  But any local variables needed by the
supported portion would need to be declared at the top of the
function and also ifdef'd -- or we'd need to indent the entire body
of the supported portion inside another level of { }.  None of this
adds clarity.  (Just to avoid an 11 line stub function.)

Finally, I'm not sure how much value there is in being able to catch
parse_options() BUGs on Linux (or any other yet-to-be-supported
platform).  The daemon isn't supported and dies immediately. I'm not
sure that forcing the user to properly compose any arguments before
we just call die() is helpful.

So, I'd rather leave this as is.

Thanks,
Jeff
