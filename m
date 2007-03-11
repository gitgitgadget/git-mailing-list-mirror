From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fast-import: use binary search in tree_content_remove
Date: Sun, 11 Mar 2007 12:34:13 -0400
Message-ID: <20070311163412.GB7110@coredump.intra.peff.net>
References: <<20070310191515.GA3416@coredump.intra.peff.net>> <20070310192131.GB3875@coredump.intra.peff.net> <20070310192304.GB3416@coredump.intra.peff.net> <20070310194012.GA5126@coredump.intra.peff.net> <20070311033833.GB10781@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Mar 11 17:34:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQQzz-0005EV-3n
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 17:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933822AbXCKQeQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 12:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933820AbXCKQeQ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 12:34:16 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4250 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933818AbXCKQeP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 12:34:15 -0400
Received: (qmail 5800 invoked from network); 11 Mar 2007 12:34:35 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 11 Mar 2007 12:34:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Mar 2007 12:34:13 -0400
Content-Disposition: inline
In-Reply-To: <20070311033833.GB10781@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41941>

On Sat, Mar 10, 2007 at 10:38:33PM -0500, Shawn O. Pearce wrote:

> Well, its not necessary for you, as you aren't trying to remove
> something from your huge tree.  ;-)

Heh, I meant necessary as in "Oops, I probably just completely broke
fast-import". But I see I managed to do that anyway. :)

> Your patch is fine.  fast-import takes an "optimization" here and
> does not bother to actually delete entries from a tree until *after*

OK, that was my reading, as well; thanks for confirming.

> Jeff King's recent changes to sort trees by strictly name (and binary
> search to locate an entry) works OK up until we have to write a
> tree out that uses the funny name/mode sorting that native Git uses:

And here is a test that I believe triggers the problem (fails with my
patches, succeeds with your fix):

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 2e1a09f..2ec68b0 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -501,4 +501,54 @@ test_expect_success \
     'test `git-rev-parse --verify branch^1` \
 		= `git-rev-parse --verify K^1`'
 
+###
+### series L
+###
+
+cat >input <<INPUT_END
+blob
+mark :1
+data <<EOF
+some data
+EOF
+
+blob
+mark :2
+data <<EOF
+other data
+EOF
+
+commit refs/heads/L
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+create L
+COMMIT
+
+M 644 :1 b.
+M 644 :1 b/other
+M 644 :1 ba
+
+commit refs/heads/L
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+data <<COMMIT
+update L
+COMMIT
+
+M 644 :2 b.
+M 644 :2 b/other
+M 644 :2 ba
+INPUT_END
+
+cat >expect <<EXPECT_END
+:100644 100644 4268632... 55d3a52... M	b.
+:040000 040000 0ae5cac... 443c768... M	b
+:100644 100644 4268632... 55d3a52... M	ba
+EXPECT_END
+
+test_expect_success \
+    'L: verify internal tree sorting' \
+	'git-fast-import <input &&
+	 git-diff --raw L^ L >output &&
+	 diff -u expect output'
+
 test_done

> I'm plastering over the problem by resorting a tree strictly by
> name after it has been written out and the deleted entries have
> been filtered out.

I wonder if we could make this a bit cleaner by actually using the git
sort in the first place. I will take a look...

-Peff
