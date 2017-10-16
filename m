Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F95220437
	for <e@80x24.org>; Mon, 16 Oct 2017 17:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754999AbdJPROI (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 13:14:08 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:4264 "EHLO bsmtp8.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754240AbdJPRNp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 13:13:45 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp8.bon.at (Postfix) with ESMTPSA id 3yG4fb1lZ0z5tlD;
        Mon, 16 Oct 2017 19:13:42 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 4DA41306;
        Mon, 16 Oct 2017 19:13:42 +0200 (CEST)
Subject: Re: Does Git build things during 'make install"?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     noloader@gmail.com, Git List <git@vger.kernel.org>
References: <CAH8yC8kx9Td51=UFvLwLAQFPKxUXg0D6KKqWR+JX+-wmTAKYRQ@mail.gmail.com>
 <0ec353db-428c-bb6f-03fe-303487fde197@kdbg.org>
 <xmqq60bfsdpj.fsf@gitster.mtv.corp.google.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <446559c7-364a-fb33-905a-74b487900d3b@kdbg.org>
Date:   Mon, 16 Oct 2017 19:13:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqq60bfsdpj.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.10.2017 um 10:23 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> Yes, running "sudo make install" is a nightmare. sudo clears the path,
>> and the git command is not found by the make invoked with root
>> permissions. This changes the version string that gets compiled into
>> the executable, which finally triggers a complete rebuild under
>> root. Sad...
> 
> In the meantime, would it help to intall as yourself under DESTDIR
> set to where you can write into, and then limit the potential
> damange done while pretending to be a privileged user to "cp -R" (or
> "tar cf" in $DESTDIR piped to "tar xf" in /)?
> 
> It appears that some dependencies are screwed up around "perl"
> related things, which may want to get fixed.  I agree that "make &&
> make install" that runs two 'make' under the same environment and
> user shouldn't (re)build anything during the latter 'make', but we
> somehow seem to do so.

We do so only, if 'make install' does not run in the same environment
and if there is no version file.

I use the patch below. It works for me, but I could imagine that it
suffers from the original problem if there is no git in PATH and there
is no version file, i.e., when the source is not a release tarball.

----- 8< -----
Subject: [PATCH] version-gen: Use just built git if no other git is in PATH

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 GIT-VERSION-GEN | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 0e88e23653..b610aa3249 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -3,6 +3,9 @@
 GVF=GIT-VERSION-FILE
 DEF_VER=v2.15.0-rc1
 
+# use git that was just compiled if there is no git elsewhere in PATH
+PATH=$PATH:.
+
 LF='
 '
 
-- 
2.14.2.808.g3bc32f2729
