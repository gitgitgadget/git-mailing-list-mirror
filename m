From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] adds --date=raw support to git blame and related
 documentation
Date: Mon, 23 Feb 2009 09:10:54 -0800
Message-ID: <7vprh9t6xt.fsf@gitster.siamese.dyndns.org>
References: <1235379429-20934-1-git-send-email-eletuchy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, eletuchy@facebook.com,
	Eugene Letuchy <eugene@facebook.com>
To: eletuchy@gmail.com
X-From: git-owner@vger.kernel.org Mon Feb 23 18:13:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbeMR-00030m-6m
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 18:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755652AbZBWRLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 12:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755649AbZBWRLH
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 12:11:07 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33860 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755549AbZBWRLG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 12:11:06 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5623E9C03F;
	Mon, 23 Feb 2009 12:11:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9E8F39C038; Mon,
 23 Feb 2009 12:10:56 -0500 (EST)
In-Reply-To: <1235379429-20934-1-git-send-email-eletuchy@gmail.com>
 (eletuchy@gmail.com's message of "Mon, 23 Feb 2009 00:57:09 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F2A0D106-01CC-11DE-8AEB-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111159>

eletuchy@gmail.com writes:

> From: Eugene Letuchy <eugene@facebook.com>
>
> In the wake of Linus' 7dff9b3, git blame --date support needs to
> incorporate --date=raw in addition to the previously supported
> date formats.

Thanks, but I do not understand what you meant by the following two lines:

> Test: > git grep relative | grep iso | grep -v raw
>       > git blame --date=raw builtin-blame.c

With the patch to add --date=raw format already on 'master', I'd prefer a
reroll of the original patch (it needs a fix for the config "don't ignore
a misconfiguration" bug Peff pointed out anyway) with this documentation
update patch squashed in.

> diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
> index e6717af..1316d4e 100644
> --- a/Documentation/blame-options.txt
> +++ b/Documentation/blame-options.txt
> @@ -36,7 +36,7 @@ of lines before or after the line given by <start>.
>  	Show long rev (Default: off).
>  
>  -t::
> -	Show raw timestamp (Default: off).
> +	Synomym for --date=raw (Default: off).

This is interesting.  It suggests that we should internally get rid of
show_raw_time variable (and need to error out when --date= and -t options
are given at the same time, as they are mutually incompatible).

But do -t and --date=raw really behave identically?  I think they should
but I didn't check.

> diff --git a/builtin-blame.c b/builtin-blame.c
> index 48cedfd..bb0d20b 100644
> --- a/builtin-blame.c
> +++ b/builtin-blame.c
> @@ -2288,12 +2288,16 @@ parse_done:
>  	case DATE_RELATIVE:
>  		blame_date_width = sizeof("14 minutes ago");
>  		break;
> +	case DATE_RAW:
> +		blame_date_width = sizeof("1235155266 -0800");
> +		output_option |= OUTPUT_RAW_TIMESTAMP;
> +		break;

I'd prefer it to see a same timestamp used consistently here.  You seem to
have used "Thu, 19 Oct 2006 16:00:04 -0700" for other case arms (I do not
know what significant things happened at that time) and what I queued in
'pu' has sizeof("1161298804 -0700") there instead.

>  	case DATE_LOCAL:
>  	case DATE_NORMAL:
>  		blame_date_width = sizeof("Thu Oct 19 16:00:04 2006 -0700");
>  		break;
>  	}
> -	blame_date_width -= 1; /* strip the null */
> +	blame_date_width -= 1; /* strip the terminating null */

The character with byte value 0 is called NUL.

Thanks.
