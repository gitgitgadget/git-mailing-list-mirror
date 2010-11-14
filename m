From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH w/o PGP] do not overwrite untracked during merge from
 unborn branch
Date: Sun, 14 Nov 2010 22:49:27 +0100
Message-ID: <20101114214927.GA29579@localhost>
References: <AANLkTimDnyzyV1FEEwEuxLfG1nSOcNa7Hzwt7DDssjba@mail.gmail.com>
 <20101114213453.GA29287@localhost>
 <20101114214601.GB29287@localhost>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gert Palok <gert@planc.ee>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 14 22:49:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHkSB-0002vR-DT
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 22:49:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376Ab0KNVt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Nov 2010 16:49:28 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51486 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932366Ab0KNVt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 16:49:27 -0500
Received: by bwz15 with SMTP id 15so4675722bwz.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 13:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=ifWxrAB34OvEITJNnJMNR1GWvzuFJHOPMzUKaVGAtp4=;
        b=ihYW4hf3BWvJXbboTXiuFCVWE51fpZ8pwBLPH697w+IFXog7pWgCQPzkjn0C0snfNk
         lPseuNDk3njcb8KPt301KAsly674Q2CnnuA2N+WG0LgpHsGdSStQ9cRGPvJm7kajunte
         q2oz8/Yg0BJ8p0LBfR4DYlaLOzIG3V5C/27Xk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=FaDJncKv8RXawjVvaVlX45Gg06bd3nSV1BWUodD81k2EM8UBtIi2NJYNvbS3tJ7Vo+
         HDPx2Y7Mt+UTMvt58PjNrDt3akI/H5yA2+BJItOFA7uqQ18wkF67r9lbX+gU6ZMHPB2O
         mI+aygx16A5//RdlUws8wWirJzPR5KcBqtfWE=
Received: by 10.204.73.78 with SMTP id p14mr5318185bkj.154.1289771365866;
        Sun, 14 Nov 2010 13:49:25 -0800 (PST)
Received: from darc.lan (p549A7640.dip.t-dialin.net [84.154.118.64])
        by mx.google.com with ESMTPS id r21sm2669481bkj.22.2010.11.14.13.49.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 13:49:24 -0800 (PST)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1PHkRz-0007lI-Rm; Sun, 14 Nov 2010 22:49:27 +0100
Content-Disposition: inline
In-Reply-To: <20101114214601.GB29287@localhost>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161451>

In case HEAD does not point to a valid commit yet, merge is
implemented as a hard reset. This will cause untracked files to be
overwritten.

Instead, assume the empty tree for HEAD and do a regular merge. An
untracked file will cause the merge to abort and do nothing. If no
conflicting files are present, the merge will have the same effect
as a hard reset.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Sun, Nov 14, 2010 at 10:46:02PM +0100, Clemens Buchacher wrote:
> --MfFXiAuoTsnnDAfZ
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
>
> This is based on next and does not apply cleanly to master because
> of t7607. I can rebase it to master, but then it will conflict with
> next later.

Without signature this time. Oops.

Clemens

 builtin/merge.c            |   20 +++++++++++++++++++-
 t/t7607-merge-overwrite.sh |   16 ++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 10f091b..7571c93 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -234,6 +234,24 @@ static void save_state(void)
 		die("not a valid object: %s", buffer.buf);
 }
 
+static void read_empty(unsigned const char *sha1, int verbose)
+{
+	int i = 0;
+	const char *args[6];
+
+	args[i++] = "read-tree";
+	if (verbose)
+		args[i++] = "-v";
+	args[i++] = "-m";
+	args[i++] = "-u";
+	args[i++] = EMPTY_TREE_SHA1_HEX;
+	args[i++] = sha1_to_hex(sha1);
+	args[i] = NULL;
+
+	if (run_command_v_opt(args, RUN_GIT_CMD))
+		die("read-tree failed");
+}
+
 static void reset_hard(unsigned const char *sha1, int verbose)
 {
 	int i = 0;
@@ -985,7 +1003,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			die("%s - not something we can merge", argv[0]);
 		update_ref("initial pull", "HEAD", remote_head->sha1, NULL, 0,
 				DIE_ON_ERR);
-		reset_hard(remote_head->sha1, 0);
+		read_empty(remote_head->sha1, 0);
 		return 0;
 	} else {
 		struct strbuf merge_names = STRBUF_INIT;
diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index e49dd80..d4a499d 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -127,4 +127,20 @@ test_expect_success SYMLINKS 'will not be confused by symlink in leading path' '
 	git checkout sub
 '
 
+cat >expect <<\EOF
+error: Untracked working tree file 'c0.c' would be overwritten by merge.
+fatal: read-tree failed
+EOF
+
+test_expect_success 'will not overwrite untracked file on unborn branch' '
+	git reset --hard c0 &&
+	git rm -fr . &&
+	git checkout --orphan new &&
+	cp important c0.c &&
+	test_must_fail git merge c0 2>out &&
+	test_cmp out expect &&
+	test_path_is_missing .git/MERGE_HEAD &&
+	test_cmp important c0.c
+'
+
 test_done
-- 
1.7.3.1.105.g84915
