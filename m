From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] replace: fix replacing object with itself
Date: Fri, 14 Nov 2014 14:45:55 -0800
Message-ID: <xmqqppcp1jvg.fsf@gitster.dls.corp.google.com>
References: <1415887559-16585-1-git-send-email-manzurmm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Manzur Mukhitdinov <manzurmm@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 23:46:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpPcx-00074H-GG
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 23:46:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755202AbaKNWp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 17:45:59 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65302 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755135AbaKNWp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 17:45:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CB881E1B6;
	Fri, 14 Nov 2014 17:45:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3uuJkaaa0OZL5kx8Dw5nzhzP7DI=; b=OZdY7S
	2ftLrd+kM3dykNcluUw6nHGVeb/ymYkB6VwJ8hroRP+qeHRBOlNhNpLhy4OhKwqp
	uiSjl16NWZ5FaQtGBCfWxLLxJMiq6X4oU4DYRriz7BhhnFEkNFxaylneSnwSf9U4
	Jtp04ewoEjBXMZIhqBVeBi4Jztlzz10i8TOoI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oj//dzE7j6bkumXbwJzHgghrWpxBTfvm
	rHccCgAexmczR0IYdlr0FeU134JJdi6tx0BCKTTQAOPuJmrXAvDw6/a2mEK92tkf
	lgBj+b7OFdWFEeoP9TioNuv0MloU54X1OB8f3Z59VEN8Hc+lNbZ76/XeFCYyr1bg
	DQ4IJs1k2Q0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 61BB91E1B5;
	Fri, 14 Nov 2014 17:45:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD1FB1E1B4;
	Fri, 14 Nov 2014 17:45:56 -0500 (EST)
In-Reply-To: <1415887559-16585-1-git-send-email-manzurmm@gmail.com> (Manzur
	Mukhitdinov's message of "Thu, 13 Nov 2014 15:05:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FF3F7694-6C4F-11E4-90B5-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Manzur Mukhitdinov <manzurmm@gmail.com> writes:

> When object is replaced with itself git shows unhelpful messages like(git log):
>     "fatal: replace depth too high for object <SHA1>"
>
> Prevents user from replacing object with itself(with test for checking
> this case).
>
> Signed-off-by: Manzur Mukhitdinov <manzurmm@gmail.com>
> ---

The patch is not wrong per-se, but I wonder how useful this "do not
replace itself but all other forms of loops are not checked at all"
would be in practice.  If your user did this:

	git replace A B ;# pretend as if what is in B is in A
        git replace B C ;# pretend as if what is in C is in B
        git replace C A ;# pretend as if we have loop
	git log C

she would not be helped with this patch at all, no?

We have the "replace depth" thing, which is a poor-man's substitute
for loop detection, primarily because we do not want to incur high
cost of loop detection at runtime.  Shouldn't we be doing at least
the same amount of loop-avoidance check, if we really want to avoid
triggering the "replace depth" check at runtime?

>  builtin/replace.c  |  8 +++-----
>  t/t6050-replace.sh | 11 +++++++++--
>  2 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/replace.c b/builtin/replace.c
> index 294b61b..628377a 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -157,6 +157,9 @@ static int replace_object_sha1(const char *object_ref,
>  	char ref[PATH_MAX];
>  	struct ref_lock *lock;
>  
> +	if (!hashcmp(object, repl))
> +		return error("new object is the same as the old one: '%s'", sha1_to_hex(object));
> +
>  	obj_type = sha1_object_info(object, NULL);
>  	repl_type = sha1_object_info(repl, NULL);
>  	if (!force && obj_type != repl_type)
> @@ -295,9 +298,6 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
>  
>  	free(tmpfile);
>  
> -	if (!hashcmp(old, new))
> -		return error("new object is the same as the old one: '%s'", sha1_to_hex(old));
> -
>  	return replace_object_sha1(object_ref, old, "replacement", new, force);
>  }
>  
> @@ -406,8 +406,6 @@ static int create_graft(int argc, const char **argv, int force)
>  
>  	strbuf_release(&buf);
>  
> -	if (!hashcmp(old, new))
> -		return error("new commit is the same as the old one: '%s'", sha1_to_hex(old));
>  
>  	return replace_object_sha1(old_ref, old, "replacement", new, force);
>  }
> diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
> index 4d5a25e..5f96374 100755
> --- a/t/t6050-replace.sh
> +++ b/t/t6050-replace.sh
> @@ -369,9 +369,8 @@ test_expect_success '--edit with and without already replaced object' '
>  	git cat-file commit "$PARA3" | grep "A fake Thor"
>  '
>  
> -test_expect_success '--edit and change nothing or command failed' '
> +test_expect_success '--edit with failed editor' '
>  	git replace -d "$PARA3" &&
> -	test_must_fail env GIT_EDITOR=true git replace --edit "$PARA3" &&
>  	test_must_fail env GIT_EDITOR="./fakeeditor;false" git replace --edit "$PARA3" &&
>  	GIT_EDITOR=./fakeeditor git replace --edit "$PARA3" &&
>  	git replace -l | grep "$PARA3" &&
> @@ -440,4 +439,12 @@ test_expect_success GPG '--graft on a commit with a mergetag' '
>  	git replace -d $HASH10
>  '
>  
> +test_expect_success 'replacing object with itself must fail' '
> +    test_must_fail git replace $HASH1 $HASH1 &&
> +    HASH8=$(git rev-parse --verify HEAD) &&
> +    test_must_fail git replace HEAD $HASH8 &&
> +    test_must_fail git replace --graft HEAD HEAD^ &&
> +    test_must_fail env GIT_EDITOR=true git replace --edit HEAD
> +'
> +
>  test_done
