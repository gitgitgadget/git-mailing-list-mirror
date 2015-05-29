From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: For first push to a bare repo, using "--tags" prevents creation of master branch
Date: Fri, 29 May 2015 11:03:18 -0700
Message-ID: <xmqqsiafclcp.fsf@gitster.dls.corp.google.com>
References: <CABRuA+iVRZR9SxvYVCO5zd0hZEbn6tioyP6dZ5xSbaAeNF4w+w@mail.gmail.com>
	<vpqbnh4hro7.fsf@anie.imag.fr>
	<xmqq617bflzh.fsf@gitster.dls.corp.google.com>
	<vpq4mmvs7zx.fsf@anie.imag.fr>
	<xmqqeglze5cu.fsf@gitster.dls.corp.google.com>
	<vpqoal3p8wo.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Darling <darlingm@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 29 20:03:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyOcw-00008t-7G
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 20:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756423AbbE2SDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 14:03:21 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36883 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756126AbbE2SDU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 14:03:20 -0400
Received: by igbsb11 with SMTP id sb11so20561958igb.0
        for <git@vger.kernel.org>; Fri, 29 May 2015 11:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=cDgHodvUG8ODgnbA3UGRfC7XLYMF3qtzOhujD/VLYIo=;
        b=qDzTLjQ5MuiSzcdVM9nNjz2EGglTPzZ97kLWTg81NaWwtOq8otIFiDABwHLqwr0yIe
         MvEkuYsMCiELMQ2TzsKjivZY8Vh5itFR2MaKeaUneyGNJ/qslli2EAZA11kVv9XgSDk+
         FrN9J36sxIHCc87PEC6HnAqNRj4Xw2mNOKzphSc7mKXZbKrRdGxiDrECsAjEPhJ/f6pQ
         1RohS9uT1LYZj3yzypTM2+YUXjoIUuAC4Fl+yUrCsouDZm9064y/naSrT/wx3kMH5rtN
         DafMu6S7WV7EVR3cBCLI6vVb2aJmUPwCe/8sfnc4pMUccJWgNxLyH8YDRnj72GQqgL1M
         t5OA==
X-Received: by 10.107.134.67 with SMTP id i64mr11603853iod.90.1432922599773;
        Fri, 29 May 2015 11:03:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:89d0:c49e:8012:77d2])
        by mx.google.com with ESMTPSA id qh1sm2010746igb.17.2015.05.29.11.03.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 29 May 2015 11:03:19 -0700 (PDT)
In-Reply-To: <vpqoal3p8wo.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	29 May 2015 19:53:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270261>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I recall "fetch --tags" was updated to become your "--tags-also" by
>> e66ef7ae (Merge branch 'mh/fetch-tags-in-addition-to-normal-refs',
>> 2013-12-12).  Perhaps we should do the same on the push side.
>
> Would we still have a way to push tags only with this?
>
> fetch and push are a bit different: it's almost never a bad idea to run
> fetch (I see remote-tracking as a kind of cache, and fetch is the way to
> refresh this cache), but pushing too much can be harmful. Not a strong
> objection, but I'm not sure that this change is 100% safe for everyone.

Yeah, a possible fallout can be seen in the updates to the tests in
this patch.  I am undecided if "pushing can be harmful" should trump
"--tags should behave in a similar way for fetch and push that are
the reverse of each other".

If we are to introduce --tags-also (or --tags-too), we should add it
to fetch, too.


-- >8 --
Subject: [PATCH] push --tags: push tags *in addition to* other stuff

Earlier, we changed "git fetch --tags" from "fetch all tags instead
of what we would fetch without --tags argument" to "fetch all tags
in addition to what we would fetch without --tags argument" with
c5a84e92 (fetch --tags: fetch tags *in addition to* other stuff,
2013-10-30), which was merged as a part of a series at e66ef7ae.

This does the same to "git push --tags"; instead of pushing all tags
(and nothing else, as the command line does not have any other
refspec), the command now pushes all tags in addition to what "git
push" would have pushed.

The changes to the tests shows a possible fallout.  Both of them do
not set up the default push refspec, causing "git push" without any
refspecs on the command line to fail, which was OK because they do
not intend to do "git push" without any explicit refspec on the
command line.  But now "--tags" no longer is considered an explicit
refspec, the logic to find the refs to be pushed by default is
triggered to find what "other stuff" needs to be pushed, and causes
the "git push --tags" to fail.  As it is to push tags and nothing
else what these pushes want to do, replace these "git push --tags"
invocations with "git push" with an explicit "refs/tags/\*" refspec.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/push.c                   | 18 ++++++++++--------
 t/t5509-fetch-push-namespaces.sh |  2 +-
 t/t5516-fetch-push.sh            |  2 +-
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 57c138b..ec215d7 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -382,7 +382,7 @@ static int push_with_options(struct transport *transport, int flags)
 	return 1;
 }
 
-static int do_push(const char *repo, int flags)
+static int do_push(const char *repo, int flags, int tags_too)
 {
 	int i, errs;
 	struct remote *remote = pushremote_get(repo);
@@ -429,6 +429,10 @@ static int do_push(const char *repo, int flags)
 		} else if (!(flags & TRANSPORT_PUSH_MIRROR))
 			setup_default_push_refspecs(remote);
 	}
+
+	if (tags_too)
+		add_refspec("refs/tags/*");
+
 	errs = 0;
 	url_nr = push_url_of_remote(remote, &url);
 	if (url_nr) {
@@ -494,7 +498,7 @@ static int git_push_config(const char *k, const char *v, void *cb)
 int cmd_push(int argc, const char **argv, const char *prefix)
 {
 	int flags = 0;
-	int tags = 0;
+	int tags_too = 0;
 	int rc;
 	const char *repo = NULL;	/* default repository */
 	struct option options[] = {
@@ -504,7 +508,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT( 0 , "mirror", &flags, N_("mirror all refs"),
 			    (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE)),
 		OPT_BOOL( 0, "delete", &deleterefs, N_("delete refs")),
-		OPT_BOOL( 0 , "tags", &tags, N_("push tags (can't be used with --all or --mirror)")),
+		OPT_BOOL( 0 , "tags", &tags_too, N_("push tags (can't be used with --all or --mirror)")),
 		OPT_BIT('n' , "dry-run", &flags, N_("dry run"), TRANSPORT_PUSH_DRY_RUN),
 		OPT_BIT( 0,  "porcelain", &flags, N_("machine-readable output"), TRANSPORT_PUSH_PORCELAIN),
 		OPT_BIT('f', "force", &flags, N_("force updates"), TRANSPORT_PUSH_FORCE),
@@ -535,20 +539,18 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	git_config(git_push_config, &flags);
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
 
-	if (deleterefs && (tags || (flags & (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH_MIRROR))))
+	if (deleterefs &&
+	    (tags_too || (flags & (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH_MIRROR))))
 		die(_("--delete is incompatible with --all, --mirror and --tags"));
 	if (deleterefs && argc < 2)
 		die(_("--delete doesn't make sense without any refs"));
 
-	if (tags)
-		add_refspec("refs/tags/*");
-
 	if (argc > 0) {
 		repo = argv[0];
 		set_refspecs(argv + 1, argc - 1, repo);
 	}
 
-	rc = do_push(repo, flags);
+	rc = do_push(repo, flags, tags_too);
 	if (rc == -1)
 		usage_with_options(push_usage, options);
 	else
diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
index cc0b31f..2f9b0f0 100755
--- a/t/t5509-fetch-push-namespaces.sh
+++ b/t/t5509-fetch-push-namespaces.sh
@@ -30,7 +30,7 @@ test_expect_success 'pushing into a repository using a ref namespace' '
 		git ls-remote pushee-namespaced >actual &&
 		printf "$commit1\trefs/heads/master\n" >expected &&
 		test_cmp expected actual &&
-		git push pushee-namespaced --tags &&
+		git push pushee-namespaced "refs/tags/*" &&
 		git ls-remote pushee-namespaced >actual &&
 		printf "$commit0\trefs/tags/0\n" >>expected &&
 		printf "$commit1\trefs/tags/1\n" >>expected &&
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 8a5f236..9d54186 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -802,7 +802,7 @@ test_expect_success 'allow deleting a ref using --delete' '
 test_expect_success 'allow deleting a tag using --delete' '
 	mk_test testrepo heads/master &&
 	git tag -a -m dummy_message deltag heads/master &&
-	git push testrepo --tags &&
+	git push testrepo "refs/tags/*" &&
 	(cd testrepo && git rev-parse --verify -q refs/tags/deltag) &&
 	git push testrepo --delete tag deltag &&
 	(cd testrepo && test_must_fail git rev-parse --verify refs/tags/deltag)
-- 
2.4.2-540-gc413a76
