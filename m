Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35DC42021E
	for <e@80x24.org>; Tue,  1 Nov 2016 01:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965172AbcKABLN (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Oct 2016 21:11:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53588 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S948411AbcKABLM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2016 21:11:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 42A784BDBA;
        Mon, 31 Oct 2016 21:11:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AiWRxTndPncmF3htpc4oE6BMjHo=; b=T+uDz+
        CArw5iDaOyreGaw+1fBxhlkCaJhO2eXwPQg+BcNb/jlOJb/vKc39YqhNH6sSkJj+
        CmT/MRk24FNCeVb5OBmgWM0dqPGBkzuBBXHmKqO1kLkbh+36oRssYGB3Ewi4+qjm
        gHL1UjKH9B5B2RfN4DupZRqlk/sVcg1MwSpfc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oeQeoIRBUzURgA5GZBq5K0mq22Nm3fg6
        Cen5RDTSz9NRxEV3sbzGqd8Xj6hn7jQGWWuftNHZPUn018p3Ud/AhFDQ1FdBsGaN
        Ikn7ttiNwM2LAvF5ScFJZQEAWjW2ojfdv2QUIP90jULX0bxYbXnJpJ3FWj2W6fWe
        1oQvS0HMZzQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 381024BDB9;
        Mon, 31 Oct 2016 21:11:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 95BFF4BDB8;
        Mon, 31 Oct 2016 21:11:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] sequencer: use trailer's trailer layout
References: <cover.1477698917.git.jonathantanmy@google.com>
        <cover.1477698917.git.jonathantanmy@google.com>
        <602ae84920300cdbb439eca8098c5e092ca322f7.1477698917.git.jonathantanmy@google.com>
Date:   Mon, 31 Oct 2016 18:11:09 -0700
In-Reply-To: <602ae84920300cdbb439eca8098c5e092ca322f7.1477698917.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 28 Oct 2016 17:05:11 -0700")
Message-ID: <xmqqeg2wqa1e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 133FB978-9FD0-11E6-9B02-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> @@ -26,30 +27,6 @@ static GIT_PATH_FUNC(git_path_opts_file, SEQ_OPTS_FILE)
>  static GIT_PATH_FUNC(git_path_seq_dir, SEQ_DIR)
>  static GIT_PATH_FUNC(git_path_head_file, SEQ_HEAD_FILE)
>  
> -static int is_rfc2822_line(const char *buf, int len)
> -{
> -	int i;
> -
> -	for (i = 0; i < len; i++) {
> -		int ch = buf[i];
> -		if (ch == ':')
> -			return 1;
> -		if (!isalnum(ch) && ch != '-')
> -			break;
> -	}
> -
> -	return 0;
> -}
> -
> -static int is_cherry_picked_from_line(const char *buf, int len)
> -{
> -	/*
> -	 * We only care that it looks roughly like (cherry picked from ...)
> -	 */
> -	return len > strlen(cherry_picked_prefix) + 1 &&
> -		starts_with(buf, cherry_picked_prefix) && buf[len - 1] == ')';
> -}

We lost two helper functions here, one to detect "Mail-header: like"
line, the other to detect "(cherry picked from") line.  Let's see
how the updated caller can do without these.  We know that both of
these can be caught if we grabbed the block of trailer block.

> @@ -59,49 +36,25 @@ static int is_cherry_picked_from_line(const char *buf, int len)
>  static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
>  	int ignore_footer)
>  {
> -	char prev;
> -	int i, k;
> -	int len = sb->len - ignore_footer;
> -	const char *buf = sb->buf;
> -	int found_sob = 0;
> -
> -	/* footer must end with newline */
> -	if (!len || buf[len - 1] != '\n')
> -		return 0;
> +	struct trailer_info info;
> +	int i;
> +	int found_sob = 0, found_sob_last = 0;
>  
> -	prev = '\0';
> -	for (i = len - 1; i > 0; i--) {
> -		char ch = buf[i];
> -		if (prev == '\n' && ch == '\n') /* paragraph break */
> -			break;
> -		prev = ch;
> -	}
> +	trailer_info_get(&info, sb->buf);
>  
> -	/* require at least one blank line */
> -	if (prev != '\n' || buf[i] != '\n')
> +	if (info.trailer_start == info.trailer_end)
>  		return 0;

So we feed the thing to trailer_info_get() which will find the
trailer block.  If there is no trailer block, start and end will
point at the same place, which is trivial.

>  
> -	/* advance to start of last paragraph */
> -	while (i < len - 1 && buf[i] == '\n')
> -		i++;
> -
> -	for (; i < len; i = k) {
> -		int found_rfc2822;
> -
> -		for (k = i; k < len && buf[k] != '\n'; k++)
> -			; /* do nothing */
> -		k++;
> +	for (i = 0; i < info.trailer_nr; i++)
> +		if (sob && !strncmp(info.trailers[i], sob->buf, sob->len)) {
> +			found_sob = 1;
> +			if (i == info.trailer_nr - 1)
> +				found_sob_last = 1;
> +		}
>  
> -		found_rfc2822 = is_rfc2822_line(buf + i, k - i - 1);
> -		if (found_rfc2822 && sob &&
> -		    !strncmp(buf + i, sob->buf, sob->len))
> -			found_sob = k;

Then we scan the trailer block and see if we are looking at the same
s-o-b line as we are asked to look for, and if it is at the last
logical line in the trailer block.

> +	trailer_info_release(&info);
>  
> -		if (!(found_rfc2822 ||
> -		      is_cherry_picked_from_line(buf + i, k - i - 1)))
> -			return 0;

We used to reject a "last paragraph" that has "cruft" other than
"Mail-header: like" line or "(cherry-picked from" line.  By reusing
the trailer code, we are getting consistently looser with its logic.

> -	}
> -	if (found_sob == i)
> +	if (found_sob_last)
>  		return 3;
>  	if (found_sob)
>  		return 2;

I found it surprising that you said "commit -s", "cherry-pick -x"
and "format-patch -s" are covered by this patch and saw a change
only to sequencer.c.

It turns out append_signoff() is the central function that is shared
among builtin/commit.c::prepare_to_commit() that does "commit -s",
log-tree.c::show_log() that is called by "format-patch -s", and
sequencer.c::do_recursive_merge() that do_pick_commit() hence "git
cherry-pick -s" uses.  And that function decides where to put a new
S-o-b by calling this has_conforming_footer() function.

In addition, do_pick_commit() also calls has_conforming_footer() to
decide where to add "(cherry picked from".

Whoever did the sequencer.c should be proud to structure the code to
make this change so easy to make (I know it is not me, and you
Jonathan know it is not you).  

Nicely done by both of you.

> diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
> index 9cce5ae..bf0a5c9 100755
> --- a/t/t3511-cherry-pick-x.sh
> +++ b/t/t3511-cherry-pick-x.sh
> @@ -25,9 +25,8 @@ Signed-off-by: B.U. Thor <buthor@example.com>"
>  
>  mesg_broken_footer="$mesg_no_footer
>  
> -The signed-off-by string should begin with the words Signed-off-by followed
> -by a colon and space, and then the signers name and email address. e.g.
> -Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
> +This is not recognized as a footer because Myfooter is not a recognized token.
> +Myfooter: A.U. Thor <author@example.com>"
>  
>  mesg_with_footer_sob="$mesg_with_footer
>  Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
> @@ -112,6 +111,17 @@ test_expect_success 'cherry-pick -s inserts blank line after non-conforming foot
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'cherry-pick -s recognizes trailer config' '
> +	pristine_detach initial &&
> +	git -c "trailer.Myfooter.ifexists=add" cherry-pick -s mesg-broken-footer &&
> +	cat <<-EOF >expect &&
> +		$mesg_broken_footer
> +		Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
> +	EOF
> +	git log -1 --pretty=format:%B >actual &&
> +	test_cmp expect actual
> +'
> +

That "myfooter" one is normally not recognized as a valid trailer,
so the test before this one would add a blank line before adding a
new S-o-b; this one adds "myfooter" thing to the vocabulary and no
longer gets the blank before.  Good.

> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index ba4902d..635b394 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -1277,8 +1277,7 @@ EOF
>  4:Subject: [PATCH] subject
>  8:
>  9:I want to mention about Signed-off-by: here.
> -10:
> -11:Signed-off-by: C O Mitter <committer@example.com>
> +10:Signed-off-by: C O Mitter <committer@example.com>
>  EOF
>  	test_cmp expected actual
>  '

The original log message is a single-liner subject line, blank, "I
want to mention..." and when asked to append S-o-b:, we would want
to see a blank before the added S-o-b, no?

This seems a bit weird.

> @@ -1294,8 +1293,7 @@ EOF
>  4:Subject: [PATCH] subject
>  8:
>  10:Signed-off-by: example happens to be wrapped here.
> -11:
> -12:Signed-off-by: C O Mitter <committer@example.com>
> +11:Signed-off-by: C O Mitter <committer@example.com>
>  EOF
>  	test_cmp expected actual
>  '

This one's original is a single-liner "subject", blank, "My
unfortunate", immediately followed by "S-o-b:".  The trailer's
loosened rule (mis)takes the two line body as a trailer block
because one of them is recognised as S-o-b, so it is understandable
that we do not see a blank before the new S-o-b.

This particular example may not look ideal, but it is exactly what
we wanted to happen while we were loosening the rule in the previous
series, so the outcome is understandable.

> @@ -1368,7 +1366,7 @@ EOF
>  	test_cmp expected actual
>  '
>  
> -test_expect_success 'signoff: detect garbage in non-conforming footer' '
> +test_expect_success 'signoff: tolerate garbage in conforming footer' '
>  	append_signoff <<\EOF >actual &&
>  subject
>  
> @@ -1383,8 +1381,36 @@ EOF
>  8:
>  10:
>  13:Signed-off-by: C O Mitter <committer@example.com>
> -14:
> -15:Signed-off-by: C O Mitter <committer@example.com>
> +EOF
> +	test_cmp expected actual
> +'

This is understandable and desirable.  The input has "Tested-by: ",
a cruft that says "Some Trash", and S-o-b and we used to reject that
three line as not-a-trailer.  We now allow that.

> +test_expect_success 'signoff: respect trailer config' '
> +	append_signoff <<\EOF >actual &&
> +subject
> +
> +Myfooter: x
> +Some Trash
> +EOF
> +	cat >expected <<\EOF &&
> +4:Subject: [PATCH] subject
> +8:
> +11:
> +12:Signed-off-by: C O Mitter <committer@example.com>
> +EOF
> +	test_cmp expected actual &&
> +
> +	test_config trailer.Myfooter.ifexists add &&
> +	append_signoff <<\EOF >actual &&
> +subject
> +
> +Myfooter: x
> +Some Trash
> +EOF
> +	cat >expected <<\EOF &&
> +4:Subject: [PATCH] subject
> +8:
> +11:Signed-off-by: C O Mitter <committer@example.com>

OK.  It is not easy to see in the test output, but the shift of the
location from 12 to 11 where a new S-o-b appears is because the last
two lines in the original is taken as a trailer block due to "Myfooter:"
being configured as a valid trailer element.

> diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
> index d84897a..4003a27 100755
> --- a/t/t7501-commit.sh
> +++ b/t/t7501-commit.sh
> @@ -460,6 +460,42 @@ $alt" &&
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'signoff respects trailer config' '
> +
> +	echo 5 >positive &&
> +	git add positive &&
> +	git commit -s -m "subject
> +
> +non-trailer line
> +Myfooter: x" &&
> +	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
> +	(
> +		echo subject
> +		echo
> +		echo non-trailer line
> +		echo Myfooter: x
> +		echo
> +		echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"

Any reason why this does not use "cat <<-EOF"?  Ahh, this mimicks
the style of existing ones.  OK.

> +	) >expected &&
> +	test_cmp expected actual &&
> +
> +	echo 6 >positive &&
> +	git add positive &&
> +	git -c "trailer.Myfooter.ifexists=add" commit -s -m "subject
> +
> +non-trailer line
> +Myfooter: x" &&
> +	git cat-file commit HEAD | sed -e "1,/^\$/d" > actual &&
> +	(
> +		echo subject
> +		echo
> +		echo non-trailer line
> +		echo Myfooter: x
> +		echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
> +	) >expected &&
> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'multiple -m' '
>  
>  	>negative &&

Looks good.
