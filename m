Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A152C4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 14:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3E42225A9
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 14:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438484AbgLNOpc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 09:45:32 -0500
Received: from mail.netline.ch ([148.251.143.178]:53401 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406958AbgLNOpc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 09:45:32 -0500
X-Greylist: delayed 463 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Dec 2020 09:45:30 EST
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id D597E2A6042;
        Mon, 14 Dec 2020 15:37:05 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id QPcfmc9RAJY2; Mon, 14 Dec 2020 15:37:05 +0100 (CET)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch [85.2.99.24])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id 7B3F32A6016;
        Mon, 14 Dec 2020 15:37:05 +0100 (CET)
Received: from [::1]
        by thor with esmtp (Exim 4.94)
        (envelope-from <michel@daenzer.net>)
        id 1kooyG-000Pzu-J7; Mon, 14 Dec 2020 15:37:04 +0100
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Cc:     Daniel Stone <daniel@fooishbar.org>
Subject: Bug report: git rebase ignores different context, resulting in subtle
 breakage
Message-ID: <c22ba034-6d7d-866a-c6fb-d769d117eec4@daenzer.net>
Date:   Mon, 14 Dec 2020 15:37:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


(Originally reported as a GitLab issue: 
https://gitlab.com/gitlab-org/gitlab/-/issues/292754)


All output below is from Debian git 2.29.2-1.


The following branches of 
https://gitlab.freedesktop.org/daenzer/mesa.git can be used to reproduce:

gitlab-issue-292754/pre-rebase (pre-rebase state)
gitlab-issue-292754/base (new base)
gitlab-issue-292754/bad-rebase (bad post-rebase state)


The pre-rebase commit b9f18d0ddb6b075819bc2c6b9fa36dee483ef443 contains 
this (truncated) hunk:

@@ -480,13 +491,9 @@ sanity:

    rules:

      - if: *is-pre-merge

        when: on_success

-    - if: *is-forked-branch

-      when: manual

      # Other cases default to never

    script:

      # ci-fairy check-commits --junit-xml=check-commits.xml



The new base commit f20153536087079f39f1ab9995ac3d36dd3c467f contains 
this hunk:

@@ -484,10 +484,8 @@ sanity:

      - .fdo.ci-fairy

    stage: sanity

    rules:

-    - if: *is-pre-merge

+    - if: *is-forked-branch-or-pre-merge

        when: on_success

-    - if: *is-forked-branch

-      when: manual

      # Other cases default to never

    variables:

      GIT_STRATEGY: none



Both remove the same 2 lines, but the context is different both before 
and after those lines.

My expectation for this case would be that

  git rebase gitlab-issue-292754/base gitlab-issue-292754/pre-rebase

fails with a conflict. However, it succeeds without any indication of 
trouble, resulting in these contents in commit 
4e549e1ac3354f465d8afe0174902e62143a6ff4:

    rules:


     - if: *is-forked-branch-or-pre-merge


        when: on_success


      # Other cases default to never


    variables:


      GIT_STRATEGY: none

    script:


      # ci-fairy check-commits --junit-xml=check-commits.xml


I.e. identical to the new base.

However, the 2 removed lines had a different effect in the original 
pre-rebase context, and the post-rebase state no longer matches the 
original intention. git rebase silently introduced a subtle bug.


git rebase --apply results in this output:

  First, rewinding head to replay your work on top of it...

  Applying: ci: Run sanity job only in pre-merge pipelines

  Using index info to reconstruct a base tree...

  M	.gitlab-ci.yml

  Falling back to patching base and 3-way merge...

  Auto-merging .gitlab-ci.yml


Looks like the applying strategy does detect the conflict, but there's 
an automatic fallback to the merging strategy, which again succeeds 
(with the same broken result).


The only way I've found to avoid the broken behaviour is git rebase -s 
octopus [...]:

  error: could not apply b9f18d0ddb6... ci: Run sanity job only in pre
  merge pipelines

  Resolve all conflicts manually, mark them as resolved with

  "git add/rm <conflicted_files>", then run "git rebase --continue".

  You can instead skip this commit: run "git rebase --skip".

  To abort and get back to the state before "git rebase", run "git rebase
  --abort".

  Could not apply b9f18d0ddb6... ci: Run sanity job only in pre-merge
  pipelines


-- 
Earthling Michel Dänzer               |               https://redhat.com
Libre software enthusiast             |             Mesa and X developer
