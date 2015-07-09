From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: Do less work when given "from" matches current branch head
Date: Thu, 09 Jul 2015 13:37:02 -0700
Message-ID: <xmqqk2u9uky9.fsf@gitster.dls.corp.google.com>
References: <20150709055227.GA32360@glandium.org>
	<1436424609-26159-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Jul 09 22:37:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDIZe-0001EF-A0
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 22:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961AbbGIUhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 16:37:15 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:35510 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754000AbbGIUhF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 16:37:05 -0400
Received: by iecuq6 with SMTP id uq6so184393297iec.2
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 13:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=WAadtc6fVCECT6Lmvt05ZyZyAEWMFZLYNr4+kw0Ptbg=;
        b=P4hQaIV7WzCHvsSvvY5IK2vqJ1riHn8A/3EzucKtyi5YI/5xgFZOxkSIlo5qHkQ1DB
         0iaUPzjA13npoQhIX58W+eDdB4JKtXyFqMK+PtGhNY40gBbcMuxMgUai9sBa0flL9b0B
         du2CaagO9svCgHuz+7xWP2b42M1JKkcj+lB5wt55eGroX/8B1gDgMKfR4KgiTi0uzD38
         n8OTALoxhp3zQ8JO8pFizqdz4XUuRA4Ri8/9t4OrxCTHb0PXg9+yfACmG91nTQozAwcv
         5t0irMIRQF7a/3zq5HToo0eWBiwwOTX7I6PspI3QS8iiVsOhgiWcXgAMlJsph+yD2fW0
         QKFQ==
X-Received: by 10.50.67.106 with SMTP id m10mr2035670igt.69.1436474225250;
        Thu, 09 Jul 2015 13:37:05 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:647a:d824:a8a3:7bb0])
        by smtp.gmail.com with ESMTPSA id d4sm17316646igl.1.2015.07.09.13.37.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 09 Jul 2015 13:37:04 -0700 (PDT)
In-Reply-To: <1436424609-26159-1-git-send-email-mh@glandium.org> (Mike
	Hommey's message of "Thu, 9 Jul 2015 15:50:09 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273775>

Mike Hommey <mh@glandium.org> writes:

Cc'ed a few people who appear at the top of "shortlog --no-merges";
I think the end result is not incorrect, but I want to hear second
opinions on this one.  I do not know Shawn still remembers this
code, but what is under discussion seems to have come mostly from
ea5e370a (fast-import: Support reusing 'from' and brown paper bag
fix reset., 2007-02-12).

>  	if (!skip_prefix(command_buf.buf, "from ", &from))
>  		return 0;
>  
> -	if (b->branch_tree.tree) {
> -		release_tree_content_recursive(b->branch_tree.tree);
> -		b->branch_tree.tree = NULL;
> -	}
> +	hashcpy(sha1, b->branch_tree.versions[1].sha1);
>  
>  	s = lookup_branch(from);
>  	if (b == s)

The part that deals with a branch that is different from the current
one is not visible in the context (i.e. when s = lookup_branch(from)
returned a non-NULL result that is different from b) but it used to,
and continues to with this patch, copy sha1 from branch_tree.sha1
and branch_tree.versions[] from sha1 and branch_tree.versions[1] of
the specified branch.

That codepath used to release the contents of branch_tree.tree when
it did so, but it no longer does so after this patch because of the
removal we see above.

Does that mean the original code was doing a release that was
unnecessary?  Or does it mean this patch changes what happens on
that codepath, namely (1) leaking resource, and/or (2) keeping a
tree of the original 'b' that does not have anything to do with the
tree of 's', preventing the later lazy-load code from reading the
tree of 's' and instead of building on top of a wrong tree content?

... me goes and reads on ...

> @@ -2610,14 +2608,16 @@ static int parse_from(struct branch *b)
>  		struct object_entry *oe = find_mark(idnum);
>  		if (oe->type != OBJ_COMMIT)
>  			die("Mark :%" PRIuMAX " not a commit", idnum);
> -		hashcpy(b->sha1, oe->idx.sha1);
> -		if (oe->pack_id != MAX_PACK_ID) {
> -			unsigned long size;
> -			char *buf = gfi_unpack_entry(oe, &size);
> -			parse_from_commit(b, buf, size);
> -			free(buf);
> -		} else
> -			parse_from_existing(b);
> +		if (hashcmp(b->sha1, oe->idx.sha1)) {
> +			hashcpy(b->sha1, oe->idx.sha1);
> +			if (oe->pack_id != MAX_PACK_ID) {
> +				unsigned long size;
> +				char *buf = gfi_unpack_entry(oe, &size);
> +				parse_from_commit(b, buf, size);
> +				free(buf);
> +			} else
> +				parse_from_existing(b);
> +		}
>  	} else if (!get_sha1(from, b->sha1)) {
>  		parse_from_existing(b);
>  		if (is_null_sha1(b->sha1))

This part is straight-forward.

> @@ -2626,6 +2626,11 @@ static int parse_from(struct branch *b)
>  	else
>  		die("Invalid ref name or SHA1 expression: %s", from);
>  
> +	if (b->branch_tree.tree && hashcmp(sha1, b->branch_tree.versions[1].sha1)) {
> +		release_tree_content_recursive(b->branch_tree.tree);
> +		b->branch_tree.tree = NULL;
> +	}
> +

This looks like an attempt to compensate for that "what happens if
(s != NULL && s != b)?" issue, and also for the surviving codepaths.

As both parse_from_commit() and parse_from_existing() only touch
branch_tree.versions[] and they do not seem to get affected if
b->branch_tree.tree holds a stale and unrelated content, this looks
OK to me from a cursory reading, but it does make me feel dirty that
it has to put *b temporarily into an inconsistent state.
