From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 6/7] replace: remove signature when using --graft
Date: Wed, 02 Jul 2014 14:19:26 -0700
Message-ID: <xmqqpphnfogx.fsf@gitster.dls.corp.google.com>
References: <20140628171731.5687.30308.chriscool@tuxfamily.org>
	<20140628181117.5687.38249.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Jul 02 23:19:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2RwJ-0002Ei-Mt
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 23:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756013AbaGBVTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 17:19:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63377 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755721AbaGBVTf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 17:19:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4C1C423BA0;
	Wed,  2 Jul 2014 17:19:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q42HDZtsNn102+vH4Keozoyg8ho=; b=sfkLgL
	IfXaXOuJCU3iDWj2vxugFUVqfJDCjjXNTYlz7gyTiQ1LT8lO8FC6oMgWqXUhl0w9
	NnTiMpcpi8I1PPC/PoZPUGDjMtSMmRY4Iy2Lai09fd+YMYNppHFfhLLzazAvdFfw
	NDryUCOFck8xC9u1Z0JBzddWFA0nIX8EAcqwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tQGucOY1JjdjIG+odJO2p+7HnXOACBZh
	zqetw1HZi2bCYC6lRmiNc8CD6Jzrogcz7HHXbLQgrmmbKgTcV1YjzUqRwkM3Xpjh
	9QIw0mT2H8YX0tmpEUu/MIWpi7jYofV6h0Hjrhb2icKLnbQ3xGL7i2ciL4W/ikDz
	5ZNovbCMcIY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4133623B9F;
	Wed,  2 Jul 2014 17:19:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8445623B90;
	Wed,  2 Jul 2014 17:19:17 -0400 (EDT)
In-Reply-To: <20140628181117.5687.38249.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sat, 28 Jun 2014 20:11:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8675C85C-022E-11E4-A9B5-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252841>

Christian Couder <chriscool@tuxfamily.org> writes:

> It could be misleading to keep a signature in a
> replacement commit, so let's remove it.
>
> Note that there should probably be a way to sign
> the replacement commit created when using --graft,
> but this can be dealt with in another commit or
> patch series.

Both paragraphs read very sensibly.

>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/replace.c |  5 +++++
>  commit.c          | 34 ++++++++++++++++++++++++++++++++++
>  commit.h          |  2 ++
>  3 files changed, 41 insertions(+)
>
> diff --git a/builtin/replace.c b/builtin/replace.c
> index ad47237..000db65 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -344,6 +344,11 @@ static int create_graft(int argc, const char **argv, int force)
>  
>  	replace_parents(&buf, argc, argv);
>  
> +	if (remove_signature(&buf))
> +		warning(_("the original commit '%s' has a gpg signature.\n"
> +			  "It will be removed in the replacement commit!"),

Hmmm...  does the second line of this message start with the usual
"warning:" prefix?

> diff --git a/commit.c b/commit.c
> index fb7897c..54e157d 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -1177,6 +1177,40 @@ int parse_signed_commit(const struct commit *commit,
>  	return saw_signature;
>  }
>  
> +int remove_signature(struct strbuf *buf)
> +{
> +	const char *line = buf->buf;
> +	const char *tail = buf->buf + buf->len;
> +	int in_signature = 0;
> +	const char *sig_start = NULL;
> +	const char *sig_end = NULL;
> +
> +	while (line < tail) {
> +		const char *next = memchr(line, '\n', tail - line);
> +		next = next ? next + 1 : tail;

This almost makes me wonder if we want something similar to
strchrnul() we use for NUL-terminated strings, and I suspect that
you would find more instances by running "git grep -A2 memchr".

I don't know what such a helper function should be named, though.
Certainly not "memchrnul()".

> +
> +		if (in_signature && line[0] == ' ')
> +			sig_end = next;
> +		else if (starts_with(line, gpg_sig_header) &&
> +			 line[gpg_sig_header_len] == ' ') {
> +			sig_start = line;
> +			sig_end = next;
> +			in_signature = 1;
> +		} else {
> +			if (*line == '\n')
> +				/* dump the whole remainder of the buffer */
> +				next = tail;
> +			in_signature = 0;
> +		}
> +		line = next;
> +	}
> +
> +	if (sig_start)
> +		strbuf_remove(buf, sig_start - buf->buf, sig_end - sig_start);

If there are two instances of gpg_sig, this will remove only the
last one, but there is no chance both signatures of such a commit
can validate OK, and we won't be losing something in between anyway,
so it should be fine.

> +	return sig_start != NULL;
> +}
> +
>  static void handle_signed_tag(struct commit *parent, struct commit_extra_header ***tail)
>  {
>  	struct merge_remote_desc *desc;
> diff --git a/commit.h b/commit.h
> index 2e1492a..4234dae 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -327,6 +327,8 @@ struct commit *get_merge_parent(const char *name);
>  
>  extern int parse_signed_commit(const struct commit *commit,
>  			       struct strbuf *message, struct strbuf *signature);
> +extern int remove_signature(struct strbuf *buf);
> +
>  extern void print_commit_list(struct commit_list *list,
>  			      const char *format_cur,
>  			      const char *format_last);
