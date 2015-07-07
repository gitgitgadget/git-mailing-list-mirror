From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] convert "enum date_mode" into a struct
Date: Tue, 07 Jul 2015 14:05:52 -0700
Message-ID: <xmqq4mlf3cgf.fsf@gitster.dls.corp.google.com>
References: <20150625165341.GA21949@peff.net>
	<20150625165501.GB23503@peff.net>
	<xmqqbnfn3dsb.fsf@gitster.dls.corp.google.com>
	<20150707204837.GA15483@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 07 23:06:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCa40-0000Pu-0N
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 23:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757913AbbGGVF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 17:05:56 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:35392 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757636AbbGGVFy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 17:05:54 -0400
Received: by iecuq6 with SMTP id uq6so143064828iec.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 14:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=7ZWx/zB/Fa6Gl1g0blhBfA9whC/0jiS5ZnzeBeGNZEQ=;
        b=h+pP3nwWpXxWSqD+CR42/6B2PLEVA9c1XLU4nmGl7xHFiwudmwyxsihr+o/l1FctX1
         9iEzK06vl3c1+SRNSXeK16KquF0522le3lyT9vTRPRm+qPQ+nVdV463oj4cF1djmwuAU
         5sa8X2asciq62OWdCfR5nLV9UCf3Z2OFtZNVUJ6tzaPXGxxF2n7vkqSuaPvGFHi5K6Kg
         6zxf6rNoCObjUzRWWD6V6ZZpvmIopeSpbakmb2wC28pwvPKcPfLHimiCofCl1QxwzLq8
         XH/j6IUomC1mhgqhSUTgBhsOtO4RuDkV2ZsH6MffXjJW/pAouB5c28fP8UlhQToJfi/O
         bNYA==
X-Received: by 10.50.30.226 with SMTP id v2mr52138615igh.3.1436303154213;
        Tue, 07 Jul 2015 14:05:54 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d74:6f43:1e30:fb1d])
        by smtp.gmail.com with ESMTPSA id bf10sm12634436igb.12.2015.07.07.14.05.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 Jul 2015 14:05:53 -0700 (PDT)
In-Reply-To: <20150707204837.GA15483@peff.net> (Jeff King's message of "Tue, 7
	Jul 2015 16:48:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273601>

Jeff King <peff@peff.net> writes:

> My assumption was that using the raw "0" is something we would frowned
> upon in new code. There was a single historical instance that I fixed in
> the series, but I wouldn't expect new ones (and actually, that instance
> was "1", which would be caught by the compiler).

That is not the problem.

The code on the side branch may add a new callsite, something like
this:

	show_ident_date(&ident_split, DATE_NORMAL);

based on the current codebase (e.g. 'master' as of today).

The merge goes cleanly, it compiles, even though the new function
signature of show_ident_date(), similar to the updated show_date(),
takes a pointer to a struct where they used to take DATE_$format
constants.

And that is because DATE_NORMAL is defined to be 0; we can claim
that the compiler is being stupid to take one of the enum
date_mode_type values that happens to be 0 and misinterpret it as
the program wanted to pass a NULL pointer to a structure, but that
is not what happened.

> However, if you're concerned, I think we could have show_date massage a
> NULL date, like:
>
> diff --git a/date.c b/date.c
> index 8f91569..a04d089 100644
> --- a/date.c
> +++ b/date.c
> @@ -173,6 +173,10 @@ const char *show_date(unsigned long time, int tz, const struct date_mode *mode)
>  {
>  	struct tm *tm;
>  	static struct strbuf timebuf = STRBUF_INIT;
> +	static const struct fallback_mode = { DATE_NORMAL };

Yes, that is nasty.  Renumbering the enum to begin with 1 may be a
much saner solution, unless somebody does

	if (!mode->type)
        	/* we know DATE_NORMAL is zero, he he */
	        do the normal thing;

In any case, I did another evil merge to fix it.
