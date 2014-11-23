From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] exec_cmd: system_path memory leak fix
Date: Sun, 23 Nov 2014 10:51:05 -0800
Message-ID: <xmqqioi5ycme.fsf@gitster.dls.corp.google.com>
References: <1416750981-24446-1-git-send-email-kuleshovmail@gmail.com>
	<1416750981-24446-2-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: 0xAX <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 23 19:51:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XscFe-00061E-Ny
	for gcvg-git-2@plane.gmane.org; Sun, 23 Nov 2014 19:51:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbaKWSvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2014 13:51:10 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50374 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751419AbaKWSvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2014 13:51:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BF7218BDA;
	Sun, 23 Nov 2014 13:51:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oPblWUsUQ5c9vlo6xdTiZChkFZQ=; b=U6H/QD
	Sh7khbikj0/Ol8vMGUGOgI7bO68Z13KsiKsZ23Lw4Z+7lt7TCY3Dljz/3yeNrlpK
	QfROFZeP50VtYl3Pu2dLcvT4Yy/VMkqe6lKlqiDg0cgqBmsbtPy3r+LclsIf3nHp
	5vlXwfWyOavS61lPbTgBQLo3GuW6B64ZIF+aI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pjTgJEdkeP4KoBy7jB2aF3sbtoFkV+xg
	5lczSy55GSRz6+EalQvKqr6v3ut+XPV4zKzI+UxcGLY4s4az7qvpUfZFzKLXvWEp
	IWPLwtbhQWWl9Pfav+HR/esDA/k5rEtbA+UxhtU3FmeSw1/CiNcOYaibtLZW0s9i
	sKQWKfqr/bI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2228118BD9;
	Sun, 23 Nov 2014 13:51:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 943EC18BD6;
	Sun, 23 Nov 2014 13:51:06 -0500 (EST)
In-Reply-To: <1416750981-24446-2-git-send-email-kuleshovmail@gmail.com>
	(kuleshovmail@gmail.com's message of "Sun, 23 Nov 2014 19:56:21
	+0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AE87C91A-7341-11E4-9018-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260095>

0xAX <kuleshovmail@gmail.com> writes:

> Signed-off-by: 0xAX <kuleshovmail@gmail.com>
> ---

The comment on names I've already mentioned elsewhere.

You need a better explanation than a "no log message", as you are
not doing "system-path memory leak fix".

You are doing a lot more.  Perhaps the story would start like this:

    system_path(): make the callers own the returned string

    The function sometimes returns a newly allocated string and
    sometimes returns a borrowed string, the latter of which the
    callers must not free().

    The existing callers all assume that the return value belongs to
    the callee and most of them copy it with strdup() when they want
    to keep it around.  They end up leaking the returned copy when
    the callee returned a new string.
    
    Change the contract between the callers and system_path() to
    make the returned string owned by the callers; they are
    responsible for freeing it when done, but they do not have to
    make their own copy to store it away.

    This accidentally fixes some unsafe callers as well.  For
    example, ...


>  exec_cmd.c | 25 ++++++++++++++++---------
>  exec_cmd.h |  4 ++--
>  git.c      | 12 +++++++++---

Even though I said that this changes the contract between the caller
and the callee and make things wasteful for some, I personally think
it is going in the right direction.

The change accidentally fixes some unsafe callers.  For example, the
first hit from "git grep system_path" is this:

    attr.c- static const char *system_wide;
    attr.c- if (!system_wide)
    attr.c:         system_wide = system_path(ETC_GITATTRIBUTES);
    attr.c- return system_wide;

This is obviously unsafe for a volatile return value from the callee
and needs to have strdup() on it, but with the patch there no longer
is need for such a caller-side strdup().

But this change also introduces new bugs, I think.  For example, the
second hit from "git grep system_path" is this:

  builtin/help.c: strbuf_addstr(&new_path, system_path(GIT_MAN_PATH));

Now the caller owns and is responsible for freeing the returned
value, but without opening the file in question in an editor or a
pager we can tell immediately that there is no way this line is not
adding a new memory leak.

> index 698e752..08f8f80 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -6,7 +6,7 @@
>  static const char *argv_exec_path;
>  static const char *argv0_path;
>  
> -const char *system_path(const char *path)
> +char *system_path(const char *path)
>  {
>  #ifdef RUNTIME_PREFIX
>  	static const char *prefix;
> @@ -14,9 +14,10 @@ const char *system_path(const char *path)
>  	static const char *prefix = PREFIX;
>  #endif
>  	struct strbuf d = STRBUF_INIT;
> +	char *new_path = NULL;
>  
>  	if (is_absolute_path(path))
> -		return path;
> +		return strdup(path);
>  
>  #ifdef RUNTIME_PREFIX
>  	assert(argv0_path);
> @@ -32,10 +33,13 @@ const char *system_path(const char *path)
>  				"Using static fallback '%s'.\n", prefix);
>  	}
>  #endif
> -
>  	strbuf_addf(&d, "%s/%s", prefix, path);
> -	path = strbuf_detach(&d, NULL);
> -	return path;
> +	new_path = malloc((strlen(prefix) + strlen(path)) + 2);
> +	sprintf(new_path, "%s/%s", prefix, path);
> +
> +	strbuf_release(&d);
> +
> +	return new_path;

Are you duplicating what strbuf_addf() is doing on the strbuf d,
manually creating the same in new_path, while discarding what the
existing code you did not remove with this patch already computed?

Isn't it sufficient to add strdup(path) for the absolute case and do
nothing else to this function?  I have no idea what you are doing
here.
