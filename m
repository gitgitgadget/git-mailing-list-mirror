From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH] Add test for ignoring pushInsteadOf when remote has
 explicit pushurl
Date: Tue, 8 Sep 2009 00:41:48 -0700
Message-ID: <20090908074147.GB3236@feather>
References: <cover.1252313313.git.josh@joshtriplett.org>
 <5e58748923d9b4a182499a6ba8fa4636bce4810e.1252313313.git.josh@joshtriplett.org>
 <7vws49gbql.fsf@alter.siamese.dyndns.org>
 <20090908071513.GA3236@feather>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 09:42:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkvL6-0004GT-Re
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 09:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865AbZIHHl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 03:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753853AbZIHHl7
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 03:41:59 -0400
Received: from relay4-v.mail.gandi.net ([217.70.178.78]:52204 "EHLO
	relay4-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753847AbZIHHl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 03:41:58 -0400
Received: from feather (pool-173-50-250-234.ptldor.fios.verizon.net [173.50.250.234])
	by relay4-v.mail.gandi.net (Postfix) with ESMTP id 12CE9BA26;
	Tue,  8 Sep 2009 09:41:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090908071513.GA3236@feather>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127985>

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---

On Tue, Sep 08, 2009 at 12:15:13AM -0700, Josh Triplett wrote:
> On Tue, Sep 08, 2009 at 12:02:42AM -0700, Junio C Hamano wrote:
> > Josh Triplett <josh@joshtriplett.org> writes:
> > 
> > > This configuration option allows systematically rewriting fetch-only
> > > URLs to push-capable URLs when used with push.  For instance:
> > >
> > > [url "ssh://example.org/"]
> > >     pushInsteadOf = "git://example.org/"
> > >
> > > This will allow clones of "git://example.org/path/to/repo" to
> > > subsequently push to "ssh://example.org/path/to/repo", without manually
> > > configuring pushurl for that remote.
> > >
> > > Includes documentation for the new option, bash completion updates, and
> > > test cases (both that pushInsteadOf applies to push and that it does
> > > *not* apply to fetch).
> > 
> > Thanks.
> > 
> > I will queue these patches, but I presume you would also want to add a
> > test that pushInsteadOf is ignored for remotes with an explicit pushURL?
> 
> Will do.

Done.  Please add this to the queue, optionally squashing it into patch
2/2 if you prefer.

 t/t5516-fetch-push.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 8f455c7..6889a53 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -193,6 +193,22 @@ test_expect_success 'push with pushInsteadOf' '
 	)
 '
 
+test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf should not rewrite)' '
+	mk_empty &&
+	TRASH="$(pwd)/" &&
+	git config "url.trash2/.pushInsteadOf" trash/ &&
+	git config remote.r.url trash/wrong &&
+	git config remote.r.pushurl "$TRASH/testrepo" &&
+	git push r refs/heads/master:refs/remotes/origin/master &&
+	(
+		cd testrepo &&
+		r=$(git show-ref -s --verify refs/remotes/origin/master) &&
+		test "z$r" = "z$the_commit" &&
+
+		test 1 = $(git for-each-ref refs/remotes/origin | wc -l)
+	)
+'
+
 test_expect_success 'push with matching heads' '
 
 	mk_test heads/master &&
-- 
1.6.3.3
