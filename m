From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 2/2] fast-import: tighten parsing of mark references
Date: Tue, 3 Apr 2012 09:20:01 -0500
Message-ID: <20120403142001.GD15589@burratino>
References: <20120401225407.GA12127@padd.com>
 <1333417910-17955-1-git-send-email-pw@padd.com>
 <1333417910-17955-3-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dmitry Ivankov <divanorama@gmail.com>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 16:20:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SF4as-0003AV-Vp
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 16:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754609Ab2DCOUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 10:20:15 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33348 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753843Ab2DCOUN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 10:20:13 -0400
Received: by yhmm54 with SMTP id m54so1768478yhm.19
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 07:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Ej7QZjYfBUf48JU233VSNQSKCbwbVWsXcs8eNcGuAK0=;
        b=RxdgabGgUZqUwoxF2ukjPHYAyDnWf++sRSIViXqs7JK7mxDklKXxLUXTHweHuV1ULT
         J8zRJEfuDBJPuatw3O4ieGtDpUAKL0iPdkrloVjcJCquaeBLx1CaIZTnQT1cfqQBL5rS
         qVcLnOPf8EB9WlCbblqychRfyTtJ/tCOJlfWBYGJo/b0wudN0tu7xexBIuWyfd2ROV/x
         5/CiP3xnCBsKwwniScU2mBOQAEmrDGrKvsylXOfF55CajI0zc8+dLs0B5b38QFsMsF2Z
         Q8Y4ctIfQa27Xzr+HpCw4gQv8TiJuNIPutW3O6Tsog6Ugz5rHbrYnee/GrUGtuVimTTf
         kJdA==
Received: by 10.60.22.234 with SMTP id h10mr18586468oef.54.1333462812916;
        Tue, 03 Apr 2012 07:20:12 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id b6sm21566714obe.12.2012.04.03.07.20.11
        (version=SSLv3 cipher=OTHER);
        Tue, 03 Apr 2012 07:20:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1333417910-17955-3-git-send-email-pw@padd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194625>

(cc-ing Johan for noteimport code)
Pete Wyckoff wrote:

>                    Fast-import does not complain when garbage
> appears after a mark reference in some cases.

Thanks for fixing it.

[...]
> +++ b/fast-import.c
[...]
> @@ -2236,20 +2287,24 @@ static void file_change_m(struct branch *b)
>  
>  	if (*p == ':') {
>  		char *x;
> -		oe = find_mark(strtoumax(p + 1, &x, 10));
> +		oe = find_mark(parse_mark_ref_space(p, &x));
>  		hashcpy(sha1, oe->idx.sha1);
>  		p = x;

Simpler:

	if (*p == ':') {
		oe = find_mark(parse_mark_ref_space(p, &p));
		hashcpy(sha1, oe->idx.sha1);
	} else if ...

>  	} else if (!prefixcmp(p, "inline")) {
>  		inline_data = 1;
>  		p += 6;
> +		if (*p != ' ')
> +			die("Missing space after 'inline': %s",
> +			    command_buf.buf);
>  	} else {
>  		if (get_sha1_hex(p, sha1))
>  			die("Invalid SHA1: %s", command_buf.buf);

If I write

	M 100644 inliness some/path/to/file

was my mistake actually leaving out a space after 'inline' or
was it using an invalid <dataref>?

I think the latter, so I would suggest

	} else if (!prefixcmp(p, "inline ")) {
		inline_data = 1;
		p += strlen("inline");	/* advance to space */
	} else {
		if (get_sha1_hex(p, sha1))
			...

[...]
>  	}
> -	if (*p++ != ' ')
> -		die("Missing space after SHA1: %s", command_buf.buf);
> +	++p;  /* skip space */

I guess I'd suggest

	assert(*p == ' ');
	p++;

as defense against coders introducing additional cases that
are not as careful.

> @@ -2408,20 +2463,24 @@ static void note_change_n(struct branch *b, unsigned char *old_fanout)
>  	/* <dataref> or 'inline' */
>  	if (*p == ':') {
>  		char *x;
> -		oe = find_mark(strtoumax(p + 1, &x, 10));
> +		oe = find_mark(parse_mark_ref_space(p, &x));
>  		hashcpy(sha1, oe->idx.sha1);
>  		p = x;

Likewise (btw, why doesn't this share code with the filemodify case?):

	if (*p == ':') {
		oe = find_mark(parse_mark_with_trailing_space(p, &p));
		hashcpy(sha1, oe->idx.sha1);
	} else if ...

and so on.

[...]
> @@ -2430,7 +2489,7 @@ static void note_change_n(struct branch *b, unsigned char *old_fanout)
>  			die("Can't add a note on empty branch.");
>  		hashcpy(commit_sha1, s->sha1);
>  	} else if (*p == ':') {
> -		uintmax_t commit_mark = strtoumax(p + 1, NULL, 10);
> +		uintmax_t commit_mark = parse_mark_ref_eol(p);
>  		struct object_entry *commit_oe = find_mark(commit_mark);
>  		if (commit_oe->type != OBJ_COMMIT)
>  			die("Mark :%" PRIuMAX " not a commit", commit_mark);
> @@ -2537,7 +2596,7 @@ static int parse_from(struct branch *b)
>  		hashcpy(b->branch_tree.versions[0].sha1, t);
>  		hashcpy(b->branch_tree.versions[1].sha1, t);
>  	} else if (*from == ':') {
> -		uintmax_t idnum = strtoumax(from + 1, NULL, 10);
> +		uintmax_t idnum = parse_mark_ref_eol(from);

The title feature.  Nice.

[...]
> @@ -2945,9 +2999,7 @@ static struct object_entry *parse_treeish_dataref(const char **p)
>  
>  	if (**p == ':') {	/* <mark> */
>  		char *endptr;
> -		e = find_mark(strtoumax(*p + 1, &endptr, 10));
> -		if (endptr == *p + 1)
> -			die("Invalid mark: %s", command_buf.buf);
> +		e = find_mark(parse_mark_ref_space(*p, &endptr));
>  		if (!e)
>  			die("Unknown mark: %s", command_buf.buf);
>  		*p = endptr;

Simpler:

	if (**p == ':') {
		e = find_mark(parse_mark_...(*p, p));
		if (!e)
			die(...);
	} else {

> @@ -2955,9 +3007,12 @@ static struct object_entry *parse_treeish_dataref(const char **p)
>  	} else {	/* <sha1> */
>  		if (get_sha1_hex(*p, sha1))
>  			die("Invalid SHA1: %s", command_buf.buf);
> -		e = find_object(sha1);
>  		*p += 40;
> +		if (**p != ' ')
> +			die("Missing space after SHA1: %s", command_buf.buf);
> +		e = find_object(sha1);

This seems dangerous.  What if a new caller arises that wants to
parse a <dataref> representing a tree-ish at the end of the line?

So I think checking the character after the tree-ish should still
be the caller's responsibility.

>  	}
> +	*p += 1;  /* skip space */

If other patches in flight use the same function, they would expect
*p to point to the space when parse_treeish_dataref returns.  If we
wanted to change that (as mentioned above I don't think we ought to)
then the function's name should be changed to force such new callers
not to compile.

> @@ -3008,8 +3063,6 @@ static void parse_ls(struct branch *b)
>  		root = new_tree_entry();
>  		hashcpy(root->versions[1].sha1, e->idx.sha1);
>  		load_tree(root);
> -		if (*p++ != ' ')
> -			die("Missing space after tree-ish: %s", command_buf.buf);

(here's the caller).

Except where noted above, this looks good.

Thanks and hope that helps,
Jonathan
