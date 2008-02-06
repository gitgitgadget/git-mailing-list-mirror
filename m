From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/4] Improve message-id generation flow control for
 format-patch
Date: Wed, 6 Feb 2008 17:10:30 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802061703230.13593@iabervon.org>
References: <alpine.LNX.1.00.0802061140360.13593@iabervon.org> <7vsl05vncj.fsf@gitster.siamese.dyndns.org> <20080206211326.GA9441@artemis.madism.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 23:11:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMsTw-0008S5-Vo
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 23:11:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760228AbYBFWKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 17:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760176AbYBFWKe
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 17:10:34 -0500
Received: from iabervon.org ([66.92.72.58]:55860 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760096AbYBFWKc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 17:10:32 -0500
Received: (qmail 18527 invoked by uid 1000); 6 Feb 2008 22:10:30 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Feb 2008 22:10:30 -0000
In-Reply-To: <20080206211326.GA9441@artemis.madism.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72859>

On Wed, 6 Feb 2008, Pierre Habouzit wrote:

> On Wed, Feb 06, 2008 at 08:31:08PM +0000, Junio C Hamano wrote:
> > Daniel Barkalow <barkalow@iabervon.org> writes:
> > 
> > > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> > > ---
> > >  builtin-log.c |   29 ++++++++++++++---------------
> > >  1 files changed, 14 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/builtin-log.c b/builtin-log.c
> > > index dcc9f81..1f74d66 100644
> > > --- a/builtin-log.c
> > > +++ b/builtin-log.c
> > > @@ -576,16 +576,19 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids, const cha
> > >  	o2->flags = flags2;
> > >  }
> > >  
> > > -static void gen_message_id(char *dest, unsigned int length, char *base)
> > > +static void gen_message_id(struct rev_info *info, char *base)
> > >  {
> > >  	const char *committer = git_committer_info(IDENT_WARN_ON_NO_NAME);
> > >  	const char *email_start = strrchr(committer, '<');
> > >  	const char *email_end = strrchr(committer, '>');
> > > -	if(!email_start || !email_end || email_start > email_end - 1)
> > > +	struct strbuf buf;
> > > +	if (!email_start || !email_end || email_start > email_end - 1)
> > >  		die("Could not extract email from committer identity.");
> > > -	snprintf(dest, length, "%s.%lu.git.%.*s", base,
> > > -		 (unsigned long) time(NULL),
> > > -		 (int)(email_end - email_start - 1), email_start + 1);
> > > +	strbuf_init(&buf, 0);
> > > +	strbuf_addf(&buf, "%s.%lu.git.%.*s", base,
> > > +		    (unsigned long) time(NULL),
> > > +		    (int)(email_end - email_start - 1), email_start + 1);
> > > +	info->message_id = buf.buf;
> > 
> > I wonder how the rule established by b315c5c (strbuf change: be
> > sure ->buf is never ever NULL) and at the beginning of strbuf.h
> > applies here.  I think the current implementation of strbuf
> > happens to allow this, and it is very handy.  Perhaps the rule
> > stated there should be loosened and allow copying the buf away
> > when you know you have stuff in there (i.e. ->buf != slopbuf).
> > Pierre, what do you think?
> > 
> > What the patch does itself is much nicer than the original.
> 
>   Why wouldn't you just use strbuf_detach ? I mean replacing:
> 
> +	info->message_id = buf.buf;
> 
> with:
> 
> +	info->message_id = strbuf_detach(&buf, NULL);
> 
>   isn't really hard to read, and has the nice side effect to prevent
> errors that could happen in the future (like reusing buf and screwing
> with info->message_id without noticing it). I'd rather stand on the safe
> side here, it's more forward-compatible and idiot-proof[0].

Is it actually right to have buf go out of scope right after 
strbuf_detach()? It sort of looks like it would leak memory from buf.buf. 
I'm happy to do whatever the API wants there, and I didn't see anything to 
leave the struct as if strbuf_release were called, but with the string 
extracted for the caller.

	-Daniel
*This .sig left intentionally blank*
