From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] read-cache: fix untracked cache invalidation when split-index is used
Date: Sun,  7 Jun 2015 17:40:52 +0700
Message-ID: <1433673652-27720-1-git-send-email-pclouds@gmail.com>
References: <xmqq1thodop8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, t.gummerer@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 07 12:41:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1Y0g-0005sM-Gr
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jun 2015 12:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbbFGKkz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Jun 2015 06:40:55 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36300 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbbFGKkx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2015 06:40:53 -0400
Received: by pdjm12 with SMTP id m12so81298391pdj.3
        for <git@vger.kernel.org>; Sun, 07 Jun 2015 03:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GQkLrwvqt0Fg3u5BGQB9JPTgM4QtGzy5vZOtEQZqpdY=;
        b=Y/U1HUkPrdSILokAfD67hcbZvZH+869g8wtFZJQBRxFQzxlFMylNnYfm8Esv9M4WGl
         Bp8pUz77rhhtNcRswtme9S17kC6qFa/XTwnahuz/ljSbsN8lpkY7dOEAaJvmW3Jy3+Fy
         DAmWXOpai5HShh72yj1b9poyOe3dwHRL40ljOJl7jiABgLtRMSX0wTSTaqg9tdov2xzu
         MV7PrmH5HMFg83dHRSwPMxgHUtkD3LN+gG3Qx0tkutvoWKMnCUk5C1UhZ2GDjn2Bi8mu
         ReFyv807BaKu6COCsUQN4uBlGecuJwbbUqoXNpTmMn8L4oqzxozHVEiyfegUUDgatHUf
         Kv4g==
X-Received: by 10.68.69.13 with SMTP id a13mr20384853pbu.122.1433673652525;
        Sun, 07 Jun 2015 03:40:52 -0700 (PDT)
Received: from lanh ([115.73.29.184])
        by mx.google.com with ESMTPSA id ie3sm11511250pbb.49.2015.06.07.03.40.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jun 2015 03:40:51 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 07 Jun 2015 17:41:03 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <xmqq1thodop8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270966>

Before this change, t7063.17 fails. The actual action though happens at
t7063.16 where the entry "two" is added back to index after being
removed in the .13. Here we expect a directory invalidate at .16 and
none at .17 where untracked cache is refreshed. But things do not go as
expected when GIT_TEST_SPLIT_INDEX is set.

The different behavior that happens at .16 when split index is used: th=
e
entry "two", when deleted at .13, is simply marked "deleted". When .16
executes, the entry resurfaces from the version in base index. This
happens in merge_base_index() where add_index_entry() is called to add
"two" back from the base index.

This is where the bug comes from. The add_index_entry() is called with
ADD_CACHE_KEEP_CACHE_TREE flag because this version of "two" is not new=
,
it does not break either cache-tree or untracked cache. The code should
check this flag and not invalidate untracked cache. This causes a secon=
d
invalidation violates test expectation. The fix is obvious.

Noticed-by: Thomas Gummerer <t.gummerer@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 PS. perhaps I should rename ADD_CACHE_KEEP_CACHE_TREE to
 ADD_CACHE_KEEP_CACHE, or add a new flag .._KEEP_UNTRACKED_CACHE to
 avoid confusion.

 On Sun, Jun 7, 2015 at 1:20 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
 > Thomas Gummerer <t.gummerer@gmail.com> writes:
 >
 >> When running the test suite with GIT_TEST_SPLIT_INDEX set, tests 17=
-18
 >> in t7063 fail. =C2=A0Unset GIT_TEST_SPLIT_INDEX at the beginning of=
 the test,
 >> in order to fix it.
 >
 > That is not fixing but sweeping the problem under the rug, is it?

 Indeed.

 > Duy, untracked-cache is a fairly new toy and I wouldn't be surprised
 > if it has un-thought-out interaction with split-index which is also
 > a fairly new exotic toy. =C2=A0As both are from you, can you take a =
look
 > at it?

 Still a bit slow to address, but I marked Thomas' mail for
 investigation when it came.

 > We may want to make it easier to run tests with TEST-SPLIT-INDEX, if
 > we envision that the feature will bring us sufficient benefit and we
 > would eventually want to encourage its use to more people. =C2=A0As =
it
 > stands now, only people who are curious enough opt into trying it
 > out by exporting the environment, which would be done by a tiny
 > minority of developers and users.

 Untracked cache, split index and the last part (*) all aim at a
 smaller user audience with large work trees. They are not really what
 a common user needs, but I hope they do have users.
=20
 We could make the test suite run twice, a normal run and a
 test-split-index run. But I'm not sure if it really justifies
 doubling test time. We will have to deal with this situation when/if
 pack-v4 is merged because we would want to exercise both v3 and v4 as
 much as possible.

 (*) the last part should keep index read time small enough even if
     the index is very large and avoid lstat() at refresh time with
     the help from watchman.

 read-cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 723d48d..309ccc7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -999,7 +999,8 @@ static int add_index_entry_with_check(struct index_=
state *istate, struct cache_e
 	}
 	pos =3D -pos-1;
=20
-	untracked_cache_add_to_index(istate, ce->name);
+	if (!(option & ADD_CACHE_KEEP_CACHE_TREE))
+		untracked_cache_add_to_index(istate, ce->name);
=20
 	/*
 	 * Inserting a merged entry ("stage 0") into the index
--=20
2.3.0.rc1.137.g477eb31
