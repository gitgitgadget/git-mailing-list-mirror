From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] cherry-pick: do not segfault without arguments.
Date: Thu, 10 Oct 2013 12:41:17 -0400
Message-ID: <20131010164116.GB21489@sigill.intra.peff.net>
References: <1380895752-5286-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: hiroshige88@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
	git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Oct 10 18:41:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUJIn-00027j-15
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 18:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756826Ab3JJQlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Oct 2013 12:41:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:47012 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755784Ab3JJQlU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Oct 2013 12:41:20 -0400
Received: (qmail 2579 invoked by uid 102); 10 Oct 2013 16:41:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Oct 2013 11:41:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Oct 2013 12:41:17 -0400
Content-Disposition: inline
In-Reply-To: <1380895752-5286-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235869>

On Fri, Oct 04, 2013 at 04:09:12PM +0200, Stefan Beller wrote:

> Commit 182d7dc46b (2013-09-05, cherry-pick: allow "-" as abbreviation of
> '@{-1}') accesses the first argument without checking whether it exists.

I think this is an obviously correct fix for the immediate segfault,
but...

> diff --git a/builtin/revert.c b/builtin/revert.c
> index 52c35e7..f81a48c 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -202,7 +202,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
>  	memset(&opts, 0, sizeof(opts));
>  	opts.action = REPLAY_PICK;
>  	git_config(git_default_config, NULL);
> -	if (!strcmp(argv[1], "-"))
> +	if (argc > 1 && !strcmp(argv[1], "-"))
>  		argv[1] = "@{-1}";
>  	parse_args(argc, argv, &opts);
>  	res = sequencer_pick_revisions(&opts);

Why are we looking at argv/argc at all before calling parse_args? We
would want to allow options to come before the "-", no?

In other words, I think the right fix is more like this:

-- >8 --
Subject: [PATCH] cherry-pick: handle "-" after parsing options

Currently, we only try converting argv[1] from "-" into
"@{-1}".  This means we do not notice "-" when used together
with an option. We can fix this by doing the substitution
after we know any remaining options must be revisions.

Since we now also come after the check that there is
something in argv to cherry-pick, this has the added bonus
of avoiding a segfault when "git cherry-pick" is run with no
options.

Noticed-by: Stefan Beller <stefanbeller@googlemail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
I still am unsure if we should be more robust about finding "-" in other
options. For example, I think you can cherry-pick multiple commits these
days. Should we allow something like:

  git cherry-pick foo~2 - bar~5

Certainly the convenience of "-" over "@{-1}" is not as big a deal if
you are cherry-picking more than one item, but it seems like we should
treat it consistently.

 builtin/revert.c              |  4 ++--
 t/t3501-revert-cherry-pick.sh | 12 ++++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 52c35e7..87659c9 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -168,6 +168,8 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		opts->revs->no_walk = REVISION_WALK_NO_WALK_UNSORTED;
 		if (argc < 2)
 			usage_with_options(usage_str, options);
+		if (!strcmp(argv[1], "-"))
+			argv[1] = "@{-1}";
 		memset(&s_r_opt, 0, sizeof(s_r_opt));
 		s_r_opt.assume_dashdash = 1;
 		argc = setup_revisions(argc, argv, opts->revs, &s_r_opt);
@@ -202,8 +204,6 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	opts.action = REPLAY_PICK;
 	git_config(git_default_config, NULL);
-	if (!strcmp(argv[1], "-"))
-		argv[1] = "@{-1}";
 	parse_args(argc, argv, &opts);
 	res = sequencer_pick_revisions(&opts);
 	if (res < 0)
diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index bff6ffe..51f3bbb 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -129,4 +129,16 @@ test_expect_success 'cherry-pick "-" is meaningless without checkout' '
 	)
 '
 
+test_expect_success 'cherry-pick "-" works with arguments' '
+	git checkout -b side-branch &&
+	test_commit change actual change &&
+	git checkout master &&
+	git cherry-pick -s - &&
+	echo "Signed-off-by: C O Mitter <committer@example.com>" >expect &&
+	git cat-file commit HEAD | grep ^Signed-off-by: >signoff &&
+	test_cmp expect signoff &&
+	echo change >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.4.1.4.gf327177
