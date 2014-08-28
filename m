From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] teach fast-export an --anonymize option
Date: Thu, 28 Aug 2014 08:32:58 -0400
Message-ID: <20140828123257.GA18642@peff.net>
References: <20140827165854.GC1432@peff.net>
 <20140827170127.GA6138@peff.net>
 <CACsJy8B3gFC7kLf-cLhAk3BgQ+v427rMXWHTqjU4LYP3NQte7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 14:33:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMyt3-00043t-DU
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 14:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbaH1MdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 08:33:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:60730 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750738AbaH1MdC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 08:33:02 -0400
Received: (qmail 1228 invoked by uid 102); 28 Aug 2014 12:33:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Aug 2014 07:33:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Aug 2014 08:32:58 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8B3gFC7kLf-cLhAk3BgQ+v427rMXWHTqjU4LYP3NQte7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256080>

On Thu, Aug 28, 2014 at 05:30:44PM +0700, Duy Nguyen wrote:

> On Thu, Aug 28, 2014 at 12:01 AM, Jeff King <peff@peff.net> wrote:
> > You can get an overview of what will be shared
> > by running a command like:
> >
> >   git fast-export --anonymize --all |
> >   perl -pe 's/\d+/X/g' |
> >   sort -u |
> >   less
> >
> > which will show every unique line we generate, modulo any
> > numbers (each anonymized token is assigned a number, like
> > "User 0", and we replace it consistently in the output).
> 
> I feel like this should be part of git-fast-export.txt, just to
> increase the user's confidence in the tool (and I don't expect most
> users to read this commit message).

Hmph. Whenever I say "I think this patch is done", suddenly the comments
start pouring in. :)

I think you are right, though, and we could stand to explain
the feature a little more in the documentation in general.
How about this patch on top (or squashed in):

-- >8 --
Subject: docs/fast-export: explain --anonymize more completely

The original commit made mention of this option, but not why
one might want it or how they might use it. Let's try to be
a little more thorough, and also explain how to confirm that
the output really is anonymous.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-fast-export.txt | 63 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 52831fa..dbe9a46 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -106,10 +106,9 @@ marks the same across runs.
 	different from the commit's first parent).
 
 --anonymize::
-	Replace all refnames, paths, blob contents, commit and tag
-	messages, names, and email addresses in the output with
-	anonymized data, while still retaining the shape of history and
-	of the stored tree.
+	Anonymize the contents of the repository while still retaining
+	the shape of the history and stored tree.  See the section on
+	`ANONYMIZING` below.
 
 --refspec::
 	Apply the specified refspec to each ref exported. Multiple of them can
@@ -147,6 +146,62 @@ referenced by that revision range contains the string
 'refs/heads/master'.
 
 
+ANONYMIZING
+-----------
+
+If the `--anonymize` option is given, git will attempt to remove all
+identifying information from the repository while still retaining enough
+of the original tree and history patterns to reproduce some bugs. The
+goal is that a git bug which is found on a private repository will
+persist in the anonymized repository, and the latter can be shared with
+git developers to help solve the bug.
+
+With this option, git will replace all refnames, paths, blob contents,
+commit and tag messages, names, and email addresses in the output with
+anonymized data.  Two instances of the same string will be replaced
+equivalently (e.g., two commits with the same author will have the same
+anonymized author in the output, but bear no resemblance to the original
+author string). The relationship between commits, branches, and tags is
+retained, as well as the commit timestamps (but the commit messages and
+refnames bear no resemblance to the originals). The relative makeup of
+the tree is retained (e.g., if you have a root tree with 10 files and 3
+trees, so will the output), but their names and the contents of the
+files will be replaced.
+
+If you think you have found a git bug, you can start by exporting an
+anonymized stream of the whole repository:
+
+---------------------------------------------------
+$ git fast-export --anonymize --all >anon-stream
+---------------------------------------------------
+
+Then confirm that the bug persists in a repository created from that
+stream (many bugs will not, as they really do depend on the exact
+repository contents):
+
+---------------------------------------------------
+$ git init anon-repo
+$ cd anon-repo
+$ git fast-import <../anon-stream
+$ ... test your bug ...
+---------------------------------------------------
+
+If the anonymized repository shows the bug, it may be worth sharing
+`anon-stream` along with a regular bug report. Note that the anonymized
+stream compresses very well, so gzipping it is encouraged. If you want
+to examine the stream to see that it does not contain any private data,
+you can peruse it directly before sending. You may also want to try:
+
+---------------------------------------------------
+$ perl -pe 's/\d+/X/g' <anon-stream | sort -u | less
+---------------------------------------------------
+
+which shows all of the unique lines (with numbers converted to "X", to
+collapse "User 0", "User 1", etc into "User X"). This produces a much
+smaller output, and it is usually easy to quickly confirm that there is
+no private data in the stream.
+
+
 Limitations
 -----------
 
-- 
2.1.0.346.ga0367b9
