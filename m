From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] commit, status: use status_printf{,_ln,_more}
 helpers
Date: Sun, 27 Feb 2011 01:11:11 -0800
Message-ID: <7vaahh6dw0.fsf@alter.siamese.dyndns.org>
References: <20110226050723.GA27864@elie> <20110226051137.GE27887@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 10:11:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtcfH-0004vG-DS
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 10:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834Ab1B0JLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 04:11:31 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37003 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784Ab1B0JLX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 04:11:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 38217266C;
	Sun, 27 Feb 2011 04:12:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=19Q4hIvW7EA94oeghom469hxxjw=; b=bHLF7dS4d8YBbP7ekQiQ/gN
	Hw29dsV+0gyFIMgFJ6REru+afCniRgZhIf1qFY/+8d3rgSTcXUg4GzUeREVyqXcI
	fWQ12ikzVDW7DsZJ1U5FiMHdmZOTMg1VjjcqHdIE7T4EF4cDu3Dg7NfEpsiRT63Y
	OcWeapVNBal9yVs/2ELw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=VWUAtYySfsJD4CLNHo3worj2PLfkVJHpLt6VJknh0v/dsf93M
	rAGiYIYqc01heU904uiZj4L8DUSeKl2PO6SOaTWMl33hwzBps7DyccpswzdZ/akK
	sPzsr4YUxlt7AHuzM6QkjVTwPcmJKZZyNdAQrr71zycNEyBJlwFrG70XE4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EA0BE266B;
	Sun, 27 Feb 2011 04:12:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8C0D82669; Sun, 27 Feb 2011
 04:12:28 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B649BFC0-4251-11E0-82E2-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168014>

Jonathan Nieder <jrnieder@gmail.com> writes:

> diff --git a/builtin/commit.c b/builtin/commit.c
> index ef5f0b2..ae62a25 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -694,50 +694,51 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  	if (use_editor && include_status) {
>  		char *ai_tmp, *ci_tmp;
>  		if (in_merge)
> -...
> +			status_printf_ln(s, GIT_COLOR_NORMAL,
> +				"\n"
> +				"It looks like you may be committing a MERGE.\n"
> +				"If this is not correct, please remove the file\n"
> +				"	%s\n"
> +				"and try again.\n"
> +				"",

This trick to avoid difference-in-comma-when-updated was semi "Huh" when
reading.  Is it worth it?

> ...
>  		if (ident_shown)
> -			fprintf(s->fp, "#\n");
> +			status_printf_ln(s, GIT_COLOR_NORMAL, "");

The "attribute((format))" safety seems to bite us here...

    $ Meta/Make --pedantic builtin/commit.o
        CC builtin/commit.o
    cc1: warnings being treated as errors
    builtin/commit.c: In function 'prepare_to_commit':
    builtin/commit.c:741: error: zero-length printf format string

In wt-status.c many similar ones exist, unfortunately.
