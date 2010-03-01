From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [RFC/PATCH 3/4] merge-file: add option to specify the marker size
Date: Mon,  1 Mar 2010 22:46:27 +0100
Message-ID: <0e7f1f44fa4a9150eb788740b70e4ad05ce2ca3b.1267479461.git.bert.wesarg@googlemail.com>
References: <b34a72b5be427e4ccbdd01d7b8f53683dfd80175.1267479461.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 01 22:46:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmDS2-0000k2-RG
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 22:46:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649Ab0CAVqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 16:46:42 -0500
Received: from mail-bw0-f212.google.com ([209.85.218.212]:43579 "EHLO
	mail-bw0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521Ab0CAVqj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 16:46:39 -0500
Received: by bwz4 with SMTP id 4so2234000bwz.28
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 13:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=r1cz61RbySREZfvevC1XeQpHb/ctwTqCEQVFxAnJzXE=;
        b=PEYKjKv5bxq8gBE54k9htYHAg2N8oWMDa9PAt5NlovttXZB6qSWP7LlB5H5X+0Qz6P
         VOyA+pzJ5wH4ckgu//vw6GT8qTQlO7RE30B0EHYbRqBX+08cmCFB66pm/SXgcE1ERNCU
         Nl4c2wO1TgT9+FqhchAWL6hLNtr1xaR5f965U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Z2h7TL7IDVKUASrwee1kjG22GLqG2AaUPAELm+lncjM9c0V5UCwC4Gwk/vzUmeNSNy
         vddlNQSnIQYyPLiUAAYBz8toknQ4hyp3GyMJOdeq9oIp2QhpjriaPizhj3XAcKNmRA5y
         CV0RjgKn6tB9xGYHdOBE/V2+0JSfQFYDiMI6Y=
Received: by 10.204.3.216 with SMTP id 24mr3608199bko.30.1267479997766;
        Mon, 01 Mar 2010 13:46:37 -0800 (PST)
Received: from localhost (drsd-4dbd936b.pool.mediaWays.net [77.189.147.107])
        by mx.google.com with ESMTPS id p13sm927754bkp.9.2010.03.01.13.46.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Mar 2010 13:46:37 -0800 (PST)
X-Mailer: git-send-email 1.7.0.584.g2da2b
In-Reply-To: <b34a72b5be427e4ccbdd01d7b8f53683dfd80175.1267479461.git.bert.wesarg@googlemail.com>
In-Reply-To: <b34a72b5be427e4ccbdd01d7b8f53683dfd80175.1267479461.git.bert.wesarg@googlemail.com>
References: <b34a72b5be427e4ccbdd01d7b8f53683dfd80175.1267479461.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141357>

This adds the abbility to specify the conflict marker size for merges outside
a git repository.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---

For merges inside a git repository, there is a proposed idea to use a --path
argument like git hash-object to get the marker size from git attributes.
Which I'm all for it. A second proposal is to give attributes as arguments to
git merge-file, which I suspect involves very intrusive changes.

There where also a suggestion that merge-file should support file arguments
that points to blob objects (ie. master:Makefile). I think the --path argument
would fit this usecase too.

There is also currently no sane upper bound for marker sizes. Neither in
the git attribute case nor in this patch.

 Documentation/git-merge-file.txt |    5 +++--
 builtin-merge-file.c             |    2 ++
 t/t6023-merge-file.sh            |   37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
index 234269a..a5b9c1f 100644
--- a/Documentation/git-merge-file.txt
+++ b/Documentation/git-merge-file.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git merge-file' [-L <current-name> [-L <base-name> [-L <other-name>]]]
-	[--ours|--theirs] [-p|--stdout] [-q|--quiet]
+	[--ours|--theirs] [-p|--stdout] [-q|--quiet] [--marker-size=<n>]
 	<current-file> <base-file> <other-file>
 
 
@@ -37,7 +37,8 @@ normally outputs a warning and brackets the conflict with lines containing
 If there are conflicts, the user should edit the result and delete one of
 the alternatives.  When `--ours` or `--theirs` option is in effect, however,
 these conflicts are resolved favouring lines from `<current-file>` or
-lines from `<other-file>` respectively.
+lines from `<other-file>` respectively.  The length of the conflict markers
+can be given with the `--marker-size` option.
 
 The exit value of this program is negative on error, and the number of
 conflicts otherwise. If the merge was clean, the exit value is 0.
diff --git a/builtin-merge-file.c b/builtin-merge-file.c
index 3389dd0..c1a35b9 100644
--- a/builtin-merge-file.c
+++ b/builtin-merge-file.c
@@ -41,6 +41,8 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 			    XDL_MERGE_FAVOR_OURS),
 		OPT_SET_INT(0, "theirs", &xmp.favor, "for conflicts, use their version",
 			    XDL_MERGE_FAVOR_THEIRS),
+		OPT_INTEGER(0, "marker-size", &xmp.marker_size,
+			    "for conflicts, use this marker size"),
 		OPT__QUIET(&quiet),
 		OPT_CALLBACK('L', NULL, names, "name",
 			     "set labels for file1/orig_file/file2", &label_cb),
diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index d605024..5034dd1 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -215,4 +215,41 @@ test_expect_success '"diff3 -m" style output (2)' '
 	test_cmp expect actual
 '
 
+cat >expect <<\EOF
+Dominus regit me,
+<<<<<<<<<< new8.txt
+et nihil mihi deerit;
+
+
+
+
+In loco pascuae ibi me collocavit;
+super aquam refectionis educavit me.
+||||||||||
+et nihil mihi deerit.
+In loco pascuae ibi me collocavit,
+super aquam refectionis educavit me;
+==========
+et nihil mihi deerit,
+
+
+
+
+In loco pascuae ibi me collocavit --
+super aquam refectionis educavit me,
+>>>>>>>>>> new9.txt
+animam meam convertit,
+deduxit me super semitas jusitiae,
+propter nomen suum.
+Nam et si ambulavero in medio umbrae mortis,
+non timebo mala, quoniam TU mecum es:
+virga tua et baculus tuus ipsa me consolata sunt.
+EOF
+
+test_expect_success 'marker size' '
+	test_must_fail git merge-file -p --marker-size=10 \
+		new8.txt new5.txt new9.txt >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.0.584.g2da2b
