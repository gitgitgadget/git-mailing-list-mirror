From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: For first push to a bare repo, using "--tags" prevents creation of master branch
Date: Fri, 29 May 2015 09:40:43 -0700
Message-ID: <xmqq617be3qs.fsf@gitster.dls.corp.google.com>
References: <CABRuA+iVRZR9SxvYVCO5zd0hZEbn6tioyP6dZ5xSbaAeNF4w+w@mail.gmail.com>
	<vpqbnh4hro7.fsf@anie.imag.fr>
	<xmqq617bflzh.fsf@gitster.dls.corp.google.com>
	<vpq4mmvs7zx.fsf@anie.imag.fr>
	<xmqqeglze5cu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Darling <darlingm@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 29 18:40:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyNL2-00018a-HZ
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 18:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756828AbbE2Qks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 12:40:48 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35771 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756177AbbE2Qkq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 12:40:46 -0400
Received: by igbyr2 with SMTP id yr2so18596923igb.0
        for <git@vger.kernel.org>; Fri, 29 May 2015 09:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=iJ/6GZwQ+QeAD1TKbFshp5PDs7HeYn8QPCTcwvj8UPY=;
        b=nyzBwSz0HQ6fPxhP1GJ4Wd2VqUKZ7UfzGrBVatFGUBYcLdiN3PoQq2KFphxlDZ11OY
         fsa8jCjqptXXrIuNWNZsxLHjsHVjD2eLHhuLJJZZZ4+NN4ptzM7VPojb/ASfCEueb+Wz
         4iRZkXpeTjxQR6KfeMYvl9LxXbovTTK5n1HowjpA95dRzJllpFVKbC/SMza5XghQO4sj
         lJbq9NRxkPIHiJgB8XWsIW9sBfJhsgBSIai/ucKi2GdgpYZ3eul+cXfJxZRSo/iB3GOj
         33V9lFjGEeaGXJCzY1DpHfs708aO5ff9DL+/Sk4C3c+eM5sGZE3hhnrcBtfaXXWZJrT8
         z7VQ==
X-Received: by 10.50.141.164 with SMTP id rp4mr5247739igb.2.1432917645326;
        Fri, 29 May 2015 09:40:45 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:89d0:c49e:8012:77d2])
        by mx.google.com with ESMTPSA id b15sm1851800igm.12.2015.05.29.09.40.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 29 May 2015 09:40:44 -0700 (PDT)
In-Reply-To: <xmqqeglze5cu.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 29 May 2015 09:05:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270254>

Junio C Hamano <gitster@pobox.com> writes:

> I recall "fetch --tags" was updated to become your "--tags-also" by
> e66ef7ae (Merge branch 'mh/fetch-tags-in-addition-to-normal-refs',
> 2013-12-12).  Perhaps we should do the same on the push side.




 builtin/push.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

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
