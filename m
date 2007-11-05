From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] pretty=format: Avoid some expensive calculations when not needed
Date: Mon, 05 Nov 2007 11:51:15 -0800
Message-ID: <7v8x5cqxn0.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711041912190.4362@racer.site>
	<Pine.LNX.4.64.0711041915290.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 05 20:51:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip7z0-0004lw-BD
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 20:51:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467AbXKETvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 14:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbXKETvX
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 14:51:23 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:50950 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbXKETvX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 14:51:23 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id B4CAA2F9;
	Mon,  5 Nov 2007 14:51:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 2C09F92851;
	Mon,  5 Nov 2007 14:51:39 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711041915290.4362@racer.site> (Johannes
	Schindelin's message of "Sun, 4 Nov 2007 19:15:44 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63544>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Unfortunately, we cannot reuse the result of that function, which
> would be cleaner: there are more users than just git log.  Most
> notably, git-archive with "$Format:...$" substitution.

That makes sense.


> diff --git a/pretty.c b/pretty.c
> index 490cede..241e91c 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -393,6 +393,7 @@ void format_commit_message(const struct commit *commit,
>  	int i;
>  	enum { HEADER, SUBJECT, BODY } state;
>  	const char *msg = commit->buffer;
> +	char *active = interp_find_active(format, table, ARRAY_SIZE(table));
> ...
> +	if (active[IHASH])
> +		interp_set_entry(table, IHASH,
> +				sha1_to_hex(commit->object.sha1));
> +	if (active[IHASH_ABBREV])
> +		interp_set_entry(table, IHASH_ABBREV,
>  			find_unique_abbrev(commit->object.sha1,
>  				DEFAULT_ABBREV));

Instead of allocating a separate array and freeing at the end,
wouldn't it make more sense to have a bitfield that records what
is used by the format string inside the array elements?
