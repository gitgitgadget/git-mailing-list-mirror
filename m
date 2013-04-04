From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] t3600: test rm of path with changed leading symlinks
Date: Thu, 4 Apr 2013 15:55:54 -0400
Message-ID: <20130404195554.GA20823@sigill.intra.peff.net>
References: <20130404190211.GA15912@sigill.intra.peff.net>
 <20130404190621.GA7484@sigill.intra.peff.net>
 <7v6202hykh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: jpinheiro <7jpinheiro@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 21:56:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNqGu-0008Ds-8a
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 21:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763314Ab3DDT4C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 15:56:02 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56282 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762960Ab3DDT4B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 15:56:01 -0400
Received: (qmail 6063 invoked by uid 107); 4 Apr 2013 19:57:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Apr 2013 15:57:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2013 15:55:54 -0400
Content-Disposition: inline
In-Reply-To: <7v6202hykh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220082>

On Thu, Apr 04, 2013 at 12:42:54PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +test_expect_success SYMLINKS 'replace dir with symlink to dir (same content)' '
> > +	git reset --hard &&
> > +	rm -rf d e &&
> > +	mkdir e &&
> > +	echo content >e/f &&
> > +	ln -s e d &&
> > +	git rm d/f &&
> > +	test_must_fail git rev-parse --verify :d/f &&
> > +	test -h d &&
> > +	test_path_is_dir e
> > +'
> 
> This does not check if e/f still exists in the working tree, and I
> suspect "git rm d/f" removes it.

I guess I should have been more clear in my test; I think it _should_ be
removed (and it is). You do not necessarily care that "d" is now the
symlink and not the actual path; it is safe to remove d/f even though it
is behind a symlink now, because it has the exact same content that it
had before (it is of course important that we still remove the actual
d/f index entry, but as far as the working tree goes, we only care that
it is safe to remove, and that we remove it).

IOW, I should have been more explicit like this:

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 9eaec08..3b51a63 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -687,7 +687,8 @@ test_expect_success SYMLINKS 'replace dir with symlink to dir (same content)' '
 	git rm d/f &&
 	test_must_fail git rev-parse --verify :d/f &&
 	test -h d &&
-	test_path_is_dir e
+	test_path_is_dir e &&
+	test_path_is_missing e/f
 '
 
 test_expect_success SYMLINKS 'replace dir with symlink to dir (new content)' '

> If you do this:
> 
> 	rm -fr d e
>         mkdir e
>         >e/f
>         ln -s e d
>         git add d/f
> 
> we do complain that d/f is beyond a symlink (meaning that all you
> can add is the symlink d that may happen to point at something).

Right, but that is because you are adding a bogus entry to the index; we
cannot have both 'd' as a symlink and 'd/f' as a path in our git tree.
But in the removal case, the index manipulation is perfectly reasonable.
You are deleting the existing "d/f" entry. The only confusion comes from
the fact that the working tree does not match that anymore.

> Silent removal of e/f that is unrelated to the current project's
> tracked contents feels very wrong, and at the same time it looks to
> me that it is inconsistent with what we do when adding.
> 
> I need a bit more persuading to understand why it is not a bug, I
> think.

But that's the point of the two content tests. It _isn't_ unrelated to
the current project's tracked contents; it's the exact same content at
the same path (albeit accessed via symlinks now). The likely case for
this is something like:

  mv dir somewhere/else
  ln -s somewhere/else/dir dir

I do not mind if you want to insert extra protection to not cross
symlink boundaries (which would obviously invalidate my test).  But I
don't think it is necessary because of the existing content-level
protections.  Adding extra protections would disallow "git rm dir/file" in
the above case, but I don't think it's that inconvenient; the user just
has to make the index aware of the typechange first via "git add".

-Peff
