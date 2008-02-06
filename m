From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Improve message-id generation flow control for format-patch
Date: Wed, 06 Feb 2008 12:31:08 -0800
Message-ID: <7vsl05vncj.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802061140360.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 21:32:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMqwI-0003by-KZ
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 21:32:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756448AbYBFUbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 15:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756477AbYBFUbW
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 15:31:22 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34105 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756448AbYBFUbV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 15:31:21 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 87C372E59;
	Wed,  6 Feb 2008 15:31:20 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A98E22E57;
	Wed,  6 Feb 2008 15:31:15 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72846>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
>  builtin-log.c |   29 ++++++++++++++---------------
>  1 files changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/builtin-log.c b/builtin-log.c
> index dcc9f81..1f74d66 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -576,16 +576,19 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids, const cha
>  	o2->flags = flags2;
>  }
>  
> -static void gen_message_id(char *dest, unsigned int length, char *base)
> +static void gen_message_id(struct rev_info *info, char *base)
>  {
>  	const char *committer = git_committer_info(IDENT_WARN_ON_NO_NAME);
>  	const char *email_start = strrchr(committer, '<');
>  	const char *email_end = strrchr(committer, '>');
> -	if(!email_start || !email_end || email_start > email_end - 1)
> +	struct strbuf buf;
> +	if (!email_start || !email_end || email_start > email_end - 1)
>  		die("Could not extract email from committer identity.");
> -	snprintf(dest, length, "%s.%lu.git.%.*s", base,
> -		 (unsigned long) time(NULL),
> -		 (int)(email_end - email_start - 1), email_start + 1);
> +	strbuf_init(&buf, 0);
> +	strbuf_addf(&buf, "%s.%lu.git.%.*s", base,
> +		    (unsigned long) time(NULL),
> +		    (int)(email_end - email_start - 1), email_start + 1);
> +	info->message_id = buf.buf;

I wonder how the rule established by b315c5c (strbuf change: be
sure ->buf is never ever NULL) and at the beginning of strbuf.h
applies here.  I think the current implementation of strbuf
happens to allow this, and it is very handy.  Perhaps the rule
stated there should be loosened and allow copying the buf away
when you know you have stuff in there (i.e. ->buf != slopbuf).
Pierre, what do you think?

What the patch does itself is much nicer than the original.
