From: Kazuki Yamaguchi <k@rhe.jp>
Subject: Re: [PATCH] branch: update all per-worktree HEADs when renaming a
 branch
Date: Fri, 25 Mar 2016 20:56:14 +0900
Message-ID: <20160325115614.GA21341@chikuwa.rhe.jp>
References: <1458553816-29091-1-git-send-email-k@rhe.jp>
 <CAPig+cRQj4td82DuqL0tD=3znLAmT4nBrfOjK3phqM7iomQseA@mail.gmail.com>
 <CACsJy8BKBiYTsp5wv9ynr++p2TE-dzS9J+DkOPEKumCL-reLVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 12:56:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajQLm-0006sr-QH
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 12:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171AbcCYL4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 07:56:18 -0400
Received: from 116.58.164.79.static.zoot.jp ([116.58.164.79]:52756 "EHLO
	walnut.rhe.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399AbcCYL4S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 07:56:18 -0400
Received: from chikuwa.rhe.jp (unknown [10.0.1.1])
	by walnut.rhe.jp (Postfix) with ESMTPSA id 946B45AACF;
	Fri, 25 Mar 2016 11:56:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CACsJy8BKBiYTsp5wv9ynr++p2TE-dzS9J+DkOPEKumCL-reLVw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289882>

On Tue, Mar 22, 2016 at 07:49:00AM +0700, Duy Nguyen wrote:
> On Tue, Mar 22, 2016 at 12:41 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> >> diff --git a/worktree.c b/worktree.c
> >> @@ -217,3 +217,41 @@ char *find_shared_symref(const char *symref, const char *target)
> >> +int update_worktrees_head_symref(const char *oldref, const char *newref)
> >> +{
> >> +       int error = 0;
> >> +       struct strbuf path = STRBUF_INIT;
> >> +       struct strbuf origref = STRBUF_INIT;
> >> +       int i;
> >> +       struct worktree **worktrees = get_worktrees();
> >> +
> >> +       for (i = 0; worktrees[i]; i++) {
> >> +               if (worktrees[i]->is_detached)
> >> +                       continue;
> >> +
> >> +               strbuf_reset(&path);
> >> +               strbuf_reset(&origref);
> >> +               strbuf_addf(&path, "%s/HEAD", worktrees[i]->git_dir);
> >> +
> >> +               if (parse_ref(path.buf, &origref, NULL))
> >> +                       continue;
> >> +
> >> +               if (!strcmp(origref.buf, oldref)) {
> >> +                       int prefix_len = strlen(absolute_path(get_git_common_dir())) + 1;
> >> +                       const char *symref = path.buf + prefix_len;
> >> +
> >> +                       /* no need to pass logmsg here as HEAD didn't really move */
> >> +                       if (create_symref(symref, newref, NULL)) {
> >> +                               error = -1;
> >> +                               break;
> >
> > Is aborting upon the first error desired behavior? (Genuine question.)
> > Would it make more sense to continue attempting the rename for the
> > remaining worktrees (and remember that an error was encountered)?
> 
> Since all these HEADs stay at the same (or close) location, if one
> fails, I think the rest will fail too. Which leads to a series of
> warnings if we continue anyway. A more interesting approach is update
> HEADs in a transaction, so we successfully update all or we update
> none. But I do not know if ref transactions can be used for HEAD,
> especially worktree HEADs. I'm ok with either abort here or continue
> anyway, though.
> -- 
> Duy

Thanks for suggestion, but it looks like ref_transaction can be used
only for updating non-symbolic references. Extending it only for this
purpose seems too much...
