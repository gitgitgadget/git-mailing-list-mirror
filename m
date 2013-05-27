From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2] fetch: don't try to update unfetched tracking refs
Date: Mon, 27 May 2013 17:33:09 +0100
Message-ID: <20130527163308.GO27005@serenity.lan>
References: <9c6fd36368cd6b0fba4855be4d31106781c02f58.1369654825.git.john@keeping.me.uk>
 <20130527154252.GB8250@sigill.intra.peff.net>
 <20130527160129.GN27005@serenity.lan>
 <20130527161934.GB9235@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 27 18:33:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uh0MO-0003lS-Nr
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 18:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180Ab3E0QdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 12:33:20 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:37247 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566Ab3E0QdT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 12:33:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 0A18BCDA5D3;
	Mon, 27 May 2013 17:33:18 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WJzM7MbZOn1L; Mon, 27 May 2013 17:33:17 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 37CEDCDA5D1;
	Mon, 27 May 2013 17:33:10 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130527161934.GB9235@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225606>

Since commit f269048 (fetch: opportunistically update tracking refs,
2013-05-11) we update tracking refs opportunistically when fetching
remote branches.  However, if there is a configured non-pattern refspec
that does not match any of the refspecs given on the command line then a
fatal error occurs.

Fix this by setting the "missing_ok" flag when calling get_fetch_map.

Test-added-by: Jeff King <peff@peff.net>
Signed-off-by: John Keeping <john@keeping.me.uk>
Acked-by: Jeff King <peff@peff.net>
---
On Mon, May 27, 2013 at 12:19:34PM -0400, Jeff King wrote:
> On Mon, May 27, 2013 at 05:01:29PM +0100, John Keeping wrote:
> 
> > > I'm not sure I understand what the last sentence means. I tried to add a
> > > test like:
> > [...]
> > > but it does not fail with the existing code. Can you give an example
> > > that fails?
> > 
> > I have this in my .git/config for git.git:
> > 
> >     [remote "origin"]
> >             url = git://github.com/gitster/git
> >             fetch = +refs/heads/*:refs/remotes/origin/*
> >             fetch = +refs/notes/amlog:refs/notes/amlog
> 
> Ah, I see. It is not "the refspec on the command-line does not match a
> configured refspec", but rather "there exists a configured non-pattern
> refspec that does not match what was on the command-line (even if what
> was on the command-line did match another refspec)".

Exactly.  I've changed the commit message to (hopefully) make this
clearer.

> So your fix makes perfect sense. Do you mind squashing in this test
> below? I think it is a little less subtle than what you posted, as it
> sets up the situation explicitly in the test. It also checks that the
> refs we _did_ match still get updated ("master" in this case).

Done.

 builtin/fetch.c  |  2 +-
 t/t5510-fetch.sh | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e41cc0d..d15a734 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -183,7 +183,7 @@ static struct ref *get_ref_map(struct transport *transport,
 		old_tail = tail;
 		for (i = 0; i < transport->remote->fetch_refspec_nr; i++)
 			get_fetch_map(ref_map, &transport->remote->fetch[i],
-				      &tail, 0);
+				      &tail, 1);
 		for (rm = *old_tail; rm; rm = rm->next)
 			rm->fetch_head_status = FETCH_HEAD_IGNORE;
 	} else {
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ff43e08..fde6891 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -422,6 +422,22 @@ test_expect_success 'configured fetch updates tracking' '
 	)
 '
 
+test_expect_success 'non-matching refspecs do not confuse tracking update' '
+	cd "$D" &&
+	git update-ref refs/odd/location HEAD &&
+	(
+		cd three &&
+		git update-ref refs/remotes/origin/master base-origin-master &&
+		git config --add remote.origin.fetch \
+			refs/odd/location:refs/remotes/origin/odd &&
+		o=$(git rev-parse --verify refs/remotes/origin/master) &&
+		git fetch origin master &&
+		n=$(git rev-parse --verify refs/remotes/origin/master) &&
+		test "$o" != "$n" &&
+		test_must_fail git rev-parse --verify refs/remotes/origin/odd
+	)
+'
+
 test_expect_success 'pushing nonexistent branch by mistake should not segv' '
 
 	cd "$D" &&
-- 
1.8.3.rc3.438.gb3e4ae3
