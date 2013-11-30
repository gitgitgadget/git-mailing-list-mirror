From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v4 09/24] ls-files.c: use index api
Date: Sat, 30 Nov 2013 21:08:23 +0100
Message-ID: <87r49xy7ns.fsf@gmail.com>
References: <1385553659-9928-1-git-send-email-t.gummerer@gmail.com> <1385553659-9928-10-git-send-email-t.gummerer@gmail.com> <CALWbr2yaD9Z98ysEzVHiQQR_W_zEj7bp0uEgZ3Z=Tp=Yc1NnoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	ramsay@ramsay1.demon.co.uk
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 30 21:08:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vmqq3-0006zs-U9
	for gcvg-git-2@plane.gmane.org; Sat, 30 Nov 2013 21:08:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562Ab3K3UIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Nov 2013 15:08:24 -0500
Received: from mail-la0-f41.google.com ([209.85.215.41]:63573 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559Ab3K3UIX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Nov 2013 15:08:23 -0500
Received: by mail-la0-f41.google.com with SMTP id eo20so7521989lab.14
        for <git@vger.kernel.org>; Sat, 30 Nov 2013 12:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=AkpuYiRcgcEeFwRABnEu2hcujW+p9n1b9lHHjJV/NYk=;
        b=KfkF2CGDV6+aK1GNkrqk6/XE2uPfYb5PXpVU9LOkUyhnV3AqTyCnEnyN9GDHJSx2Wi
         B+tmt6Uy55WFm5/3FBxMHWFpD9oVx+BgEWeHtgtJJLbzqX6ixteI3gFJp53k82PNnBbB
         j05pZMFmWluyF9v+C0IZJSYOwHfLs2yQ8PP3oddWDWGWevngpv2dtlO3pWMa2Yu1uM6f
         Q4rHpedHq9qkOcrXdlWE85SqU3a+ka9OYkaWT8Y7Y4bE99cthMmmcKIz8InNbkUVLEmp
         DieKaMdSn1TNyJUUSu6EjLmKpkHIqESkq2vPQ8LeeCJ59CKRFuzIkJsoGR4IH6Abn2W+
         1DZQ==
X-Received: by 10.152.180.228 with SMTP id dr4mr472284lac.32.1385842101615;
        Sat, 30 Nov 2013 12:08:21 -0800 (PST)
Received: from goose.tgummerer.com (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id e1sm18901062lbe.0.2013.11.30.12.08.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Nov 2013 12:08:20 -0800 (PST)
In-Reply-To: <CALWbr2yaD9Z98ysEzVHiQQR_W_zEj7bp0uEgZ3Z=Tp=Yc1NnoQ@mail.gmail.com>
User-Agent: Notmuch/0.17~rc1+8~g4a09c1a (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238569>

Antoine Pelisse <apelisse@gmail.com> writes:

> On Wed, Nov 27, 2013 at 1:00 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
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
>> +
>> +       }
>> +
>
> Would it make sense to move the declaration of "opts" as a non-pointer
> to the block where it's used ?

Yes, I think that would make sense, will do so in the re-roll. Thanks!
