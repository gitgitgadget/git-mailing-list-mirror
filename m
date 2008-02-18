From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/4] Improve message-id generation flow control for
 format-patch
Date: Mon, 18 Feb 2008 12:43:09 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802181229340.5816@iabervon.org>
References: <alpine.LNX.1.00.0802171335240.5816@iabervon.org> <alpine.LSU.1.00.0802181238280.30505@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 18 18:43:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRA1w-00083A-PN
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 18:43:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbYBRRnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 12:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbYBRRnS
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 12:43:18 -0500
Received: from iabervon.org ([66.92.72.58]:55510 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751473AbYBRRnR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 12:43:17 -0500
Received: (qmail 23275 invoked by uid 1000); 18 Feb 2008 17:43:09 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Feb 2008 17:43:09 -0000
In-Reply-To: <alpine.LSU.1.00.0802181238280.30505@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74320>

On Mon, 18 Feb 2008, Johannes Schindelin wrote:

> Hi,
> 
> On Sun, 17 Feb 2008, Daniel Barkalow wrote:
> 
> > diff --git a/builtin-log.c b/builtin-log.c
> > index 99d69f0..867cc13 100644
> > --- a/builtin-log.c
> > +++ b/builtin-log.c
> > @@ -575,16 +575,19 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids, const cha
> >  	o2->flags = flags2;
> >  }
> >  
> > -static void gen_message_id(char *dest, unsigned int length, char *base)
> > +static void gen_message_id(struct rev_info *info, char *base)
> >  {
> >  	const char *committer = git_committer_info(IDENT_WARN_ON_NO_NAME);
> >  	const char *email_start = strrchr(committer, '<');
> >  	const char *email_end = strrchr(committer, '>');
> > -	if(!email_start || !email_end || email_start > email_end - 1)
> > +	struct strbuf buf;
> > +	if (!email_start || !email_end || email_start > email_end - 1)
> >  		die("Could not extract email from committer identity.");
> > -	snprintf(dest, length, "%s.%lu.git.%.*s", base,
> > -		 (unsigned long) time(NULL),
> > -		 (int)(email_end - email_start - 1), email_start + 1);
> > +	strbuf_init(&buf, 0);
> > +	strbuf_addf(&buf, "%s.%lu.git.%.*s", base,
> > +		    (unsigned long) time(NULL),
> > +		    (int)(email_end - email_start - 1), email_start + 1);
> > +	info->message_id = strbuf_detach(&buf, NULL);
> 
> With this last line, and...
> 
> > @@ -809,15 +810,13 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
> >  		rev.nr = total - nr + (start_number - 1);
> >  		/* Make the second and subsequent mails replies to the first */
> >  		if (thread) {
> > -			if (nr == (total - 2)) {
> > -				strncpy(ref_message_id, message_id,
> > -					sizeof(ref_message_id));
> > -				ref_message_id[sizeof(ref_message_id)-1]='\0';
> > -				rev.ref_message_id = ref_message_id;
> > +			if (rev.message_id) {
> > +				if (rev.ref_message_id)
> > +					free((char *) rev.message_id);
> 
> ... this one, you should make the message_id member of struct rev_info a 
> "char *".  At least for this developer, "const char *" is a sign that the 
> caller should clean up, and that the pointer _might_ point to a constant.

It's sort of like that, in that this *is* the caller, and it's using 
gen_message_id to set it and cleaning it up, and it could put in a 
constant (in which case it would have to know this and not free it), but I 
agree that it's more suggestive of the right things as a "char *".

	-Daniel
*This .sig left intentionally blank*
