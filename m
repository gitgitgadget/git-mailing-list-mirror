From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 9/9] checkout: add new options to support narrow checkout
Date: Fri, 15 Aug 2008 21:27:30 +0700
Message-ID: <20080815142730.GA10781@laptop>
References: <cover.1218807249.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 15 16:29:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU0Ig-00069p-J5
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 16:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757521AbYHOO1q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Aug 2008 10:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756655AbYHOO1p
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 10:27:45 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:40055 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756539AbYHOO1o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 10:27:44 -0400
Received: by wa-out-1112.google.com with SMTP id j37so532801waf.23
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 07:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=S7d9HRC51N1oQApXDDlFQk7tujXrTc8kRTsbTYrgjUY=;
        b=WM5mgl+n4WqDmBB22luZWUte4p97xPuBVa1JIYfcUtXqZc6NPWIWIKPGpkyCRdef+6
         lkV4KgF8ICLXDQcGMq2EZJSco353RjuY/nr2e4GMh5Cj06zWbtbfyIOlrH51MsYJmRHl
         XDi1Rh4OBh0OCXMi3yhCa8a4KfZhFlhrxu9W4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=avkSsrJVBUPOpQWOY6ZaThSWJF9RJlfVdniA93IDa+8ejuzeg/lMEMhVOSz0r9CZnK
         1vpRFIp4Hjn5K8ANxSaUTzYJ7Ph4xsLwJFdieUcqwI5SGls+6YCvANysLALecchENwBQ
         SMbmiRlyh9IK6GGOf+NMkqyx85yBTbAc4WZ+A=
Received: by 10.115.110.1 with SMTP id n1mr2557193wam.66.1218810463743;
        Fri, 15 Aug 2008 07:27:43 -0700 (PDT)
Received: from pclouds@gmail.com ( [125.234.152.212])
        by mx.google.com with ESMTPS id z15sm59984pod.2.2008.08.15.07.27.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Aug 2008 07:27:42 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 15 Aug 2008 21:27:30 +0700
Content-Disposition: inline
In-Reply-To: <cover.1218807249.git.pclouds@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92482>

These options include:

 --full: return to full checkout (default)
 --path: narrow checkout to some areas according to given spec
 --add-path/--remove-path: adjust current narrow checkout

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-checkout.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index e95eab9..f2254c6 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -160,6 +160,11 @@ struct checkout_opts {
 	char *new_branch;
 	int new_branch_log;
 	enum branch_track track;
+
+	char *new_path;
+	char *add_path;
+	char *remove_path;
+	int no_narrow_checkout;
 };
=20
 static int reset_tree(struct tree *tree, struct checkout_opts *o, int =
worktree)
@@ -255,6 +260,23 @@ static int merge_working_tree(struct checkout_opts=
 *opts,
 		tree =3D parse_tree_indirect(new->commit->object.sha1);
 		init_tree_desc(&trees[1], tree->buffer, tree->size);
=20
+		if (opts->no_narrow_checkout) {
+			/* leave narrow_spec NULL */
+			topts.new_narrow_path =3D 1;
+		}
+		else if (opts->new_path) {
+			topts.narrow_spec =3D opts->new_path;
+			topts.new_narrow_path =3D 1;
+		}
+		else if (opts->add_path) {
+			topts.narrow_spec =3D opts->add_path;
+			topts.add_narrow_path =3D 1;
+		}
+		else if (opts->remove_path) {
+			topts.narrow_spec =3D opts->remove_path;
+			topts.remove_narrow_path =3D 1;
+		}
+
 		ret =3D unpack_trees(2, trees, &topts);
 		if (ret =3D=3D -1) {
 			/*
@@ -428,6 +450,10 @@ int cmd_checkout(int argc, const char **argv, cons=
t char *prefix)
 			BRANCH_TRACK_EXPLICIT),
 		OPT_BOOLEAN('f', NULL, &opts.force, "force"),
 		OPT_BOOLEAN('m', NULL, &opts.merge, "merge"),
+		OPT_BOOLEAN(0, "full", &opts.no_narrow_checkout, "quit sparse checko=
ut"),
+		OPT_STRING(0, "path", &opts.new_path, "prefixes", "apply new narrow =
checkout path"),
+		OPT_STRING(0, "add-path", &opts.add_path, "prefixes", "add more chec=
kout area"),
+		OPT_STRING(0, "remove-path", &opts.remove_path, "prefixes", "narrow =
checkout area"),
 		OPT_END(),
 	};
 	int has_dash_dash;
@@ -460,6 +486,18 @@ int cmd_checkout(int argc, const char **argv, cons=
t char *prefix)
 	if (opts.track =3D=3D -1)
 		opts.track =3D git_branch_track;
=20
+	if (((opts.no_narrow_checkout ? 1 : 0) +
+	     (opts.new_path ? 1 : 0) +
+	     (opts.add_path ? 1 : 0) +
+	     (opts.remove_path ? 1 : 0)) > 1)
+		die("git checkout: --path, --full, --add-path and --remove-path are =
incompatible");
+
+	if (opts.new_branch && (opts.add_path || opts.remove_path))
+		die("git checkout: --add-path and --remove-path should only be used =
on current branch");
+
+	if (opts.new_branch && opts.no_narrow_checkout)
+		die("git checkout: switching branch with --full does not make sense"=
);
+
 	if (opts.force && opts.merge)
 		die("git checkout: -f and -m are incompatible");
=20
@@ -550,6 +588,9 @@ no_reference:
 			}
 		}
=20
+		if (opts.no_narrow_checkout || opts.new_path || opts.add_path || opt=
s.remove_path)
+			die("git checkout: updating paths is incompatible with setting spar=
se checkout");
+
 		return checkout_paths(source_tree, pathspec);
 	}
=20
--=20
1.6.0.rc3.250.g8dd0
