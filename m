From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] clone: always fetch remote HEAD
Date: Fri, 3 Jun 2011 14:10:52 -0400
Message-ID: <20110603181052.GA17538@sigill.intra.peff.net>
References: <20110603050901.GA883@sigill.intra.peff.net>
 <20110603051805.GC1008@sigill.intra.peff.net>
 <BANLkTim03_3DLdDkc3QgFrcUa0Fqhhqnbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 20:11:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSYpp-0005gc-Dh
	for gcvg-git-2@lo.gmane.org; Fri, 03 Jun 2011 20:11:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528Ab1FCSKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2011 14:10:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49040
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752720Ab1FCSKz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2011 14:10:55 -0400
Received: (qmail 11509 invoked by uid 107); 3 Jun 2011 18:10:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Jun 2011 14:10:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Jun 2011 14:10:52 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTim03_3DLdDkc3QgFrcUa0Fqhhqnbw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175019>

On Fri, Jun 03, 2011 at 12:36:50AM -0500, Sverre Rabbelier wrote:

> On Fri, Jun 3, 2011 at 00:18, Jeff King <peff@peff.net> wrote:
> > So I guess it doesn't like us asking for HEAD. But the fact that it
> > sends weird data to fast-import instead of saying "hey, HEAD doesn't
> > exist" has me confused. I'm not sure if this is something one should not
> > be doing with remote helpers, or if the testgit helper is simply buggy
> > or incomplete.
> 
> Definitely the latter, quite possibly the former. I don't know if
> asking for "HEAD" makes much sense in a remote-helper context though.
> In Mercurial it does (e.g., tip), and in svn sort of, but I don't know
> about other vcs-es. Perhaps it should be guarded by a capability?

I did some more digging. I don't think the problem is with HEAD at all,
but rather with asking for more than one ref at all.

If we want to fetch multiple refs, and the remote helper has the import
capability, we end up in transport-helper.c:fetch_with_import. This will
generate an "import %s" line for every ref we are interested in.

Meanwhile, the testgit remote helper will read each import line and call
do_import. This ends up in the git_remote_helper library's
exporter.export_repo function, which dumps fast-import data to stdout,
including some "feature" lines.

On the second import line, we have already sent some fast-import data,
but now we send more "feature" lines, which causes fast-import to
complain.

So which of the three (git's transport-helper code, the testgit remote
helper, or the remote helper library) is at fault?

Is it git itself? The fetch_with_import has to be able to ask for
multiple refs, right? Or should it simply say "import" once, and then
pick the refs it wants out of the alternate namespace?

Or is it the fault of testgit for calling exporter.export_repo twice? It
seems to ignore the ref argument it gets to import, and just dumps the
whole repo, albeit into an alternate namespace. Should we then be doing
something per-ref with the result? Or since our particular import
imports everything, should we simply ignore further imports after the
first one?

Or is it the fault of the exporter code, which should not assume it is
the first thing to generate fast-import data on stdout? I don't think
this is the case, since there would be no point to exporting again,
right? We didn't actually restrict the export to a particular ref in the
first place.

So I'm confused about who is supposed to be doing what with remote
helpers and "import". And I wasn't able to find any helpful
documentation or other examples. From reading the transport-helper code,
my guess is:

  1. We send the helper a bunch of import lines, one per ref. The helper
     can use that ref to generate fast-import data for just that ref. Or
     it can ignore it and just import everything (like testgit does).
     The result goes into an alternate namespace, like refs/testgit/.

  2. Git reads the sha1 values from the alternate namespace into its
     list of to-fetch refs. This puts us in the same state we would be
     in for other transports (which usually fill in the sha1 earlier,
     but in this case, we don't know it until the import is done).

  3. Git does the usual write-out of remote sha1 values into their
     matching local counterparts.

Does that make sense? If so, then I think the right fix is for testgit
ti ignore all imports after the first one (since the first one will have
done all available refs). And the patch is:

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index df9d512..7330753 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -111,13 +111,19 @@ def update_local_repo(repo):
     return repo
 
 
+did_import = False
 def do_import(repo, args):
     """Exports a fast-import stream from testgit for git to import.
     """
+    global did_import
 
     if len(args) != 1:
         die("Import needs exactly one ref")
 
+    if did_import:
+	return
+    did_import = True
+
     if not repo.gitdir:
         die("Need gitdir to import")
 

-Peff
