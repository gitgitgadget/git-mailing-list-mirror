Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AA7C20D09
	for <e@80x24.org>; Sat, 27 May 2017 14:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756774AbdE0OGz (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 May 2017 10:06:55 -0400
Received: from avasout08.plus.net ([212.159.14.20]:33440 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756594AbdE0OGy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 May 2017 10:06:54 -0400
Received: from [10.0.2.15] ([143.159.212.80])
        by avasout08 with smtp
        id RS6r1v0081keHif01S6sb0; Sat, 27 May 2017 15:06:53 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=FLJr/6gs c=1 sm=1 tr=0
 a=n+zECcf3rkBNBoU0FNF4VQ==:117 a=n+zECcf3rkBNBoU0FNF4VQ==:17
 a=IkcTkHD0fZMA:10 a=6MLsA6WmFTffsd5Mh6wA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [GSoC][PATCH v5 3/3] submodule: port subcommand foreach from
 shell to C
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
To:     Johannes Sixt <j6t@kdbg.org>, Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, bmwill@google.com, christian.couder@gmail.com,
        sbeller@google.com
References: <20170521125814.26255-2-pc44800@gmail.com>
 <20170526151713.10974-1-pc44800@gmail.com>
 <20170526151713.10974-3-pc44800@gmail.com>
 <83801d05-e3a9-b7e4-8f29-cd8172257dac@kdbg.org>
 <41781ba1-2284-cc5d-8736-bb87d580f5bf@ramsayjones.plus.com>
Message-ID: <ef0b2850-ad3b-e33d-37b7-ece9a305a7a4@ramsayjones.plus.com>
Date:   Sat, 27 May 2017 15:06:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <41781ba1-2284-cc5d-8736-bb87d580f5bf@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 27/05/17 02:20, Ramsay Jones wrote:
> 
> 
> On 26/05/17 22:54, Johannes Sixt wrote:
>> Am 26.05.2017 um 17:17 schrieb Prathamesh Chavan:
>>> +    argv_array_pushf(&cp.env_array, "path=%s", list_item->name);
>>
>> Not good! On Windows, environment variables are case insensitive. The environment variable "path" has a very special purpose, although it is generally spelled "PATH" (actually "Path" on Windows).
>>
>> Lowercase "path" may have worked as long as it was only used in a shell script (and perhaps only by lucky coincidence), but this I can pretty much guarantee to fail. (I haven't tested it, though.)
>>
>> The correct fix can only be to rename this variable here and in shell scripts that need the value that is set here.
> 
> Yeah, I already pointed to commit 64394e3ae9 (but it seems not
> to have registered!), but ...
> 
> I tried provoking a failure on cygwin, and I couldn't get it to fail!

To be more explicit, last Sunday I hacked into t7407 to show an
example failure on cygwin (see patch below), but it passes on both
Linux (expected) and cygwin! :( Perhaps you can see what I'm doing
wrong?

ATB,
Ramsay Jones

-- >8 --
Date: Sun, 21 May 2017 16:23:58 +0100
Subject: [PATCH] submodule: foreach $path munging on cygwin

---
 t/t7407-submodule-foreach.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 6ba5daf42..c2d66bab7 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -68,17 +68,36 @@ Entering 'sub3'
 $pwd/clone-foo3-sub3-$sub3sha1
 EOF
 
+cat >expect-func <<EOF
+Entering 'sub1'
+running from TRASH
+path is <<sub1>>
+Entering 'sub3'
+running from TRASH
+path is <<sub3>>
+EOF
+
 test_expect_success 'test basic "submodule foreach" usage' '
+	PATH="$PWD:$PATH" &&
+	write_script foreach-func <<-\EOF &&
+	echo "running from TRASH"
+	echo "path is <<$1>>"
+	EOF
 	git clone super clone &&
 	(
 		cd clone &&
 		git submodule update --init -- sub1 sub3 &&
 		git submodule foreach "echo \$toplevel-\$name-\$path-\$sha1" > ../actual &&
+		git submodule foreach "foreach-func \$path" > ../actual-func1 &&
+		git submodule foreach "export path; foreach-func \$path" > ../actual-func2 &&
 		git config foo.bar zar &&
 		git submodule foreach "git config --file \"\$toplevel/.git/config\" foo.bar"
 	) &&
+	test_i18ncmp expect-func actual-func1 &&
+	test_i18ncmp expect-func actual-func2 &&
 	test_i18ncmp expect actual
 '
+test_done
 
 cat >expect <<EOF
 Entering '../sub1'
-- 
2.13.0

