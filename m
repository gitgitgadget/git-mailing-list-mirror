Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FEEC4338F
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 23:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F38261245
	for <git@archiver.kernel.org>; Sat, 21 Aug 2021 23:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhHUXUL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Aug 2021 19:20:11 -0400
Received: from w1.tutanota.de ([81.3.6.162]:43628 "EHLO w1.tutanota.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231338AbhHUXUH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Aug 2021 19:20:07 -0400
X-Greylist: delayed 478 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Aug 2021 19:20:06 EDT
Received: from w3.tutanota.de (unknown [192.168.1.164])
        by w1.tutanota.de (Postfix) with ESMTP id D88AFFBF57C;
        Sat, 21 Aug 2021 23:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1629587487;
        s=s1; d=tutanota.com;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:References:Sender;
        bh=vH2wlYIXWwzRb2/uMLhn/2NFdXP3MVOe7stXmw/XteI=;
        b=HegoEO8M2M3hqRWBq/IEJO36G3FTAATh+S+vpKucHmiNwx98/5cwAXEPniIlEk7O
        4Zv+JM1GcTIF8y/z4B7vV6rXbqCUI6CPkALE45n10P9hUW6s7dWdzE1dlnhNeCIh2Ja
        n5ZAOPXVBIAdLJvz7w0Ton8fmWWw/9ovObwfu/cuxYIB/7+s3WIHyG9ZC58odg5OH4U
        YxdV7V8cHK1z5Gd9Mfkxap47o4tTVAlw6nt5hv66xZxxc0xbW2l+nfTUBZhL34M05ow
        vDKQtzEFMnvIfqWzcNx5+OAEoCL1274lVEllXrMIk8ToGVa7Ut9I/AFXUN9rdULT4Cl
        KSdb8RtDaA==
Date:   Sun, 22 Aug 2021 01:11:27 +0200 (CEST)
From:   Rafael Santiago <voidbrainvoid@tutanota.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Rafael Santiago via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Message-ID: <Mheyv1D--3-2@tutanota.com>
In-Reply-To: <YSF1GfpHXRrXebsB@camp.crustytoothpaste.net>
References: <pull.1069.git.git.1629576007891.gitgitgadget@gmail.com> <YSF1GfpHXRrXebsB@camp.crustytoothpaste.net>
Subject: Re: [PATCH] Give support for hooks based on platform
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In my opinion "binary hooks" (hooks that execute specific binaries not present in the system as a default tool) should be versioned and built as a support tool into the repository or in the worst case downloaded from somewhere, even because versioning binaries into git repos is considered a bad practice that could make bloated repos.

The point is that in many cases a dependency with a script language is created only to make the hook actions portable from a platform to other, but what this script in its essence does is a thing that could be done with basic tools delivered with the current operating system.

There is no problem on using cygwin on windows, you should use standard hook and do all the effort to make it unique for cygwin environments and true unix boxes (in other words: you would continue doing what you are doing, because it attends yours requirements). Notice that everything that have been working will stay working as before. Anyway, if cygwin becomes a point of incompatibility at some point, you could use the "_windows" version by coding your "cygwin script" there.
Maybe this would add more possibilities in git-hook tooling by making them less plastered, I think.

Rafael Santiago
-- 
21 de ago. de 2021 18:50 por sandals@crustytoothpaste.net:

> On 2021-08-21 at 20:00:07, Rafael Santiago via GitGitGadget wrote:
>
>> From: rafael-santiago <voidbrainvoid@tutanota.com>
>>
>> The idea behind this commit can be useful for teams
>> that share git-hooks into a custom directory and
>> dealing with projects that must be developed,
>> built, maintained on several different platforms.
>>
>> This commit allows the execution of git hooks
>> based on the current operating system.
>> A "native hook" is defined in the form:
>>  hooks/hook-name_platform
>> Where platform must be equivalent to the
>> content returned in sysname field in utsname
>> struct when calling uname() [but all normalized
>> in lowercase].
>>
>> On Windows, independent of version, flavor, SP,
>> whatever it is simply "windows".
>>
>
> I'm not sure that this is going to work out very well.  The MINGW
> environment used by Git for Windows and Cygwin are quite different.  I
> would fully expect to write shell scripts and Unix tooling in Cygwin,
> whereas users using Git for Windows might not want that at all.  That
> also doesn't take into effect using Git for Windows in WSL, which
> introduces some interesting logistical challenges.
>
> In addition, I have a few concerns about the grouping of Linux
> altogether.  While in many cases it is possible to write tooling that
> works natively across Linux distros, most binaries will not.  Therefore,
> binary hooks that might run fine on Debian would fail on a Fedora or Red
> Hat system, especially if those binaries link to any of a number of
> different shared libraries (e.g., OpenSSL).
>
> There's also work to move hooks into the config and out of the hooks
> directory, and I don't think this will mesh well with it.
>
>> The main motivation of this extension is to
>> reduce dependency of scripting languages,
>> logical trinkets etc just to execute minor
>> tasks during scm events that could be done
>> natively but differently from a platform
>> to another. Less dependencies, cleaner
>> repos: a small step for a better world
>> for any software developer.
>>
>
> Is there a reason that the proper hooks couldn't be copied or symlinked
> into place with a script?  I think that would resolve this concern with
> a lot less work.
> -- 
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA
>

