From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 15/16 v2] cherry-pick, revert: add a label for ancestor
Date: Wed, 17 Mar 2010 22:34:11 -0500
Message-ID: <20100318033411.GC18193@progeny.tock>
References: <20100317113655.GA25470@progeny.tock>
 <20100317121546.GK25641@progeny.tock>
 <780e0a6b1003171309k75b33d3cpb4b1c6370d67942f@mail.gmail.com>
 <20100318031638.GA18193@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stefan Monnier <monnier@iro.umontreal.ca>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 04:33:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ns6UU-0002J8-Ld
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 04:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216Ab0CRDdm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 23:33:42 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:50032 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163Ab0CRDdl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 23:33:41 -0400
Received: by yxe29 with SMTP id 29so292488yxe.4
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 20:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=bpaDHNqp+oWkWmEM8D08h/z1IxEfSi56R9z2UXjiYH0=;
        b=QibhIZJkzT3OSCpXirfVlW5F73j9CJCSXKpdn0Pm7HgsfNLBodVL2zV5qkvxMw0zmQ
         LaRUOqfBcGlOz6Gw9DUcMmRnXGvjWdBjTB/OGe9PgzhOZddyKbPbD3pCs+nh8dh/lB1A
         uBxxrhSapmrXLDrFjQ1lPayrWy+EWVeMSHEwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=GFtbwJH+47IArhO6shXOQMO8UY2OSvRZGOMYeDCjrXkcKOEenvqupAm2/QwgH8XejV
         HkjfgzFlopAHmwFjZIo1GPTp/ojwNcKvMS9wn7kzv6Cf3idNCgrCIfkeObYHxbHfOWMe
         CTIcrd+rZrx9pofN3F2m5n8C5+88iIQjCW4BY=
Received: by 10.101.26.11 with SMTP id d11mr2818135anj.216.1268883220757;
        Wed, 17 Mar 2010 20:33:40 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm7082345iwn.3.2010.03.17.20.33.39
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Mar 2010 20:33:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100318031638.GA18193@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142449>

When writing conflict hunks in =E2=80=98diff3 -m=E2=80=99 format, also =
add a label to
the common ancestor.  Especially in a cherry-pick, it is not immediatel=
y
obvious without such a label what the common ancestor represents.

git rerere does not have trouble parsing the new output and its preimag=
e
ids are unchanged since it includes its own code for recreating conflic=
t
hunks.  No other code in git parses conflict hunks.

Requested-by: Stefan Monnier <monnier@iro.umontreal.ca>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/revert.c                |    5 ++++-
 t/t3507-cherry-pick-conflict.sh |    4 ++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index b314629..625281c 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -280,7 +280,7 @@ static int revert_or_cherry_pick(int argc, const ch=
ar **argv)
 {
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
-	const char *next_label;
+	const char *base_label, *next_label;
 	int i, index_fd, clean;
 	struct commit_message msg =3D { NULL, NULL, NULL, NULL, NULL };
=20
@@ -367,6 +367,7 @@ static int revert_or_cherry_pick(int argc, const ch=
ar **argv)
=20
 	if (action =3D=3D REVERT) {
 		base =3D commit;
+		base_label =3D msg.label;
 		next =3D parent;
 		next_label =3D msg.parent_label;
 		add_to_msg("Revert \"");
@@ -381,6 +382,7 @@ static int revert_or_cherry_pick(int argc, const ch=
ar **argv)
 		add_to_msg(".\n");
 	} else {
 		base =3D parent;
+		base_label =3D msg.parent_label;
 		next =3D commit;
 		next_label =3D msg.label;
 		set_author_ident_env(msg.message);
@@ -394,6 +396,7 @@ static int revert_or_cherry_pick(int argc, const ch=
ar **argv)
=20
 	read_cache();
 	init_merge_options(&o);
+	o.ancestor =3D base ? base_label : "(empty tree)";
 	o.branch1 =3D "HEAD";
 	o.branch2 =3D next ? next_label : "(empty tree)";
=20
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conf=
lict.sh
index 6a20817..e25cf80 100644
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -112,7 +112,7 @@ test_expect_success 'diff3 -m style' '
 	cat <<-EOF > expected &&
 	<<<<<<< HEAD
 	a
-	|||||||
+	||||||| parent of objid picked
 	b
 	=3D=3D=3D=3D=3D=3D=3D
 	c
@@ -179,7 +179,7 @@ test_expect_success 'revert conflict, diff3 -m styl=
e' '
 	cat <<-EOF > expected &&
 	<<<<<<< HEAD
 	a
-	|||||||
+	||||||| objid picked
 	c
 	=3D=3D=3D=3D=3D=3D=3D
 	b
--=20
1.7.0
