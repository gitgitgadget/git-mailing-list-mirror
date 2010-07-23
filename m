From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/5] Teach "apply --index-info" to handle rename patches
Date: Fri, 23 Jul 2010 12:04:44 -0500
Message-ID: <20100723170444.GD2507@burratino>
References: <7vwsfb2k3u.fsf@gitster.siamese.dyndns.org>
 <1279742303-29817-1-git-send-email-ddkilzer@kilzer.net>
 <20100722075133.GA9292@burratino>
 <681325.9577.qm@web30002.mail.mud.yahoo.com>
 <20100723170103.GA2507@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Fri Jul 23 19:06:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcLhJ-000790-3h
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 19:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760116Ab0GWRGE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Jul 2010 13:06:04 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61595 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754304Ab0GWRGB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 13:06:01 -0400
Received: by yxg6 with SMTP id 6so1249919yxg.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 10:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=o2+VzXZwp0NeFYUvoMlhBfN4MexK1XL/eRt6GrZg+q0=;
        b=ip5V8q0w+DulWRZ4AJDhkBH5RK2/PekkfC2u2ssYtLvu3gC+Zz+5tCHn6+oRfQPfPr
         Zct28Sy8wIO7iBSMA5DFqraTE0/hjI9MGjXDkU+Qs09Sg/w5mg5DeaU46873d1LODCan
         HgVLQ321lNBGsp3+3FLn69hpLq4TNMTwIBGac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=EIDDz5WC19SEt4UTBYlj2Nug3HeFXAEK4l7EV85eFq87hLpT6yUeIf1lhByDHkAGqd
         8mhVAh/+8Rot/JxiA8D84ShBK3ZuYtfzP8Rxi5+ZnZvPSBOxSLnHbRPjGzedojE7Iv0Q
         u8a7AuSTySJZdT7jVZ3HlkXeJCgZnhBx28Pg4=
Received: by 10.90.93.9 with SMTP id q9mr3503542agb.92.1279904744532;
        Fri, 23 Jul 2010 10:05:44 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id h41sm467340qcz.1.2010.07.23.10.05.42
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 23 Jul 2010 10:05:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100723170103.GA2507@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151551>

=46rom: Junio C Hamano <gitster@pobox.com>
Date: Mon, 10 Nov 2008 15:49:03 -0800

With v1.5.3.2~14 (apply --index-info: fall back to current index for
mode changes, 2007-09-17), git apply learned to stop worrying
about the lack of diff index line when a file already present in the
current index had no content change.

But it still worries too much: for rename patches, it is checking
that both the old and new filename are present in the current
index.  This makes no sense, since a file rename generally
involves creating a file there was none before.

So just check the old filename.

Noticed while trying to use =E2=80=9Cgit rebase=E2=80=9D with diff.rena=
mes =3D copies.

[jn: add tests]

Reported-by: David D. Kilzer <ddkilzer@kilzer.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/apply.c |    3 +--
 t/t4150-am.sh   |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 12ef9ea..f38c1f7 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2979,8 +2979,7 @@ static void build_fake_ancestor(struct patch *lis=
t, const char *filename)
 		else if (get_sha1(patch->old_sha1_prefix, sha1))
 			/* git diff has no index line for mode/type changes */
 			if (!patch->lines_added && !patch->lines_deleted) {
-				if (get_current_sha1(patch->new_name, sha1) ||
-				    get_current_sha1(patch->old_name, sha1))
+				if (get_current_sha1(patch->old_name, sha1))
 					die("mode change for %s, which is not "
 						"in current HEAD", name);
 				sha1_ptr =3D sha1;
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 70b57de..1c3d8ed 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -116,6 +116,18 @@ test_expect_success setup '
 	git commit -m "added another file" &&
=20
 	git format-patch --stdout master >lorem-move.patch &&
+
+	git checkout -b rename &&
+	git mv file renamed &&
+	git commit -m "renamed a file" &&
+
+	git format-patch -M --stdout lorem >rename.patch &&
+
+	git reset --soft lorem^ &&
+	git commit -m "renamed a file and added another" &&
+
+	git format-patch -M --stdout lorem^ >rename-add.patch &&
+
 	# reset time
 	unset test_tick &&
 	test_tick
@@ -246,8 +258,42 @@ test_expect_success 'am -3 falls back to 3-way mer=
ge' '
 	git diff --exit-code lorem
 '
=20
+test_expect_success 'am can rename a file' '
+	grep "^rename from" rename.patch &&
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout lorem^0 &&
+	git am rename.patch &&
+	! test -d .git/rebase-apply &&
+	git update-index --refresh &&
+	git diff --exit-code rename
+'
+
+test_expect_success 'am -3 can rename a file' '
+	grep "^rename from" rename.patch &&
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout lorem^0 &&
+	git am -3 rename.patch &&
+	! test -d .git/rebase-apply &&
+	git update-index --refresh &&
+	git diff --exit-code rename
+'
+
+test_expect_success 'am -3 can rename a file after falling back to 3-w=
ay merge' '
+	grep "^rename from" rename-add.patch &&
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout lorem^0 &&
+	git am -3 rename-add.patch &&
+	! test -d .git/rebase-apply &&
+	git update-index --refresh &&
+	git diff --exit-code rename
+'
+
 test_expect_success 'am -3 -q is quiet' '
 	rm -fr .git/rebase-apply &&
+	git checkout -f lorem2 &&
 	git reset master2 --hard &&
 	sed -n -e "3,\$p" msg >file &&
 	head -n 9 msg >>file &&
--=20
1.7.2.rc3
