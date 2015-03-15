From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC][GSoC] make "git diff --no-index $directory $file" DWIM better.
Date: Sun, 15 Mar 2015 13:17:28 -0700
Message-ID: <xmqqpp8at3qf.fsf@gitster.dls.corp.google.com>
References: <CAHLaBN+93mp6PQmtfjOHSvfW7iwDXwPitGQ5W1am9KBm9EZV2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Yurii Shevtsov <ungetch@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 21:17:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXEyf-0004sN-7D
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 21:17:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbbCOURb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 16:17:31 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58903 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751102AbbCOURa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 16:17:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E37483F13A;
	Sun, 15 Mar 2015 16:17:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Wm3yaXD3anchMO0Bcisnut7DV1Y=; b=UDOI8L
	xi5HMshgfqxNpwZj95PhyrwMPZJ8HknHUrNA8TXxnfPphE0M88lWPYcFIRFXzdxz
	eiNXKhAfr2yqTfUWJ3j/VwLZJMBTT+HScf/9umpL1gtVDoHLv1SLJVOEjTVO1nDC
	ZSoam2ygg8R8synHPFvMpaM9tAQQELXB8oWNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d5F+1jdCQfkvYhThMKT9s+NaupveUs8v
	j7p6dJWrbj6NlY+zu8m0zArRaxjlIYEpm7qrlPD4Ml8M8hIH8RsPGzpJ/gDJjX/x
	HinJPrwBNm7yqIW3kXL4wr+UDr4fHKULyTjP7nNLi6qjoTUC1rEu2X5sKqiN78RC
	XEzzVfXxjdQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DABEF3F138;
	Sun, 15 Mar 2015 16:17:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 620803F137;
	Sun, 15 Mar 2015 16:17:29 -0400 (EDT)
In-Reply-To: <CAHLaBN+93mp6PQmtfjOHSvfW7iwDXwPitGQ5W1am9KBm9EZV2Q@mail.gmail.com>
	(Yurii Shevtsov's message of "Sun, 15 Mar 2015 17:35:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4DFBD99E-CB50-11E4-9E10-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265519>

Yurii Shevtsov <ungetch@gmail.com> writes:

> Changes 'git diff --no-index $directory $file' behaviour.
> Now it is transformed to 'git diff --no-index $directory/&file $file'
> instead of throwing an error.

Is this asymmetric?  Shouldn't "git diff --no-index $file $directory"
behave the same way, i.e. turned into "$file $directory/$file"?

If you intended the patch to do so, perhaps

    "git diff --no-index directory/ file" used to error out, saying
    that you cannot compare a directory and a file (with the
    parameters swapped, "git diff --no-index file directory/" failed
    the same way).

    With normal "diff", "diff D/ F" acts as if it were told to
    compare D/F and F (when D/F exists---if there isn't, then it
    shows a creation of F), and behaving the same way would be more
    natural to the users.

or something?

> Signed-off-by: Yurii Shevtsov <ungetch <at> gmail.com>
> ---
>  diff-no-index.c |   21 +++++++++++++++++++--
>  1 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 265709b..4e71b36 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -97,8 +97,25 @@ static int queue_diff(struct diff_options *o,
>         if (get_mode(name1, &mode1) || get_mode(name2, &mode2))
>                 return -1;
>
> -       if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2))
> -               return error("file/directory conflict: %s, %s", name1, name2);
> +       if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2)) {
> +               struct strbuf dirnfile;
> +               const char *dir, *file;
> +               char *filename;
> +               int ret = 0;
> +
> +               dir = S_ISDIR(mode1) ? name1 : name2;
> +               file = (dir == name1) ? name2 : name1;
> +               strbuf_init(&dirnfile, strlen(name1) + strlen(name2) + 2);
> +               strbuf_addstr(&dirnfile, dir);
> +               if (dirnfile.buf[dirnfile.len - 1] != '/')
> +                       strbuf_addch(&dirnfile, '/');
> +               filename = strrchr(file, '/');
> +               strbuf_addstr(&dirnfile, filename ? (filename + 1) : file);
> +               ret = queue_diff(o, dirnfile.buf, file);

Hmm, it appears that you are turning "diff F D/" into "diff D/F F",
which is the other way around here, or am I mis-reading queue_diff().

Does queue_diff() do the right thing when D/F does not exist (not a
rhetorical question; I just did not check it myself)?
