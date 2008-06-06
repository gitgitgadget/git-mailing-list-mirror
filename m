From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: [PATCH] This patch is to allow 12 different OS's to compile and
 run git.
Date: Fri, 6 Jun 2008 17:23:37 -0600
Message-ID: <Pine.LNX.4.64.0806061718420.18454@xenau.zenez.com>
References: <Pine.LNX.4.64.0806061330180.18454@xenau.zenez.com>
 <87bq2ez72u.fsf@jeremyms.com> <Pine.LNX.4.64.0806061359080.18454@xenau.zenez.com>
 <7vmylyrwkg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Harning <harningt@gmail.com>,
	Jeremy Maitin-Shepard <jbms@cmu.edu>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 01:24:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4lIR-0001Qo-9Z
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 01:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757797AbYFFXXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 19:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757942AbYFFXXi
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 19:23:38 -0400
Received: from zenez.com ([166.70.62.2]:28867 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757709AbYFFXXi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 19:23:38 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id 4FB3DE5124; Fri,  6 Jun 2008 17:23:37 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id 4284CE5123;
	Fri,  6 Jun 2008 17:23:37 -0600 (MDT)
In-Reply-To: <7vmylyrwkg.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84141>

On Fri, 6 Jun 2008, Junio C Hamano wrote:
> Boyd Lynn Gerber <gerberb@zenez.com> writes:
> > diff --git a/progress.c b/progress.c
> > index d19f80c..295c4e3 100644
> > --- a/progress.c
> > +++ b/progress.c
> > @@ -241,7 +241,8 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
> >  	*p_progress = NULL;
> >  	if (progress->last_value != -1) {
> >  		/* Force the last update */
> > -		char buf[strlen(msg) + 5];
> > +		/* char buf[strlen(msg) + 5]; */
> > +		char *buf = alloca (strlen(msg) + 5 );
> >  		struct throughput *tp = progress->throughput;
> >  		if (tp) {
> >  			unsigned int rate = !tp->avg_misecs ? 0 :
> 
> I do not know the situation over there these days, but I have a distant
> but bitter memory of having to deal with AIX X-<.  It insisted that
> inclusion of <alloca.h> to be the very first thing in the source before
> anything else.  I would want to keep alloca() out of the codebase without
> very good reason.  Not that I care much about portability to AIX, but not
> having to worry about alloca() unless necessary is a good thing.

You hit the nail on the head, AIX and any Novell derived Compiler code 
requires it.  Also the SCO OS's
 
> I do not think progress_msg() is a good reason to even worrying about a
> dynamically sized array.  The function is designed to spit out a single
> line of message (so the incoming msg is expected to be shorter than 80
> chars or so).  If you "git grep stop_progress_msg", you will see that
> there are only two callers of this function, one in progress.c itself that
> says "done", and the other one in index-pack.c that gives a string
> formatted into 48-byte buffer.
> 
> So we can be lazy and say:
> 
> 	char buf[128];
>         ...
>         snprintf(buf, sizeof(buf), ", %s.\n", msg)
> 
> and be done with it.

I like the idea.

> If you really wanted to be safe and anal, you could do something like
> this, which would be just as efficient and much more straightforward:
> 
>  progress.c |   11 ++++++++---
>  1 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/progress.c b/progress.c
> index d19f80c..55a8687 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -241,16 +241,21 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
>  	*p_progress = NULL;
>  	if (progress->last_value != -1) {
>  		/* Force the last update */
> -		char buf[strlen(msg) + 5];
> +		char buf[128], *bufp;
> +		size_t len = strlen(msg) + 5;
>  		struct throughput *tp = progress->throughput;
> +
> +		bufp = (len < sizeof(buf)) ? buf : xmalloc(len + 1);
>  		if (tp) {
>  			unsigned int rate = !tp->avg_misecs ? 0 :
>  					tp->avg_bytes / tp->avg_misecs;
>  			throughput_string(tp, tp->curr_total, rate);
>  		}
>  		progress_update = 1;
> -		sprintf(buf, ", %s.\n", msg);
> -		display(progress, progress->last_value, buf);
> +		sprintf(bufp, ", %s.\n", msg);
> +		display(progress, progress->last_value, bufp);
> +		if (buf != bufp)
> +			free(bufp);
>  	}
>  	clear_progress_signal();
>  	free(progress->throughput);
> 
> 

Thanks for the suggestions.  I am making changes based on all the feed 
back.  I will remove all the debug junk from the final patch.  I am 
putting options in and out a lot at the moment.  Trying to make sure I do 
not break anything on the 12 OS's.  It is a real pain testing all the 
changes on them to make sure I did not break anything.

Thanks,

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
