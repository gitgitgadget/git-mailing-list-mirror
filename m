From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 08/11] date: check for "local" before anything else
Date: Thu, 03 Sep 2015 15:45:21 -0700
Message-ID: <xmqqr3mfgm0u.fsf@gitster.mtv.corp.google.com>
References: <cover.1441144343.git.john@keeping.me.uk>
	<cover.1441316394.git.john@keeping.me.uk>
	<7b53c15203dadbf143239c787f43ea39b6bf28fa.1441316394.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Sep 04 00:45:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXdGA-0007OU-Jb
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 00:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757471AbbICWpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 18:45:24 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36315 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955AbbICWpX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 18:45:23 -0400
Received: by pacwi10 with SMTP id wi10so3629223pac.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 15:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=erw0yFOnTRwyFInQ/A9rLj7VFmCDAj4fXUSat3gpids=;
        b=eltHypFOuxChQ4FigZrphmJtxsy/GKcGVCBpo7GJeRXFn4LTNVcZXDADA3iJU/TndG
         yG/BH3Kj4m9xrm8A+Xi2ErgRsiuUWbUXS/wyX+gn3p1lYZqET+/7DzVoBDW3Z43fqmP0
         oW2RhFXiVQE7G/tS+wjV/RJ0nre1mo+sOE3w2yPQ3qmE5NjvJDrjtLtfhgk57u2uIcUp
         +tNEGCWL1wvKVwn0DfNXObGEIq9ykioEhjh46+YO6hH0KtpoqN4cPL/AtObkgEelR20R
         bbncnNaW4nRyYtBemlF9b9uqUMg8kxxp1/l1F/2rCihJ/s6FgVRMpqQUGi1+RxuK5yEx
         Dm5A==
X-Received: by 10.68.233.200 with SMTP id ty8mr761866pbc.80.1441320323259;
        Thu, 03 Sep 2015 15:45:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:71da:b56c:f873:e611])
        by smtp.gmail.com with ESMTPSA id pm5sm178784pdb.53.2015.09.03.15.45.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 15:45:22 -0700 (PDT)
In-Reply-To: <7b53c15203dadbf143239c787f43ea39b6bf28fa.1441316394.git.john@keeping.me.uk>
	(John Keeping's message of "Thu, 3 Sep 2015 22:48:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277277>

John Keeping <john@keeping.me.uk> writes:

> In a following commit we will make "local" orthogonal to the format.
> Although this will not apply to "relative", which does not use the
> timezone, it applies to all other formats so move the timezone
> conversion to the start of the function.

"local" is a request to show the timestamp in the output in our
local timezone regardless of the format, so even though "relative"
is not affected by the timezone (because "relative" does not show a
timestamp at all---it only shows the duration), this change
conceptually makes sense.

Thanks.


>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  date.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/date.c b/date.c
> index 8f91569..9f0a5dd 100644
> --- a/date.c
> +++ b/date.c
> @@ -174,6 +174,9 @@ const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
>  	struct tm *tm;
>  	static struct strbuf timebuf = STRBUF_INIT;
>  
> +	if (mode->type == DATE_LOCAL)
> +		tz = local_tzoffset(time);
> +
>  	if (mode->type == DATE_RAW) {
>  		strbuf_reset(&timebuf);
>  		strbuf_addf(&timebuf, "%lu %+05d", time, tz);
> @@ -189,9 +192,6 @@ const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
>  		return timebuf.buf;
>  	}
>  
> -	if (mode->type == DATE_LOCAL)
> -		tz = local_tzoffset(time);
> -
>  	tm = time_to_tm(time, tz);
>  	if (!tm) {
>  		tm = time_to_tm(0, 0);
