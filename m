From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH][RFC] grep: add color.grep.matchcontext and color.grep.matchselected
Date: Tue, 28 Oct 2014 19:19:46 +0100
Message-ID: <544FDE42.4050905@web.de>
References: <1413870963-66431-1-git-send-email-zoltan.klinger@gmail.com>	<544D3A3C.4080906@web.de>	<544E8D89.3030201@web.de>	<xmqqy4s1s44h.fsf@gitster.dls.corp.google.com> <CAKJhZwRShbV14=BihxiTzayR4kg3GaAPN_NFXwFZ-4kAD-QHTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Zoltan Klinger <zoltan.klinger@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 19:20:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjBND-0002ee-8O
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 19:20:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843AbaJ1ST6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Oct 2014 14:19:58 -0400
Received: from mout.web.de ([212.227.17.12]:55548 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752626AbaJ1ST5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2014 14:19:57 -0400
Received: from [192.168.178.27] ([79.253.156.206]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MFcE5-1Xv1Lx2vxN-00EftI; Tue, 28 Oct 2014 19:19:52
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <CAKJhZwRShbV14=BihxiTzayR4kg3GaAPN_NFXwFZ-4kAD-QHTA@mail.gmail.com>
X-Provags-ID: V03:K0:Jkl/4Qdi8UO9WornnPJUeSTXcFv3xPLPNnhwZ2RYtJqmFDBYzdX
 Xho6mMbgZEAh+LAr2LJJ/7WRkFZlQ1ZKQn2+GmtJVqLFHFAIxDeZsJVM9sSh7+wFaoTVOzn
 iINiPsBTHBKLizeysskB0BTfwF48ZrFKewWedONbH9YCGXq1qs+L2P8j/TFGhDQrAqV4x4L
 pRwHku1Y6NF8Czoubl3Nw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.10.2014 um 00:32 schrieb Zoltan Klinger:
> I like Ren=C3=A9's approach, too. It's more flexible, supports the ol=
d
> behaviour and it scratches my itch as well.
> Don't mind if you dropped my patch and used Ren=C3=A9's instead.


Good. :)  And here's the t/ part of your patch, slightly changed to
exercise the new config options.

---
 t/t7810-grep.sh | 93 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 93 insertions(+)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 40615de..5d3e161 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1202,4 +1202,97 @@ test_expect_success LIBPCRE 'grep -P "^ "' '
 	test_cmp expected actual
 '
=20
+cat >expected <<EOF
+space-line without leading space1
+space: line <RED>with <RESET>leading space1
+space: line <RED>with <RESET>leading <RED>space2<RESET>
+space: line <RED>with <RESET>leading space3
+space:line without leading <RED>space2<RESET>
+EOF
+
+test_expect_success 'grep --color -e A -e B with context' '
+	test_config color.grep.context		normal &&
+	test_config color.grep.filename		normal &&
+	test_config color.grep.function		normal &&
+	test_config color.grep.linenumber	normal &&
+	test_config color.grep.match		red &&
+	test_config color.grep.selected		normal &&
+	test_config color.grep.separator	normal &&
+
+	git grep --color=3Dalways -C2 -e "with " -e space2  space |
+	test_decode_color >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+space-line without leading space1
+space- line <GREEN>with <RESET>leading space1
+space: line <RED>with <RESET>leading <RED>space2<RESET>
+space- line <GREEN>with <RESET>leading space3
+space-line without leading <GREEN>space2<RESET>
+EOF
+
+test_expect_success 'grep --color -e A --and -e B with context' '
+	test_config color.grep.context		normal &&
+	test_config color.grep.filename		normal &&
+	test_config color.grep.function		normal &&
+	test_config color.grep.linenumber	normal &&
+	test_config color.grep.matchContext	green &&
+	test_config color.grep.matchSelected	red &&
+	test_config color.grep.selected		normal &&
+	test_config color.grep.separator	normal &&
+
+	git grep --color=3Dalways -C2 -e "with " --and -e space2  space |
+	test_decode_color >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+space-line without leading space1
+space: line <RED>with <RESET>leading space1
+space- line <GREEN>with <RESET>leading <GREEN>space2<RESET>
+space: line <RED>with <RESET>leading space3
+space-line without leading <GREEN>space2<RESET>
+EOF
+
+test_expect_success 'grep --color -e A --and --not -e B with context' =
'
+	test_config color.grep.context		normal &&
+	test_config color.grep.filename		normal &&
+	test_config color.grep.function		normal &&
+	test_config color.grep.linenumber	normal &&
+	test_config color.grep.matchContext	green &&
+	test_config color.grep.matchSelected	red &&
+	test_config color.grep.selected		normal &&
+	test_config color.grep.separator	normal &&
+
+	git grep --color=3Dalways -C2 -e "with " --and --not -e space2  space=
 |
+	test_decode_color >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
+hello.c-#include <stdio.h>
+hello.c=3D<GREEN>int<RESET> main(<GREEN>int<RESET> argc, const char **=
argv)
+hello.c-{
+hello.c:	pr<RED>int<RESET>f("<RED>Hello<RESET> world.\n");
+hello.c-	return 0;
+hello.c-	/* char ?? */
+hello.c-}
+EOF
+
+test_expect_success 'grep --color -e A --and -e B -p with context' '
+	test_config color.grep.context		normal &&
+	test_config color.grep.filename		normal &&
+	test_config color.grep.function		normal &&
+	test_config color.grep.linenumber	normal &&
+	test_config color.grep.matchContext	green &&
+	test_config color.grep.matchSelected	red &&
+	test_config color.grep.selected		normal &&
+	test_config color.grep.separator	normal &&
+
+	git grep --color=3Dalways -p -C3 -e int --and -e Hello --no-index hel=
lo.c |
+	test_decode_color >actual &&
+	test_cmp expected actual
+'
+
 test_done
--=20
2.1.2
