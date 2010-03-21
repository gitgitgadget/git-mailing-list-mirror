From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 13/14] cherry-pick, revert: add a label for ancestor
Date: Sat, 20 Mar 2010 19:46:07 -0500
Message-ID: <20100321004607.GH23888@progeny.tock>
References: <7vr5ne908y.fsf@alter.siamese.dyndns.org>
 <20100321002535.GA23681@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 01:45:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt9I5-00037F-Tv
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 01:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200Ab0CUApM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 20:45:12 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:38347 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076Ab0CUApK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 20:45:10 -0400
Received: by gwaa18 with SMTP id a18so399905gwa.19
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 17:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4j35No83hqX/bh/5Xypev4xiXUSVk7rL5c6G6DRd7hU=;
        b=uvwlILmIuhfv4YTHWkjs38icBYrf1LrSboQgo5vFvboHhIxjzZIEUOL+KTtYYanTqQ
         dNEZB1HG2zoAnMfh3PWjCreLJXquPuR+2TEmnAFZ/LEM7571CY8OMnKW0z6bt/s915Sb
         /4KeFSQHb2fPbsWD3k5cfbI8vnsYqkktMVnRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=s9IX521l/Nz/97bSzHbrkGRppd/qD9p+ZlcBccbWVgHVIQh0pS12TRnkQfxG7De8NS
         hvAByCqyNLp1jQTWLGkzMlkemAO6F0jtc4Z0L4X/xnM3rwro4cvj3YUJrPzZyiXkJxP5
         M8bolA9VOIwUzm+A5PrGrgLMFu22nB6uTG+U0=
Received: by 10.150.170.11 with SMTP id s11mr4957306ybe.241.1269132310104;
        Sat, 20 Mar 2010 17:45:10 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm2765836iwn.2.2010.03.20.17.45.07
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Mar 2010 17:45:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100321002535.GA23681@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142781>

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
=46rom <http://thread.gmane.org/gmane.comp.version-control.git/142374/f=
ocus=3D142449>.

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
1.7.0.2
