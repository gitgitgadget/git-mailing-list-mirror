From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 3/4] status: give more information during rebase -i
Date: Wed, 01 Jul 2015 23:06:51 +0200
Message-ID: <vpqk2ujoadw.fsf@anie.imag.fr>
References: <vpq7fqkz48f.fsf@anie.imag.fr>
	<1435739433-18853-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435739433-18853-3-git-send-email-Matthieu.Moy@imag.fr>
	<xmqq4mlnc0lr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 23:07:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAPDn-0003Qa-0I
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 23:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989AbbGAVHC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 17:07:02 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54704 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752567AbbGAVHB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 17:07:01 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t61L6nau010935
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 1 Jul 2015 23:06:49 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t61L6poS025558;
	Wed, 1 Jul 2015 23:06:51 +0200
In-Reply-To: <xmqq4mlnc0lr.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 01 Jul 2015 09:18:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 01 Jul 2015 23:06:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t61L6nau010935
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436389613.56058@G+JO5S8TyLhlDygPMWm5ug
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273199>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> +		strbuf_trim(split[1]);
>> +		if (!get_sha1(split[1]->buf, sha1)) {
>> +			abbrev = find_unique_abbrev(sha1, DEFAULT_ABBREV);
>> +			strbuf_reset(split[1]);
>> +			strbuf_addf(split[1], "%s ", abbrev);
>> +		}
>
> ... else?
>
> That is, "we thought there would be a full SHA-1, but it turns out
> that there wasn't, so we keep split[1] as-is" would need to add the
> space back, no?

Right.

> Perhaps be more strict and do this instead (without leading
> strbuf_trim):
>
> 	if (!get_sha1_hex(split[1]->buf, sha1) &&
> 	    !strcmp(split[1]->buf + 40, " ") {
> 		replace split[1] with "%s " abbrev
> 	}

Actually, we can do simpler: we still have the original line available,
so if we don't find a sha1, we can just keep it. By just letting the few
lines after the if enter the if, it just works:

		strbuf_trim(split[1]);
		if (!get_sha1(split[1]->buf, sha1)) {
			abbrev = find_unique_abbrev(sha1, DEFAULT_ABBREV);
			strbuf_reset(split[1]);
			strbuf_addf(split[1], "%s ", abbrev);
			strbuf_reset(line);
			for (i = 0; split[i]; i++)
				strbuf_addf(line, "%s", split[i]->buf);
		}

>         while (!strbuf_getline(&line, f, '\n')) {
>                 if (line.len && line.len[0] == comment_line_char)
>                         continue;
>                 strbuf_rtrim(&line);
>                 if (!line.len)
>                         continue;
>                 abbrev_sha1_in_line(&line);
>                 string_list_append(lines, line.buf);
>         }

I took this (modulo s/line.len[0]/line.buf[0]/, and s/rtrim/trim/ to be
robust to leading whitespace (not really important, but doesn't harm).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
