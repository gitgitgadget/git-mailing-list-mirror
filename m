From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v9a 3/5] Implement line-history search (git log -L)
Date: Sat, 23 Mar 2013 11:31:05 +0100
Message-ID: <CALWbr2xW1SsNXq0wCh9jd_qGVrACLuQT-UETcG+zoxw9xjKSHw@mail.gmail.com>
References: <cover.1364020899.git.trast@student.ethz.ch>
	<b8cabd5ca63a17577fca524891046e5a3d3dfc60.1364020899.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Bo Yang <struggleyb.nku@gmail.com>,
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>,
	Will Palmer <wmpalmer@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Mar 23 11:31:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJLjn-0005KW-Eh
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 11:31:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094Ab3CWKbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Mar 2013 06:31:09 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49]:37673 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998Ab3CWKbI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 06:31:08 -0400
Received: by mail-qa0-f49.google.com with SMTP id l8so1171175qaq.1
        for <git@vger.kernel.org>; Sat, 23 Mar 2013 03:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=HWd1bm4c/RHnVFAKe175pofLJqCv2RXIIvl1Syywidw=;
        b=Ae61bcmXQ+zAhdqmTi3uztat0fFjnDexiVh0zWONQysdF25wAB45vdWvjC61NFxzTF
         33KRcyTifaVENehVoq90blwyCBz4Wg0Td58F+hHv7+OiOz237hky3dZdfpj63/+9vxJM
         vOSy1i6XKuvwHS70xS5xcRhKf16osONzpxBn+jrN843eUUkfuT+XwdRIWLLkXRJDCt8M
         Vz0l90bkoABEfOzReClbs6fKvTmT0vgxmofsMT5nuix4po5sfFPuAKtHRIEPIdMhF2m5
         d3T34KW61G4zW2nLW63YCOnn4WVHba998iKGMk7Fuy7oZ768P+/9qQHU/DAqpydjfbPs
         hvmA==
X-Received: by 10.224.18.138 with SMTP id w10mr1211432qaa.20.1364034665479;
 Sat, 23 Mar 2013 03:31:05 -0700 (PDT)
Received: by 10.49.70.163 with HTTP; Sat, 23 Mar 2013 03:31:05 -0700 (PDT)
In-Reply-To: <b8cabd5ca63a17577fca524891046e5a3d3dfc60.1364020899.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218905>

> diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
> new file mode 100755
> index 0000000..286390d
> --- /dev/null
> +++ b/t/t4211-line-log.sh
> @@ -0,0 +1,38 @@
> +#!/bin/sh
> +
> +test_description='test log -L'
> +. ./test-lib.sh
> +
> +test_expect_success 'setup (import history)' '
> +       git fast-import < "$TEST_DIRECTORY"/t4211/history.export &&
> +       git reset --hard
> +'
> +
> +canned_test () {
> +       test_expect_success "$1" "
> +               git log $1 >actual &&
> +               test_cmp \"\$TEST_DIRECTORY\"/t4211/expect.$2 actual
> +       "
> +}
> +
> +canned_test "-L 4,12:a.c simple" simple-f
> +canned_test "-L 4,+9:a.c simple" simple-f
> +canned_test "-L '/long f/,/^}/:a.c' simple" simple-f
> +
> +canned_test "-L '/main/,/^}/:a.c' simple" simple-main
> +
> +canned_test "-L 1,+4:a.c simple" beginning-of-file
> +
> +canned_test "-L 20:a.c simple" end-of-file
> +
> +test_expect_success "-L 20,10000:a.c (bogus end)" '
> +       test_must_fail git log -L 20,10000:a.c simple 2>errors &&
> +       grep "has only.*lines" errors
> +'
> +
> +canned_test "-L '/long f/',/^}/:a.c -L /main/,/^}/:a.c simple" two-ranges
> +canned_test "-L 24,+1:a.c simple" vanishes-early
> +
> +canned_test "-L '/long f/,/^}/:b.c' move-support" move-support-f
> +
> +test_done

Hi Thomas,

You should probably add some failing tests (for example when the input
parameters are not correct), and as a matter of fact, I have the
following segfault with v9:

Starting program: /home/antoine/code/git/git-log -M -L :git.c
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".

Program received signal SIGSEGV, Segmentation fault.
0x0000000000000000 in ?? ()
(gdb) bt
#0  0x0000000000000000 in ?? ()
#1  0x000000000050164d in parse_range_funcname (arg=0x84f2d0 ":git.c",
    nth_line_cb=0, cb_data=0x0, lines=0, begin=0x0, end=0x0, path=0x0)
    at line-range.c:160
#2  0x0000000000501d28 in skip_range_arg (arg=0x84f2d0 ":git.c")
    at line-range.c:229
#3  0x00000000004fda78 in parse_lines (commit=0x86ea60, prefix=0x0,
    args=0x7fad48) at line-log.c:544
#4  0x00000000004fd75a in line_log_init (rev=0x7fffffffd9a8, prefix=0x0,
    args=0x7fad48) at line-log.c:701
#5  0x0000000000457189 in cmd_log_init_finish (argc=1, argv=0x7fffffffe238,
    prefix=0x0, rev=0x7fffffffd9a8, opt=0x7fffffffd988) at builtin/log.c:192
#6  0x0000000000455d2c in cmd_log_init (argc=4, argv=0x7fffffffe238,
    prefix=0x0, rev=0x7fffffffd9a8, opt=0x7fffffffd988) at builtin/log.c:201
#7  0x0000000000457250 in cmd_log (argc=4, argv=0x7fffffffe238, prefix=0x0)
    at builtin/log.c:612
#8  0x00000000004056cf in run_builtin (p=0x7f7af8, argc=4,
    argv=0x7fffffffe238) at git.c:281
#9  0x00000000004047aa in handle_internal_command (argc=4,
    argv=0x7fffffffe238) at git.c:443
#10 0x0000000000404506 in main (argc=4, argv=0x7fffffffe238) at git.c:532
