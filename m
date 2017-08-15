Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E900208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 18:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752527AbdHOSZK (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 14:25:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59497 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751605AbdHOSZK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 14:25:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 70A9AA4B91;
        Tue, 15 Aug 2017 14:25:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RSHPEwh4fkPsWpthWs8lwijyCSk=; b=c9zX2s
        y+FP88UgDoB0+J21LMMzBMecu1egC5ltVylK6BnVRcPCkHEYc8O2igtCKRqYhlWO
        t8eJgYcFMdOkJUYU/WlX929iaZjP7kOkjpHTF73pr9gec2ucFCuJQS7W2gjfA3l1
        cKkhq8dfMjGEvt13ZHrXnAF53gv4FarVPFa3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u4WkmEDxt+nCCsFGg37trPG/4O/0CHnh
        e4uw59hVpL2NfnsCtegvO6eB6nTH0x6gDKXJnQ4QtnKnVr5KZ4dR2dSFC4+kVfoH
        zUgFZ922Uljzj8wnECXov+cborqDmjmn8N4h0uYesytYsH7MAnFaw0ijlP+sC1Ba
        yM7GFXj/5Oc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 694FCA4B8F;
        Tue, 15 Aug 2017 14:25:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CEAC1A4B8D;
        Tue, 15 Aug 2017 14:25:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 3/5] commit: replace the raw buffer with strbuf in read_graft_line
References: <cover.1502796628.git.patryk.obara@gmail.com>
        <cover.1502796628.git.patryk.obara@gmail.com>
        <b5633a5425c623f3d2204325e99332b5bb511582.1502796628.git.patryk.obara@gmail.com>
Date:   Tue, 15 Aug 2017 11:25:07 -0700
In-Reply-To: <b5633a5425c623f3d2204325e99332b5bb511582.1502796628.git.patryk.obara@gmail.com>
        (Patryk Obara's message of "Tue, 15 Aug 2017 13:49:04 +0200")
Message-ID: <xmqqwp64r8n0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1178269E-81E7-11E7-A3E4-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patryk Obara <patryk.obara@gmail.com> writes:

> This simplifies function declaration and allows for use of strbuf_rtrim
> instead of modifying buffer directly.
>
> Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
> ---
>  builtin/blame.c |  2 +-
>  commit.c        | 11 ++++++-----
>  commit.h        |  2 +-
>  3 files changed, 8 insertions(+), 7 deletions(-)

Looks good; both existing callers already have strbuf, and we do not
expect we will gain a lot more callers to this ancient facility, so
there is no point to have a more accomodating API that separately
takes <ptr,len>.

> diff --git a/builtin/blame.c b/builtin/blame.c
> index bda1a78..d4472e9 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -488,7 +488,7 @@ static int read_ancestry(const char *graft_file)
>  		return -1;
>  	while (!strbuf_getwholeline(&buf, fp, '\n')) {
>  		/* The format is just "Commit Parent1 Parent2 ...\n" */
> -		struct commit_graft *graft = read_graft_line(buf.buf, buf.len);
> +		struct commit_graft *graft = read_graft_line(&buf);
>  		if (graft)
>  			register_commit_graft(graft, 0);
>  	}
> diff --git a/commit.c b/commit.c
> index 8b28415..499fb14 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -134,15 +134,16 @@ int register_commit_graft(struct commit_graft *graft, int ignore_dups)
>  	return 0;
>  }
>  
> -struct commit_graft *read_graft_line(char *buf, int len)
> +struct commit_graft *read_graft_line(struct strbuf *line)
>  {
>  	/* The format is just "Commit Parent1 Parent2 ...\n" */
> -	int i;
> +	int i, len;
> +	char *buf = line->buf;
>  	struct commit_graft *graft = NULL;
>  	const int entry_size = GIT_SHA1_HEXSZ + 1;
>  
> -	while (len && isspace(buf[len-1]))
> -		buf[--len] = '\0';
> +	strbuf_rtrim(line);
> +	len = line->len;
>  	if (buf[0] == '#' || buf[0] == '\0')
>  		return NULL;
>  	if ((len + 1) % entry_size)
> @@ -174,7 +175,7 @@ static int read_graft_file(const char *graft_file)
>  		return -1;
>  	while (!strbuf_getwholeline(&buf, fp, '\n')) {
>  		/* The format is just "Commit Parent1 Parent2 ...\n" */
> -		struct commit_graft *graft = read_graft_line(buf.buf, buf.len);
> +		struct commit_graft *graft = read_graft_line(&buf);
>  		if (!graft)
>  			continue;
>  		if (register_commit_graft(graft, 1))
> diff --git a/commit.h b/commit.h
> index 6d857f0..baecc0a 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -247,7 +247,7 @@ struct commit_graft {
>  };
>  typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
>  
> -struct commit_graft *read_graft_line(char *buf, int len);
> +struct commit_graft *read_graft_line(struct strbuf *line);
>  int register_commit_graft(struct commit_graft *, int);
>  struct commit_graft *lookup_commit_graft(const struct object_id *oid);
