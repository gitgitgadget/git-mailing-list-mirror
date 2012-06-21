From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fast-import: disallow empty branches as parents
Date: Wed, 20 Jun 2012 22:57:53 -0500
Message-ID: <20120621035753.GA3842@burratino>
References: <1340220841-753-1-git-send-email-divanorama@gmail.com>
 <1340220841-753-2-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <davidbarr@google.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 05:58:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShYXe-0001uw-9c
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 05:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758609Ab2FUD6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 23:58:04 -0400
Received: from mail-yw0-f51.google.com ([209.85.213.51]:40310 "EHLO
	mail-yw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754706Ab2FUD6C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 23:58:02 -0400
Received: by yhnn12 with SMTP id n12so172038yhn.10
        for <git@vger.kernel.org>; Wed, 20 Jun 2012 20:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=36hxXwORwuXq+tE3nTyU82IuZi9AQpOeZ6spTLmRjaU=;
        b=w0DC+Ly6IZdFCKLxnkpdaBXXmbxOClquODfrESZCOHcovZV39rHzUDCUeMIFfPcXuT
         LZFZ3nptMtVxzBQJ7Q/gxJirYQZ5SfULZ3OksFc2OYgqgTWSaf47Znm8TFU+BfYathqz
         EtQN8jlqw3PpHkn30gMjUh3OlyaE3zaUTFh9VAKbgdlFhujZk0Q4J5iHACS9jbaO4TuF
         297EK2TIvD0uBUqFSOUbuK/iPbDLATL8jSMJuRU/t5LJmYGVTaZQSd8TWxb9B1tBgpzR
         cj3+sFYQ2P6TBewus8Jsw0w0Aal9i/6zaydxRXvpYOFhVyqPU87LaxiRKTPebxnKIAyl
         50vA==
Received: by 10.50.222.170 with SMTP id qn10mr6393233igc.45.1340251081615;
        Wed, 20 Jun 2012 20:58:01 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id ud8sm30870226igb.4.2012.06.20.20.57.59
        (version=SSLv3 cipher=OTHER);
        Wed, 20 Jun 2012 20:58:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1340220841-753-2-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200380>

Hi Dmitry,

Dmitry Ivankov wrote:

> Empty branches (either new or reset-ed) have null_sha1 in fast-import
> internals. These null_sha1 heads can slip to the real commit objects.
[... nice explanation snipped ...]

Very nice, thanks much for this.

Would it be possible to split this into multiple independent fixes?
See [*] below for one way.

> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -2540,7 +2540,8 @@ static void file_change_deleteall(struct branch *b)
>  	b->num_notes = 0;
>  }
>  
> -static void parse_from_commit(struct branch *b, char *buf, unsigned long size)
> +static void parse_from_commit(struct branch *b, unsigned char *sha1,
> +						char *buf, unsigned long size)
>  {

What is happening here?  The new argument doesn't seem to be used.

[...]
> @@ -2551,29 +2552,31 @@ static void parse_from_commit(struct branch *b, char *buf, unsigned long size)
>  		b->branch_tree.versions[1].sha1);
>  }
>  
> -static void parse_from_existing(struct branch *b)
> +static void parse_from_existing(struct branch *b, unsigned char *sha1)
>  {
> -	if (is_null_sha1(b->sha1)) {
> +	if (is_null_sha1(sha1)) {
>  		hashclr(b->branch_tree.versions[0].sha1);
>  		hashclr(b->branch_tree.versions[1].sha1);
>  	} else {
>  		unsigned long size;
>  		char *buf;
>  
> -		buf = read_object_with_reference(b->sha1,
> -			commit_type, &size, b->sha1);
> +		buf = read_object_with_reference(sha1,
> +			commit_type, &size, sha1);

This seems to be about delaying the effect of "from" so it doesn't
interfere with a "merge" command referring to the same commit.

[...]
> -static int parse_from(struct branch *b)
> +static int parse_from(struct branch *b, unsigned char *sha1out)
>  {
>  	const char *from;
>  	struct branch *s;
>  
> -	if (prefixcmp(command_buf.buf, "from "))
> +	if (prefixcmp(command_buf.buf, "from ")) {
> +		hashclr(sha1out);
>  		return 0;
> +	}

This code path handles the case where there is no "from" after a
"reset" or "commit" command.  We clear sha1out to make the calling
convention simple --- sha1out is always written to, and the caller
does not have to worry about initializing it in advance.

I guess this is part of the change that delays the effect of "from"?

[...]
> @@ -2586,7 +2589,10 @@ static int parse_from(struct branch *b)
>  		die("Can't create a branch from itself: %s", b->name);
>  	else if (s) {
>  		unsigned char *t = s->branch_tree.versions[1].sha1;
> +		if (is_null_sha1(s->sha1))
> +			die("Can't create a branch from an empty branch:"
> +				" %s from %s", b->name, s->name);

This seems to be about protecting against "from" with an unborn
branch.

> -		hashcpy(b->sha1, s->sha1);
> +		hashcpy(sha1out, s->sha1);

Delaying the effect of "from", maybe.

[...]
> @@ -2594,16 +2600,16 @@ static int parse_from(struct branch *b)
>  		struct object_entry *oe = find_mark(idnum);
>  		if (oe->type != OBJ_COMMIT)
>  			die("Mark :%" PRIuMAX " not a commit", idnum);
> -		hashcpy(b->sha1, oe->idx.sha1);
> +		hashcpy(sha1out, oe->idx.sha1);

Delaying "from" effect?

>  		if (oe->pack_id != MAX_PACK_ID) {
>  			unsigned long size;
>  			char *buf = gfi_unpack_entry(oe, &size);
> -			parse_from_commit(b, buf, size);
> +			parse_from_commit(b, sha1out, buf, size);

Likewise?

>  			free(buf);
>  		} else
> -			parse_from_existing(b);
> +			parse_from_existing(b, sha1out);
> -	} else if (!get_sha1(from, b->sha1))
> +	} else if (!get_sha1(from, sha1out))
> -		parse_from_existing(b);
> +		parse_from_existing(b, sha1out);

Likewise?

[...]
>  	else
>  		die("Invalid ref name or SHA1 expression: %s", from);
>  
> @@ -2622,9 +2628,11 @@ static struct hash_list *parse_merge(unsigned int *count)
>  		from = strchr(command_buf.buf, ' ') + 1;
>  		n = xmalloc(sizeof(*n));
>  		s = lookup_branch(from);
> -		if (s)
> +		if (s) {
> +			if (is_null_sha1(s->sha1))
> +				die("Can't merge empty branch: %s", s->name);
>  			hashcpy(n->sha1, s->sha1);
> -		else if (*from == ':') {
> +		} else if (*from == ':') {

Protecting against "merge" with unknown branch.

[...]
> @@ -2656,6 +2664,7 @@ static void parse_new_commit(void)
>  {
>  	static struct strbuf msg = STRBUF_INIT;
>  	struct branch *b;
> +	unsigned char sha1[20];
>  	char *sp;
>  	char *author = NULL;
>  	char *committer = NULL;
> @@ -2683,7 +2692,7 @@ static void parse_new_commit(void)
>  		die("Expected committer but didn't get one");
>  	parse_data(&msg, 0, NULL);
>  	read_next_command();
> -	parse_from(b);
> +	parse_from(b, sha1);

Delayed "from" effect?

[...]
> @@ -2730,7 +2739,9 @@ static void parse_new_commit(void)
>  	strbuf_reset(&new_data);
>  	strbuf_addf(&new_data, "tree %s\n",
>  		sha1_to_hex(b->branch_tree.versions[1].sha1));
> -	if (!is_null_sha1(b->sha1))
> +	if (!is_null_sha1(sha1))
> +		strbuf_addf(&new_data, "parent %s\n", sha1_to_hex(sha1));
> +	else if (!is_null_sha1(b->sha1))
>  		strbuf_addf(&new_data, "parent %s\n", sha1_to_hex(b->sha1));

Delaying "from"?

[...]
> @@ -2855,7 +2866,7 @@ static void parse_reset_branch(void)
>  	else
>  		b = new_branch(sp);
>  	read_next_command();
> -	parse_from(b);
> +	parse_from(b, b->sha1);

Likewise?

[*]
So it looks like this would be easier to read as three patches:

 1. protecting against "from" of unborn branch
 2. protecting against "merge" of unborn branch
 3. delaying the effect of "from" to avoid it confusingly changing
    the effect of a "merge" in the same commit

(1) and (2) would be no-brainers, while (3) seems more subtle ---
maybe it should be documented to help importers for other version
control systems to know to make the same change?

[...]
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -2895,6 +2895,54 @@ test_expect_success 'S: merge with garbage after mark must fail' '
>  	test_i18ngrep "after mark" err
>  '
>  
> +test_expect_success 'S: empty branch as merge parent must fail' '
> +	test_must_fail git fast-import <<-EOF 2>err &&
> +	commit refs/heads/chicken
> +	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> +	data <<COMMIT
> +	I am the chicken.
> +	COMMIT
> +	merge refs/heads/chicken
> +	EOF
> +	cat err &&
> +	test_must_fail git rev-parse --verify refs/heads/chicken^

There would be no "chicken" branch after this import at all, right?

[...]
> +test_expect_success 'S: empty branch as merge parent must fail (2)' '
> +	test_must_fail git fast-import <<-EOF 2>err &&
> +	commit refs/heads/egg1
> +	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> +	data <<COMMIT
> +	I am the egg N1.
> +	COMMIT
> +
> +	commit refs/heads/egg2
> +	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> +	data <<COMMIT
> +	I am the egg N2.
> +	COMMIT
> +	from refs/heads/egg1
> +	merge refs/heads/egg2
> +	EOF
> +	cat err &&
> +	test_must_fail git rev-parse --verify refs/heads/egg2^2

Likewise for egg2.

[...]
> +test_expect_success 'S: empty branch as a parent must fail ' '
> +	test_must_fail git fast-import <<-EOF 2>err &&
> +	reset refs/heads/egg3
> +
> +	commit refs/heads/egg4
> +	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> +	data <<COMMIT
> +	I am the egg N4.
> +	COMMIT
> +	from refs/heads/egg3
> +	EOF
> +	cat err &&
> +	test_must_fail git rev-parse --verify refs/heads/egg4^2

Likewise for egg4.

If this were split up as described above, I imagine it would be much
easier to read and most of it would move into the "obviously good"
category (I'm still uncertain about some details of the "delayed from"
implementation and haven't checked carefully whether it misses any
spots).  What do you think?

Thanks for a pleasant read, and hope that helps,
Jonathan
