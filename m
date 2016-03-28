From: Kazuki Yamaguchi <k@rhe.jp>
Subject: Re: [PATCH v2 5/5] branch -d: refuse deleting a branch which is
 currently checked out
Date: Mon, 28 Mar 2016 16:16:14 +0900
Message-ID: <20160328071614.GA27034@chikuwa.rhe.jp>
References: <1458553816-29091-1-git-send-email-k@rhe.jp>
 <cover.1458927521.git.k@rhe.jp>
 <cbc5116e5069f20545d66e12e082e0e17f4ecced.1458927521.git.k@rhe.jp>
 <CAPig+cSCC+OzotkTx89iS+t4DRd3F+QoHP4n-v_+rxXU2R+2LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 09:16:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akRPW-0002Sn-8Z
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 09:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081AbcC1HQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 03:16:20 -0400
Received: from 116.58.164.79.static.zoot.jp ([116.58.164.79]:52672 "EHLO
	walnut.rhe.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752831AbcC1HQT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 03:16:19 -0400
Received: from chikuwa.rhe.jp (unknown [10.0.1.1])
	by walnut.rhe.jp (Postfix) with ESMTPSA id C28C65BB14;
	Mon, 28 Mar 2016 07:16:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAPig+cSCC+OzotkTx89iS+t4DRd3F+QoHP4n-v_+rxXU2R+2LA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290026>

On Sun, Mar 27, 2016 at 01:52:18PM -0400, Eric Sunshine wrote:
> On Fri, Mar 25, 2016 at 2:28 PM, Kazuki Yamaguchi <k@rhe.jp> wrote:
> > When a branch is checked out by current working tree, deleting the
> > branch is forbidden. However when the branch is checked out only by
> > other working trees, deleting is allowed.
> > Use find_shared_symref() to check if the branch is in use, not just
> > comparing with the current working tree's HEAD.
> >
> > Signed-off-by: Kazuki Yamaguchi <k@rhe.jp>
> > ---
> > diff --git a/builtin/branch.c b/builtin/branch.c
> > @@ -215,16 +216,17 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
> >                 int flags = 0;
> >
> >                 strbuf_branchname(&bname, argv[i]);
> > -               if (kinds == FILTER_REFS_BRANCHES && !strcmp(head, bname.buf)) {
> > +               free(name);
> > +               name = mkpathdup(fmt, bname.buf);
> > +
> > +               if (kinds == FILTER_REFS_BRANCHES &&
> > +                   find_shared_symref("HEAD", name)) {
> >                         error(_("Cannot delete the branch '%s' "
> > -                             "which you are currently on."), bname.buf);
> > +                             "which is currently checked out."), bname.buf);
> 
> Would it be possible to do a better job of letting the user know what
> went wrong by stating in which worktree(s) the branch is checked out?
> My concern is that someone seeing this message might respond "huh? I
> have 'master' checked out, so why is this telling me that 'foo' is
> checked out", and not realize that 'foo' is in fact checked out in a
> different worktree.

Yes, indeed. I'll do it. Thanks.
