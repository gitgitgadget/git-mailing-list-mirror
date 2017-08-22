Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03346208CD
	for <e@80x24.org>; Tue, 22 Aug 2017 00:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754229AbdHVAin (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 20:38:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63445 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753979AbdHVAin (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 20:38:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 48D089505E;
        Mon, 21 Aug 2017 20:38:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MczT3lhk1/TtuCEDBNhknaKcjHc=; b=PVeSX5
        yj9uZrlZ2AG477L1PV7k/7Xm3HCgbSsQFo+JvApNXM6/S1qdNmWezBN9pH3P/eOX
        vBMpOhhl/wlGXf4Pe3uUuRG+WCgX9btjcXGRhLmtbxThgRVe57r4AaL1rTMH1yZM
        tEdJXuu75InRCdtOEUBiS/PLIex3c8BRtZmmY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R6l+HQI5IL57ZGgaaGXykdD6dip23oKU
        018TMyNcwPtSayj0I0OUW85Ik14HRXaOb1BbTIxOuIqqqUpiCopW2mUlwqBefxhd
        bSti1UkwSsv71UFAFJN9XQNJj6/Na045SHdcrO/94j9HTcMYX82T43ooEbIHW0Lf
        0LsjSWsM6iQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FCB09505D;
        Mon, 21 Aug 2017 20:38:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 80A069505C;
        Mon, 21 Aug 2017 20:38:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, hIpPy <hippy2981@gmail.com>
Subject: Re: [PATCH v2 3/3] merge: save merge state earlier
References: <fe681e447791ded6db52ccd84e64e3637c08ffe5.1503309751.git.git@grubix.eu>
        <cover.1503319519.git.git@grubix.eu>
        <407f205e2b824d56c652411256eea3c0047576ef.1503319519.git.git@grubix.eu>
Date:   Mon, 21 Aug 2017 17:38:33 -0700
In-Reply-To: <407f205e2b824d56c652411256eea3c0047576ef.1503319519.git.git@grubix.eu>
        (Michael J. Gruber's message of "Mon, 21 Aug 2017 14:53:16 +0200")
Message-ID: <xmqqk21w4et2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3AC65B48-86D2-11E7-A4E9-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

>  static void prepare_to_commit(struct commit_list *remoteheads)
>  {
>  	struct strbuf msg = STRBUF_INIT;
> @@ -767,6 +768,8 @@ static void prepare_to_commit(struct commit_list *remoteheads)
>  		strbuf_commented_addf(&msg, _(merge_editor_comment), comment_line_char);
>  	if (signoff)
>  		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
> +	if (!squash)
> +		write_merge_heads(remoteheads);
>  	write_file_buf(git_path_merge_msg(), msg.buf, msg.len);
>  	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
>  			    git_path_merge_msg(), "merge", NULL))

I can understand that you would never want to write out MERGE_HEAD
while squashing, but I somehow think it would be a bug in the caller
to call prepare_to_commit(), whose point is to prepare the merge
message to be recorded in the resulting merge commit, when the user
gave us the "--squash" option, which is an explicit instruction that
the user does not want the merge commit the message is used.

Can squash ever be true in this function?

This function has two callsites: merge_trivial() and
finish_automerge().

I think merge_trivial() will not be called under "--squash", which
turns option_commit off and the only callsite of it is inside an
else-if clause that requres option_commit to be true.  You can do a
similar deduction around the "automerge_was_ok" variable to see if
finish_automerge() can be called when "--squash" is given; I suspect
the answer may be no.

> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> index 2ebda509ac..80194b79f9 100755
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -774,4 +774,19 @@ test_expect_success 'merge can be completed with --continue' '
>  	verify_parents $c0 $c1
>  '
>  
> +write_script .git/FAKE_EDITOR <<EOF
> +# kill -TERM command added below.
> +EOF
> +
> +test_expect_success EXECKEEPSPID 'killed merge can be completed with --continue' '
> +	git reset --hard c0 &&
> +	! "$SHELL_PATH" -c '\''
> +	  echo kill -TERM $$ >> .git/FAKE_EDITOR
> +	  GIT_EDITOR=.git/FAKE_EDITOR
> +	  export GIT_EDITOR
> +	  exec git merge --no-ff --edit c1'\'' &&

This is a tricky construct.  You "reserve" a process ID by using a
shell, arrange it to be killed and then using "exec" to make it the
"git merge" program to be killed.  I kind of like the convolutedness.

> +	git merge --continue &&
> +	verify_parents $c0 $c1
> +'
> +
>  test_done
