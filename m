From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH jn/fast-import-fix v3] fast-import: treat filemodify with
 empty tree as delete
Date: Wed, 26 Jan 2011 17:06:08 -0600
Message-ID: <20110126230608.GA26787@burratino>
References: <1291286420-13591-1-git-send-email-david.barr@cordelta.com>
 <20110103080130.GA8842@burratino>
 <20110103082458.GC8842@burratino>
 <20110126224104.GA20388@burratino>
 <AANLkTimNWLFgTk0Bueiscw-WkAX53v0Xsepn9esXOt7+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 27 00:06:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiERq-0003Cp-Sm
	for gcvg-git-2@lo.gmane.org; Thu, 27 Jan 2011 00:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943Ab1AZXGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 18:06:21 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:48326 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824Ab1AZXGU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 18:06:20 -0500
Received: by qyk12 with SMTP id 12so1616771qyk.19
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 15:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=mWsGzSFZFe1HCRSUyn0WLvztzS/EKT4s9z9g85sNXNo=;
        b=fDXodrZGwWvOJlNBnu3m6HJZZi3Ir5nvRolQgqUiLjGx98kVvIv31cIgO6fdEztXAT
         VDlM7D8M8SwdEqGgWKle+mulLpKqtTHw2/Ibnd3s/vf1s520OmSJUIL0a6bMBgzdJT4x
         YGEij+LeAw2AxHrA9mM56lGKxrUxllH0is5+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=jaL49QjlchXx7c/zfjMTaSeVdzB9jZwFLnIgihiNFOKD/KFH/sbZsO77dwJlmxHcK+
         X6M1iqDYWZGg6L0BsDBTLwDLbVjo2dB/pn35x+J8t9gcPsRY9KZFSjOc7YDk3m/mNalm
         ZenjKgRTeB3qX+/NJpbjCciVa5d5EKd6L1v5A=
Received: by 10.229.98.206 with SMTP id r14mr873003qcn.145.1296083179417;
        Wed, 26 Jan 2011 15:06:19 -0800 (PST)
Received: from burratino (adsl-69-209-75-28.dsl.chcgil.sbcglobal.net [69.209.75.28])
        by mx.google.com with ESMTPS id p13sm11357176qcu.29.2011.01.26.15.06.16
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 26 Jan 2011 15:06:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTimNWLFgTk0Bueiscw-WkAX53v0Xsepn9esXOt7+@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165561>

Date: Sat, 11 Dec 2010 16:42:28 -0600

Normal git processes do not allow one to build a tree with an empty
subtree entry without trying hard at it.  This is in keeping with the
general UI philosophy: git tracks content, not empty directories.

Unfortunately, v1.7.3-rc0~75^2 (2010-06-30) changed that by making it
easy to include an empty subtree in fast-import's active commit:

	M 040000 4b825dc642cb6eb9a060e54bf8d69288fbee4904 subdir

It is easy to trigger this by accident by reading an empty tree (for
example, the tree corresponding to an empty root commit) and trying to
move it to a subtree.  It would be better and more closely analogous
to "git read-tree --prefix" to treat such commands as a request to
remove ("to empty") the subdir.

Noticed-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Sverre Rabbelier wrote:

> Should it go on maint now that it's factored out, since it shipped in
> 1.7.3, or just master?

Hmm.  I suppose on top of b2124125 (jn/fast-import-fix).

While applying it there I noticed that the change to t9300 includes an
unrelated change (residue of an old rebase).  Here's a fixed version.

 fast-import.c          |   10 ++++++++++
 t/t9300-fast-import.sh |   42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index d881630..9cf26f1 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2194,6 +2194,16 @@ static void file_change_m(struct branch *b)
 		p = uq.buf;
 	}
 
+	/*
+	 * Git does not track empty, non-toplevel directories.
+	 */
+	if (S_ISDIR(mode) &&
+	    !memcmp(sha1, (const unsigned char *) EMPTY_TREE_SHA1_BIN, 20) &&
+	    *p) {
+		tree_content_remove(&b->branch_tree, p, NULL);
+		return;
+	}
+
 	if (S_ISGITLINK(mode)) {
 		if (inline_data)
 			die("Git links cannot be specified 'inline': %s",
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index dd90a09..ef3a347 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -875,6 +875,48 @@ test_expect_success \
 	 compare_diff_raw expect actual'
 
+test_expect_success \
+	'N: delete directory by copying' \
+	'cat >expect <<-\EOF &&
+	OBJID
+	:100644 000000 OBJID OBJID D	foo/bar/qux
+	OBJID
+	:000000 100644 OBJID OBJID A	foo/bar/baz
+	:000000 100644 OBJID OBJID A	foo/bar/qux
+	EOF
+	 empty_tree=$(git mktree </dev/null) &&
+	 cat >input <<-INPUT_END &&
+	commit refs/heads/N-delete
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	collect data to be deleted
+	COMMIT
+
+	deleteall
+	M 100644 inline foo/bar/baz
+	data <<DATA_END
+	hello
+	DATA_END
+	C "foo/bar/baz" "foo/bar/qux"
+	C "foo/bar/baz" "foo/bar/quux/1"
+	C "foo/bar/baz" "foo/bar/quuux"
+	M 040000 $empty_tree foo/bar/quux
+	M 040000 $empty_tree foo/bar/quuux
+
+	commit refs/heads/N-delete
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	delete subdirectory
+	COMMIT
+
+	M 040000 $empty_tree foo/bar/qux
+	INPUT_END
+	 git fast-import <input &&
+	 git rev-list N-delete |
+		git diff-tree -r --stdin --root --always |
+		sed -e "s/$_x40/OBJID/g" >actual &&
+	 test_cmp expect actual'
+
 test_expect_success \
 	'N: copy root directory by tree hash' \
 	'cat >expect <<-\EOF &&
 	:100755 000000 f1fb5da718392694d0076d677d6d0e364c79b0bc 0000000000000000000000000000000000000000 D	file3/newf
-- 
1.7.4.rc3
