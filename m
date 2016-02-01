From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] wt-status: read rebase todolist with strbuf_getline()
Date: Mon, 01 Feb 2016 13:39:34 -0800
Message-ID: <xmqq8u34un3d.fsf@gitster.mtv.corp.google.com>
References: <56ACF82B.2030005@moritzneeb.de> <56ACFB7B.6050800@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Moritz Neeb <lists@moritzneeb.de>
X-From: git-owner@vger.kernel.org Mon Feb 01 22:39:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQMCD-0007AZ-KA
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 22:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677AbcBAVji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 16:39:38 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54140 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753380AbcBAVjh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 16:39:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 75C9341470;
	Mon,  1 Feb 2016 16:39:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xjz8Did35nCG9olkPpgM9lr51z0=; b=dL/Xu+
	nUY/jhGU13xVz1zr7zkeYPVXzQ9Sc6YmMB6j2c5cOH3TjZ3F7dQRJsmeaeNvSX15
	BwJ6WVYIARoMYxvIkps4SJK5Pw+drWzG4mGImrS0RiTpKsUMHbU+Psx49yoZS11S
	xw0qTEfpmwLhCHYYUR5RHFcsiVTxehu5wZa54=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lvpd+nyW1EjYxb9hn1SvtneWcKp4ZbNC
	0O7amknfWUHhkvXXOIzjuCpAK025/WEM6zzWO2rNlmeMDdfwS6QEq3GKshU5tdTh
	VOLDsD9BMaKROU8rH1/32qdjczrR35c/n0eS903HVvnk16pScH2oVlQEls3mszX/
	3hEtEdYtCLw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6BC554146F;
	Mon,  1 Feb 2016 16:39:36 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D8E964146C;
	Mon,  1 Feb 2016 16:39:35 -0500 (EST)
In-Reply-To: <56ACFB7B.6050800@moritzneeb.de> (Moritz Neeb's message of "Sat,
	30 Jan 2016 19:05:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 49D3F65A-C92C-11E5-826B-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285217>

Moritz Neeb <lists@moritzneeb.de> writes:

>     In read_rebase_todolist() every line is, after reading, checked
>     for a comment_line_char. After that it is trimmed via strbuf_trim().
>     Assuming we do never expect a CR as comment_line_char,
>     strbuf_getline_lf() can be safely replaced by its CRLF counterpart.
>
> Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
> ---
>
> Notes:
>     Looking at the code in read_rebase_todolist(), the
>     lines are read, checked for a comment_line_char and then trimmed. I
>     wonder why the input is not trimmed before checking for this character?
>     Is it safe to replace strbuf_getline_lf() by strbuf_getline() anyway?
>         The only case I can imagine that could lead to unexpected behaviour then
>     would be when someone sets the comment_line_char to CR. How likely is that?
>         Why is the trim _after_ checking for the comment char anyway? Should
>     something like "   # foobar" not be considered as comment?
>         I decided to roll out the patch because I considered it not as a risk to be
>     taken seriously, that the comment line char will be '\r'.
>         Meta-question: Should something of this discussion be put into the commit?

Yes to the meta question.  Add something like this as the second
paragraph of the log message, but do *not* change the patch text.

	The current code checks if the line begins with a comment
	line char (typically '#') before trimming, which is
	consistent with the way how commands like 'git commit'
	prepares commented lines in that this does not treat a line
	that begins with whitespaces and '#' as commented out.  We
	however made a mistake in the parser of "git rebase -i" long
	time ago to allow such a line to be treated as a comment,
	and made an exception with 1db168ee (rebase-i: loosen
	over-eager check_bad_cmd check, 2015-10-01).  It probably is
	a good idea to match that exception by swapping the order of
	comment check and trimming in this codepath as well.

>
>  wt-status.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index ab4f80d..f053b2f 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1076,7 +1076,7 @@ static void read_rebase_todolist(const char *fname, struct string_list *lines)
>  	if (!f)
>  		die_errno("Could not open file %s for reading",
>  			  git_path("%s", fname));
> -	while (!strbuf_getline_lf(&line, f)) {
> +	while (!strbuf_getline(&line, f)) {
>  		if (line.len && line.buf[0] == comment_line_char)
>  			continue;
>  		strbuf_trim(&line);
