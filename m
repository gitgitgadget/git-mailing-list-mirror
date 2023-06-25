Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B9BEB64DC
	for <git@archiver.kernel.org>; Sun, 25 Jun 2023 15:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjFYPqd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jun 2023 11:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjFYPqc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2023 11:46:32 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CD210E
        for <git@vger.kernel.org>; Sun, 25 Jun 2023 08:46:31 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0BA742716B;
        Sun, 25 Jun 2023 11:46:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RUG0T1aiPBC+REBjcUysxWtKUs4OXMyqXsxrLs
        Zhth4=; b=RvpH+P0reW+VmlXLpzJaBgfuyu/cUym/Av1ILyWrjSsEnvlpRUGBI3
        L8iY2ELKQeysbT0cSjgUjtqsnUfdsosRsx40DzRXMtbJvkNs4MNcHM2LDiU34CrZ
        dfJxOe0eCY4KP3PHLCw6Qu8qka5vTDn/3esULAQz5hW2o43HSppUU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 024DE2716A;
        Sun, 25 Jun 2023 11:46:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0870E27169;
        Sun, 25 Jun 2023 11:46:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mark Levedahl <mlevedahl@gmail.com>
Cc:     git@vger.kernel.org, adam@dinwoodie.org, me@yadavpratyush.com,
        johannes.schindelin@gmx.de
Subject: Re: [PATCH v0 0/4] Remove obsolete Cygwin support from git-gui
References: <20230624212347.179656-1-mlevedahl@gmail.com>
        <xmqq8rc8781p.fsf@gitster.g>
        <e04e28e2-2308-1db8-9462-5f81aeff1155@gmail.com>
Date:   Sun, 25 Jun 2023 08:46:26 -0700
In-Reply-To: <e04e28e2-2308-1db8-9462-5f81aeff1155@gmail.com> (Mark Levedahl's
        message of "Sun, 25 Jun 2023 07:26:11 -0400")
Message-ID: <xmqqwmzr5yul.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 72A106BE-136F-11EE-B4EA-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark Levedahl <mlevedahl@gmail.com> writes:

> So, the code under the is_Windows and is_Cygwin branches of the
> if/else trees are now completely independent, and the is_Windows
> branch is never entered on Cygwin.

I missed this hunk in your updated get_explorer in [2/4]

 proc get_explorer {} {
-	if {[is_Cygwin] || [is_Windows]} {
+	if {[is_Windows]} {
 		set explorer "explorer.exe"
 	} elseif {[is_MacOSX]} {
 		set explorer "open"

and saw only this in [3/4]

 proc get_explorer {} {
 	if {[is_Windows]} {
 		set explorer "explorer.exe"
+	} elseif {[is_Cygwin]} {
+		set explorer "/bin/cygstart.exe --explore"
 	} elseif {[is_MacOSX]} {
 		set explorer "open"
 	} else {

As I missed the earlier change, the latter one alone looked to me
that for get_explorer to be share with GfW, the only explanation was
that is_Windows yields true on Cygwin, in which case the new elseif
did not make sense.

I think the hunk in [2/4] should be removed; it is confusing, it
does not have anything to do with the theme of [2/4], which is to
"remove obsolete Cygwin specific code".  And instead [3/4] should
be updated to do

+	if {[is_Cygwin] || [is_Windows]} {
-	if {[is_Windows]} {
		... do windows thing ...
+	} elseif {[is_Cygwin]} {
+		... do Cygwin thing ...
	} elseif {[is_MacOSX]} {
		... do macOS thing ...

The earlier explanation in the cover letter says this:

    The existing code for file browsing and creating a desktop icon is
    shared with Git For Windows support, and uses Windows pathnames. This
    code does not work on Cygwin, and needs replacement.  These functions
    have not worked since 2012.

If the change for get_explorer is updated to read like so, then "was
shared with GfW, now we have one that is for Cygwin" starts making
sense for the file browsing.

But I still do not understand the issue with desktop icon, though.
do_windows_shortcut and do_cygwin_shortcut were separate proc before
this series---while I fully believe that do_cygwin_shortcut did not
work on modern Cygwin if you say so, and "uses Windows pathnames"
may be what makes the original implementation not work on modern
Cygwin, I do not see how the existing code for the desktop icon "is
shared with GfW".

Ah, this is again due to the suboptimal splitting of the patches.

The original does have do_cygwin_shortcut, but you remove it in step
[2/4], together with its caller.  The code before your series did
have its own do_cygwin_shortcut, but after [2/4] it and its caller
are removed. The code may not have worked before step [2/4], so it
is probably alright in the end, but it does make step [4/4] very
confusing.  Since [4/4] does need to add Cygwin specific code,
perhaps you should exclude the shortcut related change from [2/4]
and keep it focused on removing Cygwin specific code that will not
be used in the end (instead of getting fixed to keep it alive).

So, earlier I said [2/4] made sense and obviously good.  But not
anymore.  It does a bit too many things and then have later steps
compensate for it, which made reviewing the series harder than
necessary.  It needs to be cleaned up a bit, I think.

Thanks.

