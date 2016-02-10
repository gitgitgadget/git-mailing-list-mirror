From: Jeff King <peff@peff.net>
Subject: Re: git show doesn't work on file names with square brackets
Date: Wed, 10 Feb 2016 11:15:49 -0500
Message-ID: <20160210161548.GC19867@sigill.intra.peff.net>
References: <25D155FA-6F05-425C-AB2D-7F0B44E0D1C5@jetbrains.com>
 <alpine.DEB.2.20.1602061708220.2964@virtualbox>
 <CACsJy8ChZzYWXePSwF6D8vPZMuz3dQe1=jtw6rSG7M1oC+RiNw@mail.gmail.com>
 <32B9BD70-F06C-49C4-B672-24173E69B99F@jetbrains.com>
 <CACsJy8AMEgk8UXF==VmvLXsL4R67u0+U4MiUGPtO6HX0Y30oXg@mail.gmail.com>
 <20160208141552.GC27054@sigill.intra.peff.net>
 <20160208150709.GA13664@sigill.intra.peff.net>
 <xmqqpow7807l.fsf@gitster.mtv.corp.google.com>
 <20160208195230.GA30693@sigill.intra.peff.net>
 <xmqqziv939ir.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 17:16:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTXQq-0001ER-N3
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 17:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbcBJQPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 11:15:53 -0500
Received: from cloud.peff.net ([50.56.180.127]:39801 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752006AbcBJQPv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 11:15:51 -0500
Received: (qmail 2426 invoked by uid 102); 10 Feb 2016 16:15:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Feb 2016 11:15:51 -0500
Received: (qmail 29119 invoked by uid 107); 10 Feb 2016 16:15:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Feb 2016 11:15:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Feb 2016 11:15:49 -0500
Content-Disposition: inline
In-Reply-To: <xmqqziv939ir.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285908>

On Tue, Feb 09, 2016 at 12:37:32PM -0800, Junio C Hamano wrote:

> I was leaning towards merging this version, but I became unsure
> while writing an entry for "What's cooking" (which will be used as a
> merge summary message and then will appear in the Release Notes).
> 
> We would surely want
> 
>     $ git log ':/tighten.*'
> 
> to find this commit, not take it as a pathspec.  But running
> 
>     $ git log ':/*.c'
> 
> in a subdirectory to find commits that touched any .c file, taking
> it as a pathspec, would equally be a sensible thing to want.
> 
> I would feel that we should require "--" for both cases; with or
> without this patch, we already treat these as revs without "--",
> making the latter fail without "--".

Yes, because ":/" is treated specially in check_filename(), and avoids
kicking in the wildcard behavior. That is certainly preferring revs to
pathspecs, but I think preferring one over the other is preferable to
barfing. If the user wants carefulness, they should use "--"
unconditionally. If they want to DWIM, we should make it as painless as
possible, even if we sometimes guess wrong.

> Also:
> 
>     $ git log "HEAD^{/tighten.*}"
> 
> is already dwimmed as a rev.

Is it? That is the exact case I think regressed in v2.5.0, because it
clearly _is_ a rev, didn't previously require a "--", and now does:

  $ git.v2.4.8 log --oneline -1 'HEAD^{/tighten.*}'
  913c2c7 Merge branch 'jk/sanity' into maint

  $ git.v2.5.0 log --oneline -1 'HEAD^{/tighten.*}'
  fatal: ambiguous argument 'HEAD^{/tighten.*}': both revision and filename
  Use '--' to separate paths from revisions, like this:
  'git <command> [<revision>...] -- [<file>...]'

And that's what my patch is trying to do: pull back the over-broad match
in 28fcc0b for cases that are pretty clearly revs.

> And a path with glob(3) metacharacters is an insane thing, be it
> inside a treeish or in the working tree, and I think it is OK to
> require users to explicitly say what they mean with "--".

Yeah, I can buy that line of reasoning.

> We may want to rethink the interface into check_filename().  The
> callers of this function that try to help users who did not use "--"
> want the function to say "It is likely that this was meant as a
> pathname" and when this function says "No, the user did not mean it
> as a filename." they will in turn ask the revision parser "Is this a
> rev?".  At that point, if it is not a revision, these callers can
> say "Not a file, not a rev" and die.
> 
> In order to allow "':/tighten.*' is a rev, ':/*.c' is a pathspec,
> they are equally likely and you must disambiguate", the current
> interface is inadequate.

Hmm. I think at least for the revision-parser it is the other way
around. We actually check first "is it a rev". If it is, and there is no
"--", then we ask "could it also be a filename" and complain if so. If
the revision parser says "no, it cannot be", then we say "well, could it
plausibly be a filename"?

And both of those use the same check_filename() test, but I think they
are asking two different things. The first one probably wants to say "is
it definitely a filename, because if so, that's ambiguous". And it would
be OK to look at a wildcard and say "sure, it _could_ be a path, but
taking it as a rev is reasonable". IOW, to err on the side of "not a
filename", and allow something possibly ambiguous. And then the second
test is the opposite; we know it's not a rev, so if it could plausibly
be a file, then take it as one.

But I have a feeling from what you've written that you do not agree with
the "err and allow something possibly ambiguous" philosophy.

I'll note also two things:

  1. I've _just_ looked at revision.c here; there are other callers of
     verify_filename and verify_non_filename (and even a bare
     check_filename() call!) that may not all have the same needs.

  2. The ":/*.c" case is much more complicated. Before we get to
     check_filename() at all, we use get_sha1(), which says "yes, this
     is a pattern". And then barfs with a fatal error when it sees that
     "*.c" is not a valid regex. So no matter what check_filename()
     does, we would have to propagate that error from get_sha1() to make
     anything interesting work there.

> I actually think that no_wildcard() check added in check_filename()
> was the original mistake.  If we revert the check_filename() to a
> simple "Is this a filename?" and move the "does this thing have a
> wildcard" aka "can this be a pathspec even when check_filename()
> says there is no file with that exact name?" to the code that tries
> to allow users omit "--", i.e. the caller of check_filename(), would
> that make the code structure and the semantics much cleaner, I
> wonder...

Yes. After writing the above, I was envisioning pushing the "err on this
side" logic into check_filename() with a flag. The main callers are
verify_filename() and verify_non_filename(), and they would use opposite
flags from each other.  But pulling that logic out to the caller would
be fine, too.

IOW, something like this implements the "permissive" thing I wrote above
(i.e., be inclusive when seeing if something could plausibly be a
filename, but exclusive when complaining that it _could_ be one):

diff --git a/setup.c b/setup.c
index 2c4b22c..995e924 100644
--- a/setup.c
+++ b/setup.c
@@ -139,9 +139,7 @@ int check_filename(const char *prefix, const char *arg)
 		if (arg[2] == '\0') /* ":/" is root dir, always exists */
 			return 1;
 		name = arg + 2;
-	} else if (!no_wildcard(arg))
-		return 1;
-	else if (prefix)
+	} else if (prefix)
 		name = prefix_filename(prefix, strlen(prefix), arg);
 	else
 		name = arg;
@@ -202,7 +200,7 @@ void verify_filename(const char *prefix,
 {
 	if (*arg == '-')
 		die("bad flag '%s' used after filename", arg);
-	if (check_filename(prefix, arg))
+	if (check_filename(prefix, arg) || !no_wildcard(arg))
 		return;
 	die_verify_filename(prefix, arg, diagnose_misspelt_rev);
 }
