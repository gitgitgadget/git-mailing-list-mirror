From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 19/24] refs.c: allow listing and deleting badly named refs
Date: Thu, 02 Oct 2014 11:55:29 -0700
Message-ID: <xmqqa95envxa.fsf@gitster.dls.corp.google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
	<CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
	<CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
	<CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
	<20140820231723.GF20185@google.com>
	<20140911030318.GD18279@google.com> <20141002014817.GS1175@google.com>
	<20141002022819.GL1175@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 20:55:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZlXO-0005OF-6C
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 20:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbaJBSze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2014 14:55:34 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56980 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751703AbaJBSzd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2014 14:55:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2DDBB3F6E5;
	Thu,  2 Oct 2014 14:55:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cQ0KNhUjV00Y9RcbJLK31AZVbd0=; b=RQnJOf
	MGPhKqN2MKevHMpeo8eyMdO3FlDM/jF3RUAHNOUUFC3OrAGyyUDByHcPejjv+Rw0
	e/xqFDHo2/xp0pVM9vQPWx0NN2j/73afsLn5Wbf20pLkKRsttOvA4tAogvqYPcQo
	WPioByV6t0gzj/oyaXhtMecGofq7UqAz8ydGs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fkHePOxSYN2jTCA+LPnhAtjyigFutQmW
	UsJAnBDsoggkgH8u4k2MitAxdhnC4FnSrevKV198ZpBahvfI5LH6Fyn5wAEwUh3+
	W5g+nyVw1EGdf57HiqEED1vPzX9MDs1Z/9IhCRNaOBZttQ+iHYctg17tltJJzPRE
	T+956TmIhSM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2317D3F6E4;
	Thu,  2 Oct 2014 14:55:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 94F213F6DB;
	Thu,  2 Oct 2014 14:55:30 -0400 (EDT)
In-Reply-To: <20141002022819.GL1175@google.com> (Jonathan Nieder's message of
	"Wed, 1 Oct 2014 19:28:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AE68ECB6-4A65-11E4-8CDC-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257817>

Jonathan Nieder <jrnieder@gmail.com> writes:

> From: Ronnie Sahlberg <sahlberg@google.com>
> ...
> In resolving functions, refuse to resolve refs that don't pass the
> check-ref-format(1) check unless the new RESOLVE_REF_ALLOW_BAD_NAME
> flag is passed.  Even with RESOLVE_REF_ALLOW_BAD_NAME, refuse to
> resolve refs that escape the refs/ directory and do not match the
> pattern [A-Z_]* (think "HEAD" and "MERGE_HEAD").
>
> In locking functions, refuse to act on badly named refs unless they
> are being deleted and either are in the refs/ directory or match [A-Z_]*.
>
> Just like other invalid refs, flag resolved, badly named refs with the
> REF_ISBROKEN flag, treat them as resolving to null_sha1, and skip them
> in all iteration functions except for for_each_rawref.
>
> Flag badly named refs with a REF_BAD_NAME flag to make it easier for
> future callers to notice and handle them specially.
>
> In the transaction API, refuse to create or update badly named refs,
> but allow deleting them (unless they escape refs/ and don't match
> [A-Z_]*).
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.  We originally threw all the different kind of breakages
into ISBROKEN, but a ref can have a malformed name or can contain a
bad/non value and allowing us to tell them apart is a good direction
to go.

> diff --git a/cache.h b/cache.h
> index 5ca7f2b..0c0ac60 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -978,16 +978,26 @@ extern int read_ref(const char *refname, unsigned char *sha1);
>   * If flags is non-NULL, set the value that it points to the
>   * combination of REF_ISPACKED (if the reference was found among the
>   * packed references), REF_ISSYMREF (if the initial reference was a
> - * symbolic reference) and REF_ISBROKEN (if the ref is malformed).
> + * symbolic reference), REF_BAD_NAME (if the reference name is ill
> + * formed --- see RESOLVE_REF_ALLOW_BAD_NAME below), and REF_ISBROKEN
> + * (if the ref is malformed).

You want to define "is malformed" here.

The original defines REF_ISBROKEN as "malformed" because

 (1) resolve_ref_unsafe() uses get_sha1_hex() and read_loose_refs()
     uses read_ref_full(), both to catch "malformed values" stored;

 (2) resolve_ref_unsafe() uses check_refname_format() and catches
     "malformed names" stored as a symref target.

I _think_ you are introducing ALLOW_BAD_NAME to allow add the third
class ".git/refs/remotes/origin/mal..formed..name".  I do not know
if they should be the same class as a symref with a good name
".git/refs/remotes/origin/HEAD" that points at a bad name
"mal..formed..name", which is (2) above).  Perhaps not.  (2) is
still above what is stored in the ref, and the ref in question may
or may not have a well-formed name, which is orthogonal.

So probably you left only the "value stored in the ref is malformed"
(in other words, "we expected to find 40-hex object name but didn't
find one") case for REF_ISBROKEN?

Do we want to separate "value is not 40-hex" and "a symref points at
a malformed refname" as separate "malformed value" errors?

> + * RESOLVE_REF_ALLOW_BAD_NAME allows resolving refs even when their
> + * name is invalid according to git-check-ref-format(1).  If the name
> + * is bad then the value stored in sha1 will be null_sha1 and the
> + * REF_ISBROKEN and REF_BAD_NAME flags will be set.

Viewed with that light, I am not sure if a badly named ref should
yield null_sha1[] (REF_ISBROKEN, which I am assuming is about a
value that is badly formatted and cannot be read, should keep
yielding it as before).  Wouldn't it make it harder for the user if
you give null_sha1[] back to somebody who is trying to recover by
reading "refs/heads/mal..formed", creating "refs/heads/sensible" to
point at the same value and then removing the former?

Note that I am not saying we should give back the parsed value at
this step in the series.  Perhaps there are some existing callers
that do not check for ISBROKEN flag and instead says "null_sha1[]
ref is to be rejected/ignored", in which case they may need to be
corrected before that happens.  Or there may be some reason I
overlooked that makes it not so useful if we returned the object
name stored in a ref whose name is malformed.  Just wondering.

> @@ -272,6 +272,37 @@ static struct ref_dir *get_ref_dir(struct ref_entry *entry)
>  	return dir;
>  }
>  
> +static int escapes_cwd(const char *path) {
> +	char *buf;
> +	int result;
> +
> +	if (is_absolute_path(path))
> +		return 1;
> +	buf = xmalloc(strlen(path) + 1);
> +	result = !!normalize_path_copy(buf, path);
> +	free(buf);
> +	return result;
> +}

I think this function is misnamed for two reasons.

 - It does not have anything to do with cwd; it does not make any
   difference to the outcome of this function given the same input,
   if 'pwd' says "/u/jc/git" or "/u/jc/git/Documentation", no?

 - Even if this had something to do with cwd, I would expect a
   function whose name is escapes_cwd("/u/jc/git/Documentation") to
   yield false when 'pwd' says "/u/jc/git", but the implementation
   unconditionally rejects absolute path.  In the context of the
   (sole) caller of this function, which deals with a refname "refs/...",
   it makes no sense to see an absolute path, but that does not have
   anything to do with "does this path escape cwd?", no?

> +/*
> + * Check if a refname is safe.
> + * For refs that start with "refs/" we consider it safe as long as the rest
> + * of the path components does not allow it to escape from this directory.
> + * For all other refs we only consider them safe iff they only contain
> + * upper case characters and '_'.
> + */

I presume that the exception is to accomodate for "HEAD", "ORIG_HEAD",
"MERGE_HEAD" and friends, but you probably do not want the readers to
guess.

> +static int refname_is_safe(const char *refname)
> +{
> +	if (starts_with(refname, "refs/"))
> +		return !escapes_cwd(refname + strlen("refs/"));
> +	while (*refname) {
> +		if (!isupper(*refname) && *refname != '_')
> +			return 0;
> +		refname++;
> +	}
> +	return 1;
> +}
