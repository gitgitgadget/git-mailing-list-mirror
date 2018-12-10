Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 334AF20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 23:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbeLJXNT (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 18:13:19 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:59358 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727626AbeLJXNT (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 10 Dec 2018 18:13:19 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBAN9KCC022162;
        Mon, 10 Dec 2018 15:13:14 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2p8cpp2peg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 10 Dec 2018 15:13:13 -0800
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Mon, 10 Dec 2018 15:13:16 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Mon, 10 Dec 2018 15:13:16 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 1DB14220F600;
        Mon, 10 Dec 2018 15:13:12 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
CC:     <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/3] rebase: offer to reschedule failed exec commands automatically
Date:   Mon, 10 Dec 2018 15:13:11 -0800
Message-ID: <20181210231311.15621-1-newren@gmail.com>
X-Mailer: git-send-email 2.20.0.11.g8d7039fcd7
In-Reply-To: pull.90.git.gitgitgadget@gmail.com
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-10_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812100207
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 10, 2018 at 1:18 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:

> The idea was brought up by Paul Morelle.
>
> To be honest, this idea of rescheduling a failed exec makes so much sense
> that I wish we had done this from the get-go.
> 
> So let's do the next best thing: implement a command-line option and a
> config setting to make it so.

I was a bit worried that the optics weren't good enough for recovering from
a typoed exec command (or one that otherwise wouldn't be in a state the
user could make pass but they wanted the rebase to continue).  However,
after trying it out, I found:

$ git rebase --exec /bin/false --reschedule-failed-exec HEAD~1
Executing: /bin/false
warning: execution failed: /bin/false
You can fix the problem, and then run

  git rebase --continue


hint: Could not execute the todo command
hint: 
hint:     exec /bin/false
hint: 
hint: It has been rescheduled; To edit the command before continuing, please
hint: edit the todo list first:
hint: 
hint:     git rebase --edit-todo
hint:     git rebase --continue

and if the user just runs "git rebase --continue" without looking at that big
hint, they'll get the hint again.  When they run "git rebase --edit-todo", they
see the failed command listed first and can remove that line.

So, I think my initial worry was unfounded.

 
> The obvious intent behind that config setting is to not only give users a
> way to opt into that behavior already, but also to make it possible to flip
> the default at a later date, after the feature has been battle-tested and
> after deprecating the non-rescheduling behavior for a couple of Git
> versions.
> 
> If the team agrees with my reasoning, then the 3rd patch (introducing -y
> <cmd> as a shortcut for --reschedule-failed-exec -x <cmd>) might not make
> much sense, as it would introduce a short option that would become obsolete
> soon.

This series is awesome; thanks much to Paul for suggesting this idea.
And yeah, I agree and hope the third patch won't be necessary.  :-)

> Johannes Schindelin (3):
>   rebase: introduce --reschedule-failed-exec
>   rebase: add a config option to default to --reschedule-failed-exec
>   rebase: introduce a shortcut for --reschedule-failed-exec
> 
>  Documentation/config/rebase.txt |  5 ++++
>  Documentation/git-rebase.txt    | 11 +++++++++
>  builtin/rebase--interactive.c   |  2 ++
>  builtin/rebase.c                | 42 ++++++++++++++++++++++++++++++++-
>  git-legacy-rebase.sh            | 24 ++++++++++++++++++-
>  git-rebase--common.sh           |  1 +
>  sequencer.c                     | 13 +++++++---
>  sequencer.h                     |  1 +
>  t/t3418-rebase-continue.sh      | 14 +++++++++++
>  9 files changed, 108 insertions(+), 5 deletions(-)
> 
> 
> base-commit: a1598010f775d82b5adf12c29d0f5bc9b41434c6
> Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-90%2Fdscho%2Freschedule-failed-exec-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-90/dscho/reschedule-failed-exec-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/90
> -- 
> gitgitgadget
