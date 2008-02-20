From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] fix "git push $there +HEAD"
Date: Wed, 20 Feb 2008 12:59:24 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802201226560.19024@iabervon.org>
References: <7vprurc3n8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 19:00:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRtEj-00012h-Sl
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 19:00:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756619AbYBTR71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 12:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756297AbYBTR71
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 12:59:27 -0500
Received: from iabervon.org ([66.92.72.58]:48621 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756568AbYBTR70 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 12:59:26 -0500
Received: (qmail 29646 invoked by uid 1000); 20 Feb 2008 17:59:24 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Feb 2008 17:59:24 -0000
In-Reply-To: <7vprurc3n8.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74527>

On Wed, 20 Feb 2008, Junio C Hamano wrote:

> An earlier commit 47d996a (push: support pushing HEAD to real
> branch name) added support for "git push $there HEAD" by
> introducing a rewrite rule for the refspecs obtained from the
> command line.  However, unlike the usual refspecs, it did not
> allow prefixing with '+' to mean forcing the branch.
> 
> This refactors the rewriting rule into a separate function, and
> teaches it to pay attention to a possible '+' prefix.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * If we were to do the "remote.*.push = HEAD" I mentioned
>    earlier for defeating the default "matching" behaviour while
>    pushing into shared repositories, we would need to apply the
>    same rewriting rule for the refspecs obtained from remote at
>    the beginning of do_push(), and that is what triggered this
>    refactoring.

If that's the ultimate goal, I think it would be better to have "<src>" 
treated as "<src>:<resolve of <src>>" instead of as "<src>:<src>" in 
match_refs(); and not do any special rewriting on the front end. How about 
this:

-----

commit a5de00049f4072e3ea54ff05bc265a4b48a5ce74
Author: Daniel Barkalow <barkalow@iabervon.org>
Date:   Wed Feb 20 12:54:05 2008 -0500

    Resolve value supplied for no-colon push refspecs
    
    When pushing a refspec like "HEAD", we used to treat it as
    "HEAD:HEAD", which didn't work without rewriting. Instead, we should
    resolve the ref. If it's a symref, further require it to point to a
    branch, to avoid doing anything especially unexpected. Also remove the
    rewriting previously added in builtin-push.
    
    Since the code for "HEAD" uses the regular refspec parsing, it
    automatically handles "+HEAD" without anything special.
    
    Passes the included test written by Junio Hamano.
    
    Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

diff --git a/builtin-push.c b/builtin-push.c
index c8cb63e..41df717 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -44,15 +44,6 @@ static void set_refspecs(const char **refs, int nr)
 			strcat(tag, refs[i]);
 			ref = tag;
 		}
-		if (!strcmp("HEAD", ref)) {
-			unsigned char sha1_dummy[20];
-			ref = resolve_ref(ref, sha1_dummy, 1, NULL);
-			if (!ref)
-				die("HEAD cannot be resolved.");
-			if (prefixcmp(ref, "refs/heads/"))
-				die("HEAD cannot be resolved to branch.");
-			ref = xstrdup(ref + 11);
-		}
 		add_refspec(ref);
 	}
 }
diff --git a/remote.c b/remote.c
index 6b56473..d2b19a8 100644
--- a/remote.c
+++ b/remote.c
@@ -643,9 +643,17 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		errs = 1;
 
 	if (!dst_value) {
+		unsigned char sha1[20];
+		int flag;
+
 		if (!matched_src)
 			return errs;
-		dst_value = matched_src->name;
+		dst_value = resolve_ref(matched_src->name, sha1, 1, &flag);
+		if (!dst_value ||
+		    ((flag & REF_ISSYMREF) && 
+		     prefixcmp(dst_value, "refs/heads/")))
+			die("%s cannot be resolved to branch.",
+			    matched_src->name);
 	}
 
 	switch (count_refspec_match(dst_value, dst, &matched_dst)) {
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 9d2dc33..3370d53 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -271,6 +271,27 @@ test_expect_success 'push with HEAD nonexisting at remote' '
 	check_push_result $the_commit heads/local
 '
 
+test_expect_success 'push with +HEAD' '
+
+	mk_test heads/master &&
+	git checkout master &&
+	git branch -D local &&
+	git checkout -b local &&
+	git push testrepo master local &&
+	check_push_result $the_commit heads/master &&
+	check_push_result $the_commit heads/local &&
+
+	# Without force rewinding should fail
+	git reset --hard HEAD^ &&
+	! git push testrepo HEAD &&
+	check_push_result $the_commit heads/local &&
+
+	# With force rewinding should succeed
+	git push testrepo +HEAD &&
+	check_push_result $the_first_commit heads/local
+
+'
+
 test_expect_success 'push with dry-run' '
 
 	mk_test heads/master &&
