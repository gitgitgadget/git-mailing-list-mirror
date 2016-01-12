From: Jeff King <peff@peff.net>
Subject: Re: Can't diff against the 00000000 revision
Date: Tue, 12 Jan 2016 10:32:39 -0500
Message-ID: <20160112153239.GA8041@sigill.intra.peff.net>
References: <jwv4meiygrc.fsf-monnier+gmane.comp.version-control.git@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Stefan Monnier <monnier@iro.umontreal.ca>
X-From: git-owner@vger.kernel.org Tue Jan 12 16:32:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ0wA-00079S-TI
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 16:32:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649AbcALPcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 10:32:43 -0500
Received: from cloud.peff.net ([50.56.180.127]:52281 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752222AbcALPcm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 10:32:42 -0500
Received: (qmail 3490 invoked by uid 102); 12 Jan 2016 15:32:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 10:32:42 -0500
Received: (qmail 15063 invoked by uid 107); 12 Jan 2016 15:32:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 Jan 2016 10:32:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jan 2016 10:32:39 -0500
Content-Disposition: inline
In-Reply-To: <jwv4meiygrc.fsf-monnier+gmane.comp.version-control.git@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283822>

On Tue, Jan 12, 2016 at 10:17:24AM -0500, Stefan Monnier wrote:

> If I look at the initial commit on a branch, I see something like:
> 
>     % git show d59cfff346c3e210adc26501f8cebf8da5ab2e7d
>     commit d59cfff346c3e210adc26501f8cebf8da5ab2e7d
>     Author: Stefan Monnier <monnier@iro.umontreal.ca>
>     Date:   Wed Dec 2 20:46:51 2015 -0500
>     
>         Initial release
>     
>     diff --git a/bugit b/bugit
>     new file mode 100755
>     index 0000000..681bd38
>     --- /dev/null
>     +++ b/bugit
>     @@ -0,0 +1,512 @@
>     ...
> 
> which is great.  But I can't get the same result with
> 
>     git diff 0000000..681bd38
> 
> because it complains:
> 
>     % git diff 0000000..681bd38
>     fatal: ambiguous argument '0000000..681bd38': unknown revision or path not in the working tree.
>     Use '--' to separate paths from revisions, like this:
>     'git <command> [<revision>...] -- [<file>...]'
>     %

Right. There is no "000000" blob; it's just a syntactic placeholder.

If you want to diff against the empty blob, you can. Its name is:

  $ git hash-object -t blob /dev/null
  e69de29bb2d1d6434b8b29ae775ad8c2e48c5391

> I bumped into this problem in a post-receive hook where I need to pay
> attention to all newly added files, and where this problem means that
> I can't use the same code for a newly added branch as for a push on
> a pre-existing branch.

Keep in mind that the "000000" in your example is showing the change in
the _blob_, not the change in revisions. Even if it were not 0's, you
could not run "git diff A..B" on it, because that syntax only works with
commits.

So the corner case you need to deal with is not about a newly added
branch; it is about a newly added file (or in the opposite direction, a
deleted file).

Or from your description, maybe you are also running into the all-zero
sha1 in the argument to the post-receive hook (where it is standing in
for a commit sha1 on a newly-pushed branch).

> I currently work around the problem by adding a dummy empty branch, but
> being able to use the revision 00000000 as a known reference to an empty
> tree would come in really handy, and since it's already used at various
> places in Git (post-receive hook and "git show" output, at least), it
> would seem like a natural extension.

The empty tree also has a name:

  $ git hash-object -t tree /dev/null
  4b825dc642cb6eb9a060e54bf8d69288fbee4904

and you can diff against that.

And hopefully that explains why "000000" does not necessarily make a
good placeholder for "the empty thing". There are multiple empty things,
and it is not clear what:

  git diff 0000000 1234abcd

means. Is 0000000 a tree? A blob?

-Peff
