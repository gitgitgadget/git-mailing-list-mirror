From: Jeff King <peff@peff.net>
Subject: Re: [RFC] git checkout $tree -- $path always rewrites files
Date: Thu, 13 Nov 2014 13:30:34 -0500
Message-ID: <20141113183033.GA24107@peff.net>
References: <20141107081324.GA19845@peff.net>
 <xmqqegtfgcfx.fsf@gitster.dls.corp.google.com>
 <20141107191745.GB5695@peff.net>
 <CANiSa6hufp=80TaesNpo1CxCbwVq3LPXvYaUSbcmzPE5pj_GGw@mail.gmail.com>
 <CANiSa6ggX-DJSXLzjYwv1K2nF1ZrpJ3bHvPjh6gFnqSLQaqZFQ@mail.gmail.com>
 <CAPc5daWdzrHr8Rdksr3HycMRQu0=Ji7h=BPYjzZj7MH6Ko0VgQ@mail.gmail.com>
 <20141108083040.GA15833@peff.net>
 <xmqqbnoge1ci.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 19:30:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XozAI-0000DI-5Y
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 19:30:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933785AbaKMSai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 13:30:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:39999 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933226AbaKMSag (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 13:30:36 -0500
Received: (qmail 8893 invoked by uid 102); 13 Nov 2014 18:30:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 12:30:36 -0600
Received: (qmail 29336 invoked by uid 107); 13 Nov 2014 18:30:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 13:30:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Nov 2014 13:30:34 -0500
Content-Disposition: inline
In-Reply-To: <xmqqbnoge1ci.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 09, 2014 at 09:21:49AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Fri, Nov 07, 2014 at 11:35:59PM -0800, Junio C Hamano wrote:
> >
> >> I think that has direct linkage; what you have in mind I think is
> >> http://thread.gmane.org/gmane.comp.version-control.git/234903/focus=234935
> >
> > Thanks for that link.
> 
> It was one of the items in the "git blame leftover bits" list
> (websearch for that exact phrase), so I didn't have to do any
> digging just for this thread ;-)
> 
> But I made a huge typo above.  s/I think/I do not think/;

Oh. That might explain some of my confusion. :)

> The original observation you made in this thread is that when "git
> checkout $tree - $pathspec", whose defintion is to "grab paths in
> the $tree that match $pathspec and put them in the index, and then
> overwrite the working tree paths with the contents of these paths
> that are updated in the index with the contents taken from the
> $tree", unnecessarily rewrites the working tree paths even when they
> already had contents that were up to date.  That is what I called an
> "implementation glitch".
> 
> The old thread is a different topic.
> [...]

Right, I do agree that these things don't need to be linked. The reason
I ended up dealing with the deletion thing is that one obvious way to
implement "do not touch entries which have not changed" is by running a
diff between $tree and the index. But doing a diff means we have to
reconsider all of the code surrounding deletions (and handling of
unmerged entries in the pathspec but not in $tree). I tried a few
variants and had trouble making it work (getting caught up either in the
"make sure each pathspec matched" code, or the "treat unmerged entries
specially" behavior).

In the patch below, I ended up retaining the existing
read_tree_recursive code, and just specially handling the replacement of
index entries (which is itself sort of a diff, but it fits nicely into
the existing scheme).

> I'd prefer that these two to be treated separately.

Yeah, that makes sense after reading your emails. What I was really
unclear on was whether the handling of deletion was a bug or a design
choice, and it is the latter (if it were the former, we would not need a
transition plan :) ).

Anyway, here is the patch.

-- >8 --
Subject: checkout $tree: do not throw away unchanged index entries

When we "git checkout $tree", we pull paths from $tree into
the index, and then check the resulting entries out to the
worktree. Our method for the first step is rather
heavy-handed, though; it clobbers the entire existing index
entry, even if the content is the same. This means we lose
our stat information, leading checkout_entry to later
rewrite the entire file with identical content.

Instead, let's see if we have the identical entry already in
the index, in which case we leave it in place. That lets
checkout_entry do the right thing. Our tests cover two
interesting cases:

  1. We make sure that a file which has no changes is not
     rewritten.

  2. We make sure that we do update a file that is unchanged
     in the index (versus $tree), but has working tree
     changes. We keep the old index entry, and
     checkout_entry is able to realize that our stat
     information is out of date.

Signed-off-by: Jeff King <peff@peff.net>
---
Note that the test refreshes the index manually (because we are tweaking
the timestamp of file2). In normal use this should not be necessary
(i.e., your entries should generally be uptodate). I did wonder if
checkout should be refreshing the index itself, but it would a bunch of
extra lstats in the common case.

 builtin/checkout.c        | 31 +++++++++++++++++++++++++------
 t/t2022-checkout-paths.sh | 17 +++++++++++++++++
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5410dac..67cab4e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -65,21 +65,40 @@ static int post_checkout_hook(struct commit *old, struct commit *new,
 static int update_some(const unsigned char *sha1, const char *base, int baselen,
 		const char *pathname, unsigned mode, int stage, void *context)
 {
-	int len;
+	struct strbuf buf = STRBUF_INIT;
 	struct cache_entry *ce;
+	int pos;
 
 	if (S_ISDIR(mode))
 		return READ_TREE_RECURSIVE;
 
-	len = baselen + strlen(pathname);
-	ce = xcalloc(1, cache_entry_size(len));
+	strbuf_add(&buf, base, baselen);
+	strbuf_addstr(&buf, pathname);
+
+	/*
+	 * If the entry is the same as the current index, we can leave the old
+	 * entry in place. Whether it is UPTODATE or not, checkout_entry will
+	 * do the right thing.
+	 */
+	pos = cache_name_pos(buf.buf, buf.len);
+	if (pos >= 0) {
+		struct cache_entry *old = active_cache[pos];
+		if (create_ce_mode(mode) == old->ce_mode &&
+		    !hashcmp(old->sha1, sha1)) {
+			old->ce_flags |= CE_UPDATE;
+			strbuf_release(&buf);
+			return 0;
+		}
+	}
+
+	ce = xcalloc(1, cache_entry_size(buf.len));
 	hashcpy(ce->sha1, sha1);
-	memcpy(ce->name, base, baselen);
-	memcpy(ce->name + baselen, pathname, len - baselen);
+	memcpy(ce->name, buf.buf, buf.len);
 	ce->ce_flags = create_ce_flags(0) | CE_UPDATE;
-	ce->ce_namelen = len;
+	ce->ce_namelen = buf.len;
 	ce->ce_mode = create_ce_mode(mode);
 	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
+	strbuf_release(&buf);
 	return 0;
 }
 
diff --git a/t/t2022-checkout-paths.sh b/t/t2022-checkout-paths.sh
index 8e3545d..f46d049 100755
--- a/t/t2022-checkout-paths.sh
+++ b/t/t2022-checkout-paths.sh
@@ -61,4 +61,21 @@ test_expect_success 'do not touch unmerged entries matching $path but not in $tr
 	test_cmp expect.next0 actual.next0
 '
 
+test_expect_success 'do not touch files that are already up-to-date' '
+	git reset --hard &&
+	echo one >file1 &&
+	echo two >file2 &&
+	git add file1 file2 &&
+	git commit -m base &&
+	echo modified >file1 &&
+	test-chmtime =1000000000 file2 &&
+	git update-index -q --refresh &&
+	git checkout HEAD -- file1 file2 &&
+	echo one >expect &&
+	test_cmp expect file1 &&
+	echo "1000000000	file2" >expect &&
+	test-chmtime -v +0 file2 >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.1.2.596.g7379948
