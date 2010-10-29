From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] checkout: apply Dscho's dwim even with "--" present
Date: Fri, 29 Oct 2010 18:53:58 -0500
Message-ID: <20101029235358.GA21410@burratino>
References: <AANLkTinM863uZfRxy_1BW1fnfEPsPo8A2m86=Wxh7XGd@mail.gmail.com>
 <7vbp6c7ski.fsf@alter.siamese.dyndns.org>
 <20101029194639.GA1738@burratino>
 <7vsjzo691r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dun Peal <dunpealer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 30 01:55:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBynY-00089o-BZ
	for gcvg-git-2@lo.gmane.org; Sat, 30 Oct 2010 01:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758811Ab0J2Xzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 19:55:47 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54476 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209Ab0J2Xzp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 19:55:45 -0400
Received: by vws13 with SMTP id 13so486522vws.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 16:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Kl/W8FrZ3wCpGC+JK+fSczJ8D7eLAjgxhdTtwbb3+fU=;
        b=PThTpfAtkwxlqaI0iRrHuFyV11kEqbP5nh454UjWoHg/fybOUCkr+/L5UrL+kNZ7k4
         2DrtNcseDcE++L2Xr2K4rfoN0OQ9DGGjsY3k/igXfAOApIeocYwBaBTJsvqmgrG/LD4h
         fLYSLsQyXRD4C5swSjeH8WDa8cadd3kuebmyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CNSxs6WKIQoC7mxuhQkL0EzlQAMFOn3PbF9iowln/wWOYwxSzQxl7K6iyAN4yUfNm8
         wnig+cP2SVyoiw0jNY675LJBuLx9T6yJzPKT+PhxZ2GDqrROVMb8x/QeRAIi6O/xYmDX
         y6cOUAi7nH/7T+hHSKi7XFK3XXt8ey6ZVsTl4=
Received: by 10.224.174.8 with SMTP id r8mr1686742qaz.332.1288396544680;
        Fri, 29 Oct 2010 16:55:44 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id t35sm2863810qco.42.2010.10.29.16.55.42
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 29 Oct 2010 16:55:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vsjzo691r.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160367>

git reset and similar commands use -- to disambiguate between
revisions and paths on the command line.  The same syntax is not
necessary to specify a revision to git checkout (for convenience
and historical reasons, revisions are preferred over paths), but
for consistency it is accepted:

	git checkout master --; # check out master branch, not "master" file.

The autovivification of branches introduced by 70c9ac2f1 (DWIM "git
checkout frotz" to "git checkout -b frotz origin/frotz", 2009-10-18)
is currently disabled by that syntax, for no good reason.  Paranoid
scripts can still use

	git checkout --no-guess master

or even better,

	old=$(git rev-parse --verify HEAD)
	new=$(git rev-parse --verify refs/heads/master^0)
	git read-tree -m -u --exclude-standard $old $new
	git symbolic-ref -m "$me: switching branches" HEAD refs/heads/master

Requested-by: Dun Peal <dunpealer@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:

> That looks simpler than what I just did.  Can we have a few tests, too?

Sure.  The tests are not too heavy, though (e.g., no "ambiguous
ref" stuff).

>> -			    !check_filename(NULL, arg) &&
>> +			    (has_dash_dash || !check_filename(NULL, arg)) &&
>>  			    argc == 1) {

Should have been (argc == 2) in the has_dash_dash case.

 builtin/checkout.c            |   19 ++++++---
 t/t2010-checkout-ambiguous.sh |   83 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 9240faf..6c3de9f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -771,6 +771,12 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	 *   <ref> must be a valid tree, everything after the '--' must be
 	 *   a path.
 	 *
+	 *   Except: with no paths, if <something> does not resolve as
+	 *   an object, no -t nor -b was given, and there is a tracking
+	 *   branch whose name is <something> in one and only one remote,
+	 *   then this is a short-hand to fork local <something> from
+	 *   that remote-tracking branch.
+	 *
 	 * case 2: git checkout -- [<paths>]
 	 *
 	 *   everything after the '--' must be paths.
@@ -808,23 +814,24 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			arg = "@{-1}";
 
 		if (get_sha1_mb(arg, rev)) {
-			if (has_dash_dash)          /* case (1) */
-				die("invalid reference: %s", arg);
+			trace_printf("trace: guess = %d\n", dwim_new_local_branch);
 			if (!patch_mode &&
 			    dwim_new_local_branch &&
 			    opts.track == BRANCH_TRACK_UNSPECIFIED &&
 			    !opts.new_branch &&
-			    !check_filename(NULL, arg) &&
-			    argc == 1) {
+			    (has_dash_dash || !check_filename(NULL, arg)) &&
+			    (argc == has_dash_dash ? 2 : 1)) {
 				const char *remote = unique_tracking_name(arg);
 				if (!remote || get_sha1(remote, rev))
 					goto no_reference;
 				opts.new_branch = arg;
 				arg = remote;
 				/* DWIMmed to create local branch */
-			}
-			else
+			} else if (has_dash_dash) {	/* case (1) */
+				die("invalid reference: %s", arg);
+			} else {
 				goto no_reference;
+			}
 		}
 
 		/* we can't end up being in (2) anymore, eat the argument */
diff --git a/t/t2010-checkout-ambiguous.sh b/t/t2010-checkout-ambiguous.sh
index 7cc0a35..80ac7b5 100755
--- a/t/t2010-checkout-ambiguous.sh
+++ b/t/t2010-checkout-ambiguous.sh
@@ -4,10 +4,25 @@ test_description='checkout and pathspecs/refspecs ambiguities'
 
 . ./test-lib.sh
 
+test_branch_is () {
+	echo "refs/heads/$1" >expect &&
+	git symbolic-ref HEAD >actual &&
+	test_cmp expect actual
+}
+
 test_expect_success 'setup' '
+	git init upstream &&
+	(
+		cd upstream &&
+		test_commit upstream-commit &&
+		git branch -m upstream-topic
+	) &&
+	git remote add upstream upstream &&
+	git fetch upstream &&
 	echo hello >world &&
 	echo hello >all &&
 	git add all world &&
+	test_tick &&
 	git commit -m initial &&
 	git branch world
 '
@@ -32,6 +47,74 @@ test_expect_success 'non ambiguous call' '
 	git checkout all
 '
 
+test_expect_success "autovivification (Dscho's DWIM)" '
+	git checkout master &&
+	test_might_fail git branch -D upstream-topic &&
+	git checkout upstream-topic &&
+	git diff --exit-code upstream-topic upstream/upstream-topic &&
+	test_branch_is upstream-topic
+'
+
+test_expect_success 'autovivification with --' '
+	git checkout master &&
+	test_might_fail git branch -D upstream-topic &&
+	git checkout upstream-topic -- &&
+	git diff --exit-code upstream-topic upstream/upstream-topic &&
+	test_branch_is upstream-topic
+'
+
+test_expect_success 'no autovivification after --' '
+	git checkout master &&
+	test_might_fail git branch -D upstream-topic &&
+	test_must_fail git checkout -- upstream-topic &&
+	test_branch_is master
+'
+
+test_expect_success '--no-guess defeats autovivification' '
+	git checkout master &&
+	test_might_fail git branch -D upstream-topic &&
+	test_must_fail git checkout --no-guess upstream-topic &&
+	test_must_fail git checkout --no-guess upstream-topic -- &&
+	test_branch_is master
+'
+
+test_expect_success 'paths defeat autovivification' '
+	git checkout master &&
+	test_might_fail git branch -D upstream-topic &&
+	test_must_fail git checkout upstream-topic -- . &&
+	test_must_fail git checkout upstream-topic . &&
+	test_branch_is master
+'
+
+test_expect_success 'real branch defeats autovivification' '
+	git checkout master &&
+	git update-ref refs/heads/upstream-topic HEAD^0 &&
+	git checkout upstream-topic &&
+	test_must_fail git diff --exit-code upstream-topic upstream/upstream-topic &&
+	test_branch_is upstream-topic
+'
+
+test_expect_success '-t defeats autovivification' '
+	git checkout master &&
+	test_might_fail git branch -D upstream-topic &&
+	test_must_fail git checkout -t upstream-topic &&
+	test_branch_is master
+'
+
+test_expect_success 'checkout of remote-tracking branch detaches HEAD' '
+	git checkout master &&
+	test_might_fail git branch -D upstream-topic &&
+	git checkout upstream/upstream-topic &&
+	test_must_fail git symbolic-ref HEAD
+'
+
+test_expect_success 'checkout -t of remote-tracking branch does not detach HEAD' '
+	git checkout master &&
+	test_might_fail git branch -D upstream-topic &&
+	git checkout -t upstream/upstream-topic &&
+	test_branch_is upstream-topic
+'
+
 test_expect_success 'allow the most common case' '
 	git checkout world &&
 	test "refs/heads/world" = "$(git symbolic-ref HEAD)"
