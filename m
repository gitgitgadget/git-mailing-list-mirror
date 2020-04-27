Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B225EC4CECD
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 21:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E2472076A
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 21:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgD0Vjp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:39:45 -0400
Received: from forward500p.mail.yandex.net ([77.88.28.110]:54135 "EHLO
        forward500p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726182AbgD0Vjp (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 17:39:45 -0400
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Apr 2020 17:39:43 EDT
Received: from mxback9j.mail.yandex.net (mxback9j.mail.yandex.net [IPv6:2a02:6b8:0:1619::112])
        by forward500p.mail.yandex.net (Yandex) with ESMTP id 5A1F494042B;
        Tue, 28 Apr 2020 00:33:54 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback9j.mail.yandex.net (mxback/Yandex) with ESMTP id p2rHI5jfqE-Xr70QaDE;
        Tue, 28 Apr 2020 00:33:53 +0300
Received: by myt6-4d759d962265.qloud-c.yandex.net with HTTP;
        Tue, 28 Apr 2020 00:33:53 +0300
From:   Konstantin Podsvirov <konstantin@podsvirov.pro>
To:     Pratyush Yadav <me@yadavpratyush.com>,
        Konstantin Podsvirov via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <20200427194546.7ce4z2ooe4jaab5w@yadavpratyush.com>
References: <pull.612.git.1586900734341.gitgitgadget@gmail.com> <20200427194546.7ce4z2ooe4jaab5w@yadavpratyush.com>
Subject: Re: [PATCH] git-gui: msys2 compatibility patches
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 28 Apr 2020 00:33:53 +0300
Message-Id: <952341588022066@mail.yandex.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



27.04.2020, 22:48, "Pratyush Yadav" <me@yadavpratyush.com>:
> Hi Konstantin,
>
> Thanks for the patch, and sorry for the late reply.
>
> On 14/04/20 09:45PM, Konstantin Podsvirov via GitGitGadget wrote:
>>  From: Konstantin Podsvirov <konstantin@podsvirov.pro>
>>
>>  Allow using `git gui` command via MSYS2's MINGW32/64 subsystems (apropriate shells).
>
> I think this should be the commit subject, instead of "msys2
> compatibility patches".

I do not mind.

>>  Just install apropriate `tk` package:
>>
>>  ```bash
>>  user@host MINGW32 ~
>>  pacman -S mingw-w64-i686-tk
>>  ```
>>
>>  or
>>
>>  ```bash
>>  user@host MINGW64 ~
>>  pacman -S mingw-w64-x86_64-tk
>>  ```
>>
>>  For more info see: https://github.com/msys2/MSYS2-packages/pull/1912
>
> Please don't just link to an external website. Put the explanation there
> in the commit message. Explain what the problem was, and how this patch
> fixes it.

The startup script everywhere operates on Unix paths, but on Windows they are incomplete, and the interpreter expects full native paths.

>>  Signed-off-by: Konstantin Podsvirov <konstantin@podsvirov.pro>
>>  ---
>>   git-gui.sh | 52 ++++++++++++++++++++++++++++++----------------------
>>   1 file changed, 30 insertions(+), 22 deletions(-)
>>
>>  diff --git a/git-gui.sh b/git-gui.sh
>>  index 4610e4ca72a..512f4f121aa 100755
>>  --- a/git-gui.sh
>>  +++ b/git-gui.sh
>>  @@ -44,6 +44,28 @@ if {[catch {package require Tcl 8.5} err]
>>
>>   catch {rename send {}} ; # What an evil concept...
>>
>>  +######################################################################
>>  +##
>>  +## platform detection
>>  +
>>  +set _iscygwin {}
>>  +
>>  +proc is_Cygwin {} {
>>  + global _iscygwin
>>  + if {$_iscygwin eq {}} {
>>  + if {$::tcl_platform(platform) eq {windows}} {
>>  + if {[catch {set p [exec cygpath --windir]} err]} {
>>  + set _iscygwin 0
>>  + } else {
>>  + set _iscygwin 1
>>  + }
>>  + } else {
>>  + set _iscygwin 0
>>  + }
>>  + }
>>  + return $_iscygwin
>>  +}
>>  +
>>   ######################################################################
>>   ##
>>   ## locate our library
>>  @@ -51,7 +73,14 @@ catch {rename send {}} ; # What an evil concept...
>>   if { [info exists ::env(GIT_GUI_LIB_DIR) ] } {
>>           set oguilib $::env(GIT_GUI_LIB_DIR)
>>   } else {
>>  - set oguilib {@@GITGUI_LIBDIR@@}
>>  + if {[is_Cygwin]} {
>>  + set oguilib [exec cygpath \
>>  + --windows \
>>  + --absolute \
>>  + @@GITGUI_LIBDIR@@]
>>  + } else {
>>  + set oguilib {@@GITGUI_LIBDIR@@}
>>  + }
>
> This would convert the Windows style path to a Unix style path if we are
> running in Cygwin, right? This is what I assume the heart of the problem
> is.

It is true exactly the opposite.

> Style nitpick: something like this would probably be better:
>
>   set oguilib {@@GITGUI_LIBDIR@@}
>   if {[is_Cygwin]} {
>         ...
>   }

Looks good.

> This makes it clear that Cygwin is the exception. For all other cases,
> we want to use @@GITGUI_LIBDIR@@ directly.

Yes.

>>   }
>>   set oguirel {@@GITGUI_RELATIVE@@}
>>   if {$oguirel eq {1}} {
>>  @@ -163,7 +192,6 @@ set _isbare {}
>>   set _gitexec {}
>>   set _githtmldir {}
>>   set _reponame {}
>>  -set _iscygwin {}
>
> Why move the initialization?

To use this above when setting `oguilib` variable.

>>   set _search_path {}
>>   set _shellpath {@@SHELL_PATH@@}
>>
>>  @@ -266,26 +294,6 @@ proc is_Windows {} {
>>           return 0
>>   }
>>
>>  -proc is_Cygwin {} {
>>  - global _iscygwin
>>  - if {$_iscygwin eq {}} {
>>  - if {$::tcl_platform(platform) eq {windows}} {
>>  - if {[catch {set p [exec cygpath --windir]} err]} {
>>  - set _iscygwin 0
>>  - } else {
>>  - set _iscygwin 1
>>  - # Handle MSys2 which is only cygwin when MSYSTEM is MSYS.
>>  - if {[info exists ::env(MSYSTEM)] && $::env(MSYSTEM) ne "MSYS"} {
>>  - set _iscygwin 0
>>  - }
>
> I'm afraid I don't understand this hunk. I don't use Windows, and don't
> completely understand the difference between cygwin, msys, etc. Could
> you please explain further why this check is removed? Are there any
> negative side-effects?

To use `git gui` we need `tk` (wish), but `tk` (wish) can be available only when MSYSTEM is equal to MINGW32 or MINGW64.

>>  - }
>>  - } else {
>>  - set _iscygwin 0
>>  - }
>>  - }
>>  - return $_iscygwin
>>  -}
>>  -
>
> Why move the function? Can't this and the _iscygwin initialization just
> stay in their place? It will make the diff much easier to read.

To use this above when setting `oguilib` variable.

>>   proc is_enabled {option} {
>>           global enabled_options
>>           if {[catch {set on $enabled_options($option)}]} {return 0}
>
> --
> Regards,
> Pratyush Yadav

What is the further course of action?

--
Regards,
Konstantin Podsvirov

