From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Git is not scalable with too many refs/*
Date: Fri, 30 Sep 2011 11:12:08 +0200
Message-ID: <4E8587E8.9070606@lsrfire.ath.cx>
References: <4DF6A8B6.9030301@op5.se> <7c0105c6cca7dd0aa336522f90617fe4@quantumfyre.co.uk> <4E84B89F.4060304@lsrfire.ath.cx> <201109291411.06733.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Fri Sep 30 11:12:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9Z8v-00042n-O1
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 11:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756964Ab1I3JMW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Sep 2011 05:12:22 -0400
Received: from india601.server4you.de ([85.25.151.105]:55515 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637Ab1I3JMV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 05:12:21 -0400
Received: from [192.168.2.104] (p4FFD9870.dip.t-dialin.net [79.253.152.112])
	by india601.server4you.de (Postfix) with ESMTPSA id 176EA2F803A;
	Fri, 30 Sep 2011 11:12:19 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0) Gecko/20110922 Thunderbird/7.0
In-Reply-To: <201109291411.06733.mfick@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182473>

Hi Martin,

Am 29.09.2011 22:11, schrieb Martin Fick:
> Your patch works well for me.  It achieves about the same=20
> gains as Julian's patch. Thanks!

OK, and what happens if you apply the following patch on top of my firs=
t
one?  It avoids going through all the refs a second time during cleanup=
,
at the cost of going through the list of all known objects.  I wonder i=
f
that's any faster in your case.

Thanks,
Ren=C3=A9


diff --git a/builtin/checkout.c b/builtin/checkout.c
index 84e0cdc..a4b1003 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -596,15 +596,14 @@ static int add_pending_uninteresting_ref(const ch=
ar *refname,
 	return 0;
 }
=20
-static int clear_commit_marks_from_one_ref(const char *refname,
-				      const unsigned char *sha1,
-				      int flags,
-				      void *cb_data)
+static void clear_commit_marks_for_all(unsigned int mark)
 {
-	struct commit *commit =3D lookup_commit_reference_gently(sha1, 1);
-	if (commit)
-		clear_commit_marks(commit, -1);
-	return 0;
+	unsigned int i, max =3D get_max_object_index();
+	for (i =3D 0; i < max; i++) {
+		struct object *object =3D get_indexed_object(i);
+		if (object && object->type =3D=3D OBJ_COMMIT)
+			object->flags &=3D ~mark;
+	}
 }
=20
 static void describe_one_orphan(struct strbuf *sb, struct commit *comm=
it)
@@ -690,8 +689,7 @@ static void orphaned_commit_warning(struct commit *=
commit)
 	else
 		describe_detached_head(_("Previous HEAD position was"), commit);
=20
-	clear_commit_marks(commit, -1);
-	for_each_ref(clear_commit_marks_from_one_ref, NULL);
+	clear_commit_marks_for_all(ALL_REV_FLAGS);
 }
=20
 static int switch_branches(struct checkout_opts *opts, struct branch_i=
nfo *new)
