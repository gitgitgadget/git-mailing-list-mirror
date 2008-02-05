From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RESEND] Avoid a useless prefix lookup in strbuf_expand()
Date: Mon, 04 Feb 2008 23:00:43 -0800
Message-ID: <7vtzknga5g.fsf@gitster.siamese.dyndns.org>
References: <1201950593-6119-1-git-send-email-mcostalba@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 08:01:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMHo8-0003mG-54
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 08:01:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbYBEHAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 02:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752810AbYBEHAz
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 02:00:55 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41784 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791AbYBEHAy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 02:00:54 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 252C22889;
	Tue,  5 Feb 2008 02:00:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 98A5A2888;
	Tue,  5 Feb 2008 02:00:50 -0500 (EST)
In-Reply-To: <1201950593-6119-1-git-send-email-mcostalba@gmail.com> (Marco
	Costalba's message of "Sat, 2 Feb 2008 12:09:53 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72629>

Marco Costalba <mcostalba@gmail.com> writes:

> Currently the --prett=format prefix is looked up in a
> ...
> diff --git a/pretty.c b/pretty.c
> index b987ff2..64ead65 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -282,16 +282,18 @@ static char *logmsg_reencode(const struct commit *commit,
>  	return out;
>  }
>  
> -static void format_person_part(struct strbuf *sb, char part,
> +/* returns placeholder length or 0 if placeholder is not known */
> +static size_t format_person_part(struct strbuf *sb, char part,
>                                 const char *msg, int len)
>  {
> -	int start, end, tz = 0;
> -	unsigned long date;
> +	int start, end, tz = 0, end_of_data;
> +	unsigned long date = 0;
>  	char *ep;
>  
> -	/* parse name */
> +	/* advance 'end' to point to email start delimiter */
>  	for (end = 0; end < len && msg[end] != '<'; end++)
>  		; /* do nothing */
> +

Another thing I noticed is that --pretty='format:%an %ae %at'
would end up running this function three times.  Perhaps it is
worth memoizing the result in format_commit_context while you
are at it?
