From: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
Subject: Re: [[TIG][PATCH] 1/3] Add log_select function to find commit from
 context in log view
Date: Tue, 06 Aug 2013 00:08:26 -0400
Message-ID: <20130806040826.GA14703@bluemoon.alumni.iitm.ac.in>
References: <1375489399-11618-1-git-send-email-a.kumar@alumni.iitm.ac.in>
 <1375489399-11618-2-git-send-email-a.kumar@alumni.iitm.ac.in>
 <CAFuPQ1KkUn5t54BXLTnYUcH_jY-SiSEJx3dDVzQ3FpswhFg0Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git <git@vger.kernel.org>
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Tue Aug 06 06:08:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6YZW-0003Wd-DE
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 06:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984Ab3HFEIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 00:08:30 -0400
Received: from mta4.srv.hcvlny.cv.net ([167.206.4.199]:63472 "EHLO
	mta4.srv.hcvlny.cv.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935Ab3HFEI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 00:08:29 -0400
Received: from odessa (ool-18bb429a.dyn.optonline.net [24.187.66.154])
 by mta4.srv.hcvlny.cv.net
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPA id <0MR300C5SCU3KBN0@mta4.srv.hcvlny.cv.net> for
 git@vger.kernel.org; Tue, 06 Aug 2013 00:08:28 -0400 (EDT)
Received: from kumar by odessa with local (Exim 4.80)
	(envelope-from <a.kumar@alumni.iitm.ac.in>)	id 1V6YZO-0004db-Um; Tue,
 06 Aug 2013 00:08:26 -0400
In-reply-to: <CAFuPQ1KkUn5t54BXLTnYUcH_jY-SiSEJx3dDVzQ3FpswhFg0Bw@mail.gmail.com>
Mail-followup-to: Jonas Fonseca <fonseca@diku.dk>, git <git@vger.kernel.org>
Content-disposition: inline
X-OS: Linux odessa 3.3.0-trunk-amd64 x86_64
X-Operating-System: Linux odessa 3.3.0-trunk-amd64 x86_64
X-Editor: GNU Emacs 24.3.1
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231717>

Dear Jonas,

Thanks for the patient review.
On Mon, Aug 05, 2013 at 11:27:44PM -0400, Jonas Fonseca wrote:
> On Fri, Aug 2, 2013 at 8:23 PM, Kumar Appaiah <a.kumar@alumni.iitm.ac.in> wrote:
> > This commit introduces and uses the log_select function to find the
> > correct commit in the unsplit log view. In the log view, if one
> > scrolls down across a commit line, the current commit (as displayed in
> > the status bar) gets updated, but not so when scrolling upward across
> > a commit. The log_select function handles this scenario to to the
> 
> s/to to/to do/

Done.

> > ``right thing''. In addition, it introduces the log_state structure as
> > the private entry of the log view to hold a flag that decides whether
> > to re-evaluate the current commit based on scrolling.
> >
> > Signed-off-by: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
> > ---
> >  tig.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 48 insertions(+), 2 deletions(-)
> >
> > diff --git a/tig.c b/tig.c
> > index 72f132a..dd4b0f4 100644
> > --- a/tig.c
> > +++ b/tig.c
> > @@ -4384,6 +4384,33 @@ pager_select(struct view *view, struct line *line)
> >         }
> >  }
> >
> > +struct log_state {
> > +       bool update_commit_ref;
> > +};
> > +
> > +static void
> > +log_select(struct view *view, struct line *line)
> > +{
> > +       struct log_state *state = (struct log_state *) view->private;
> > +
> > +       if (state->update_commit_ref && line->lineno > 1) {
> > +               /* We need to recalculate the previous commit,
> > +                  since the user has likely scrolled up. */
> 
> I'd prefer that state->update_commit_ref is given another name so it
> won't be necessary to have these comments everywhere the field is
> used, for example recalculate_commit_context. The comment could be
> moved to the declaration in struct log_state to explain its use.

Done.

> Multi-line comments should start with '*' for each additonal line, e.g.
> 
>   /* bla bla
>    * bla bla */

Done.

> > +               const struct line *commit_line = find_prev_line_by_type(view, line, LINE_COMMIT);
> > +
> > +               if (commit_line)
> > +                       string_copy_rev(view->ref, (char *) (commit_line->data + STRING_SIZE("commit ")));
> 
> You mentioned elsewhere that this looked funny, and I guess you are
> right. I will extract this into a utility method so you can simply
> call: string_copy_rev_from_line(view->ref, commit_line); ...

I will wait on this. The next iteration of the patch will still have
this problem.

> > +       }
> > +       if (line->type == LINE_COMMIT) {
> > +               char *text = (char *)line->data + STRING_SIZE("commit ");
> > +
> > +               if (!view_has_flags(view, VIEW_NO_REF))
> > +                       string_copy_rev(view->ref, text);
> 
> ... and: string_copy_rev_from_line(view->ref, line);

I understand.

> > +       }
> > +       string_copy_rev(ref_commit, view->ref);
> > +       state->update_commit_ref = FALSE;
> > +}
> > +
> >  static bool
> >  pager_open(struct view *view, enum open_flags flags)
> >  {
> > @@ -4427,11 +4454,30 @@ log_open(struct view *view, enum open_flags flags)
> >  static enum request
> >  log_request(struct view *view, enum request request, struct line *line)
> >  {
> > +       struct log_state *state = (struct log_state *) view->private;
> 
> There's no need to cast view->private here.

Done.

> > +
> >         switch (request) {
> >         case REQ_REFRESH:
> >                 load_refs();
> >                 refresh_view(view);
> >                 return REQ_NONE;
> > +
> > +       case REQ_MOVE_UP:
> > +       case REQ_PREVIOUS:
> > +               if (line->type == LINE_COMMIT && line->lineno > 1) {
> > +                       /* We are at a commit, and heading upward. We
> > +                          force log_select to find the previous
> > +                          commit above, from the context. */
> 
> Please delete this comment.

Done.

> > +                       state->update_commit_ref = TRUE;
> > +               }
> > +               return pager_request(view, request, line);
> 
> There's not really any reason to call pager_request here, since it
> only handles REQ_ENTER.

Done.

> > +
> > +       case REQ_MOVE_PAGE_UP:
> > +       case REQ_MOVE_PAGE_DOWN:
> > +               /* We need to figure out the right commit again. */
> 
> Please delete this this comment.

Done.

> > +               state->update_commit_ref = TRUE;
> > +               return pager_request(view, request, line);
> 
> Calling pager_request again.

Done.

I will send in another patch to review shortly.

Thanks!

Kumar
-- 
Kumar Appaiah
