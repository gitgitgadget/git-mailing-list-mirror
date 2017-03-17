Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5BBD20323
	for <e@80x24.org>; Fri, 17 Mar 2017 05:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751076AbdCQF5T (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 01:57:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54822 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750885AbdCQF5R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 01:57:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D3B5B71DDC;
        Fri, 17 Mar 2017 01:56:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ud0+a2lZbTubD02pnwPXr9S9qXw=; b=PZ+ihW
        V13oFomqt/yYkJJ7ddpF7PBZ7QQIRuh/hsMK7fLwwDFBnilJ22LlY3wr1M5fej3M
        J3NdFJ3lydheHaZefFmdW/Wju4qwTBF9EO4tFVO9dIobRGIvbEMnFVcFI6joVqBM
        d0QpfvWipbkYnKkcrs1R14gZcClIetdCLrKhU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mIEujjqEXcx5zkaXLvxqJpnlFlgMW1C4
        7QZVVTtgDV8dFlxMXszWeg/5Oqv8mLyiDmKnzyNjWKefezm9nOWSeu2/w1etlwB+
        +XuB7QeOl9OeY5AtCuh/Z4FV6kPS9gkafcOAvq+0FowK9HY5hFyjgRKsHFqkswjw
        XSm+GXDUQks=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC78071DDB;
        Fri, 17 Mar 2017 01:56:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 36CB571DDA;
        Fri, 17 Mar 2017 01:56:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/2] name-rev: favor describing with tags and use committer date to tiebreak
References: <xmqqd1die00j.fsf@gitster.mtv.corp.google.com>
        <20170315225045.15788-1-gitster@pobox.com>
        <20170315225045.15788-3-gitster@pobox.com>
        <9AE7ADCA-97F9-4857-AC55-76C4BD822C25@gmail.com>
        <xmqqy3w48nif.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 16 Mar 2017 22:56:22 -0700
In-Reply-To: <xmqqy3w48nif.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 16 Mar 2017 22:45:28 -0700")
Message-ID: <xmqqshmc8n09.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73559F64-0AD6-11E7-BCED-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Lars Schneider <larsxschneider@gmail.com> writes:
>
>> A quick bisect indicates that this patch might break 
>> t9807-git-p4-submit.sh 8 and 13. I haven't looked into
>> it further, yet.
>
> As I do not do P4, help in diagnosing why it breaks is appreciated.
> If the test script expects...
> On the other hand, if git-p4 command internally uses name-rev and it
> is not prepared to properly handle commits that can be named in more
> than one way, the problem would be deeper, as it would mean it can
> misbehave even without the change to name-rev when multiple branches
> point at the same commit.

Yikes.  Perhaps something along this line?  

This function seems to want to learn which branch we are on, and
running "name-rev HEAD" is *NEVER* the right way to do so.  If you
are on branch B which happens to point at the same commit as branch
A, "name-rev HEAD" can say either A or B (and it is likely it would
say A simply because it sorts earlier, and the logic seems to favor
the one that was discovered earlier when all else being equal).

 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index eab319d76e..351d1ab58e 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -582,7 +582,7 @@ def currentGitBranch():
         # on a detached head
         return None
     else:
-        return read_pipe(["git", "name-rev", "HEAD"]).split(" ")[1].strip()
+        return read_pipe(["git", "symbolic-ref", "HEAD"]).strip()[11:]
 
 def isValidGitDir(path):
     return git_dir(path) != None
