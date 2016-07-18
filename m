Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 506922018B
	for <e@80x24.org>; Mon, 18 Jul 2016 22:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbcGRW4N (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 18:56:13 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33866 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825AbcGRW4L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 18:56:11 -0400
Received: by mail-qk0-f173.google.com with SMTP id o67so1197435qke.1
        for <git@vger.kernel.org>; Mon, 18 Jul 2016 15:56:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=nitPuUZ899fKtya9eRxTBPDnO3jBc/2pgstQKxnHFqc=;
        b=NXmAfW7GuaQw1rK5L6kEf+/Te27cVF7uIM89i7NLJeqneMowIV0ssemMlnfz4Bsafr
         UmAwfaikQOwuci9WLj1TvhnRiBkLA+qAjai87TdIRYz1N4Av3rR+4S2A21rwfz5+a/Qt
         pzkjySAlT+X6CkUHJuOlsCxcEIMA0SAZnk1FGzs3EG5dMeezS6tVwWQdPvu/zRO9s5sL
         yJkA+NYuWeKcYNa36UVaV2dBk133eh7QmiRcnDir1mnt+WNxneTGjZ3hQdEWoYS1+RIv
         x6I5JzuT4cUVJclb9kITUDoO+poVw3PEN1arhJc/qUqjnT85KtdLAsFpIqfJx1RAbPMN
         wrEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nitPuUZ899fKtya9eRxTBPDnO3jBc/2pgstQKxnHFqc=;
        b=jGnZ2/7lPRTLja2MTofLFKbNqQDBT0GvYP1bDge+49mcrVD9+0UEJUMNVwfEDG0bxB
         VwXub+XoBRnHaNJnRhT38oDbcJJhLITMueSahEXIA1DQQoF1okkqVLY2bDtLtkI5jqAI
         6BARtTCqdaKlJyL3QWhm8DOcL4bm50QcQkmOdyThpowrk0uSJOPjSDVksVb3vc0jkxUU
         +Je5SNIVYeN7d7d3DlmrjdbeJT3JOkm6erduy/cVUPjqesQ6uLz7/7GXIKBgVYXHkcfP
         ptSwtu5tYNRGrgodV3zxztTDF059hewmnuvPwA7upI0i4Qb4arKB/oMoOGBwmXax6UNH
         4Mtw==
X-Gm-Message-State: ALyK8tINth85MN7I9Zpe9YKmY6IPFXUwp4mklEUNah8xtwopbs15QlCK8gZ/RnVuTnd9WTTBwuh+pc9K8vig8g==
X-Received: by 10.55.22.154 with SMTP id 26mr47938962qkw.193.1468882570085;
 Mon, 18 Jul 2016 15:56:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.45.249 with HTTP; Mon, 18 Jul 2016 15:56:09 -0700 (PDT)
From:	Richard Soderberg <rsoderberg@gmail.com>
Date:	Mon, 18 Jul 2016 15:56:09 -0700
Message-ID: <CAEvc1UQvXKtQCXvCmt-774A84--bkK-sb94BtFeqDDr0Gsf7qw@mail.gmail.com>
Subject: git-prompt.sh incompatible with non-basic global grep.patternType
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi, I wanted to report something interesting that I found while
tracing a severe slowdown in git-prompt.sh.

https://github.com/git/git/commit/6d158cba282f22fa1548af1188f78042fed30aed#diff-f37c4f4a898819f0ca4b5ff69e81d4d9R141

Way back in this commit, someone added a useful chunk of code that
works perfectly with svn+ssh:// URLs under basic regexes:

+ local svn_upstream=($(git log --first-parent -1 \
+ --grep="^git-svn-id: \(${svn_url_pattern:2}\)" 2>/dev/null))

However, if I switch over to Perl regexes (or Extended):

git config --global grep.patternType perl

Then the command runs for one wall clock second and shows incorrect
results on my repository. I eventually traced this to an issue with
the regular expression provided, assuming the svn repository url is
"svn+ssh://...":

git log ... --grep="^git-svn-id: \(svn+ssh://...\)" 2>/dev/null

The + sign isn't escaped in git-prompt.sh, which under non-basic
regexes causes the match to fail entirely.

 - R.

ps. git log --basic-regexp does not fix the issue, as for unknown
reasons (I'll start another thread) the command-line option doesn't
override grep.patternType.
