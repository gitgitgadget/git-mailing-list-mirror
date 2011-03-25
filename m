From: Jeff King <peff@peff.net>
Subject: Re: merge recursive and code movement
Date: Fri, 25 Mar 2011 05:37:58 -0400
Message-ID: <20110325093758.GA9047@sigill.intra.peff.net>
References: <AANLkTi=h6jUsjqXofd0QeWbNBjc9DeodJJ3FN7caW4XC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 10:38:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q33T5-0005zT-4f
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 10:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756640Ab1CYJiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 05:38:01 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37199
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751652Ab1CYJiA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 05:38:00 -0400
Received: (qmail 11481 invoked by uid 107); 25 Mar 2011 09:38:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Mar 2011 05:38:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Mar 2011 05:37:58 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=h6jUsjqXofd0QeWbNBjc9DeodJJ3FN7caW4XC@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169974>

On Thu, Mar 24, 2011 at 05:18:20PM -0400, Jay Soffian wrote:

> There's a use case that merge recursive doesn't seem to handle, and I
> wonder how difficult it would be to add.

I don't think it's that hard. In your example:

> Say you have a merge between OURS and THEIRS, with common ancestor BASE.
> 
> Between BASE and THEIRS, a file named header.h has the following changes:
> 
>   # Rename header.h to header_new.h
>   git mv header.h header_new.h
> 
>   # Minor edits to account for the rename such as fixing the
>   # include guard:
>   perl -pi -e 's/HEADER_H_/HEADER_NEW_H_/' header_new.h
> 
>   # Drop a compatibility header.h in place till we can fix all the
>   # files which include header.h
>   cat > header.h <<-__EOF__
> 	#ifndef HEADER_H_
> 	#define HEADER_H_
> 	#include "header_hew.h"
> 	#endif // HEADER_H_
>   __EOF__

You have a move coupled with a rewritten version of a file. So without
copy or break detection, we won't consider the original header.h as a
possible rename source.

>   git add header.h header_new.h
>   git commit -m 'rename header.h to header_new.h'
> 
> Meanwhile, between BASE and OURS, a few minor changes are made to
> header.h. This could be as little as a single line change in the
> middle of the header.h.
> 
> Now you merge THEIRS to OURS. Git will just show header.h in conflict.

Right. merge-recursive won't detect the rename here.

In your case, I think merge-recursive doing break detection is the right
solution. It realizes that header.h has been rewritten and considers it
as a source candidate for the rename to header_new.

Copy detection might also work, but I don't think it makes sense in a
merge setting. If I copy "foo.h" to "bar.h", and meanwhile you make a
change to "foo.h", there is no reason to think the change should apply
to bar.h instead of foo.h (you might perhaps think it could apply to
_both_, but that is a different story).

So break detection is the only thing that makes sense to me.  This
one-liner does what you want:

diff --git a/merge-recursive.c b/merge-recursive.c
index 2a048c6..ed574e6 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -429,6 +429,7 @@ static struct string_list *get_renames(struct merge_options *o,
 			    1000;
 	opts.rename_score = o->rename_score;
 	opts.show_rename_progress = o->show_rename_progress;
+	opts.break_opt = 0;
 	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	if (diff_setup_done(&opts) < 0)
 		die("diff setup failed");

And I tested it on this:

-- >8 --
#!/bin/sh

rm -rf repo

git init repo && cd repo

# Sample header.
cp /path/to/your/git/revision.h .
git add revision.h
git commit -m 'add revision.h'

# Move and tweak header.
git mv revision.h foo.h
perl -pi -e 's/REVISION_H/FOO_H/' foo.h

# And put in replacement header.
cat >revision.h <<'EOF'
#ifndef REVISION_H
#define REVISION_H
#include "foo.h"
#endif /* REVISION_H */
EOF

# And commit.
git add revision.h foo.h
git commit -m 'rename revision.h to foo.h'

# Now make a minor change on a side branch.
git checkout -b other HEAD^
sed -i '/REV_TREE_SAME/i/* some comment */' revision.h
git commit -a -m 'tweak revision.h'

git merge master
-- 8< --

It _almost_ works. The merge completes automatically, and the tweak ends
up in foo.h, as you expect. But the merge silently deletes the
placeholder revision.h!

I suspect it is a problem of merge-recursive either not handling the
broken filepair properly, or perhaps reading too much into what a rename
means. I haven't dug further.

-Peff
