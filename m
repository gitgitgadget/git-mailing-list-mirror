From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 4/9] Prevent diff machinery from examining worktree outside
	narrow checkout
Date: Fri, 15 Aug 2008 21:26:01 +0700
Message-ID: <20080815142601.GA10705@laptop>
References: <cover.1218807249.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 15 16:27:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU0H0-0005R0-M5
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 16:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755228AbYHOO0R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Aug 2008 10:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755255AbYHOO0R
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 10:26:17 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:29683 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755089AbYHOO0Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 10:26:16 -0400
Received: by yx-out-2324.google.com with SMTP id 8so739951yxm.1
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 07:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=kcIsKocHuoDY6kU0laUmhzlDLxd6bH0+jqURBCRnd0M=;
        b=nSykW5kxTg7LJAavYB6XLC6N+0SWY9QmdT+9Ff5+qC6OZVnV6vT+fPfFi3UOK7FR6r
         RYvPULF8Prlcxxpot+jJe1AvQqtd5D+AXu2SjW2WNPwd/eEdLZ5Jk/V0WoKkLGOE8Dxp
         n8EI7AJKWZZky72Osz/8nneumHrGiwLe+R54I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=B46RiEgb3ktwbJxJl/pusNdwBd+vk6kKRpMoUtJDY5RqZJuAvGoD/zlbalqElnf9M4
         n4CQP/yCUoJqEfaYKIMqP0wlAE6kfx4UXQU92QjTY8sSh101oilsTwBQKMIs4330UUmG
         kb4STDoWAzPxVYQ+zrnfk85O2j+60Tj1ARqdY=
Received: by 10.114.166.1 with SMTP id o1mr2554938wae.119.1218810375237;
        Fri, 15 Aug 2008 07:26:15 -0700 (PDT)
Received: from pclouds@gmail.com ( [125.234.152.212])
        by mx.google.com with ESMTPS id a8sm143343poa.12.2008.08.15.07.26.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Aug 2008 07:26:14 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 15 Aug 2008 21:26:01 +0700
Content-Disposition: inline
In-Reply-To: <cover.1218807249.git.pclouds@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92478>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff-lib.c |    5 +++--
 diff.c     |    4 +++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index e7eaff9..4fffd31 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -159,7 +159,7 @@ int run_diff_files(struct rev_info *revs, unsigned =
int option)
 				continue;
 		}
=20
-		if (ce_uptodate(ce))
+		if (ce_uptodate(ce) || ce_no_checkout(ce))
 			continue;
=20
 		changed =3D check_removed(ce, &st);
@@ -346,6 +346,8 @@ static void do_oneway_diff(struct unpack_trees_opti=
ons *o,
 	struct rev_info *revs =3D cbdata->revs;
 	int match_missing, cached;
=20
+	/* if the entry is not checked out, don't examine work tree */
+	cached =3D o->index_only || ce_no_checkout(idx);
 	/*
 	 * Backward compatibility wart - "diff-index -m" does
 	 * not mean "do not ignore merges", but "match_missing".
@@ -353,7 +355,6 @@ static void do_oneway_diff(struct unpack_trees_opti=
ons *o,
 	 * But with the revision flag parsing, that's found in
 	 * "!revs->ignore_merges".
 	 */
-	cached =3D o->index_only;
 	match_missing =3D !revs->ignore_merges;
=20
 	if (cached && idx && ce_stage(idx)) {
diff --git a/diff.c b/diff.c
index a6c1432..ad164a5 100644
--- a/diff.c
+++ b/diff.c
@@ -1716,8 +1716,10 @@ static int reuse_worktree_file(const char *name,=
 const unsigned char *sha1, int
=20
 	/*
 	 * If ce matches the file in the work tree, we can reuse it.
+	 * For narrow checkout case, ce_uptodate() may be true although
+	 * the file may or may not exist in the work tree.
 	 */
-	if (ce_uptodate(ce) ||
+	if ((ce_uptodate(ce) && ce_checkout(ce)) ||
 	    (!lstat(name, &st) && !ce_match_stat(ce, &st, 0)))
 		return 1;
=20
--=20
1.6.0.rc3.250.g8dd0
