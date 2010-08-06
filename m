From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 06/12] apply: run setup_git_directory_gently() sooner
Date: Thu, 5 Aug 2010 22:08:45 -0500
Message-ID: <20100806030844.GJ22369@burratino>
References: <20100626192203.GA19973@burratino>
 <7vpqzacs3h.fsf@alter.siamese.dyndns.org>
 <7v630hyf5r.fsf@alter.siamese.dyndns.org>
 <20100806023529.GB22369@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 05:10:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhDK2-00069j-63
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 05:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935336Ab0HFDKK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 23:10:10 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34915 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760380Ab0HFDKI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 23:10:08 -0400
Received: by yxg6 with SMTP id 6so2714149yxg.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 20:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=beV7DhY22Mpku1yLyT2Qv4eEqgHX7pAdiVb/VtNK4gQ=;
        b=m+UQfrpwLTX4RMOV/Bs1TMkKjq8Eu382u6uhcEMhIIoQow/gXmiWLc54MXi/8Xltk3
         ZwBk3Wva98mPdzngj6ttb4+ZpEwP01j57OLHjJ0yJpn/szDlUwYEIO+m/oPHvodXOgF+
         KBKb5sjCxkwN/qldw3/Is+uiFtt0HxF7xd9BI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ATXPcAKHp8VRiCRvamslt6zKYvWDLJP6igTCefVX96DFtH+fKzMqF18eiYyONFj1Js
         ExW+0TSmF+uNGP/oDRMrcdnd5C+I7eNe2+00o/jckQwZY8OT+Pt/KF/wP+bHdyMqV+mq
         /x4g8uh2tPMJxbODebdzSSf+a0z/lf8MSSTNE=
Received: by 10.100.248.16 with SMTP id v16mr3326507anh.42.1281064207589;
        Thu, 05 Aug 2010 20:10:07 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id f22sm1286620anh.4.2010.08.05.20.10.05
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 20:10:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100806023529.GB22369@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152751>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

As v1.7.2~16^2 (2010-07-14) explains, without this change,
=E2=80=9Cgit --paginate apply=E2=80=9D can ignore the repository-local
=E2=80=9C[core] pager=E2=80=9D configuration.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
New explanation and test; simplified patch by keeping the
is_not_gitdir local.

 builtin/apply.c  |    3 +--
 git.c            |    2 +-
 t/t7006-pager.sh |    3 +++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 562e534..08f3586 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3611,7 +3611,7 @@ int cmd_apply(int argc, const char **argv, const =
char *unused_prefix)
 {
 	int i;
 	int errs =3D 0;
-	int is_not_gitdir;
+	int is_not_gitdir =3D !startup_info->have_repository;
 	int binary;
 	int force_apply =3D 0;
=20
@@ -3684,7 +3684,6 @@ int cmd_apply(int argc, const char **argv, const =
char *unused_prefix)
 		OPT_END()
 	};
=20
-	prefix =3D setup_git_directory_gently(&is_not_gitdir);
 	prefix_length =3D prefix ? strlen(prefix) : 0;
 	git_config(git_apply_config, NULL);
 	if (apply_default_whitespace)
diff --git a/git.c b/git.c
index 0240179..82b390b 100644
--- a/git.c
+++ b/git.c
@@ -301,7 +301,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 		{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 		{ "annotate", cmd_annotate, RUN_SETUP },
-		{ "apply", cmd_apply },
+		{ "apply", cmd_apply, RUN_SETUP_GENTLY },
 		{ "archive", cmd_archive },
 		{ "bisect--helper", cmd_bisect__helper, RUN_SETUP | NEED_WORK_TREE }=
,
 		{ "blame", cmd_blame, RUN_SETUP },
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index fd7f77b..96fbb0f 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -399,4 +399,7 @@ test_no_local_config_subdir expect_success 'git sho=
rtlog'
 test_default_pager        expect_success 'git -p shortlog'
 test_core_pager_subdir    expect_success 'git -p shortlog'
=20
+test_core_pager_subdir    expect_success test_must_fail \
+                                         'git -p apply </dev/null'
+
 test_done
--=20
1.7.2.1.544.ga752d.dirty
