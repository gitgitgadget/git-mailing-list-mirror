From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 3/4] status: give more information during rebase -i
Date: Thu, 02 Jul 2015 10:01:49 +0200
Message-ID: <vpqh9pnm1hu.fsf@anie.imag.fr>
References: <vpq7fqkz48f.fsf@anie.imag.fr>
	<1435739433-18853-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435739433-18853-3-git-send-email-Matthieu.Moy@imag.fr>
	<xmqq4mlnc0lr.fsf@gitster.dls.corp.google.com>
	<vpqk2ujoadw.fsf@anie.imag.fr>
	<xmqqr3or7et9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 10:02:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAZRi-000181-1T
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 10:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752084AbbGBICB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 04:02:01 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36549 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752845AbbGBIB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 04:01:58 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t6281nJ5009621
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 2 Jul 2015 10:01:49 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6281nWl001707;
	Thu, 2 Jul 2015 10:01:49 +0200
In-Reply-To: <xmqqr3or7et9.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 01 Jul 2015 14:23:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 02 Jul 2015 10:01:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6281nJ5009621
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436428913.4509@Q42hSlTnTFOlfsJXa63t2Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273216>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Actually, we can do simpler: we still have the original line available,
>> ...
>>
>> I took this (modulo s/line.len[0]/line.buf[0]/, and s/rtrim/trim/ to be
>> robust to leading whitespace (not really important, but doesn't harm).
>
> I'd prefer us to be more strict when we know we are reading our own
> output; rtrim is sensible, as the log line has end-user subject
> the end and the subject might have a trailing whitespace we want to
> trim, but there is no valid reason to expect leading whitespace.

I would agree with "more strict" is it was about rejecting the input (to
catch errors), but here we're still accepting it without complaining if
it has leading whitespaces. So, being strict does not seem to have any
benefit to me. Being a bit more robust is just one character _less_ in
the code.

Actually, there's a hidden benefit in accepting not-well-formatted
input: it mimicks the shell equivalent closer, which means that we're
close to replacing the shell's collapse_todo_ids and expand_todo_ids in
C which would avoid C/shell duplication.

> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1046,12 +1046,8 @@ static void abbrev_sha1_in_line(struct strbuf *line)
>                 unsigned char sha1[20];
>                 const char *abbrev;
>  
> -               /*
> -                * strbuf_split_max left a space. Trim it and re-add
> -                * it after abbreviation.
> -                */
> -               strbuf_trim(split[1]);
> -               if (!get_sha1(split[1]->buf, sha1)) {
> +               if (!get_sha1_hex(split[1]->buf, sha1) &&
> +                   !strcmp(split[1]->buf + 40, " ")) {
>                         abbrev = find_unique_abbrev(sha1, DEFAULT_ABBREV);
>                         strbuf_reset(split[1]);
>                         strbuf_addf(split[1], "%s ", abbrev);

I prefer my version. It's simpler: when we can't expand, keep the
original "line", don't try to deconstruct/reconstruct it, it's
unmodified by construction. And my version works if the line is just
"pick <sha1>\n", while yours doesn't.

About get_sha1_hex Vs get_sha1, the same argument as above applies:
accepting short sha1s here means that implementing expand_todo_ids based
on the function would be relatively easy.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
