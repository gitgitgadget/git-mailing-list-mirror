From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] branch: optionally setup branch.*.merge from upstream
 local branches
Date: Tue, 19 Feb 2008 10:55:21 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802191054070.30505@racer.site>
References: <1203386832-43969-1-git-send-email-jaysoffian@gmail.com> <76718490802181819o4cf742edi92bbcd9039f0cdac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 11:56:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRQ8z-0005ov-IW
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 11:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbYBSKzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 05:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752468AbYBSKzh
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 05:55:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:56037 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752156AbYBSKzg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 05:55:36 -0500
Received: (qmail invoked by alias); 19 Feb 2008 10:55:34 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp043) with SMTP; 19 Feb 2008 11:55:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX196Cc8jPX56LRHkY7RTWevhUKJpHIFf9tWDuARn0z
	MV/ec988P4/Rp9
X-X-Sender: gene099@racer.site
In-Reply-To: <76718490802181819o4cf742edi92bbcd9039f0cdac@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74392>

Hi,

On Mon, 18 Feb 2008, Jay Soffian wrote:

> On Feb 18, 2008 9:07 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> > diff --git a/branch.c b/branch.c
> > index 1fc8788..9d7585e 100644
> > --- a/branch.c
> > +++ b/branch.c
> > @@ -37,7 +37,8 @@ static int find_tracked_branch(struct remote *remote, void *priv)
> >   * to infer the settings for branch.<new_ref>.{remote,merge} from the
> >   * config.
> >   */
> > -static int setup_tracking(const char *new_ref, const char *orig_ref)
> > +static int setup_tracking(const char *new_ref, const char *orig_ref,
> > +                          enum branch_track track)
> >  {
> >         char key[1024];
> >         struct tracking tracking;
> > @@ -48,10 +49,14 @@ static int setup_tracking(const char *new_ref, const char *orig_ref)
> >
> >         memset(&tracking, 0, sizeof(tracking));
> >         tracking.spec.dst = (char *)orig_ref;
> > -       if (for_each_remote(find_tracked_branch, &tracking) ||
> > -                       !tracking.matches)
> > +       if (for_each_remote(find_tracked_branch, &tracking))
> >                 return 1;
> >
> > +       if (!tracking.matches && track == BRANCH_TRACK_ALWAYS) {
> > +               tracking.matches = 1;
> > +               tracking.src = xstrdup(orig_ref);
> > +       }
> > +
> 
> Well that's obviously wrong (though it causes no problems, setup_tracking()
> would return 0 when it should return 1, but its return value is currently
> ignored). I changed it to:
> 
> 	if (!tracking.matches) {
> 		if (track != BRANCH_TRACK_ALWAYS)
> 			return 1;
> 		tracking.matches = 1;
> 		tracking.src = xstrdup(orig_ref);
> 	}

Ah, yes.  But I still maintain that xstrdup()ing orig_ref only to free it 
later is ugly.  Why not have the "tracking.src ? tracking.src : orig_ref" 
as I suggested?  The free() obviously can stay, since it will say 
"free(NULL)" in the case of tracking.matches == 0.

Ciao,
Dscho
