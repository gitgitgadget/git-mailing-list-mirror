From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] log: grep author/committer using mailmap
Date: Wed, 26 Dec 2012 11:27:41 -0800
Message-ID: <7vr4mcobpu.fsf@alter.siamese.dyndns.org>
References: <1356195512-4846-1-git-send-email-apelisse@gmail.com>
 <1356195512-4846-2-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 26 20:28:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TnweA-0003NH-Lg
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 20:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645Ab2LZT1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 14:27:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47183 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752429Ab2LZT1p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 14:27:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50C54996D;
	Wed, 26 Dec 2012 14:27:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r36Ep46Qwfe7SMATadpmQ8EfI0E=; b=ZIK20B
	qkCT4o5hdZJMt5vnRNh1pm95SEPN00mbgZQpccP+fCjmjtDdhhvJ/KcWDZmeOwwv
	F1s8nv88SQn5eykWu/0vpvr6U1nvHcXvKEInz8kUBR4cIBiNnEgF41OKl3cZOyRT
	J7c0j6Aaz2ACSbqxU9QDk8XoWDLlzDaHwYRdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z/5Dka/zNHXfLXwlATFo7FAsriva1gaS
	KRT7ZmzFng93+qnOrelcqR4lXG8tVrvdjQTFaOvXlbNNroXOHYiYcT9Z0iNhSg4w
	B9LckJMo8mUGIcj8mgM9FJJkT3fRA1sVv+u6xIPXCjOdKWILuC5c5UapKvzYfaTx
	7Fy6MbbpTR4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BB44996C;
	Wed, 26 Dec 2012 14:27:44 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43056996B; Wed, 26 Dec 2012
 14:27:43 -0500 (EST)
In-Reply-To: <1356195512-4846-2-git-send-email-apelisse@gmail.com> (Antoine
 Pelisse's message of "Sat, 22 Dec 2012 17:58:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 51ECC630-4F92-11E2-9D6D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212145>

Antoine Pelisse <apelisse@gmail.com> writes:

> Currently mailmap can be used to display log authors and committers
> but there no way to use mailmap to find commits with mapped values.
>
> This commit allows those commands to work:
>
>     git log --use-mailmap --author mapped_name_or_email
>     git log --use-mailmap --committer mapped_name_or_email
>
> Of course it only works if the --use-mailmap option is used.
>
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> ---
> I probably missed something but I didn't find the connection with
> commit 2d10c55. Let me know if I went the wrong direction.
>
>  revision.c         |   53 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  t/t4203-mailmap.sh |   18 ++++++++++++++++++
>  2 files changed, 71 insertions(+)
>
> diff --git a/revision.c b/revision.c
> index 95d21e6..fb9fd41 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -13,6 +13,7 @@
>  #include "decorate.h"
>  #include "log-tree.h"
>  #include "string-list.h"
> +#include "mailmap.h"
>
>  volatile show_early_output_fn_t show_early_output;
>
> @@ -2219,6 +2220,50 @@ static int rewrite_parents(struct rev_info *revs, struct commit *commit)
>  	return 0;
>  }
>
> +static int commit_rewrite_authors(struct strbuf *buf, const char *what, struct string_list *mailmap)
> +{
> +	char *author, *endp;
> +	size_t len;
> +	struct strbuf name = STRBUF_INIT;
> +	struct strbuf mail = STRBUF_INIT;
> +	struct ident_split ident;
> +
> +	author = strstr(buf->buf, what);
> +	if (!author)
> +		goto error;

This does not stop at the end of the header part and would match a
random line in the log message that happens to begin with "author ";
is this something we would worry about, or would we leave it to "fsck"?

> +	author += strlen(what);
> +	endp = strstr(author, "\n");

Using strchr(author, '\n') would feel more natural.  Also rename
"author" to "person" or something, as you would be using this
function for the committer information as well?

> +	if (!endp)
> +		goto error;
> +
> +	len = endp - author;
> +
> +	if (split_ident_line(&ident, author, len)) {
> +	error:
> +		strbuf_release(&name);
> +		strbuf_release(&mail);
> +
> +		return 1;

We usually signal error by returning a negative integer.  It does
not matter too much in this case as no callers seem to check the
return value from this function, though.

> +	}
> +
> +	strbuf_add(&name, ident.name_begin, ident.name_end - ident.name_begin);
> +	strbuf_add(&mail, ident.mail_begin, ident.mail_end - ident.mail_begin);
> +
> +	map_user(mailmap, &mail, &name);
> +
> +	strbuf_addf(&name, " <%s>", mail.buf);
> +
> +	strbuf_splice(buf, ident.name_begin - buf->buf,
> +		      ident.mail_end - ident.name_begin + 1,
> +		      name.buf, name.len);

Would it give us better performance if we splice only when
map_user() tells us that we actually rewrote the ident?

> +	strbuf_release(&name);
> +	strbuf_release(&mail);
> +
> +	return 0;
> +}
> +
>  static int commit_match(struct commit *commit, struct rev_info *opt)
>  {
>  	int retval;
> @@ -2237,6 +2282,14 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
>  	if (buf.len)
>  		strbuf_addstr(&buf, commit->buffer);
>
> +	if (opt->mailmap) {
> +		if (!buf.len)
> +			strbuf_addstr(&buf, commit->buffer);
> +
> +		commit_rewrite_authors(&buf, "\nauthor ", opt->mailmap);
> +		commit_rewrite_authors(&buf, "\ncommitter ", opt->mailmap);
> +	}
> +
>  	/* Append "fake" message parts as needed */
>  	if (opt->show_notes) {
>  		if (!buf.len)
> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> index db043dc..e16187f 100755
> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> @@ -248,11 +248,29 @@ Author: Other Author <other@author.xx>
>  Author: Some Dude <some@dude.xx>
>  Author: A U Thor <author@example.com>
>  EOF
> +
>  test_expect_success 'Log output with --use-mailmap' '
>  	git log --use-mailmap | grep Author >actual &&
>  	test_cmp expect actual
>  '
>
> +cat >expect <<\EOF
> +Author: Santa Claus <santa.claus@northpole.xx>
> +Author: Santa Claus <santa.claus@northpole.xx>
> +EOF
> +
> +test_expect_success 'Grep author with --use-mailmap' '
> +	git log --use-mailmap --author Santa | grep Author >actual &&
> +	test_cmp expect actual
> +'
> +
> +>expect
> +
> +test_expect_success 'Only grep replaced author with --use-mailmap' '
> +	git log --use-mailmap --author "<cto@coompany.xx>" >actual &&
> +	test_cmp expect actual
> +'
> +
>  # git blame
>  cat >expect <<\EOF
>  ^OBJI (A U Thor     DATE 1) one
> --
> 1.7.9.5
