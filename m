From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/6] builtin-commit: resurrect behavior for multiple -m
  options
Date: Sun, 11 Nov 2007 20:42:48 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711112039130.4362@racer.site>
References: <Pine.LNX.4.64.0711111730580.4362@racer.site>
 <Pine.LNX.4.64.0711111736310.4362@racer.site> <20071111194228.GC13200@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Nov 11 21:43:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrJeR-0000Zf-BI
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 21:43:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757508AbXKKUnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 15:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757360AbXKKUnF
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 15:43:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:46455 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756042AbXKKUnC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 15:43:02 -0500
Received: (qmail invoked by alias); 11 Nov 2007 20:43:00 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp056) with SMTP; 11 Nov 2007 21:43:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+PaHh6Q1CPINxkgIkzD6QUl9rqVbC91iIOJQXYVB
	+Xf6LGNf1Y2oB6
X-X-Sender: gene099@racer.site
In-Reply-To: <20071111194228.GC13200@artemis.corp>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64510>

Hi,

On Sun, 11 Nov 2007, Pierre Habouzit wrote:

> On Sun, Nov 11, 2007 at 05:36:39PM +0000, Johannes Schindelin wrote:
> > 
> > When more than one -m option is given, the message does not replace
> > the previous, but is appended.
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin-commit.c |   26 ++++++++++++++++++++------
> >  1 files changed, 20 insertions(+), 6 deletions(-)
> > 
> > diff --git a/builtin-commit.c b/builtin-commit.c
> > index 66d7e5e..069d180 100644
> > --- a/builtin-commit.c
> > +++ b/builtin-commit.c
> > @@ -30,13 +30,27 @@ static char *use_message_buffer;
> >  static const char commit_editmsg[] = "COMMIT_EDITMSG";
> >  static struct lock_file lock_file;
> >  
> > -static char *logfile, *force_author, *message, *template_file;
> > +static char *logfile, *force_author, *template_file;
> >  static char *edit_message, *use_message;
> >  static int all, edit_flag, also, interactive, only, amend, signoff;
> >  static int quiet, verbose, untracked_files, no_verify;
> >  
> >  static int no_edit, initial_commit, in_merge;
> >  const char *only_include_assumed;
> > +struct strbuf message;
> 
>   Unless I'm mistaken `static` keywords are missign for`message` and
> `only_include_assumed`.

Oh yeah.  Will fix.

>   And you _have_ to initialize message with STRBUF_INIT (remember of the
> slop).

Not in this case, since I do not use message.buf as long as message.len == 
0.  But I agree it would be cleaner to just use STRBUF_INIT.

> > +static int opt_parse_m(const struct option *opt, const char *arg, int unset)
> > +{
> > +	struct strbuf *buf = opt->value;
> > +	if (unset)
> > +		strbuf_setlen(buf, 0);
> > +	else {
> > +		strbuf_addstr(buf, arg);
> > +		strbuf_addch(buf, '\n');
> > +		strbuf_addch(buf, '\n');
> > +	}
> > +	return 0;
> > +}
> 
>   I believe such a callback could live in parse-options.[hc]. The need
> to aggregate all string arguments into a strbuf looks generic enough to
> me. Why are you adding two '\n' btw ? Isn't one enough ?

Well, this empty line is needed to stay backwards compatible.  It was 
added to pass the test that Junio added to 'next'.  As such, this function 
is not really generic enough, right?

>   Oh and last nitpicking, strbuf_addstr(buf, "\n\n"); is more efficient
> than the two addchar (the strlen it generates is inlined).

Well, I meant to mention it in the cover letter.  My preference is to do 
away with the extra empty line.  But this might break existing setups 
depending on that behaviour.

Ciao,
Dscho
