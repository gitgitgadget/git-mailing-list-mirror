From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 06/11] sequencer.c: always separate "(cherry picked
 from" from commit body
Date: Sun, 27 Jan 2013 18:34:10 -0800
Message-ID: <20130128023409.GH8206@elie.Belkin>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
 <1359335515-13818-7-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 03:34:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzeYQ-0003T9-DJ
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 03:34:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049Ab3A1CeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 21:34:17 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:56129 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718Ab3A1CeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 21:34:16 -0500
Received: by mail-pa0-f50.google.com with SMTP id hz10so1228842pad.9
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 18:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=4Ykr9/0+EnXy8A44y557737NJ7n4c+LmEb0TfngTezE=;
        b=ronSdAW+K6+dhtqPuwymAgLj4zP1XBsACC5HPE9sk2MhZXiZaHFttvOPqzUWcl5t5q
         JFmKRrRSIhnCqaC4Gbms477faUkxbZUQL/fV2FePDQcdzQyNuLbEOq1ZirpzpymPfNI9
         J2BmpDyWIHWEqtXSbm3NIaiyXR91YUnWqXJvuKL1CTXtMNqtzm72ZA8TbWgSRUrzDgY2
         jjUpycgXTMOapa4CIWnb/XDUdyieGROoVdUSsh/cklHwJ0mpFAGJs5TKY3MUWfwcUR8T
         d0ugj6hYYi08zqBLSkKhp8pW7nGlmhpAdvyxDteQU0ZPuYha+/EGrTw4hQIaXr8MXGfX
         Ma4w==
X-Received: by 10.68.232.169 with SMTP id tp9mr33961784pbc.1.1359340456002;
        Sun, 27 Jan 2013 18:34:16 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ir4sm5326199pbc.41.2013.01.27.18.34.13
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 18:34:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1359335515-13818-7-git-send-email-drafnel@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214790>

Brandon Casey wrote:

> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -20,6 +20,67 @@
[...]
>  static int has_conforming_footer(struct strbuf *sb, int ignore_footer)
[...]
> +	/* require at least one blank line */
> +	if (!last_char_was_nl || buf[i] != '\n')
> +		return 0;

Makes sense.  append_signoff already added a blank line after a
one-line message

	foo: bar

because of e5138436 (builtin-commit.c: fix logic to omit empty line
before existing footers, 2009-11-06) but the logic to do so was in the
wrong place and it didn't handle its ill-formatted cousin

	foo: bar
	baz: qux

[...]
> @@ -497,6 +558,8 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
>  		}
>  
>  		if (opts->record_origin) {
> +			if (!has_conforming_footer(&msgbuf, 0))
> +				strbuf_addch(&msgbuf, '\n');

What should this do in the case of an entirely blank message?
(Maybe that's too insane a case to worry about.)

[...]
> --- a/t/t3511-cherry-pick-x.sh
> +++ b/t/t3511-cherry-pick-x.sh
> @@ -81,6 +94,19 @@ test_expect_failure 'cherry-pick -s inserts blank line after non-conforming foot
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'cherry-pick -x inserts blank line when conforming footer not found' '

Yay. :)

Thanks for a clear and well thought-out patch with thorough tests.
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
