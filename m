From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/10] revert: Eliminate global "commit" variable
Date: Wed, 25 May 2011 16:10:56 -0700
Message-ID: <7v1uzm1im7.fsf@alter.siamese.dyndns.org>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
 <1306333025-29893-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 26 01:11:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPNET-0003Q8-Du
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 01:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753996Ab1EYXLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 19:11:12 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49953 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219Ab1EYXLL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 19:11:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C18A5550D;
	Wed, 25 May 2011 19:13:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ABVKYtWGT0BOnnZuPSVnlmqLcgI=; b=C3TAPR
	psgRj9G8HNtFfbRL1Ov1ugzYhlBcHPZ5FkG7y15i3vnpWthGsM7Obzney+fu+zZi
	MBioEhXQONKGn+Gea1o7pfuek4ydOTiQ0/bYDykD/ET7nS1ObXy1uhFIqy1903ET
	kl7lmHS46b9of543XXT9jQLGWAroRb1nMvSk0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KI7Bg139XclSB7914wI7Jf4iOhQWQfgA
	hQ0Y0AjKB7T47nsqfN66/Itsh3k/16zGAcQiuR1unoFxaMxIQTemxdTr5msdLtnF
	uFmT8hdE7V6JTSofxeDwlcr12H4n0scfDMSDEV8yqjVHCAw6iX4RXQzcDCocRY+2
	BpGjr2Vq6wA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6EBEE550B;
	Wed, 25 May 2011 19:13:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7B43F5500; Wed, 25 May 2011
 19:13:05 -0400 (EDT)
In-Reply-To: <1306333025-29893-4-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Wed, 25 May 2011 14:16:58 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8FE0EDDC-8724-11E0-88E9-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174472>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> diff --git a/builtin/revert.c b/builtin/revert.c
> index 523d41a..6c485f6 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -37,7 +37,6 @@ static const char * const cherry_pick_usage[] = {
>  
>  static int edit, no_replay, no_commit, mainline, signoff, allow_ff;
>  static enum { REVERT, CHERRY_PICK } action;
> -static struct commit *commit;

I agree that the stated goal of this change is a worthy one.

> @@ -116,11 +115,12 @@ struct commit_message {
>  	const char *message;
>  };
>  
> -static int get_message(const char *raw_message, struct commit_message *out)
> +static int get_message(const char *sha1_abbrev, const char *raw_message,
> +		struct commit_message *out)
>  {

This somehow feels dubious and also goes against the "let's not rely on
global variable commit", no?

This function relied on the global variable and also got information
passed from the caller that this function could have derived from that
global commit object (i.e. raw_message came from commit->buffer).

A logical thing to fix that situation would be to make its signature:

    static int get_message(struct commit *commit, struct commit_message *out)

no?

Especially dubious is this part:

> @@ -139,17 +139,14 @@ static int get_message(const char *raw_message, struct commit_message *out)
>  	if (out->reencoded_message)
>  		out->message = out->reencoded_message;
>  
> -	abbrev = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
> -	abbrev_len = strlen(abbrev);
> -
>  	subject_len = find_commit_subject(out->message, &subject);
>  
> -	out->parent_label = xmalloc(strlen("parent of ") + abbrev_len +
> +	out->parent_label = xmalloc(strlen("parent of ") + DEFAULT_ABBREV +
>  			      strlen("... ") + subject_len + 1);

You moved the call to f-u-a() to the caller, and that is why you have to
pass its return value as an extra parameter.  If you passed commit you do
not have to.

Worse yet, the above xmalloc() and memcpy below are wrong, as you are no
longer taking the actual length of the abbreviated object name into
account, like the old code did.  f-u-a() is _about_ uniqueness, and you
can get a string longer than the minimum length you gave to it.

>  	q = out->parent_label;
>  	q = mempcpy(q, "parent of ", strlen("parent of "));
>  	out->label = q;
> -	q = mempcpy(q, abbrev, abbrev_len);
> +	q = mempcpy(q, sha1_abbrev, DEFAULT_ABBREV);
>  	q = mempcpy(q, "... ", strlen("... "));
>  	out->subject = q;
>  	q = mempcpy(q, subject, subject_len);


> @@ -168,8 +165,7 @@ static char *get_encoding(const char *message)
>  	const char *p = message, *eol;
>  
>  	if (!p)
> -		die (_("Could not read commit message of %s"),
> -				sha1_to_hex(commit->object.sha1));
> +		die (_("BUG: get_encoding() called with NULL"));

Hmm, do we really want to translate this error message?

As the function is file-scope static, I suspect that calling it with NULL
is a programmer error, not data error (i.e. it is not like we might get an
object with NULL here in some repository created by a different version or
implementation of git).  Once you got confident (and I hope you will be
before this series hits our tree) that no caller calls this function with
NULL, we might want to demote this to assert(p) or even remove that if
statement altogether.

> @@ -185,25 +181,26 @@ static char *get_encoding(const char *message)
>  	return NULL;
>  }
>  
> -static void add_message_to_msg(struct strbuf *msgbuf, const char *message)
> +static void add_message_to_msg(const char *fallback, struct strbuf *msgbuf,
> +			const char *message)
>  {
>  	const char *p = message;
>  	while (*p && (*p != '\n' || p[1] != '\n'))
>  		p++;
>  
>  	if (!*p)
> -		strbuf_addstr(msgbuf, sha1_to_hex(commit->object.sha1));
> +		strbuf_addstr(msgbuf, fallback);

Can you explain what the above loop and if statements are doing for me?
It seems to be doing something a lot more than what the name of the
function suggests, which is a bad sign that the helper is not designed
properly with clear semantics in mind.  I would probably prefer to see
this function removed, and do this kind of thing in the only caller of
this confused helper function.  You could make an even smaller helper
function that implements the logic to determine if there are two
consecutive LFs in a string (seen above), but I suspect that would be just
the matter of strstr(message, "\n\n")

> -static void write_cherry_pick_head(void)
> +static void write_cherry_pick_head(const char *commit_sha1_hex)
>  {
>  	int fd;
>  	struct strbuf buf = STRBUF_INIT;
>  
> -	strbuf_addf(&buf, "%s\n", sha1_to_hex(commit->object.sha1));
> +	strbuf_addf(&buf, "%s\n", commit_sha1_hex);
>  
>  	fd = open(git_path("CHERRY_PICK_HEAD"), O_WRONLY | O_CREAT, 0666);
>  	if (fd < 0)
> @@ -370,7 +367,7 @@ static int run_git_commit(const char *defmsg)
>  	return run_command_v_opt(args, RUN_GIT_CMD);
>  }
>  
> -static int do_pick_commit(void)
> +static int do_pick_commit(struct commit *commit)
>  {
>  	unsigned char head[20];
>  	struct commit *base, *next, *parent;
> @@ -378,6 +375,7 @@ static int do_pick_commit(void)
>  	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
>  	char *defmsg = NULL;
>  	struct strbuf msgbuf = STRBUF_INIT;
> +	const char *sha1_abbrev = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);

Given the lifetime rule of f-u-a return value, I think it is a bad design
to call it and pass it as an extra parameter to get_message() much later.
