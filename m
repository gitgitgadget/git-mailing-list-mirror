From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/6] revert: report fine-grained error messages from insn
 parser
Date: Sun, 8 Jan 2012 14:07:48 -0600
Message-ID: <20120108200748.GJ1942@burratino>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326025653-11922-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 08 21:02:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rjyx6-0006Z8-3y
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 21:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754383Ab2AHUCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jan 2012 15:02:42 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45479 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466Ab2AHUCl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jan 2012 15:02:41 -0500
Received: by iaeh11 with SMTP id h11so5682778iae.19
        for <git@vger.kernel.org>; Sun, 08 Jan 2012 12:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NfkVb+W+aSCfyoXu1haXKx6wJfSCG83Lyt+bfyRGAlI=;
        b=bhubwTiu7U93D3PdWg1O8qTNv+iD1PowjFLdUE/l7hlPlZ8aab4D7JiXDnEn3oBK0X
         IDW9/RpOfeGt8dzc440TSdL41YBN+Y0B9yZHYOzO3qf3lVN/eL+GMGhX1y8NRMSbgc4G
         dPNelPWomdSuRlSu1K/2oyxuqexJSjKyU1Vq8=
Received: by 10.42.152.65 with SMTP id h1mr13163710icw.50.1326052961006;
        Sun, 08 Jan 2012 12:02:41 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id rc7sm11873008igb.0.2012.01.08.12.02.40
        (version=SSLv3 cipher=OTHER);
        Sun, 08 Jan 2012 12:02:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1326025653-11922-6-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188122>

Ramkumar Ramachandra wrote:

> Three kinds of errors can arise from parsing '.git/sequencer/todo':
> 1. Unrecognized action
> 2. Malformed object name
> 3. Object name does not refer to a valid commit
>
> Since we would like to make the instruction sheet user-editable in the
> future (much like the 'rebase -i' sheet), report more fine-grained
> parse errors prefixed with the filename and line number.

Seems like a sensible idea.  In other words, the infrastructure that
parses .git/sequencer/todo is meant to handle arbitrary user input
some day, so it can be used as the implementation of "git rebase
--interactive" and "git sequence --edit", and currently it is
suboptimal for that purpose because the parse error messages just say

	error: Could not parse line 5.

This patch shifts responsibility to parse_insn_line(), which can come
up with a more detailed message like

	error: .git/sequencer/todo:5: unrecognized action "frobnicate"

Once the operator is allowed to edit the sequence, the message might
be adjusted to something meaning

	error: <sequence you just gave me>:5: unrecognized action "frobnicate"

instead of exposing an implementation detail, or maybe some day "git
sequence --edit" could even re-launch the editor with an error message
in a comment before the problematic line and the cursor pointing
there.  And for now, pointing to the explicit filename is useful since
this should only happen if there was filesystem corruption, tampering,
or a git bug.

By the way, an example of the output before and after the patch would
have been useful in saving some trouble of figuring this out.

Ok, onward to the patch.

[...]
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -714,26 +714,29 @@ static int format_todo(struct strbuf *buf, struct replay_insn_list *todo_list)
>  	return 0;
>  }
>  
> -static int parse_insn_line(char *bol, char *eol, struct replay_insn_list *item)
> +static int parse_insn_line(char *bol, char *eol,
> +			struct replay_insn_list *item, int lineno)
>  {
> +	const char *todo_file = git_path(SEQ_TODO_FILE);

This idiom is _still_ scary.  I don't want to have to shout about
this, but why didn't the commit message at least acknowledge it to put
the reader's mind at ease when this has come up again and again?

[...]
> +		bol += strlen("revert ");
> +	} else {
> +		error_len = eol - bol > 255 ? 255 : eol - bol;
> +		return error(_("%s:%d: Unrecognized action: %.*s"),
> +			todo_file, lineno, (int)error_len, bol);

Ah, so my example above was wrong: the actual message is

	error: .git/sequencer/todo:5: Unrecognized action: the quick bro
	wn fox jumps over the lazy dog

I guess that's fine.  Is it intended?

> +	}
>  
>  	/* Eat up extra spaces/ tabs before object name */
> -	padding = strspn(bol, " \t");
> -	if (!padding)
> -		return -1;
> -	bol += padding;
> +	bol += strspn(bol, " \t");

What does this have to do with the stated goal of the patch?  It seems
to me that an unrelated and unadvertised bugfix snuck in.

[...]
> @@ -741,12 +744,18 @@ static int parse_insn_line(char *bol, char *eol, struct replay_insn_list *item)
>  	status = get_sha1(bol, commit_sha1);
>  	*end_of_object_name = saved;
>  
> -	if (status < 0)
> -		return -1;
> +	if (status < 0) {
> +		error_len = eol - bol > 255 ? 255 : eol - bol;
> +		return error(_("%s:%d: Malformed object name: %.*s"),
> +			todo_file, lineno, (int)error_len, bol);
> +	}

This seems a little repetitive --- maybe it would make sense to
factor out a function to emit errors of the form

	error: file:lineno: message: line

By the way, this is gross.  Probably get_sha1 should grow a variant
that takes a buffer and a length.

[...]
>  	item->operand = lookup_commit_reference(commit_sha1);
> -	if (!item->operand)
> -		return -1;
> +	if (!item->operand) {
> +		error_len = eol - bol > 255 ? 255 : eol - bol;
> +		return error(_("%s:%d: Not a valid commit: %.*s"),
> +			todo_file, lineno, (int)error_len, bol);
> +	}

Hmm, this one can be emitted even when there was no corruption or
internal error, because the user removed a commit she was
cherry-picking and the gc-ed before a "git cherry-pick --continue".
Alternatively, it can happen because the repository has grown very
crowded and what used to be an unambiguous commit name no longer is
one (not enough digits).  Will the error message be intuitive in these
situations?

[...]
> @@ -761,8 +770,8 @@ static int parse_insn_buffer(char *buf, struct replay_insn_list **todo_list)
>  
>  	for (i = 1; *p; i++) {
>  		char *eol = strchrnul(p, '\n');
> -		if (parse_insn_line(p, eol, &item) < 0)
> -			return error(_("Could not parse line %d."), i);
> +		if (parse_insn_line(p, eol, &item, i) < 0)
> +			return -1;

Not related to this patch, but why the "< 0" test?  It makes this
reader worry that there is some unusual return value convention that
he should be taking into account.

To sum up: the idea looks promising, but this patch doesn't seem to be
ready yet.

Hope that helps,
Jonathan
