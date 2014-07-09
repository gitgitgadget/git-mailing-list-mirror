From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 02/10] replace: add --graft option
Date: Wed, 09 Jul 2014 07:59:20 -0700
Message-ID: <xmqqsima7f3r.fsf@gitster.dls.corp.google.com>
References: <20140707063342.3708.83493.chriscool@tuxfamily.org>
	<20140707063540.3708.51047.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Jul 09 16:59:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4tLO-00060G-MX
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 16:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755513AbaGIO7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 10:59:30 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60258 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755197AbaGIO72 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 10:59:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 038D425841;
	Wed,  9 Jul 2014 10:59:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=b/sGCBhHfmcOpkKU1TNTbKpDG4w=; b=As7Zu2WQ88nD2aaCxsHQ
	G0pjR3T1whHJEuR5/OPtnTtt98YfPgbCCOAzocSNbbDzFbG+vuE+QPImhZtwep8Q
	aknlXW9Lxf8wLZG8MkOUl7dXvqDO/ubJCYNadL2gqFrcTg7r06Jc57JH26LK4bdU
	J7l/iZaH3bvBUpntraZih6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=WvYQR4mcMrq2Fh+ziwajq3MiSmE6iQYrVrmCm8iSKDM6FB
	zjaKtrcrUw2WWsZ8p5SUaCSwPpHe+YscD/3gS0uGiDhOOFQYbt/2WoMg5I0INneW
	0JnOyyDjubnzdo8Rq7pU89EuGq+Z4By4np94ZnwLhpewNQ95wnei59S7HjWss=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EB79225840;
	Wed,  9 Jul 2014 10:59:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A411B25839;
	Wed,  9 Jul 2014 10:59:07 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 939BE28C-0779-11E4-8D2C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253127>

Christian Couder <chriscool@tuxfamily.org> writes:

> The usage string for this option is:
>
> git replace [-f] --graft <commit> [<parent>...]
>
> First we create a new commit that is the same as <commit>
> except that its parents are [<parents>...]
>
> Then we create a replace ref that replace <commit> with
> the commit we just created.
>
> With this new option, it should be straightforward to
> convert grafts to replace refs.

Sensible.

>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/replace.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 73 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/replace.c b/builtin/replace.c
> index 1bb491d..ad47237 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -17,6 +17,7 @@
>  static const char * const git_replace_usage[] = {
>  	N_("git replace [-f] <object> <replacement>"),
>  	N_("git replace [-f] --edit <object>"),
> +	N_("git replace [-f] --graft <commit> [<parent>...]"),
>  	N_("git replace -d <object>..."),
>  	N_("git replace [--format=<format>] [-l [<pattern>]]"),
>  	NULL
> @@ -294,6 +295,66 @@ static int edit_and_replace(const char *object_ref, int force)
>  	return replace_object_sha1(object_ref, old, "replacement", new, force);
>  }
>  
> +static void replace_parents(struct strbuf *buf, int argc, const char **argv)
> +{
> +	struct strbuf new_parents = STRBUF_INIT;
> +	const char *parent_start, *parent_end;
> +	int i;
> +
> +	/* find existing parents */
> +	parent_start = buf->buf;
> +	parent_start += 46; /* "tree " + "hex sha1" + "\n" */
> +	parent_end = parent_start;
> +
> +	while (starts_with(parent_end, "parent "))
> +		parent_end += 48; /* "parent " + "hex sha1" + "\n" */
> +
> +	/* prepare new parents */
> +	for (i = 1; i < argc; i++) {

It looks somewhat strange that both replace_parents() and
create_graft() take familiar-looking <argc, argv> pair, but one
ignores argv[0] and uses the remainder and the other uses argv[0].
Shouldn't this function consume argv[] starting from [0] for
consistency?  You'd obviously need to update the caller to adjust
the arguments it gives to this function.

> +static int create_graft(int argc, const char **argv, int force)
> +{
> +	unsigned char old[20], new[20];
> +	const char *old_ref = argv[0];
> +...
> +
> +	replace_parents(&buf, argc, argv);
> +
> +	if (write_sha1_file(buf.buf, buf.len, commit_type, new))
> +		die(_("could not write replacement commit for: '%s'"), old_ref);
> +
> +	strbuf_release(&buf);
> +
> +	if (!hashcmp(old, new))
> +		return error("new commit is the same as the old one: '%s'", sha1_to_hex(old));

Is this really an error?  It may be a warning-worthy situation for a
user or a script to end up doing a no-op graft, e.g.

	git replace --graft HEAD HEAD^

but I wonder if it is more convenient to signal an error (like this
patch does) or just ignore the request and return without adding the
replace ref.

Other than these two points, looks good to me.

Thanks.
