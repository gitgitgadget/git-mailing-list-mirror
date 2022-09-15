Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2F8ECAAD3
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 08:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiIOIwG convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 15 Sep 2022 04:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiIOIvv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 04:51:51 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437D58C46E
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 01:51:45 -0700 (PDT)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 28F8phlM080873
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 15 Sep 2022 04:51:43 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Adam Dinwoodie'" <adam@dinwoodie.org>,
        "'Git Mailing List'" <git@vger.kernel.org>
Cc:     "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>,
        =?UTF-8?B?J8SQb8OgbiBUcuG6p24gQ8O0bmcgRGFuaCc=?= 
        <congdanhqx@gmail.com>,
        "'Emily Shaffer'" <emilyshaffer@google.com>,
        "'Johannes Schindelin'" <johannes.schindelin@gmx.de>,
        "'Johannes Sixt'" <j6t@kdbg.org>,
        "'Junio C Hamano'" <gitster@pobox.com>
References: <20220901173942.abolcr4aa5gixncm@lucy.dinwoodie.org> <20220915075717.425673-1-adam@dinwoodie.org>
In-Reply-To: <20220915075717.425673-1-adam@dinwoodie.org>
Subject: RE: [PATCH v2] t1800: correct test to handle Cygwin
Date:   Thu, 15 Sep 2022 04:51:38 -0400
Organization: Nexbridge Inc.
Message-ID: <002001d8c8e0$617c5f80$24751e80$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKd6Br1tbcI/e22m/Ii9JrYIDCjcwKVbkjxrEFEnuA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 15, 2022 3:57 AM, Adam Dinwoodie wrote:
>On Cygwin, when failing to spawn a process using start_command, Git outputs the
>same error as on Linux systems, rather than using the GIT_WINDOWS_NATIVE-
>specific error output.  The WINDOWS test prerequisite is set in both Cygwin and
>native Windows environments, which means it's not appropriate to use to
>anticipate the error output from start_command.  Instead, use the MINGW test
>prerequisite, which is only set for Git in native Windows environments, and not for
>Cygwin.
>
>Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
>Helped-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
>---
>
>With apologies to folk receiving this multiple times; it looks like my SMTP setup
>was causing problems for some servers, and while the mails seemed to be arriving
>with me, they didn't seem to be appearing at
>https://public-inbox.org/git/?q=t1800
>
> t/t1800-hook.sh | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh index 64096adac7..43fcb7c0bf
>100755
>--- a/t/t1800-hook.sh
>+++ b/t/t1800-hook.sh
>@@ -157,9 +157,9 @@ test_expect_success 'git hook run a hook with a bad
>shebang' '
> 	write_script bad-hooks/test-hook "/bad/path/no/spaces" </dev/null &&
>
> 	# TODO: We should emit the same (or at least a more similar)
>-	# error on Windows and !Windows. See the OS-specific code in
>-	# start_command()
>-	if test_have_prereq !WINDOWS
>+	# error on MINGW (essentially Git for Windows) and all other
>+	# platforms.. See the OS-specific code in start_command()
>+	if test_have_prereq !MINGW
> 	then
> 		cat >expect <<-\EOF
> 		fatal: cannot run bad-hooks/test-hook: ...
>--
>2.34.1

I am not convinced this will solve the problem on NonStop where EPERM is reported instead of ENOENT. Apparently EPERM is allowed by POSIX, so text comparison of error messages are not going to work anyway.

