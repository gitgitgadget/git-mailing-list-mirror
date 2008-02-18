From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/4] Improve message-id generation flow control for
 format-patch
Date: Mon, 18 Feb 2008 12:41:10 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802181238280.30505@racer.site>
References: <alpine.LNX.1.00.0802171335240.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Feb 18 13:42:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR5Jm-0006bl-G4
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 13:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758801AbYBRMlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 07:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758786AbYBRMlX
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 07:41:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:39284 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758672AbYBRMlX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 07:41:23 -0500
Received: (qmail invoked by alias); 18 Feb 2008 12:41:21 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp016) with SMTP; 18 Feb 2008 13:41:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+XbhoXRHqXFuIjUUHV5aEEi0anEubWFgnUairQ/s
	bd0Hi35/9DvNai
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802171335240.5816@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74276>

Hi,

On Sun, 17 Feb 2008, Daniel Barkalow wrote:

> diff --git a/builtin-log.c b/builtin-log.c
> index 99d69f0..867cc13 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -575,16 +575,19 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids, const cha
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
> +	info->message_id = strbuf_detach(&buf, NULL);

With this last line, and...

> @@ -809,15 +810,13 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		rev.nr = total - nr + (start_number - 1);
>  		/* Make the second and subsequent mails replies to the first */
>  		if (thread) {
> -			if (nr == (total - 2)) {
> -				strncpy(ref_message_id, message_id,
> -					sizeof(ref_message_id));
> -				ref_message_id[sizeof(ref_message_id)-1]='\0';
> -				rev.ref_message_id = ref_message_id;
> +			if (rev.message_id) {
> +				if (rev.ref_message_id)
> +					free((char *) rev.message_id);

... this one, you should make the message_id member of struct rev_info a 
"char *".  At least for this developer, "const char *" is a sign that the 
caller should clean up, and that the pointer _might_ point to a constant.

Ciao,
Dscho
