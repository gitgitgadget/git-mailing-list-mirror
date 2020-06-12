Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9C5C433E0
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 23:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9336206D7
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 23:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgFLXQ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 19:16:57 -0400
Received: from dovecot.mat.umk.pl ([158.75.2.81]:59972 "EHLO
        poczta1.mat.umk.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgFLXQ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 19:16:56 -0400
Received: from dovecot.mat.umk.pl (localhost.localdomain [127.0.0.1])
        by poczta1.mat.umk.pl (Postfix) with ESMTP id 118F79568B9;
        Sat, 13 Jun 2020 01:16:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mat.umk.pl
Received: from poczta1.mat.umk.pl ([127.0.0.1])
        by dovecot.mat.umk.pl (poczta1.mat.umk.pl [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id If8O4nvTaI1q; Sat, 13 Jun 2020 01:16:53 +0200 (CEST)
Received: from [192.168.0.2] (host-89-229-7-83.dynamic.mm.pl [89.229.7.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jnareb)
        by poczta1.mat.umk.pl (Postfix) with ESMTPSA id 26F509568B7;
        Sat, 13 Jun 2020 01:16:53 +0200 (CEST)
Cc:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 1/4] alloc: introduce parsed_commits_count
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>, git@vger.kernel.org
References: <20200612184014.1226972-1-abhishekkumar8222@gmail.com>
 <20200612184014.1226972-2-abhishekkumar8222@gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <8b0facef-c85d-c25c-d49d-2bc1a3836e77@gmail.com>
Date:   Sat, 13 Jun 2020 01:16:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200612184014.1226972-2-abhishekkumar8222@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12.06.2020, Abhishek Kumar wrote:

> Commit slab relies on uniqueness of commit->index to access data. As
> submodules are repositories on their own, alloc_commit_index() (which
> depends on repository->parsed_objects->commit_count) no longer
> returns unique values.
> 
> This would break tests once we move `generation` and `graph_pos` into a
> commit slab, as commits of supermodule and submodule can have the same
> index but must have different graph positions.

First, commits of supermodule and of submodule are in different graphs,
so I don't see why they have to be in the same serialized commit-graph
file.

Second, Git stores many different types of information on slab already.
How comes that we have not had any problems till now?  

There is contains_cache, commit_seen, indegree_slab, author_date_slab,
commit_base, commit_pos, bloom_filter_slab, buffer_slab, commit_rev_name,
commit_names, commit_name_slab, saved_parents, blame_suspects,
commit_todo_item.

> 
> Let's introduce a counter variable, `parsed_commits_count` to keep track
> of parsed commits so far.

All right, thought it might be worth mentioning that it is a global
variable, or rather a static variable in a function.

> 
> 
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
> 
> CI Build for the failing tests:
> https://travis-ci.com/github/abhishekkumar2718/git/jobs/345413840

The failed tests are, from what I see:
- t4060-diff-submodule-option-diff-format.sh
- t4041-diff-submodule-option.sh
- t4059-diff-submodule-not-initialized.sh


> 
>   alloc.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/alloc.c b/alloc.c
> index 1c64c4dd16..29f0e3aa80 100644
> --- a/alloc.c
> +++ b/alloc.c
> @@ -101,7 +101,9 @@ void *alloc_object_node(struct repository *r)
>   
>   static unsigned int alloc_commit_index(struct repository *r)
>   {
> -	return r->parsed_objects->commit_count++;
> +	static unsigned int parsed_commits_count = 0;
> +	r->parsed_objects->commit_count++;

Do we use r->parsed_objects->commit_count anywhere?

> +	return parsed_commits_count++;

Does it matter that it is not thread safe, because it is not atomic?
Shouldn't it be

  +	static _Atomic unsigned int parsed_commits_count = 0;

or

  +	static _Atomic unsigned int parsed_commits_count = ATOMIC_VAR_INIT(0);

(If it is allowed).

>   }
>   
>   void init_commit_node(struct repository *r, struct commit *c)
> 

