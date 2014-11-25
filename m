From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: Re*: [PATCH] change contract between system_path and it's callers
Date: Tue, 25 Nov 2014 23:59:05 +0600
Message-ID: <CANCZXo53s4X4sZbQ1Tj3bVinbPVTodMvGiJR6kevYtZKkJvPYg@mail.gmail.com>
References: <87mw7gae8k.fsf@gmail.com>
	<1416838063-16797-1-git-send-email-kuleshovmail@gmail.com>
	<xmqqoarwwfz1.fsf@gitster.dls.corp.google.com>
	<87ppcc4b2g.fsf@gmail.com>
	<xmqqbnnwwcg0.fsf@gitster.dls.corp.google.com>
	<CANCZXo7yDJCuhKVFG3QfSSoem+KN_9VCbGerTd+5tqQuzA7dbg@mail.gmail.com>
	<CANCZXo4C_6Zfob9VnxjGxPbsRnUioVqC10z3Hhv09_xtrx-Pog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 18:59:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtKOP-0007iS-70
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 18:59:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbaKYR7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 12:59:08 -0500
Received: from mail-ob0-f172.google.com ([209.85.214.172]:34098 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750964AbaKYR7G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 12:59:06 -0500
Received: by mail-ob0-f172.google.com with SMTP id wn1so869299obc.3
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 09:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kMbMObWHUzAYKxzLEWZDI0unZIibGnxjAUUO3lD6BZ0=;
        b=jPf6VJC7NxNYL/gKxcCrQUyrqc2EsOTGZuA6R2nRHj3gztK128L2Ij3d5e7O64zC52
         WrrLdSeELPcWqfSx9128N9Zs7XamljKD4v44CB+vQ3gNh9HYmVdFTp1kiMh5P0Sr/wto
         jJOZD/16HPRt866VOcN4SlCsANsrVID1JdcsWfjeN7SyeVVHapKXmO9V+uLFcvrNpzSF
         ruMfyfDQ3br9+QMl1uCFLfo1yKLyeDpd2S4o9jOSl5NggqrWYViyBthoEkpDYDQxqGrY
         KPP3m2peL3jwYFmzllvhSMLEecvDpQNMsukkfybzIpx/U/V/nePa37yOVcAMDOq9LsI7
         N55Q==
X-Received: by 10.60.58.33 with SMTP id n1mr16353825oeq.85.1416938345845; Tue,
 25 Nov 2014 09:59:05 -0800 (PST)
Received: by 10.182.26.42 with HTTP; Tue, 25 Nov 2014 09:59:05 -0800 (PST)
In-Reply-To: <CANCZXo4C_6Zfob9VnxjGxPbsRnUioVqC10z3Hhv09_xtrx-Pog@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260229>

Hello Junio,

I'm working on this patch and builtin/config.c, i have a little question:

Look, here - https://github.com/git/git/blob/master/builtin/config.c#L509
and in the next if clauses we get allocated path, but if i test it
with given config file with git config -f....
(https://github.com/git/git/blob/master/builtin/config.c#L513) i have
prefix NULL and next if clause doesn't execute, so if i'll put
free(given_config_source.file) after config action i'll get error
because given_config_source.file wasn't allocated. How to be with
this?

Thank you.

2014-11-25 13:04 GMT+06:00 Alexander Kuleshov <kuleshovmail@gmail.com>:
> But if we still static const char* for git_etc_gitattributes and will
> not free it in bootstrap_attr_stack there will no memory leak, just
> tested it, so i'll remove free for it.
>
> 2014-11-25 12:45 GMT+06:00 Alexander Kuleshov <kuleshovmail@gmail.com>:
>> Hello Junio,
>>
>> I returned static to git_etc_gitattributes return value, but now i
>> can't understand where to free 'system_wide'. As i understand
>> correctly attr.c has following API for querying attributes:
>>
>> git_attr
>>
>> git_check_attr
>>
>> And as i see in code git_attr doesn't use git_attr_check, so now we
>> have only git_check_attr and git_all_stars functions which are through
>> prepare_attr_stack and bootstrap_attr_stack in it uses path which
>> returned
>>  by system_path. So you're right if i free etc_attributes like this
>> and git_etc_gitattributes will return static value we'll have access
>> to freed memory if it will called again. But we have no access to
>> etc_attributes outside bootstrap_attr_stack so where will be best
>> place to free it?
>>
>> Thank you
>>
>> 2014-11-25 2:50 GMT+06:00 Junio C Hamano <gitster@pobox.com>:
>>> Alex Kuleshov <kuleshovmail@gmail.com> writes:
>>>
>>>>> One thing to note is that this illustration does not consider memory
>>>>> pointed at by the "system_wide" variable here (from attr.c)
>>>>>
>>>>>         static const char *git_etc_gitattributes(void)
>>>>>         {
>>>>>                 static const char *system_wide;
>>>>>                 if (!system_wide)
>>>>>                         system_wide = system_path(ETC_GITATTRIBUTES);
>>>>>                 return system_wide;
>>>>>         }
>>>>>
>>>>> at the point of process exit as a "leak".
>>>>
>>>> But why? We allocated memory to "system_wide" with system_path, next git
>>>> will exit somewhere with die, but system_wide didn't free... Or i'm
>>>> wrong here too?
>>>
>>> It is in the same league as "static const char *git_dir" and friends
>>> that appear in the file-scope-static of environment.c.  Keeping small
>>> things around to be cleaned up by exit() is not a crime.
>>
>>
>>
>> --
>> _________________________
>> 0xAX
>
>
>
> --
> _________________________
> 0xAX



-- 
_________________________
0xAX
