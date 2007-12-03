From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/2] Allow callers of unpack_trees() to handle failure
Date: Mon, 3 Dec 2007 01:31:20 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0712030126390.5349@iabervon.org>
References: <Pine.LNX.4.64.0712030032400.5349@iabervon.org>
 <7v63zgqorw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 07:31:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz4qF-0001nL-4r
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 07:31:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbXLCGbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 01:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbXLCGbW
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 01:31:22 -0500
Received: from iabervon.org ([66.92.72.58]:45033 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751070AbXLCGbW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 01:31:22 -0500
Received: (qmail 24266 invoked by uid 1000); 3 Dec 2007 06:31:20 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Dec 2007 06:31:20 -0000
In-Reply-To: <7v63zgqorw.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66875>

On Sun, 2 Dec 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > Return an error from unpack_trees() instead of calling die(), and exit
> > with an error in read-tree. The merge function can return negative to
> > abort.
> >
> > This will be used in builtin-checkout -m.
> >
> > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> > ---
> >  builtin-read-tree.c |    3 +-
> >  unpack-trees.c      |   85 ++++++++++++++++++++++++++++----------------------
> >  2 files changed, 50 insertions(+), 38 deletions(-)
> >
> > diff --git a/builtin-read-tree.c b/builtin-read-tree.c
> > index 43cd56a..4f680c3 100644
> > --- a/builtin-read-tree.c
> > +++ b/builtin-read-tree.c
> > @@ -269,7 +269,8 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
> >  		parse_tree(tree);
> >  		init_tree_desc(t+i, tree->buffer, tree->size);
> >  	}
> > -	unpack_trees(nr_trees, t, &opts);
> > +	if (unpack_trees(nr_trees, t, &opts))
> > +		return 128;
> 
> Magic 128 when everybody else in the patch returns -1 for error?

This is a cmd_ function, so this is the exit code. 128 is what die() uses. 
Should this be explicitly an exit(128)?

> Otherwise the changes seem sensible, as long as the callers are paying
> attention to the return values, which I admit that I did not check.

The only callers are here and merge-recursive, and merge-recursive was 
already checking the return value (and never getting anything); 
merge-recursive die()s if it gets non-zero.

	-Daniel
*This .sig left intentionally blank*
