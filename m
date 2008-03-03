From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH, fixed] builtin-clone: create remotes/origin/HEAD symref,
 if guessed
Date: Mon, 3 Mar 2008 17:10:52 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803031709150.22527@racer.site>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org>  <200802260321.14038.johan@herland.net>  <alpine.LNX.1.00.0802261128360.19024@iabervon.org>  <alpine.LSU.1.00.0803020556380.22527@racer.site>  <alpine.LSU.1.00.0803020622190.22527@racer.site>
 <1204563913.4084.3.camel@gaara.boston.redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-1636564381-1204564254=:22527"
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: =?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 18:13:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWEDY-0001q4-16
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 18:12:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757935AbYCCRLl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 12:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757910AbYCCRLk
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 12:11:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:35157 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757827AbYCCRLi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 12:11:38 -0500
Received: (qmail invoked by alias); 03 Mar 2008 17:11:37 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp038) with SMTP; 03 Mar 2008 18:11:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18507kGfJw57yDX/YehfkWprz3kD7VJpRpG8buuiN
	OQYOXxO8JQn5uP
X-X-Sender: gene099@racer.site
In-Reply-To: <1204563913.4084.3.camel@gaara.boston.redhat.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75950>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-1636564381-1204564254=:22527
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 3 Mar 2008, Kristian Høgsberg wrote:

> On Sun, 2008-03-02 at 06:25 +0000, Johannes Schindelin wrote:
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > 
> > 	Sorry, my previous patch was broken in so many ways.  This one
> > 	is better, promise.
> > 
> > 	BTW this incidentally fixes the branch.<branch>.{remote,merge} 
> > 	setup: it used to strip all up-to and including a slash from the 
> > 	ref name.  This just _happened_ to work, because commonly HEAD is 
> > 	at "refs/heads/master".  However, if it is at "refs/heads/a/b", it 
> > 	would fail.
> > 
> >  builtin-clone.c |   35 ++++++++++++++++++++---------------
> >  1 files changed, 20 insertions(+), 15 deletions(-)
> > 
> > diff --git a/builtin-clone.c b/builtin-clone.c
> > index 056e8a3..f27d205 100644
> > --- a/builtin-clone.c
> > +++ b/builtin-clone.c
> > @@ -523,33 +523,38 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
> >  		git_config_set_multivar(key, value, "^$", 0);
> >  	}
> >  
> > +	if (head_points_at)
> > +		/* Local default branch */
> > +		create_symref("HEAD", head_points_at->name, NULL);
> > +
> >  	if (option_bare) {
> > -		if (head_points_at) {
> > -			/* Local default branch */
> > -			create_symref("HEAD", head_points_at->name, NULL);
> > -		}
> >  		junk_work_tree = NULL;
> >  		junk_git_dir = NULL;
> >  		return 0;
> >  	}
> >  
> >  	if (head_points_at) {
> > -		if (strrchr(head_points_at->name, '/'))
> > -			head = strrchr(head_points_at->name, '/') + 1;
> > -		else
> > -			head = head_points_at->name;
> > +		struct strbuf head_ref, real_ref;
> >  
> > -		/* Local default branch */
> > -		create_symref("HEAD", head_points_at->name, NULL);
> > +		head = head_points_at->name;
> > +		if (!prefixcmp(head, "refs/heads/"))
> > +			head += 11;
> >  
> >  		/* Tracking branch for the primary branch at the remote. */
> >  		update_ref(NULL, "HEAD", head_points_at->old_sha1,
> >  			   NULL, 0, DIE_ON_ERR);
> > -	/*
> > -		rm -f "refs/remotes/$origin/HEAD"
> > -		git symbolic-ref "refs/remotes/$origin/HEAD" \
> > -			"refs/remotes/$origin/$head_points_at" &&
> > -	*/
> > +
> > +		strbuf_init(&head_ref, 0);
> > +		strbuf_addstr(&head_ref, branch_top);
> > +		strbuf_addstr(&head_ref, "/HEAD");
> > +		delete_ref(head_ref.buf, head_points_at->old_sha1);
> > +		strbuf_init(&real_ref, 0);
> > +		strbuf_addstr(&real_ref, branch_top);
> > +		strbuf_addch(&real_ref, '/');
> > +		strbuf_addstr(&real_ref, head);
> 
> What about just using
> 
>   strbuf_addf(&real_ref, "%s/%s", branch_top, head);
> 
> Are you worried about performance? :-p

You know, just after sending, I thought the same.

> Oh and I'm wondering if
> 
>   strbuf_initf(&real_ref,﻿ "%s/%s", branch_top, head);
> 
> would be a worthwhile addition to the strbuf API...

And exactly this was crossing my mind, too, as

static inline int strbuf_initf(struct strbuf *buf, const char *format, ...)
{
	strbuf_init(buf, strlen(format));
	return strbuf_addf(format, ...);
}

(just a sketch, but you get the idea...)

Ciao,
Dscho

---1463811741-1636564381-1204564254=:22527--
