Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3436C433EF
	for <git@archiver.kernel.org>; Mon,  9 May 2022 16:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238780AbiEIQD4 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 9 May 2022 12:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238713AbiEIQDz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 12:03:55 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196812A7C0B
        for <git@vger.kernel.org>; Mon,  9 May 2022 09:00:00 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 249Fxs5p031579
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 9 May 2022 11:59:54 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Michael J Gruber'" <git@grubix.eu>
Cc:     <git@vger.kernel.org>
References: <cover.1651859773.git.git@grubix.eu>        <f306f43f375bc9b9c98e85260587442e5d9ef0ba.1652094958.git.git@grubix.eu> <xmqq7d6ug0un.fsf@gitster.g>
In-Reply-To: <xmqq7d6ug0un.fsf@gitster.g>
Subject: RE: [PATCH] detect-compiler: make detection independent of locale
Date:   Mon, 9 May 2022 11:59:49 -0400
Organization: Nexbridge Inc.
Message-ID: <034701d863bd$d3688200$7a398600$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKBROfmxINt9G3t8H7f4u2eJilVLQILeCTbAue0ZeurnVdx8A==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 9, 2022 11:52 AM, Junio C Hamano wrote:
>Michael J Gruber <git@grubix.eu> writes:
>
>> `detect-compiler` has accumulated a few compiler dependent workarounds
>> lately for the more and more ubiquitious gcc12. This is intended to
>> make CI set-ups work across tool-chain updates, but also help those
>> developers who build with `DEVELOPER=1`.
>>
>> Alas, `detect-compiler` uses the locale dependent output of `$(CC) -v`
>> to parse for the version string, which fails unless it literally
>> contains ` version`.
>>
>> Use `LANG=C $(CC) -v` instead to grep for stable output.
>
>I think this patch is a bit insufficient.
>
>    $ LC_ALL=ja_JP.utf8 LANG=C gcc -v 2>&1 | head -n 1
>    組み込み spec を使用しています。
>    $ LC_ALL=C LANG=ja_JP.utf8 gcc -v 2>&1 | head -n 1
>    Using built-in specs.
>
>In theory overriding LC_ALL alone may be sufficient these days where everybody
>seems to know about LC_*, but just out of habit, I would recommend forcing
>both, i.e.
>
>>  get_version_line() {
>> -	$CC -v 2>&1 | grep ' version '
>> +	LANG=C $CC -v 2>&1 | grep ' version '
>
>this on top of the posted patch, which is what I'll squash in when queuing this
>patch (no need to resend if you agree with the above and unless you have other
>changes and improvements).
>
>Thanks.
>
>diff --git i/detect-compiler w/detect-compiler index 473f3bd4fe..50087f5670
>100755
>--- i/detect-compiler
>+++ w/detect-compiler
>@@ -9,7 +9,7 @@ CC="$*"
> #
> # FreeBSD clang version 3.4.1 (tags/RELEASE...)
> get_version_line() {
>-	LANG=C $CC -v 2>&1 | grep ' version '
>+	LANG=C LC_ALL=C $CC -v 2>&1 | grep ' version '
> }
>
> get_family() {

Just a small transfer of experience from a different project - if we transition or expand LOCALE functions into C at some point. Be aware that the locale_t series in C is not supported universally, despite being in POSIX going back a few years. We found, at least on the OpenSSL project, that using locale_t caused compile breakages on a variety of platforms, including some older but active Linux variants. Just raising awareness as I'm working this issue there.

Sincerely,
Randall

