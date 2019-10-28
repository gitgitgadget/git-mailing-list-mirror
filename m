Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FF141F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 14:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390007AbfJ1O1I (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 10:27:08 -0400
Received: from felt-1.demon.nl ([82.161.237.226]:39084 "EHLO felt-1.demon.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728330AbfJ1O1I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 10:27:08 -0400
X-Greylist: delayed 1592 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Oct 2019 10:27:07 EDT
Received: from [192.168.129.7] (x007.home.local [192.168.129.7])
        by felt-1.demon.nl (AIX7.1/8.14.4/8.14.4) with ESMTP id x9SE0YkB12320796
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 14:00:34 GMT
To:     git@vger.kernel.org
From:   Michael Felt <aixtools@felt.demon.nl>
Subject: COMMENTS: building git on AIX
Message-ID: <1200106e-b75d-5b15-0608-427cd923578a@felt.demon.nl>
Date:   Mon, 28 Oct 2019 15:00:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have, a couple of time, successfully built git for AIX. However, my
prior attempt (version 2.18) - I never got around to finishing and today
with version 2.23.0 - I am unsure how to proceed without a lot of hacking.

Just some comments - long long way from calling anything a bug - just
not as portable as I would have hoped.

The simple issues:

1. The "Makefile" is surprising. I expect to run ./configure (or better,
out-of tree, e.g., ../src/git-2.23.0/configure). Just running OOT
configure does not result in a "Makefile". So, copy source tree to dest
and try again.

2. Makefile assumes gmake. Standard make does not support :: syntax
(fix: install cmake)

3. The default CFLAGS contains -Wall. Not all compilers support -Wall.
"Fixed" by adding CFLAGS="-g -O2". I am also undecided on having -g as a
default flag.

4. Must have gettext installed, which needs GNU libiconv - sad to have
these libraries as additional dependencies. e.g., bash 4.4 finally
removed the gettext and iconv gnu dependencies. -- FYI!

5. Another "gcc"? dependency: "git-compat-util.h", line 361.1: 1506-277
(S) Syntax error: possible missing ';'
FIX: add 'CC=xlc_r' to get language extensions

6. Needs curl (libcurl and curl.h), but does not check until much later:
FIX install curl; FIX2 add -I flag to find $prefix/include to CFLAGS
(.e.g., CFLAGS="-g -O2 -I/opt/include") - FYI GNU autotools also fail to
include $prefix/include

7. More stuck here. libssh2 is built by curl, but as a static library. I
could "hack" the libssh2.o file into the linkage, but unclear how well
that will work. Also wonder if libssh2 is "required" or optional. For
curl it has been optional (and I think it still is).

Current status:

xlc_r   -g -O2 -I/opt/include -I. -D_LARGE_FILES
-DGIT_HOST_CPU="\"00C291F54C00\"" -DUSE_CURL_FOR_IMAP_SEND -DNO_NSEC
-DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES
-DSHA1DC_INIT_SAFE_HASH_DEFAULT=0
-DSHA1DC_CUSTOM_INCLUDE_SHA1_C="\"cache.h\""
-DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="\"git-compat-util.h\""
-DSHA256_BLK   -DFREAD_READS_DIRECTORIES -DNO_STRCASESTR -DNO_STRLCPY
-DNO_MKDTEMP -DNO_MEMMEM -DINTERNAL_QSORT -Icompat/regex
-DFILENO_IS_A_MACRO -DNEED_ACCESS_ROOT_HANDLER -DDEFAULT_PAGER='"more"'
-DSHELL_PATH='"/bin/sh"' -DPAGER_ENV='"LESS=FRX LV=-c"' -o
git-imap-send   imap-send.o http.o common-main.o \
          -L/opt/lib -lcurl -lssh2 -lssh2 -lssl -lcrypto -lldap -llber
-lssl -lcrypto -lz  -lssl  -lcrypto libgit.a xdiff/lib.a  -lz  -liconv
-lintl -lpthread
ld: 0706-006 Cannot find or open library file: -l ssh2
        ld:open(): A file or directory in the path name does not exist.
ld: 0706-006 Cannot find or open library file: -l ssh2
        ld:open(): A file or directory in the path name does not exist.
ld: 0706-006 Cannot find or open library file: -l ldap
        ld:open(): A file or directory in the path name does not exist.
ld: 0706-006 Cannot find or open library file: -l lber
        ld:open(): A file or directory in the path name does not exist.

This will need, at the least an additional LDFLAGS added to the make
command ('LDFLAGS="-L/opt/lib"'), but I still have to find where the
-lssh2 is generated.

Not sure - if I can help - but do hope this already helps in a (small) way.

Regards,

Michael

