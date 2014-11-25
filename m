From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: Re*: [PATCH] change contract between system_path and it's callers
Date: Tue, 25 Nov 2014 13:04:46 +0600
Message-ID: <CANCZXo4C_6Zfob9VnxjGxPbsRnUioVqC10z3Hhv09_xtrx-Pog@mail.gmail.com>
References: <87mw7gae8k.fsf@gmail.com>
	<1416838063-16797-1-git-send-email-kuleshovmail@gmail.com>
	<xmqqoarwwfz1.fsf@gitster.dls.corp.google.com>
	<87ppcc4b2g.fsf@gmail.com>
	<xmqqbnnwwcg0.fsf@gitster.dls.corp.google.com>
	<CANCZXo7yDJCuhKVFG3QfSSoem+KN_9VCbGerTd+5tqQuzA7dbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 08:04:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtABA-00005F-Of
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 08:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbaKYHEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 02:04:48 -0500
Received: from mail-ob0-f179.google.com ([209.85.214.179]:36235 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328AbaKYHEr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 02:04:47 -0500
Received: by mail-ob0-f179.google.com with SMTP id va2so8472321obc.10
        for <git@vger.kernel.org>; Mon, 24 Nov 2014 23:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=sxW8Dv3EQWWqydbqFBPnI7Nuumt776rw3lIhekOKZhc=;
        b=WMOY16XW21Wjj2YdtWdBAXka6KA/rtVhKiroGfez7VOuKEEoiKtNiQU051PjVBFsln
         g/7XcDGgYyXEl8ofXAvvvw5gxnD23sdSp+OCzAYVqoUE7rXNVynehZWWq2SvoFMyPz26
         mBKRXinxtcVeRQDq+JHSgf6BhRrzW2v6Nwo1Bp+3506/3XSOnjJEANP4kXbLpyQkWj4K
         njxIx9kCpMzu5pn2QHz73/+ZC3ed0FDO4IrkMY4+nwdCSGt6gRc9Vx/Jahc19ZeiCQEu
         6CG47s2FZAHKsrbIjkVP6sJz2KmVGYY5UYzy8y/iS2DryBmcuj5PLwsF9jxpTOLYH+RD
         hyDQ==
X-Received: by 10.202.65.85 with SMTP id o82mr13556236oia.95.1416899086642;
 Mon, 24 Nov 2014 23:04:46 -0800 (PST)
Received: by 10.182.26.42 with HTTP; Mon, 24 Nov 2014 23:04:46 -0800 (PST)
In-Reply-To: <CANCZXo7yDJCuhKVFG3QfSSoem+KN_9VCbGerTd+5tqQuzA7dbg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260196>

But if we still static const char* for git_etc_gitattributes and will
not free it in bootstrap_attr_stack there will no memory leak, just
tested it, so i'll remove free for it.

2014-11-25 12:45 GMT+06:00 Alexander Kuleshov <kuleshovmail@gmail.com>:
> Hello Junio,
>
> I returned static to git_etc_gitattributes return value, but now i
> can't understand where to free 'system_wide'. As i understand
> correctly attr.c has following API for querying attributes:
>
> git_attr
>
> git_check_attr
>
> And as i see in code git_attr doesn't use git_attr_check, so now we
> have only git_check_attr and git_all_stars functions which are through
> prepare_attr_stack and bootstrap_attr_stack in it uses path which
> returned
>  by system_path. So you're right if i free etc_attributes like this
> and git_etc_gitattributes will return static value we'll have access
> to freed memory if it will called again. But we have no access to
> etc_attributes outside bootstrap_attr_stack so where will be best
> place to free it?
>
> Thank you
>
> 2014-11-25 2:50 GMT+06:00 Junio C Hamano <gitster@pobox.com>:
>> Alex Kuleshov <kuleshovmail@gmail.com> writes:
>>
>>>> One thing to note is that this illustration does not consider memory
>>>> pointed at by the "system_wide" variable here (from attr.c)
>>>>
>>>>         static const char *git_etc_gitattributes(void)
>>>>         {
>>>>                 static const char *system_wide;
>>>>                 if (!system_wide)
>>>>                         system_wide = system_path(ETC_GITATTRIBUTES);
>>>>                 return system_wide;
>>>>         }
>>>>
>>>> at the point of process exit as a "leak".
>>>
>>> But why? We allocated memory to "system_wide" with system_path, next git
>>> will exit somewhere with die, but system_wide didn't free... Or i'm
>>> wrong here too?
>>
>> It is in the same league as "static const char *git_dir" and friends
>> that appear in the file-scope-static of environment.c.  Keeping small
>> things around to be cleaned up by exit() is not a crime.
>
>
>
> --
> _________________________
> 0xAX



-- 
_________________________
0xAX
