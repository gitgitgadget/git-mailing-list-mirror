From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v3] commit -v: strip diffs and submodule shortlogs from
 the commit message
Date: Thu, 21 Nov 2013 22:26:06 +0100
Message-ID: <528E7A6E.8080603@web.de>
References: <528D385F.2070906@web.de> <xmqqpppu65fs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>, Ari Pollak <ari@debian.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 21 22:26:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjblR-0006SR-TO
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 22:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753784Ab3KUV0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 16:26:14 -0500
Received: from mout.web.de ([212.227.15.14]:58606 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751226Ab3KUV0N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 16:26:13 -0500
Received: from [192.168.178.41] ([91.3.140.19]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0MBkLb-1Vr08y1PeR-00AnOB for <git@vger.kernel.org>; Thu,
 21 Nov 2013 22:26:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <xmqqpppu65fs.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:ppF9YVZB6Y/S6IonR/6YUgl5e/Yg6rD2ZIHSw6u299uRApZ1aBy
 L6/G7HHOjaYkZ3vYMsoO6X+6iVbVWzKrz0WLrF3QW4X6zIpueX/qdgQAjg3RDXnw35Pjr4r
 dntqgrspaQEdiRZimDltzFJ21IqzdUWi1rdzXeNdgYTb/aXSXYIHVhcUvBh6UNl5aoOdzcB
 IirfvbYFI6ncZ0bc3Fukg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238156>

Am 21.11.2013 00:04, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>> diff --git a/wt-status.c b/wt-status.c
>> index b4e44ba..734f94b 100644
>> --- a/wt-status.c
>> +++ b/wt-status.c
>> @@ -16,6 +16,9 @@
>>  #include "column.h"
>>  #include "strbuf.h"
>>
>> +static char wt_status_cut_line[] = /* 'X' is replaced with comment_line_char */
>> +"X ------------------------ >8 ------------------------\n";
>> +
>>  static char default_wt_status_colors[][COLOR_MAXLEN] = {
>>  	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
>>  	GIT_COLOR_GREEN,  /* WT_STATUS_UPDATED */
>> @@ -767,6 +770,15 @@ conclude:
>>  	status_printf_ln(s, GIT_COLOR_NORMAL, "");
>>  }
>>
>> +void wt_status_truncate_message_at_cut_line(struct strbuf *buf)
>> +{
>> +	const char *p;
>> +
>> +	p = strstr(buf->buf, wt_status_cut_line);
>> +	if (p && (p == buf->buf || p[-1] == '\n'))
>> +		strbuf_setlen(buf, p - buf->buf);
>> +}
> 
> Perhaps it may happen that all the current callers have called
> wt_status_print_verbose() to cause wt_status_cut_line[0] to hold
> comment_line_char, but relying on that calling sequence somehow
> makes me feel uneasy.

I initialized the place to be occupied by the comment_line_char
in wt_status_cut_line with 'X' on purpose to notice such a
problem. But I'd be also fine with setting wt_status_cut_line[0]
again here just to be sure. But please also see below ...

> Perhaps cut_line[] should only have "--- >8 ---" part and both
> printing side (below) and finding side (this one) should check these
> separately?

... ok ...

> That is:
> 
> 	p = buf->buf;
> 	while (p && *p) {
> 		p = strchr(p, comment_line_char);
>                 if (!p)
> 			break;
> 		if (strstr(p + 1, cut_line) == p + 1)
> 			break;
> 		p++;
>                 continue;
> 	}
>         if (p && *p && (p == buf->buf || p[-1] == '\n'))
> 		strbuf_setlen(buf, p - buf->buf);
> 
> or something (the above is deliberately less-efficient-than-ideal,
> because I want to keep the code structure in such a way that we can
> later turn comment_line_char to a string[] that can hold "//" to
> allow a multi-char comment introducer more easily)?

Hmm, I'm a bit reluctant to go that far to optimize this patch for
another one that might materialize later. But what about this:

	struct strbuf cut_line = STRBUF_INIT;
	strbuf_addf(&cut_line, "%c %s", comment_line_char, wt_status_cut_line);
	p = strstr(buf->buf, cut_line.buf);
	if (p && (p == buf->buf || p[-1] == '\n'))
		strbuf_setlen(buf, p - buf->buf);
	strbuf_release(&cut_line);

That is shorter can easily be adapted to a comment line string later.
And even though it's slightly less performant should not be a problem
here as this happens only once after invoking an editor for user input.

>>  static void wt_status_print_verbose(struct wt_status *s)
>>  {
>>  	struct rev_info rev;
>> @@ -787,10 +799,17 @@ static void wt_status_print_verbose(struct wt_status *s)
>>  	 * If we're not going to stdout, then we definitely don't
>>  	 * want color, since we are going to the commit message
>>  	 * file (and even the "auto" setting won't work, since it
>> -	 * will have checked isatty on stdout).
>> +	 * will have checked isatty on stdout). But we then do want
>> +	 * to insert the scissor line here to reliably remove the
>> +	 * diff before committing.
>>  	 */
>> -	if (s->fp != stdout)
>> +	if (s->fp != stdout) {
>>  		rev.diffopt.use_color = 0;
>> +		wt_status_cut_line[0] = comment_line_char;
>> +		fprintf(s->fp, wt_status_cut_line);
>> +		fprintf(s->fp, _("%c Do not touch the line above.\n"), comment_line_char);
>> +		fprintf(s->fp, _("%c Everything below will be removed.\n"), comment_line_char);
>> +	}
> 
> I didn't bother with my "how about this" version, but we may want to
> use strbuf_add_commented_lines() to help i18n/l10n folks.  Depending
> on the l10n, this message may want to become more or less than 2
> lines.

Makes sense, will change that (maybe using strbuf_commented_addf()
instead) for v4.
