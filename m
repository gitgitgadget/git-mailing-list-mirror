From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/6] sequencer: Expose API to cherry-picking machinery
Date: Sat, 13 Aug 2011 12:06:23 -0500
Message-ID: <20110813170623.GB1494@elie.gateway.2wire.net>
References: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
 <1313088705-32222-6-git-send-email-artagnon@gmail.com>
 <20110811215650.GA13839@elie.gateway.2wire.net>
 <CALkWK0migSRUmhPp0069O_NiRs3gQJbrU8QLdwUJ-kUYAsLz4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 13 19:06:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsHfP-0000pR-I3
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 19:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721Ab1HMRGb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Aug 2011 13:06:31 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:35396 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab1HMRGa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2011 13:06:30 -0400
Received: by gwaa12 with SMTP id a12so2578143gwa.19
        for <git@vger.kernel.org>; Sat, 13 Aug 2011 10:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FJlOMdh1fdKYTnTRCpvIW4lABOKPPWVjAYxEJgMman4=;
        b=UttoEIVdCwyDbrL9+dxmo7o1mz2/ZC0wgMwJIqKGl+0z/e5G7vZPrV/zG4sSnPoOHU
         AkwHd2qPuxE74mXhzBBoh7gtlXoKCoScRoB176PykVeMX+9ii9AiG/UORsvdg/3aBg6C
         69dp1pua/2zB7WODDi28N3twuV8sFh5fsBHWw=
Received: by 10.236.181.97 with SMTP id k61mr6948462yhm.264.1313255189950;
        Sat, 13 Aug 2011 10:06:29 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-68-255-106-30.dsl.chcgil.ameritech.net [68.255.106.30])
        by mx.google.com with ESMTPS id r28sm2406931yhm.52.2011.08.13.10.06.28
        (version=SSLv3 cipher=OTHER);
        Sat, 13 Aug 2011 10:06:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0migSRUmhPp0069O_NiRs3gQJbrU8QLdwUJ-kUYAsLz4Q@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179282>

Ramkumar Ramachandra wrote:
> Jonathan Nieder writes:

>> Another thought. =C2=A0I wonder if it's possible to leave
>> sequencer_parse_args() private to builtin/revert.c, making the split
>> a little more logical:
>
> Yes, I'd like this too.  However, there are two new issues:
> revert_or_cherry_pick_usage and action_name.  The former has two
> callsites: one in prepare_revs (in sequencer.c) and another in
> parse_args (in builtin/revert.c).

So it sounds like the answer is "no, it's not possible without
further changes".  Alas. :)  Thanks for checking.

(Q. Wait, what further changes?

 A. The above suggests that the setup_revisions call should also be
    the responsibility of the builtin, and that it could communicate
    revs and other rev-list options using a

	struct rev_info *revs;

    instead of

	int commit_argc;
	const char **commit_argv;

    Like this, maybe:

 builtin/revert.c |   52 ++++++++++++++++++++++++++++++----------------=
------
 1 files changed, 30 insertions(+), 22 deletions(-)

diff --git i/builtin/revert.c w/builtin/revert.c
index 8b452e81..f602ece0 100644
--- i/builtin/revert.c
+++ w/builtin/revert.c
@@ -55,13 +55,14 @@ struct replay_opts {
 	int allow_rerere_auto;
=20
 	int mainline;
-	int commit_argc;
-	const char **commit_argv;
=20
 	/* Merge strategy */
 	const char *strategy;
 	const char **xopts;
 	size_t xopts_nr, xopts_alloc;
+
+	/* Only used by the default subcommand ("git revert <revs>") */
+	struct rev_info *revs;
 };
=20
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
@@ -164,7 +165,7 @@ static void parse_args(int argc, const char **argv,=
 struct replay_opts *opts)
 			die(_("program error"));
 	}
=20
-	opts->commit_argc =3D parse_options(argc, argv, NULL, options, usage_=
str,
+	argc =3D parse_options(argc, argv, NULL, options, usage_str,
 					PARSE_OPT_KEEP_ARGV0 |
 					PARSE_OPT_KEEP_UNKNOWN);
=20
@@ -201,9 +202,6 @@ static void parse_args(int argc, const char **argv,=
 struct replay_opts *opts)
 				NULL);
 	}
=20
-	else if (opts->commit_argc < 2)
-		usage_with_options(usage_str, options);
-
 	if (opts->allow_ff)
 		verify_opt_compatible(me, "--ff",
 				"--signoff", opts->signoff,
@@ -211,7 +209,23 @@ static void parse_args(int argc, const char **argv=
, struct replay_opts *opts)
 				"-x", opts->record_origin,
 				"--edit", opts->edit,
 				NULL);
-	opts->commit_argv =3D argv;
+
+	if (opts->subcommand !=3D REPLAY_NONE) {
+		opts->revs =3D NULL;
+		if (argc > 1)
+			usage_with_options(usage_str, options);
+	} else {
+		opts->revs =3D xmalloc(sizeof(*opts->revs));
+		init_revisions(opts->revs, NULL);
+		opts->revs->no_walk =3D 1;
+
+		if (argc < 2)
+			usage_with_options(usage_str, options);
+
+		argc =3D setup_revisions(argc, argv, opts->revs, NULL);
+		if (argc > 1)
+			usage_with_options(usage_str, options);
+	}
 }
=20
 struct commit_message {
@@ -612,23 +626,15 @@ static int do_pick_commit(struct commit *commit, =
struct replay_opts *opts)
 	return res;
 }
=20
-static void prepare_revs(struct rev_info *revs, struct replay_opts *op=
ts)
+static void prepare_revs(struct replay_opts *opts)
 {
-	int argc;
-
-	init_revisions(revs, NULL);
-	revs->no_walk =3D 1;
 	if (opts->action !=3D REVERT)
-		revs->reverse =3D 1;
+		opts->revs->reverse ^=3D 1;
=20
-	argc =3D setup_revisions(opts->commit_argc, opts->commit_argv, revs, =
NULL);
-	if (argc > 1)
-		usage(*revert_or_cherry_pick_usage(opts));
-
-	if (prepare_revision_walk(revs))
+	if (prepare_revision_walk(opts->revs))
 		die(_("revision walk setup failed"));
=20
-	if (!revs->commits)
+	if (!opts->revs->commits)
 		die(_("empty commit set passed"));
 }
=20
@@ -825,14 +831,13 @@ static void read_populate_opts(struct replay_opts=
 **opts_ptr)
 static void walk_revs_populate_todo(struct commit_list **todo_list,
 				struct replay_opts *opts)
 {
-	struct rev_info revs;
 	struct commit *commit;
 	struct commit_list **next;
=20
-	prepare_revs(&revs, opts);
+	prepare_revs(opts);
=20
 	next =3D todo_list;
-	while ((commit =3D get_revision(&revs)))
+	while ((commit =3D get_revision(opts->revs)))
 		next =3D commit_list_append(commit, next);
 }
=20
@@ -955,6 +960,9 @@ static int pick_revisions(struct replay_opts *opts)
 	struct commit_list *todo_list =3D NULL;
 	unsigned char sha1[20];
=20
+	if (opts->subcommand =3D=3D REPLAY_NONE)
+		assert(opts->revs);
+
 	read_and_refresh_cache(opts);
=20
 	/*
--=20
)
