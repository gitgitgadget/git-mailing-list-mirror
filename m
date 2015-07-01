From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/4] status: give more information during rebase -i
Date: Wed, 01 Jul 2015 09:18:56 -0700
Message-ID: <xmqq4mlnc0lr.fsf@gitster.dls.corp.google.com>
References: <vpq7fqkz48f.fsf@anie.imag.fr>
	<1435739433-18853-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435739433-18853-3-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	antoine.delaite@ensimag.grenoble-inp.fr
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jul 01 18:19:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAKj7-00065q-DA
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 18:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616AbbGAQTE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 12:19:04 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:34071 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754564AbbGAQTB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 12:19:01 -0400
Received: by igcsj18 with SMTP id sj18so138863199igc.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 09:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4e5GaGainrTa4QiWQm+HykpNwKsnrKcpDBetkajV1/I=;
        b=v7dTwopYzJ6DaeLQ4axrkThFQw6OdRZ9DlUULuXT2OtUTG+Rt1jB4d9rt0YE/mxGje
         Sp9LkUhpoghVYWlQ/Qm0DwN4Q6CiwlkIzsMrqSRNG3As6LYhHpSASgH3z0zr7QRd8JkH
         yVvFXhFY9nkJyCKth4riPcbzRll7r6XPhfIy0wpX0iQigKS00XD65nbR+e60maCB8x+y
         A3zSeFVnz5RLlOhMYYzRhswb7qmB9DV3dnEg6iccBobyda1QqGiJIdjOwo6qH1XuDPSX
         3rwHbydOVaBDd/6Linxzl4KFE6v11uXfHAcc2wnkXZ5DPMxNR9kHzjzWBfaKTLLbZJOP
         pDTQ==
X-Received: by 10.50.49.46 with SMTP id r14mr10400209ign.45.1435767540815;
        Wed, 01 Jul 2015 09:19:00 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:64b9:4225:baa1:c97c])
        by mx.google.com with ESMTPSA id j20sm1973799igt.16.2015.07.01.09.18.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Jul 2015 09:18:58 -0700 (PDT)
In-Reply-To: <1435739433-18853-3-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Wed, 1 Jul 2015 10:30:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273157>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> +/*
> + * Turn
> + * pick d6a2f0303e897ec257dd0e0a39a5ccb709bc2047 some message
> + * into
> + * pick d6a2f03 some message
> + */
> +static void abbrev_sha1_in_line(struct strbuf *line)
> +{
> +	struct strbuf **split;
> +	int i;
> +
> +	if (starts_with(line->buf, "exec ") ||
> +	    starts_with(line->buf, "x "))
> +		return;
> +
> +	split = strbuf_split_max(line, ' ', 3);
> +	if (split[0] && split[1]) {
> +		unsigned char sha1[20];
> +		const char *abbrev;
> +
> +		/*
> +		 * strbuf_split_max left a space. Trim it and re-add
> +		 * it after abbreviation.
> +		 */
> +		strbuf_trim(split[1]);
> +		if (!get_sha1(split[1]->buf, sha1)) {
> +			abbrev = find_unique_abbrev(sha1, DEFAULT_ABBREV);
> +			strbuf_reset(split[1]);
> +			strbuf_addf(split[1], "%s ", abbrev);
> +		}

... else?

That is, "we thought there would be a full SHA-1, but it turns out
that there wasn't, so we keep split[1] as-is" would need to add the
space back, no?  Perhaps be more strict and do this instead (without
leading strbuf_trim):

	if (!get_sha1_hex(split[1]->buf, sha1) &&
	    !strcmp(split[1]->buf + 40, " ") {
		replace split[1] with "%s " abbrev
	}

> +		strbuf_reset(line);
> +		for (i = 0; split[i]; i++)
> +			strbuf_addstr(line, split[i]->buf);
> +	}
> +	for (i = 0; split[i]; i++)
> +		strbuf_release(split[i]);
> +
> +}
> +
> +static void read_rebase_todolist(const char *fname, struct string_list *lines)
> +{
> +	struct strbuf line = STRBUF_INIT;
> +	FILE *f = fopen(git_path(fname), "r");
> +
> +	if (!f)
> +		die_errno("Could not open file %s for reading", git_path(fname));
> +	while (!strbuf_getline(&line, f, '\n')) {
> +		stripspace(&line, 1);

stripspace() is meant to be used for multi-line input (e.g. it
collapses a multi-line paragraph break into one blank line) and it
does not look a good fit in a loop that goes line-by-line. As you
call (and you have to, because stripspace() fixes the incomplete
line by adding LF at the end) rtrim() immediately afterward, this
call is done only for removing comments (in other words, trailing
whitespaces are removed without the call to stripspace() anyway).

> +		/* Remove trailing \n */
> +		strbuf_rtrim(&line);
> +		abbrev_sha1_in_line(&line);
> +		string_list_append(lines, line.buf);
> +	}
> +	string_list_remove_empty_items(lines, 1);
> +}

Perhaps

        while (!strbuf_getline(&line, f, '\n')) {
                if (line.len && line.len[0] == comment_line_char)
                        continue;
                strbuf_rtrim(&line);
                if (!line.len)
                        continue;
                abbrev_sha1_in_line(&line);
                string_list_append(lines, line.buf);
        }

without the "we may have added cruft, so discard them at the end"?

Other than these two minor nits, I didn't spot anything questionable
in the diff between this and the previous round.

Thanks.
