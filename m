From: Johan Herland <johan@herland.net>
Subject: Re: To graft or not to graft... (Re: Recovering from repository
 corruption)
Date: Thu, 12 Jun 2008 09:14:21 +0200
Message-ID: <200806120914.22083.johan@herland.net>
References: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com>
 <20080611232126.GA9054@cuci.nl>
 <alpine.LFD.1.10.0806111635200.3101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Stephen R. van den Berg" <srb@cuci.nl>,
	Denis Bueno <dbueno@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 12 09:16:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6h2h-00070v-Aa
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 09:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753808AbYFLHPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 03:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753517AbYFLHPZ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 03:15:25 -0400
Received: from smtp.getmail.no ([84.208.20.33]:58715 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753438AbYFLHPY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 03:15:24 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K2C004019HBUM00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 12 Jun 2008 09:15:11 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2C00MYG9FYPYA0@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 12 Jun 2008 09:14:22 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2C003W99FY1I40@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Thu, 12 Jun 2008 09:14:22 +0200 (CEST)
In-reply-to: <alpine.LFD.1.10.0806111635200.3101@woody.linux-foundation.org>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84729>

On Thursday 12 June 2008, Linus Torvalds wrote:
> On Thu, 12 Jun 2008, Stephen R. van den Berg wrote:
> > As I understood it from the few shreds of documentation that actually
> > mention the grafts file, the grafts file is *not* being cloned.
> > Therefore, my assumption was that cloning a repository that has a
> > grafts file gives an identical result to cloning the same repository
> > *without* the grafts file present.
>
> That would probably be the right behaviour, but no - all our commit
> walkers honor the grafts file.
>
> Including the ones used for creating pack-files and thus a clone.
>
> > As I understand it now, the cloning process actually peeks at the
> > grafts file while cloning, and then doesn't copy it.  This results in a
> > rather confusingly corrupt clone.
>
> Yes. The grafts-file was a mistake, but it's just barely useful to some
> people that it's stayed alive. Sadly, those "some people" don't tend to
> care enough about the problems it can cause.
>
> > I suggest two things:
> > a. That during the cloning process, the grafts file is completely
> >    disregarded in any case at first.
>
> Yes.
>
> And (a'): git-fsck and repacking should just consider it to be an
> _additional_ source of parenthood rather than a _replacement_ source.
>
> > b. Preferably the grafts file is copied as well (after cloning).  I
> >    never really understood why the file is not being copied in the
> > first place (anyone care to explain that?).
>
> The grafts file isn't part of the object stream and refs, and clones (and
> fetches) very much just copy the object database.

AFAICS, there's already a perfectly fine way to distribute grafted history:
1. Add a grafts file
2. Run git-filter-branch
3. Remove grafts file
4. Distribute repo
5. Profit!

Since git-filter-branch turns grafted parentage into _real_ parentage,
there's no point in ever having a grafts file at all (except transiently
for telling git-filter-branch what to do).

I suggest we make commit walkers NOT obey the grafts file by default, but
instead require a --follow-grafts option to restore the current behaviour.
Then, we teach git-filter-branch to obey the grafts file (probably by
employing said --follow-grafts option).

For those who want to hang on to the current behaviour, they can create
some config option that is equivalent to always running with
--follow-grafts.


The following is ugly, untested, undocumented, and obviously unfit for
inclusion:


diff --git a/commit.c b/commit.c
index 94d5b3d..3e9ebf7 100644
--- a/commit.c
+++ b/commit.c
@@ -7,6 +7,7 @@
 #include "revision.h"
 
 int save_commit_buffer = 1;
+int use_grafts = 0;
 
 const char *commit_type = "commit";
 
@@ -242,7 +243,7 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
 	char *bufptr = buffer;
 	unsigned char parent[20];
 	struct commit_list **pptr;
-	struct commit_graft *graft;
+	struct commit_graft *graft = NULL;
 	unsigned n_refs = 0;
 
 	if (item->object.parsed)
@@ -260,7 +261,8 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
 	bufptr += 46; /* "tree " + "hex sha1" + "\n" */
 	pptr = &item->parents;
 
-	graft = lookup_commit_graft(item->object.sha1);
+	if (use_grafts)
+		graft = lookup_commit_graft(item->object.sha1);
 	while (bufptr + 48 < tail && !memcmp(bufptr, "parent ", 7)) {
 		struct commit *new_parent;
 
diff --git a/commit.h b/commit.h
index 2d94d41..3e30aa0 100644
--- a/commit.h
+++ b/commit.h
@@ -22,6 +22,7 @@ struct commit {
 };
 
 extern int save_commit_buffer;
+extern int use_grafts;
 extern const char *commit_type;
 
 /* While we can decorate any object with a name, it's only used for commits.. */
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index d04c346..5ebe7cd 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -230,11 +230,11 @@ mkdir ../map || die "Could not create map/ directory"
 case "$filter_subdir" in
 "")
 	git rev-list --reverse --topo-order --default HEAD \
-		--parents "$@"
+		--follow-grafts --parents "$@"
 	;;
 *)
 	git rev-list --reverse --topo-order --default HEAD \
-		--parents "$@" -- "$filter_subdir"
+		--follow-grafts --parents "$@" -- "$filter_subdir"
 esac > ../revs || die "Could not get the commits"
 commits=$(wc -l <../revs | tr -d " ")
 
diff --git a/revision.c b/revision.c
index 5a1a948..ca98815 100644
--- a/revision.c
+++ b/revision.c
@@ -1059,6 +1059,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				revs->first_parent_only = 1;
 				continue;
 			}
+			if (!strcmp(arg, "--follow-grafts")) {
+				use_grafts = 1;
+				continue;
+			}
 			if (!strcmp(arg, "--reflog")) {
 				handle_reflog(revs, flags);
 				continue;
-- 
1.5.6.rc2.128.gf64ae


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
