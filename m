From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] diff: avoid stack-buffer-read-overrun for very long name
Date: Thu, 26 Apr 2012 17:52:51 +0200
Message-ID: <87d36uxzfw.fsf@rho.meyering.net>
References: <87ty0jbt5p.fsf@rho.meyering.net> <20120416222713.GA2396@moj>
	<87397t862o.fsf@rho.meyering.net>
	<xmqq1unbd2m5.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Marcus Karlsson <mk@acc.umu.se>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 17:54:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNR1T-0002Su-Ap
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 17:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757775Ab2DZPxB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 11:53:01 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:52218 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756335Ab2DZPxA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 11:53:00 -0400
Received: from mx.meyering.net (unknown [88.168.87.75])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 38274D48079
	for <git@vger.kernel.org>; Thu, 26 Apr 2012 17:52:52 +0200 (CEST)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id A274460056;
	Thu, 26 Apr 2012 17:52:51 +0200 (CEST)
In-Reply-To: <xmqq1unbd2m5.fsf@junio.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 25 Apr 2012 12:37:38 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196375>

Junio C Hamano wrote:
> Jim Meyering <jim@meyering.net> writes:
>
>> Marcus Karlsson wrote:
>> ...
>>> Are there any guarantees that len1 and len2 does not exceed PATH_MAX?
>>> Because if there aren't any then that function looks like it could need
>>> even more improvements.
>>
>> Hi Marcus,
>>
>> You're right to ask.
>> I've just confirmed that there is such a guarantee.
>
> In any case, I think this is an old part of the codebase that has not
> been updated to take advantage of newer API, partly because not many
> people cared, and partly because there wasn't any serious bug there,
> that can use some facelifting.  Wouldn't it make more sense to use
> strbuf here, perhaps like this (not even compile tested), on top of your
> patch?
>
>  diff-no-index.c |   40 +++++++++++++++++-----------------------
>  1 file changed, 17 insertions(+), 23 deletions(-)
>
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 5cd3ff5..b44473e 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -52,7 +52,7 @@ static int get_mode(const char *path, int *mode)
>  }
>
>  static int queue_diff(struct diff_options *o,
> -		const char *name1, const char *name2)
> +		      const char *name1, const char *name2)
>  {
>  	int mode1 = 0, mode2 = 0;
>
> @@ -63,10 +63,11 @@ static int queue_diff(struct diff_options *o,
>  		return error("file/directory conflict: %s, %s", name1, name2);
>
>  	if (S_ISDIR(mode1) || S_ISDIR(mode2)) {
> -		char buffer1[PATH_MAX], buffer2[PATH_MAX];
> +		struct strbuf buffer1 = STRBUF_INIT;
> +		struct strbuf buffer2 = STRBUF_INIT;
>  		struct string_list p1 = STRING_LIST_INIT_DUP;
>  		struct string_list p2 = STRING_LIST_INIT_DUP;
> -		int len1 = 0, len2 = 0, i1, i2, ret = 0;
> +		int i1, i2, ret = 0;
>
>  		if (name1 && read_directory(name1, &p1))
>  			return -1;
> @@ -76,19 +77,15 @@ static int queue_diff(struct diff_options *o,
>  		}
>
>  		if (name1) {
> -			len1 = strlen(name1);
> -			if (len1 > 0 && name1[len1 - 1] == '/')
> -				len1--;
> -			memcpy(buffer1, name1, len1);
> -			buffer1[len1++] = '/';
> +			strbuf_addstr(&buffer1, name1);
> +			if (buffer1.len && buffer1.buf[buffer1.len - 1] != '/')
> +				strbuf_addch(&buffer1, '/');
>  		}
>
>  		if (name2) {
> -			len2 = strlen(name2);
> -			if (len2 > 0 && name2[len2 - 1] == '/')
> -				len2--;
> -			memcpy(buffer2, name2, len2);
> -			buffer2[len2++] = '/';
> +			strbuf_addstr(&buffer2, name2);
> +			if (buffer2.len && buffer2.buf[buffer2.len - 1] != '/')
> +				strbuf_addch(&buffer2, '/');

Hi Junio,

That looks much better.
I verified that it compiles and passes the tests on x86_64/Fedora 17.

What do you think about replacing those two append-if-needed two-liners:

    if (buffer2.len && buffer2.buf[buffer2.len - 1] != '/')
            strbuf_addch(&buffer2, '/');

by something that readably encapsulates the idiom:

    strbuf_append_if_absent (&buffer2, '/');

(though the name isn't particularly apt, because you might
take "absent" to mean "not anywhere in the string," so maybe
  strbuf_append_if_not_already_at_end (ugly) or
  strbuf_append_uniq
)

There are several other uses that would benefit from such a transformation:
To find the easy ones, I ran this:

  git grep -B1 "strbuf_addch.*'"|grep -A1 '!='

I've manually marked/separated the ones that don't apply.
Note how only 2 of the 6 candidates ensure that length is positive
before using ".len - 1":

------------------------------------
builtin/branch.c-	if (!buf.len || buf.buf[buf.len-1] != '\n')
builtin/branch.c:		strbuf_addch(&buf, '\n');
--
builtin/fmt-merge-msg.c-		if (out->buf[out->len - 1] != '\n')
builtin/fmt-merge-msg.c:			strbuf_addch(out, '\n');
--
builtin/log.c-		if (filename.buf[filename.len - 1] != '/')
builtin/log.c:			strbuf_addch(&filename, '/');
--
builtin/notes.c-	if (buf.buf[buf.len - 1] != '\n')
builtin/notes.c:		strbuf_addch(&buf, '\n'); /* Make sure msg ends with newline */
--
refs.c-		if (real_pattern.buf[real_pattern.len - 1] != '/')
refs.c:			strbuf_addch(&real_pattern, '/');
--
strbuf.h-	if (sb->len && sb->buf[sb->len - 1] != '\n')
strbuf.h:		strbuf_addch(sb, '\n');






--
NO wt-status.c-			if (*line != '\n' && *line != '\t')
NO wt-status.c:				strbuf_addch(&linebuf, ' ');
--
NO builtin/merge.c-	while ((commit = get_revision(&rev)) != NULL) {
NO builtin/merge.c:		strbuf_addch(&out, '\n');
--
NO builtin/shortlog.c-	if (col != log->wrap)
NO builtin/shortlog.c:		strbuf_addch(sb, '\n');
--
NO dir.c-	if (path->buf[original_len - 1] != '/')
NO dir.c:		strbuf_addch(path, '/');
--
NO path.c-	if (len && path[len-1] != '/')
NO path.c:		strbuf_addch(&buf, '/');
--
NO pretty.c-			if (p != commit->parents)
NO pretty.c:				strbuf_addch(sb, ' ');
--
NO pretty.c-			if (p != commit->parents)
NO pretty.c:				strbuf_addch(sb, ' ');
--
NO pretty.c-	if (pp->fmt != CMIT_FMT_ONELINE && !pp->subject) {
NO pretty.c:		strbuf_addch(sb, '\n');
--
NO pretty.c-	if (pp->fmt != CMIT_FMT_ONELINE)
NO pretty.c:		strbuf_addch(sb, '\n');
