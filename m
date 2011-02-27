From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/5] commit, status: use status_printf{,_ln,_more} helpers
Date: Sun, 27 Feb 2011 03:50:37 -0600
Message-ID: <20110227095022.GB24391@elie>
References: <20110226050723.GA27864@elie>
 <20110226051137.GE27887@elie>
 <7vaahh6dw0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 10:51:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtdHH-0004R7-L6
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 10:50:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914Ab1B0Jus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 04:50:48 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:49197 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878Ab1B0Jur (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 04:50:47 -0500
Received: by vxi39 with SMTP id 39so2448728vxi.19
        for <git@vger.kernel.org>; Sun, 27 Feb 2011 01:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=S1m41fJY22EOdhsCgfrKwmB84epOCD5xx1tpEwNxdr0=;
        b=mDIOVYNXWrHjoyV64ATmw6CnVGrrdyYFptJ4drzpkS3pR8449Ht8QdytHtm7NuqJPG
         39CyZX44+659pMuu92tcL96TyJxD3BBWE66pZj6WFUoDhdxOsuuxdMT38R/A/4kJ3WTB
         cEVc4ItkUuXUnzhSwXUP48073lv1RXy5fKFaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LX3qLnjGEsEkqNNMk97NWxmYyBuNlteZQAP8TJZmDT2E84A2kzqC+G9GDvXpoTWCev
         v0LNkXyvQI934FccghwaWfIhBDDCfrFPPaminz96JcbpXQoqpsIinC5mbl0+GNzHJQuM
         ZNMmdzb8xzhXQ+Huao5AlbJbDl234s2u3usis=
Received: by 10.52.155.1 with SMTP id vs1mr6546881vdb.207.1298800245545;
        Sun, 27 Feb 2011 01:50:45 -0800 (PST)
Received: from elie (adsl-76-206-235-173.dsl.chcgil.sbcglobal.net [76.206.235.173])
        by mx.google.com with ESMTPS id g2sm1819248vbz.0.2011.02.27.01.50.42
        (version=SSLv3 cipher=OTHER);
        Sun, 27 Feb 2011 01:50:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vaahh6dw0.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168018>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> +++ b/builtin/commit.c
>> @@ -694,50 +694,51 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>>  	if (use_editor && include_status) {
>>  		char *ai_tmp, *ci_tmp;
>>  		if (in_merge)
>> -...
>> +			status_printf_ln(s, GIT_COLOR_NORMAL,
>> +				"\n"
>> +				"It looks like you may be committing a MERGE.\n"
>> +				"If this is not correct, please remove the file\n"
>> +				"	%s\n"
>> +				"and try again.\n"
>> +				"",
>
> This trick to avoid difference-in-comma-when-updated was semi "Huh" when
> reading.  Is it worth it?

The hint starts and ends with a blank (commented) line.

			status_printf(s, GIT_COLOR_NORMAL,
				"\n"
				...
				"and try again.\n"
				"\n",

would be clearer.

> The "attribute((format))" safety seems to bite us here...
>
>     $ Meta/Make --pedantic builtin/commit.o
>         CC builtin/commit.o
>     cc1: warnings being treated as errors
>     builtin/commit.c: In function 'prepare_to_commit':
>     builtin/commit.c:741: error: zero-length printf format string
>
> In wt-status.c many similar ones exist, unfortunately.

What a warning. :)  I don't understand how it is supposed to benefit
the world[1].

	status_printf_ln(s, GIT_COLOR_NORMAL, "%s", "");
	status_printf(s, GIT_COLOR_NORMAL, "\n");

I suppose the latter could be a bearable workaround.

[1] http://gcc.gnu.org/ml/gcc-patches/2002-05/msg01462.html
