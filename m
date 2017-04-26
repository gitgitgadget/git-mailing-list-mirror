Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D9D4207D6
	for <e@80x24.org>; Wed, 26 Apr 2017 11:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1954315AbdDZL7q (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 07:59:46 -0400
Received: from mout.gmx.net ([212.227.17.22]:51757 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2999140AbdDZL7m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 07:59:42 -0400
Received: from virtualbox ([95.208.59.147]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MFctN-1dHybA2APF-00EeVq; Wed, 26
 Apr 2017 13:59:09 +0200
Date:   Wed, 26 Apr 2017 13:59:07 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 0/9] The final building block for a faster rebase -i
In-Reply-To: <cover.1493128210.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1493207864.git.johannes.schindelin@gmx.de>
References: <cover.1493128210.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:a6Q0muRlMBed7cWbTlkeww8yMWUS62K+1zC30KwCZsg6pZcf7uB
 cvZLhxCsBgz6jarFlsRCI0cO/HGoOm6TZ/sBY91MB5012sP3yL8+tDJuehG6BhJfCPixAMr
 wSdBN3ckX6eaDzvk1qhY/Eiq92mYGqICdqCkR2ptk5EA9uPtgSW01F/vnZTLn/iZUEg+Ou7
 S4XcxNf82fN3dDDri7UxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r0fU5wKk+7I=:uoBPis3Ou1ScS5dWpS5WdQ
 2U34wlihOe18a075OZZtUlPEsvIwAvIj0ft8xL7g0qyTSTG4fr599VJ2CwfMHkETI4O0VJVrF
 59acg5wRur23znxR/lVdqSGSg691DWfoCjFKqrfsSqbhYCCjff27GzVbR9qvJfxqZcZqxuqYa
 dYXDcfRmZlPHi9xswb2Qbkw+7HAL44pUzJ5rCM9cizWv964tDkpmZu65N7JUtL0Llv7QLYXAj
 9JBHVynzod6u9eY3XCmp96EBBbklaxlPnmVX0YHGAfhO4Fr0ZacShfE9gzLNJtSSBlTMAB8jE
 vTqfh32aM+1C9hD5EvVw28yXJxVxEFTPD6yi1ZSEJ09dpsLeO89kglGDkhMH4B7IenJOj0aAH
 /2aNaf9lcITuIe2ZXgaRp78Zz/1974etSyyeq9AfeH3f190CfBk//RFBesOlNHCN8rg9B53ZJ
 HjjAOf8ZpytPbOfEg+lGXDPgfOZTZM/C4TUib3NqT+dhv+YCtWG40/x54Lvf/ZdQOeoZ4Q6EF
 BTy4jJOztvJYYpd9TgplZXBTtFJXo+7eYJiwIAndLMNeMi0dp028OELnWJlixnvN9K1GnLw/B
 Qptfsiy8jqmW/Gl9+wowK9cEcJYdo3XrhT3pzDSZoz4Cgq9Alwe3W+C9Og0yvanb5pLOa/GM1
 Ph/ZPa2b7Tb/YqkRAGYYv6S2+kHXeNahtlkuKOcypJVD30qjNoXqPkOBmgm+lNVh0/7Pt8sDV
 qxVUhegSrCB6LubmLJraljJEBIFbZJBgCpPXivK1pQ26Ef1UndMYQO26w+Mez3yuuRdpATlXu
 aJ1EwpE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series reimplements the expensive pre- and post-processing of
the todo script in C.

And it concludes the work I did to accelerate rebase -i.

Changes since v2:

- rearranged error_errno() calls to come before any subsequent free()
  and close()

- now call close(fd) in case of error to avoid resource leaks

- removed unused `format` variable holding the value of
  rebase.instructionFormat from rearrange_squash()

- modified rearrange_squash() to make it easier to reason about
  subjects[i] taking custody of a strbuf's buffer (this should enable
  Coverity to see that there is no resource leak here)


Johannes Schindelin (9):
  rebase -i: generate the script via rebase--helper
  rebase -i: remove useless indentation
  rebase -i: do not invent onelines when expanding/collapsing SHA-1s
  rebase -i: also expand/collapse the SHA-1s via the rebase--helper
  t3404: relax rebase.missingCommitsCheck tests
  rebase -i: check for missing commits in the rebase--helper
  rebase -i: skip unnecessary picks using the rebase--helper
  t3415: test fixup with wrapped oneline
  rebase -i: rearrange fixup/squash lines using the rebase--helper

 Documentation/git-rebase.txt  |  16 +-
 builtin/rebase--helper.c      |  29 ++-
 git-rebase--interactive.sh    | 362 ++++------------------------
 sequencer.c                   | 531 ++++++++++++++++++++++++++++++++++++++++++
 sequencer.h                   |   8 +
 t/t3404-rebase-interactive.sh |  22 +-
 t/t3415-rebase-autosquash.sh  |  16 +-
 7 files changed, 641 insertions(+), 343 deletions(-)


base-commit: e2cb6ab84c94f147f1259260961513b40c36108a
Based-On: rebase--helper at https://github.com/dscho/git
Fetch-Base-Via: git fetch https://github.com/dscho/git rebase--helper
Published-As: https://github.com/dscho/git/releases/tag/rebase-i-extra-v3
Fetch-It-Via: git fetch https://github.com/dscho/git rebase-i-extra-v3

Interdiff vs v2:

 diff --git a/sequencer.c b/sequencer.c
 index 2b07fb9e0ce..7ac1792311e 100644
 --- a/sequencer.c
 +++ b/sequencer.c
 @@ -2393,7 +2393,7 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
  int sequencer_make_script(int keep_empty, FILE *out,
  		int argc, const char **argv)
  {
 -	char *format = "%s";
 +	char *format = xstrdup("%s");
  	struct pretty_print_context pp = {0};
  	struct strbuf buf = STRBUF_INIT;
  	struct rev_info revs;
 @@ -2412,6 +2412,7 @@ int sequencer_make_script(int keep_empty, FILE *out,
  	revs.pretty_given = 1;
  	git_config_get_string("rebase.instructionFormat", &format);
  	get_commit_format(format, &revs);
 +	free(format);
  	pp.fmt = revs.commit_format;
  	pp.output_encoding = get_log_output_encoding();
  
 @@ -2676,24 +2677,41 @@ int skip_unnecessary_picks(void)
  		const char *done_path = rebase_path_done();
  
  		fd = open(done_path, O_CREAT | O_WRONLY | O_APPEND, 0666);
 +		if (fd < 0) {
 +			error_errno(_("could not open '%s' for writing"),
 +				    done_path);
 +			todo_list_release(&todo_list);
 +			return -1;
 +		}
  		if (write_in_full(fd, todo_list.buf.buf, offset) < 0) {
 +			error_errno(_("could not write to '%s'"), done_path);
  			todo_list_release(&todo_list);
 -			return error_errno(_("could not write to '%s'"),
 -				done_path);
 +			close(fd);
 +			return -1;
  		}
  		close(fd);
  
  		fd = open(rebase_path_todo(), O_WRONLY, 0666);
 +		if (fd < 0) {
 +			error_errno(_("could not open '%s' for writing"),
 +				    rebase_path_todo());
 +			todo_list_release(&todo_list);
 +			return -1;
 +		}
  		if (write_in_full(fd, todo_list.buf.buf + offset,
  				todo_list.buf.len - offset) < 0) {
 +			error_errno(_("could not write to '%s'"),
 +				    rebase_path_todo());
 +			close(fd);
  			todo_list_release(&todo_list);
 -			return error_errno(_("could not write to '%s'"),
 -				rebase_path_todo());
 +			return -1;
  		}
  		if (ftruncate(fd, todo_list.buf.len - offset) < 0) {
 +			error_errno(_("could not truncate '%s'"),
 +				    rebase_path_todo());
  			todo_list_release(&todo_list);
 -			return error_errno(_("could not truncate '%s'"),
 -				rebase_path_todo());
 +			close(fd);
 +			return -1;
  		}
  		close(fd);
  
 @@ -2768,6 +2786,7 @@ int rearrange_squash(void)
  		struct strbuf buf = STRBUF_INIT;
  		struct todo_item *item = todo_list.items + i;
  		const char *commit_buffer, *subject, *p;
 +		size_t subject_len;
  		int i2 = -1;
  		struct subject2item_entry *entry;
  
 @@ -2788,7 +2807,7 @@ int rearrange_squash(void)
  		commit_buffer = get_commit_buffer(item->commit, NULL);
  		find_commit_subject(commit_buffer, &subject);
  		format_subject(&buf, subject, " ");
 -		subject = subjects[i] = buf.buf;
 +		subject = subjects[i] = strbuf_detach(&buf, &subject_len);
  		unuse_commit_buffer(item->commit, commit_buffer);
  		if ((skip_prefix(subject, "fixup! ", &p) ||
  		     skip_prefix(subject, "squash! ", &p))) {
 @@ -2835,19 +2854,16 @@ int rearrange_squash(void)
  			tail[i2] = i;
  		} else if (!hashmap_get_from_hash(&subject2item,
  						strhash(subject), subject)) {
 -			FLEX_ALLOC_MEM(entry, subject, buf.buf, buf.len);
 +			FLEX_ALLOC_MEM(entry, subject, subject, subject_len);
  			entry->i = i;
  			hashmap_entry_init(entry, strhash(entry->subject));
  			hashmap_put(&subject2item, entry);
  		}
 -		strbuf_detach(&buf, NULL);
  	}
  
  	if (rearranged) {
  		struct strbuf buf = STRBUF_INIT;
 -		char *format = NULL;
  
 -		git_config_get_string("rebase.instructionFormat", &format);
  		for (i = 0; i < todo_list.nr; i++) {
  			enum todo_command command = todo_list.items[i].command;
  			int cur = i;

-- 
2.12.2.windows.2.406.gd14a8f8640f

