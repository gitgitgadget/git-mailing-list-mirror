From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/2] tree_entry_interesting: make recursive mode
 default
Date: Sun, 15 Jan 2012 17:03:27 +0700
Message-ID: <20120115100327.GA10735@do>
References: <1326341371-16628-1-git-send-email-pclouds@gmail.com>
 <1326533003-19686-1-git-send-email-pclouds@gmail.com>
 <1326533003-19686-2-git-send-email-pclouds@gmail.com>
 <7v8vl9wtfg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 15 11:04:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmMwU-0002h2-IL
	for gcvg-git-2@lo.gmane.org; Sun, 15 Jan 2012 11:04:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077Ab2AOKD6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Jan 2012 05:03:58 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40183 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935Ab2AOKD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2012 05:03:57 -0500
Received: by iagf6 with SMTP id f6so878101iag.19
        for <git@vger.kernel.org>; Sun, 15 Jan 2012 02:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HtdkirZ9s3kCvusEFxZwNr2XFSW518+y8PKG4WQ1KLw=;
        b=c16AJoEapK03ZbcebKjMWXOkvXX4kOpLakh340ppgW/cKKBqMF751N26rGMvOZb9HH
         N/y4Wf2xyoptMdSt58JyAykSqbBcGryheIf/in50klebaIHqUqrYByVwpcpUiAn6hoEA
         ewrdhmgZaZKIUs6OWPPb5IwZtpKqfyLiQdWVs=
Received: by 10.42.150.6 with SMTP id y6mr6561407icv.14.1326621836884;
        Sun, 15 Jan 2012 02:03:56 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.41.201])
        by mx.google.com with ESMTPS id pb6sm26226750igc.5.2012.01.15.02.03.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 Jan 2012 02:03:55 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 15 Jan 2012 17:03:27 +0700
Content-Disposition: inline
In-Reply-To: <7v8vl9wtfg.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188596>

On Sat, Jan 14, 2012 at 07:12:03PM -0800, Junio C Hamano wrote:
> That makes my head hurt and makes me suspect there is something
> fundamentally wrong in the patch.  Sigh...

I'll need to think about it. In the meantime perhaps the following
bandage patch would suffice, rather than revert 2f88c19 (diff-index:
pass pathspec down to unpack-trees machinery)

-- 8< --
Subject: [PATCH] diff-index: enable recursive pathspec matching in unpa=
ck_trees

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff-lib.c               |    2 ++
 t/t4010-diff-pathspec.sh |    8 ++++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 62f4cd9..fc0dff3 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -469,6 +469,8 @@ static int diff_cache(struct rev_info *revs,
 	opts.src_index =3D &the_index;
 	opts.dst_index =3D NULL;
 	opts.pathspec =3D &revs->diffopt.pathspec;
+	opts.pathspec->recursive =3D 1;
+	opts.pathspec->max_depth =3D -1;
=20
 	init_tree_desc(&t, tree->buffer, tree->size);
 	return unpack_trees(1, &t, &opts);
diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
index fbc8cd8..af5134b 100755
--- a/t/t4010-diff-pathspec.sh
+++ b/t/t4010-diff-pathspec.sh
@@ -48,6 +48,14 @@ test_expect_success \
      compare_diff_raw current expected'
=20
 cat >expected <<\EOF
+:100644 100644 766498d93a4b06057a8e49d23f4068f1170ff38f 0a41e115ab61be=
0328a19b29f18cdcb49338d516 M	path1/file1
+EOF
+test_expect_success \
+    '"*file1" should show path1/file1' \
+    'git diff-index --cached $tree -- "*file1" >current &&
+     compare_diff_raw current expected'
+
+cat >expected <<\EOF
 :100644 100644 766498d93a4b06057a8e49d23f4068f1170ff38f 0a41e115ab61be=
0328a19b29f18cdcb49338d516 M	file0
 EOF
 test_expect_success \
--=20
1.7.8.36.g69ee2

-- 8< --
--=20
Duy
