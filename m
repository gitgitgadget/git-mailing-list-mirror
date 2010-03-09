From: Jeff King <peff@peff.net>
Subject: Re: 'git add' regression in git-1.7?
Date: Tue, 9 Mar 2010 18:09:31 -0500
Message-ID: <20100309230931.GC25265@sigill.intra.peff.net>
References: <hll45t$50o$1@ger.gmane.org>
 <32541b131002182042p610fce4ex96efbffea9afe2ed@mail.gmail.com>
 <hll65c$87a$1@ger.gmane.org>
 <32541b131002182115t5501d0d1u19367a4d8e7627e4@mail.gmail.com>
 <20100219053431.GB22645@coredump.intra.peff.net>
 <20100219060249.GD22645@coredump.intra.peff.net>
 <20100219082445.GB13691@coredump.intra.peff.net>
 <7vhbp0ls26.fsf@alter.siamese.dyndns.org>
 <20100309223729.GA25265@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	SungHyun Nam <goweol@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 10 00:09:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np8Yd-0000ix-2K
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 00:09:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755526Ab0CIXJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 18:09:37 -0500
Received: from peff.net ([208.65.91.99]:34020 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755180Ab0CIXJg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 18:09:36 -0500
Received: (qmail 3561 invoked by uid 107); 9 Mar 2010 23:09:56 -0000
Received: from c-71-206-173-191.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.191)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 09 Mar 2010 18:09:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Mar 2010 18:09:31 -0500
Content-Disposition: inline
In-Reply-To: <20100309223729.GA25265@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141853>

On Tue, Mar 09, 2010 at 05:37:30PM -0500, Jeff King wrote:

> No, we would still be correct if we recurse into the ignored directory
> _only_ to collect the ignored bits (so we don't even bother if
> COLLECT_IGNORED isn't set). But what I don't like is that you take a
> performance hit, because in most cases you won't ever care what's inside
> those directories. You need to recurse only when:
> 
>   - you actually care about all files. git-add does. git-status does not
>     (unless you explicitly told it to show directories). So that would
>     probably need a flag passed to fill_directory.
> 
>   - you have a pathspec that means the contents of the directory might
>     be interesting. Right now we check in_pathspec in treat_one_path.
>     But I think we would need to recognize that "subdir/file" is
>     means "subdir" is in our pathspec (and that "sub*" means the same
>     thing).

Actually, if we accept that the message simply mentions the excluded
path, i.e.:

  $ git add subdir/file
  The following paths are ignored by one of your .gitignore files:
  subdir
  Use -f if you really want to add them.

then we don't really need to recurse. We just need to fix in_pathspec to
flag files that are _relevant_ to a pathspec.

And something like this seems to fix the OP's problem:

diff --git a/dir.c b/dir.c
index 00d698d..5091bfd 100644
--- a/dir.c
+++ b/dir.c
@@ -554,13 +554,17 @@ static int simplify_away(const char *path, int pathlen, const struct path_simpli
 	return 0;
 }
 
-static int in_pathspec(const char *path, int len, const struct path_simplify *simplify)
+static int relevant_pathspec(const char *path, int len, const struct path_simplify *simplify)
 {
 	if (simplify) {
 		for (; simplify->path; simplify++) {
 			if (len == simplify->len
 			    && !memcmp(path, simplify->path, len))
 				return 1;
+			if (len < simplify->len
+			    && simplify->path[len] == '/'
+			    && !memcmp(path, simplify->path, len))
+				return 1;
 		}
 	}
 	return 0;
@@ -638,7 +642,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 {
 	int exclude = excluded(dir, path, &dtype);
 	if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
-	    && in_pathspec(path, *len, simplify))
+	    && relevant_pathspec(path, *len, simplify))
 		dir_add_ignored(dir, path, *len);
 
 	/*

Which is similar to your fix, but hoisted into the ignore-collection
phase. Like the original code and your patch, it suffers from using a
straight memcmp. I think it should actually be checking the pathspec
expansion to catch things like 'sub*/file' being relevant to 'subdir'.

-Peff
