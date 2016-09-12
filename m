Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24F8720984
	for <e@80x24.org>; Mon, 12 Sep 2016 08:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757152AbcILIpM (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 04:45:12 -0400
Received: from forward2h.cmail.yandex.net ([87.250.230.17]:45982 "EHLO
        forward2h.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757091AbcILIpL (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Sep 2016 04:45:11 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Sep 2016 04:45:10 EDT
Received: from mxback2o.mail.yandex.net (mxback2o.mail.yandex.net [37.140.190.16])
        by forward2h.cmail.yandex.net (Yandex) with ESMTP id 8B04820C4C
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 11:38:01 +0300 (MSK)
Received: from web11o.yandex.ru (web11o.yandex.ru [95.108.205.111])
        by mxback2o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id Rr8xDEsEw5-c0t4cWVB;
        Mon, 12 Sep 2016 11:38:00 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=filippov.me; s=mail; t=1473669480;
        bh=0ZaG2VU3/0ZYz8Po6vatFiCbAOB8RlKrH3kwk90j2Ss=;
        h=From:To:In-Reply-To:References:Subject:Message-Id:Date;
        b=i/4RXZNRygteOSGpkodFeOj+sIYrzNpiap03mt4AKp51W93qRHwWxOkZ63XhOeYTU
         FmHC3xWAHlQqLdhCPlIsLh7GxpU7Zohm78RB/3N1SQjPVICM5ELqGvQbXpNTh9ntd6
         gc/4//63mfQzCUMpTEk7x3iiiDoK6ndRjoaFgduQ=
Authentication-Results: mxback2o.mail.yandex.net; dkim=pass header.i=@filippov.me
Received: by web11o.yandex.ru with HTTP;
        Mon, 12 Sep 2016 11:38:00 +0300
From:   Mikhail Filippov <mikhail@filippov.me>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <xmqqeg4q6mw4.fsf@gitster.mtv.corp.google.com>
References: <1473625505-7641-1-git-send-email-mikhail@filippov.me> <xmqqeg4q6mw4.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH] Do not record unstaged deleted file upon recursive merge if file was moved outside of working tree with enabled sparse-checkout.
MIME-Version: 1.0
Message-Id: <798801473669480@web11o.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Mon, 12 Sep 2016 11:38:00 +0300
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's a very unexpected behaviour when a user sees a deleted file after a merge with enabled sparse-checkout. Moreover, when the user resolves merge conflicts and commits the changes with the command "git commit -am xxx", a repository can be broken because all the moved files will be deleted. Finally, it's really hard to find a user who deleted these files because "git log file" doesn't show any merge commits by default. I'm not sure that my fix is correct but I checked all tests and I didn't find a better way to prevent files deleting.

12.09.2016, 02:24, "Junio C Hamano" <gitster@pobox.com>:
>    Mikhail Filippov <mikhail@filippov.me> writes:
>
>>     ---
>
>    You'd need a lot more explanation on why this is needed
>    (i.e. without it what behaviour you would get, and why that
>    behaviour is wrong).
>
>>      merge-recursive.c | 9 +++++---
>>      t/t6042-merge-rename-corner-cases.sh | 42 ++++++++++++++++++++++++++++++++++++
>>      2 files changed, 48 insertions(+), 3 deletions(-)
>>
>>     diff --git a/merge-recursive.c b/merge-recursive.c
>>     index e349126..25dc701 100644
>>     --- a/merge-recursive.c
>>     +++ b/merge-recursive.c
>>     @@ -1724,9 +1724,12 @@ static int merge_content(struct merge_options *o,
>>                       */
>>                      path_renamed_outside_HEAD = !path2 || !strcmp(path, path2);
>>                      if (!path_renamed_outside_HEAD) {
>>     - add_cacheinfo(o, mfi.mode, &mfi.oid, path,
>>     - 0, (!o->call_depth), 0);
>>     - return mfi.clean;
>>     + struct stat st;
>>     + if (lstat(path, &st) == 0) {
>>     + add_cacheinfo(o, mfi.mode, &mfi.oid, path,
>>     + 0, (!o->call_depth), 0);
>>     + return mfi.clean;
>>     + }
>
>    I cannot guess what you are trying to achieve without explanation in
>    the proposed log message, but I can say that this unconditional
>    checking of a working tree file cannot be correct (there may or may
>    not be other things that are wrong with this change, which cannot be
>    judged without more information).
>
>    Imagine your o->call_depth is not zero, i.e. we are making a virtual
>    common ancestor with this merge, in which case any of the three
>    trees involved may have nothing to do with the current working tree
>    files.
>
>>     +test_expect_success 'move file/sparse-checkout/merge should not delete moved file' '
>>     + git rm -rf . &&
>>     + git clean -fdqx &&
>>     + rm -rf .git &&
>>     + git init &&
>
>    Yuck. This is inherited from existing tests but I think they need
>    to be cleaned up. It is not your fault, and it is not in the scope
>    of this change.
>
>>     + git status >output &&
>>     + cp output /tmp/a &&
>
>    Huh?
>
>>     + test_i18ngrep "nothing to commit" output
>>     +'
>>     +
>>      test_done




-- 
Mikhail Filippov 
Software Developer
JetBrains
http://jetbrains.com
“The Drive To Develop"
