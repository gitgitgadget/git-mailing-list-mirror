From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH v3] do not overwrite untracked during merge from unborn
 branch
Date: Sun, 14 Nov 2010 23:07:49 +0100
Message-ID: <20101114220749.GA29786@localhost>
References: <AANLkTimDnyzyV1FEEwEuxLfG1nSOcNa7Hzwt7DDssjba@mail.gmail.com>
 <20101114213453.GA29287@localhost>
 <20101114214601.GB29287@localhost>
 <20101114214953.GB16413@burratino>
Reply-To: Clemens Buchacher <drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gert Palok <gert@planc.ee>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 23:07:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHkjq-0004oL-EV
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 23:07:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755535Ab0KNWHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Nov 2010 17:07:49 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41790 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912Ab0KNWHt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 17:07:49 -0500
Received: by bwz15 with SMTP id 15so4684556bwz.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 14:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:reply-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=/294aDo7NC6PTOkGXZpbDzxG7QxMYfjGsOMTdyUX57Y=;
        b=OGvS0wudPSdOpvU55asnky+lVKukcWtbSe7IMArPOmGQE9JIi7MH1f3jzJ7+cllRcN
         8da/itCg4bsYAszPBm7/WX3qBmkhRmWPg+FKQqHIVzVylABwfKrD6Yhl6rRA8pqZmwu8
         Ij1bVZ/x3XIw+gTy/kT8s6/0gEfV1R8BmRdf8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=ckfCEWKmCpIOE1mshiwiP60SyUQYnMXY0nVFdaPH1BkwcVV5dlHYx2nseww38F4rmb
         h1FHWNWNfEiPvdNfOm3onyO8Hcf3QAb0FHW9U3HMttpTMtlagbMslF0JHrDNJ5rSMMk2
         yn0A4+XDvNbgQqeGXPWrQatDk7Dk6r0EV5EZY=
Received: by 10.204.127.96 with SMTP id f32mr5227311bks.201.1289772467472;
        Sun, 14 Nov 2010 14:07:47 -0800 (PST)
Received: from darc.lan (p549A7640.dip.t-dialin.net [84.154.118.64])
        by mx.google.com with ESMTPS id d27sm2677404bkw.2.2010.11.14.14.07.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 14:07:46 -0800 (PST)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1PHkjl-0007on-Tw; Sun, 14 Nov 2010 23:07:49 +0100
Content-Disposition: inline
In-Reply-To: <20101114214953.GB16413@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161455>

In case HEAD does not point to a valid commit yet, merge is
implemented as a hard reset. This will cause untracked files to be
overwritten.

Instead, assume the empty tree for HEAD and do a regular merge. An
untracked file will cause the merge to abort and do nothing. If no
conflicting files are present, the merge will have the same effect
as a hard reset.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Sun, Nov 14, 2010 at 03:49:53PM -0600, Jonathan Nieder wrote:
>
> Naturally, this is the sort of patch that would want to be
> fast-tracked to master (or even maint) if it is in good shape.

Ok, no problem. This applies to master and maint.

Clemens

 builtin/merge.c            |   20 +++++++++++++++++++-
 t/t7607-merge-overwrite.sh |   16 ++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 10f091b..613543e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -234,6 +234,24 @@ static void save_state(void)
 		die("not a valid object: %s", buffer.buf);
 }
 
+static void read_empty(unsigned const char *sha1, int verbose)
+{
+	int i = 0;
+	const char *args[7];
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
index d82349a..3988900 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -84,4 +84,20 @@ test_expect_success 'will not overwrite removed file with staged changes' '
 	test_cmp important c1.c
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
