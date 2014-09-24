From: Jeff King <peff@peff.net>
Subject: Re: Passing tar(1) options via git-archive(1)
Date: Wed, 24 Sep 2014 01:46:25 -0400
Message-ID: <20140924054624.GB24141@peff.net>
References: <87bnq6jhbk.fsf@brockman.se>
 <5421EAE4.30704@virtuell-zuhause.de>
 <20140924001522.GB6920@vauxhall.crustytoothpaste.net>
 <87k34tizb5.fsf@brockman.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Braun <thomas.braun@virtuell-zuhause.de>,
	git@vger.kernel.org
To: Daniel Brockman <daniel@brockman.se>
X-From: git-owner@vger.kernel.org Wed Sep 24 07:46:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWfPM-0000Vk-M2
	for gcvg-git-2@plane.gmane.org; Wed, 24 Sep 2014 07:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbaIXFq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2014 01:46:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:51195 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750817AbaIXFq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2014 01:46:27 -0400
Received: (qmail 30159 invoked by uid 102); 24 Sep 2014 05:46:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Sep 2014 00:46:27 -0500
Received: (qmail 2373 invoked by uid 107); 24 Sep 2014 05:46:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Sep 2014 01:46:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Sep 2014 01:46:25 -0400
Content-Disposition: inline
In-Reply-To: <87k34tizb5.fsf@brockman.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257451>

On Wed, Sep 24, 2014 at 03:26:22AM +0200, Daniel Brockman wrote:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> > Git does not invoke tar(1).  It has its own tar (actually, pax)
> > implementation, so any options would have to be implemented in Git.
> > We'd probably want to make such a change effective in the zip format
> > as well.
> 
> Ah, I see...
> 
> Well, I guess in the meantime I'll just do this:
> 
>    git commit -m dummy --allow-empty --date=1970-01-01T00:00:00Z
>    git archive HEAD | docker build -
>    git reset HEAD~

I don't think that will work. The `--date` parameter sets the author
date, but archive uses the committer date. You'd have to set
GIT_COMMITTER_DATE in the environment to override that.

Also, you can avoid writing to the HEAD ref entirely by using the
commit-tree plumbing. Like:

  commit=$(
    GIT_COMMITTER_DATE=1970-01-01T00:00:00Z \
    git commit-tree HEAD^{tree} </dev/null
  )
  git archive $commit | ...

However, the --mtime patch you are asking for is really not that big:

diff --git a/archive.c b/archive.c
index 952a659..9396fca 100644
--- a/archive.c
+++ b/archive.c
@@ -299,7 +299,8 @@ static void parse_treeish_arg(const char **argv,
 	ar_args->tree = tree;
 	ar_args->commit_sha1 = commit_sha1;
 	ar_args->commit = commit;
-	ar_args->time = archive_time;
+	if (!ar_args->time)
+		ar_args->time = archive_time;
 }
 
 #define OPT__COMPR(s, v, h, p) \
@@ -323,6 +324,7 @@ static int parse_archive_args(int argc, const char **argv,
 	int i;
 	int list = 0;
 	int worktree_attributes = 0;
+	unsigned long mtime = 0;
 	struct option opts[] = {
 		OPT_GROUP(""),
 		OPT_STRING(0, "format", &format, N_("fmt"), N_("archive format")),
@@ -332,6 +334,7 @@ static int parse_archive_args(int argc, const char **argv,
 			N_("write the archive to this file")),
 		OPT_BOOL(0, "worktree-attributes", &worktree_attributes,
 			N_("read .gitattributes in working directory")),
+		OPT_DATE(0, "mtime", &mtime, N_("mtime of files in archive")),
 		OPT__VERBOSE(&verbose, N_("report archived files on stderr")),
 		OPT__COMPR('0', &compression_level, N_("store only"), 0),
 		OPT__COMPR('1', &compression_level, N_("compress faster"), 1),
@@ -398,6 +401,7 @@ static int parse_archive_args(int argc, const char **argv,
 	args->base = base;
 	args->baselen = strlen(base);
 	args->worktree_attributes = worktree_attributes;
+	args->time = mtime;
 
 	return argc;
 }

which allows:

  git archive --mtime='yesterday at 3pm' HEAD

For inclusion in git, it would need someone to wrap it up with a commit
message, and add a basic test (see the existing mtime test in
t/t5000-tar-tree) and documentation in Documentation/git-archive.txt.
That someone could be you. :)

-Peff
