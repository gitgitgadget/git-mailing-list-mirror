From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v4 09/24] ls-files.c: use index api
Date: Sat, 30 Nov 2013 11:30:26 +0100
Message-ID: <87zjomxjul.fsf@gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com> <1385553659-9928-10-git-send-email-t.gummerer@gmail.com> <CACsJy8D6q5Y4uLTcxD+9pY7U9_2qkO6o-_JeciWWAwJFrsqrzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, tr@thomasrast.ch,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 30 11:30:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vmhop-0008KJ-58
	for gcvg-git-2@plane.gmane.org; Sat, 30 Nov 2013 11:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549Ab3K3Kaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Nov 2013 05:30:30 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:62537 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320Ab3K3Ka3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Nov 2013 05:30:29 -0500
Received: by mail-lb0-f180.google.com with SMTP id w6so7419689lbh.39
        for <git@vger.kernel.org>; Sat, 30 Nov 2013 02:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=jmnlKCQYxrBjgaUsX4+FIFYvVy036VPluwHNRezIolY=;
        b=G8KrPphLy6g2B5rylCb4+lGay3b8C/W1rGWQmqSABAXghyPv55zyfygQcwdknTPV6t
         aL4+8gbHwE3NM6EZXtcMjAS8qV8Sv4PovBtEn8DPXAtxv+xWUOULlKDJ4qBRHc3oz/W4
         IGM+cuY35fRKN54yWXCVeV1bqgdNFqX9mnn4ypysTxOWALlAT6noOOR6awK6tFxVEsiv
         zquXDKIYIqCeaRKpuNzR8qYaCA9Pcj4lc2BxkJkM4HhhB1b5j/5X/d8M1XwjZJmSTZPL
         YqB4wXgyYC78k+1TTF2GuXDPKa24KQiMiU5Gba2c0GOU1kiMu95xsKk9gCJc9voZRYtR
         WZEg==
X-Received: by 10.112.189.74 with SMTP id gg10mr3510073lbc.8.1385807425331;
        Sat, 30 Nov 2013 02:30:25 -0800 (PST)
Received: from goose.tgummerer.com (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id qj3sm56270662lbb.1.2013.11.30.02.30.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Nov 2013 02:30:24 -0800 (PST)
In-Reply-To: <CACsJy8D6q5Y4uLTcxD+9pY7U9_2qkO6o-_JeciWWAwJFrsqrzQ@mail.gmail.com>
User-Agent: Notmuch/0.17~rc1+8~g4a09c1a (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238553>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Nov 27, 2013 at 7:00 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> @@ -447,6 +463,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>>         struct dir_struct dir;
>>         struct exclude_list *el;
>>         struct string_list exclude_list = STRING_LIST_INIT_NODUP;
>> +       struct filter_opts *opts = xmalloc(sizeof(*opts));
>>         struct option builtin_ls_files_options[] = {
>>                 { OPTION_CALLBACK, 'z', NULL, NULL, NULL,
>>                         N_("paths are separated with NUL character"),
>> @@ -512,9 +529,6 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>>                 prefix_len = strlen(prefix);
>>         git_config(git_default_config, NULL);
>>
>> -       if (read_cache() < 0)
>> -               die("index file corrupt");
>> -
>>         argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
>>                         ls_files_usage, 0);
>>         el = add_exclude_list(&dir, EXC_CMDL, "--exclude option");
>> @@ -550,6 +564,24 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>>                        PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
>>                        prefix, argv);
>>
>> +       if (!with_tree && !needs_trailing_slash_stripped()) {
>> +               memset(opts, 0, sizeof(*opts));
>> +               opts->pathspec = &pathspec;
>> +               opts->read_staged = 1;
>> +               if (show_resolve_undo)
>> +                       opts->read_resolve_undo = 1;
>> +               if (read_cache_filtered(opts) < 0)
>> +                       die("index file corrupt");
>> +       } else {
>> +               if (read_cache() < 0)
>> +                       die("index file corrupt");
>> +               parse_pathspec(&pathspec, 0,
>> +                              PATHSPEC_PREFER_CWD |
>> +                              PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
>> +                              prefix, argv);
>
> So we ran parse_pathspec() once (not shown in the context), if found
> trailing slashes, we read full cache and rerun parse_pathspec()
> because the index is not loaded on the first run.
>
> This is fine. Just a note for future improvement: as _SLASH_CHEAP only
> needs to look at a few entries with cache_name_pos(), we could take
> advantage of v5 to peek individual entries (or in v2, load full cache
> first). Nothing needs to be done now, I think we have not decided
> whether to combine _SLASH_CHEAP and _SLASH_EXPENSIVE into one.

Yes that makes sense.  Adding the ability to search for path entries
without reading the whole or part of the index was something I was
thinking about, but didn't have time to do so yet.  I'll add this to my
list of possible future improvements.

>> +       }
>> +
>>         /* Find common prefix for all pathspec's */
>>         max_prefix = common_prefix(&pathspec);
>>         max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
> -- 
> Duy
