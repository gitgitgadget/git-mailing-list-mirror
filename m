From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-describe: allow reflogs as reference points
Date: Sat, 30 Sep 2006 17:20:52 -0700
Message-ID: <7vac4g7uor.fsf@assigned-by-dhcp.cox.net>
References: <20060930222903.GA11252@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 01 02:21:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTp4m-0000AO-MX
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 02:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbWJAAU6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Sep 2006 20:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbWJAAU6
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Sep 2006 20:20:58 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:23188 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751819AbWJAAU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Sep 2006 20:20:57 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061001002056.KAPL6711.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Sat, 30 Sep 2006 20:20:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UoLw1V0071kojtg0000000
	Sat, 30 Sep 2006 20:20:59 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060930222903.GA11252@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 30 Sep 2006 18:29:04 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28165>

Jeff King <peff@peff.net> writes:

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> It's basically impossible to use this in the git repository, since we
> prefer tags to reflogs. Should --reflog turn off tag matching? Should
> there be a command line option to turn off tags?

(Also please see my other message to Linus).

I think the behaviour we want out of the command when using
ref-log and when describing based on well-known points (aka
tags) are mutually incompatible, so I agree --reflog should turn
off tag matching.  Also you need to be prepared to handle a
ref-log that happens to have a rewound history.  See attached
patch.

I do not however think the patch is useful to get the
information the discussion which lead to this patch wanted to
know, as I described in a separate message today.  For example,
asking:

	$ git describe --reflog ce74618

answers "next@{3 months ago}-gce74618", in my repository, which
is quite bogus.  "next@{3 months ago}" is 47e5c0; it indeed is
an ancestor of ce74618 and it probably was once at the tip of
"next", so you are not giving any incorrect information, but
that one certainly did _not_ contain the change ce74618
introduced, so that form of output is not useful for answering
the question "when did this commit hit this branch".

	$ gitk master..next

shows that the commit ce74618 is a direct descendant of the
current "master" (4839bd8), and was merged into "next" for the
first time with 5a98f4e which was done last night.

Another example.  Recently somebody on the kernel list was
bitten by an ancient bug in diff.c::emit_rewrite_diff().  The
bug was there in the very first version of this feature (June
19, 2005) and nobody touched the vicinity of the code.  I fixed
it on top of recent master.

However, somebody else could have fixed it on top of v0.99 and
then I could have merged the fix from his branch that is based
on v0.99 (the bug is that ancient).  I do not enable the reflog
on my "master", but if I did, it would have looked like:

	from v0.99^ to v0.99 on July 10th 15:40 2005
	from v0.99 to 013aab on July 10th 23:55 2005
	...
	from 18b633 to 4839bd on Sept 29th 18:54 2006

IOW, my reflog would have recorded v0.99 was once at the tip of
the "master" branch.  Using it, describing 

	git describe --reflog $that_fixes_on_v0_99

would say v0.99 is the closest ancestor of the fix, which is
technically correct.  And if I merge that on top of my "master"
creating a new merge commit, that merge commit is the first
commit my "master" branch sees the fix.  So when I make the
merge, the reflog would have a new entry at the end:

	from 4839bd to xxxxxx on Sept 30th 17:10 2006 merge the fix

and what would be useful is to find this record and notice the
commit is the first one in the "master"'s history that has the
fix as its ancestor.


diff --git a/describe.c b/describe.c
index 1dc5209..cc38651 100644
--- a/describe.c
+++ b/describe.c
@@ -106,13 +106,18 @@ static int get_reflog_name(const char *r
 	}
 	reflog_start(&log);
 	while (reflog_next(&log, &c)) {
+		struct commit *commit;
 		snprintf(buf, sizeof(buf), "%s@{%s}",
 			ref,
 			reflog == FMT_DATE_REL ? show_date(c.date, 0, 1) :
 			reflog == FMT_DATE_GIT ? show_date(c.date, c.tz, 0) :
 			show_rfc2822_date(c.date, c.tz));
 		reflog_entry_to(&c, sha1);
-		add_to_known_names(buf, lookup_commit_reference(sha1), 0);
+		commit = lookup_commit_reference(sha1);
+		if (!commit)
+			/* rewound head */
+			continue;
+		add_to_known_names(buf, commit, 0);
 	}
 	reflog_close(&log);
 	return 0;
@@ -147,9 +151,10 @@ static void describe(const char *arg, in
 
 	if (!initialized) {
 		initialized = 1;
-		for_each_ref(get_name, NULL);
 		if (reflog)
 			for_each_branch_ref(get_reflog_name, NULL);
+		else
+			for_each_ref(get_name, NULL);
 		qsort(name_array, names, sizeof(*name_array), compare_names);
 	}
 
