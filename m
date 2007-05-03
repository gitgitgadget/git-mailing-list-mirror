From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Make xstrndup common
Date: Thu, 3 May 2007 01:02:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705030100050.28708@iabervon.org>
References: <Pine.LNX.4.64.0705022248040.28708@iabervon.org>
 <7vzm4m35xm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 03 07:02:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjTSV-0002UH-Em
	for gcvg-git@gmane.org; Thu, 03 May 2007 07:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767383AbXECFCY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 01:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767387AbXECFCY
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 01:02:24 -0400
Received: from iabervon.org ([66.92.72.58]:2044 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767383AbXECFCX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 01:02:23 -0400
Received: (qmail 8496 invoked by uid 1000); 3 May 2007 05:02:22 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 May 2007 05:02:22 -0000
In-Reply-To: <7vzm4m35xm.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46062>

On Wed, 2 May 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > This also improves the implementation to match how strndup is
> > specified (by GNU): if the length given is longer than the string,
> > only the string's length is allocated and copied, but the string need
> > not be null-terminated if it is at least as long as the given length.
> >
> > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> > ---
> > Haven't got the rest of my series updated for comments, but I'd like to 
> > get this change, which is logically unrelated aside from being a 
> > dependancy, in now.
> >
> >  commit.c          |    8 --------
> >  git-compat-util.h |   12 ++++++++++++
> >  2 files changed, 12 insertions(+), 8 deletions(-)
> >
> > diff --git a/commit.c b/commit.c
> > index f1ba972..aa7059c 100644
> > --- a/commit.c
> > +++ b/commit.c
> > @@ -718,14 +718,6 @@ static char *logmsg_reencode(const struct commit *commit,
> >  	return out;
> >  }
> >  
> > -static char *xstrndup(const char *text, int len)
> > -{
> > -	char *result = xmalloc(len + 1);
> > -	memcpy(result, text, len);
> > -	result[len] = '\0';
> > -	return result;
> > -}
> > -
> >  static void fill_person(struct interp *table, const char *msg, int len)
> >  {
> >  	int start, end, tz = 0;
> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index 2c84016..0dcd4e2 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -197,6 +197,18 @@ static inline void *xmalloc(size_t size)
> >  	return ret;
> >  }
> >  
> > +static inline char *xstrndup(const char *str, int len)
> > +{
> > +	char *ret;
> > +	int i;
> > +	for (i = 0; i < len && str[i]; i++)
> > +		;
> > +	ret = xmalloc(i + 1);
> > +	strncpy(ret, str, i);
> 
> Why strncpy() not memcpy()?

Left over from my previous attempt. memcpy() is better with the length 
check.

	-Daniel
*This .sig left intentionally blank*
