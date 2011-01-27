From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v4] fast-import: treat filemodify with empty tree as delete
Date: Thu, 27 Jan 2011 00:07:49 -0600
Message-ID: <20110127060749.GA5586@burratino>
References: <1291286420-13591-1-git-send-email-david.barr@cordelta.com>
 <20110103080130.GA8842@burratino>
 <20110103082458.GC8842@burratino>
 <20110126224104.GA20388@burratino>
 <AANLkTimNWLFgTk0Bueiscw-WkAX53v0Xsepn9esXOt7+@mail.gmail.com>
 <20110126230608.GA26787@burratino>
 <7vd3nji54o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 27 07:08:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiL1e-0003QL-16
	for gcvg-git-2@lo.gmane.org; Thu, 27 Jan 2011 07:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205Ab1A0GID (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jan 2011 01:08:03 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58147 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835Ab1A0GIB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jan 2011 01:08:01 -0500
Received: by gyb11 with SMTP id 11so468732gyb.19
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 22:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=UqEC6vOq6fCU7lCBzoFKYSioJ9XgJGECyM/XaXfueOE=;
        b=Q7GpDjKQQK42YJYIclszGwzP1eMsJ7VhKMotwlB+XujbDHinHDnLTzyVI2Ck0x4Pp6
         Kk9jTwOfh/K6EnvMPJX/wquTGjztsyWp1CDYKjpGF0UNd9q5p/YjvfiZcvGmNMGgeMKq
         2ikmCxX9sUHDA5gq+020Yo9lFeRWUKS1Ad1E0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=B2ynNXlPQZwolLwZ18eDOvpn3FmEMvScalChzPUbVUjNI1Pt+bXj9iW5r0PPbccUl/
         SpoIHFiwYMTQhVWbMTPgSxYLbbJYBTJwGHakfAF4l8VHevKSa2IHk3Jrm+OBSWh2MO4G
         8wDqg8mux9b6GLlRkCnUx4CLT6qTcVYj3rVrQ=
Received: by 10.236.95.17 with SMTP id o17mr1067718yhf.56.1296108480917;
        Wed, 26 Jan 2011 22:08:00 -0800 (PST)
Received: from burratino (adsl-69-209-75-28.dsl.chcgil.ameritech.net [69.209.75.28])
        by mx.google.com with ESMTPS id 26sm1680030yhl.23.2011.01.26.22.07.58
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 26 Jan 2011 22:07:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vd3nji54o.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165571>

Normal git processes do not allow one to build a tree with an empty
subtree entry without trying hard at it.  This is in keeping with the
general UI philosophy: git tracks content, not empty directories.

v1.7.3-rc0~75^2 (2010-06-30) changed that by making it easy to include
an empty subtree in fast-import's active commit:

	M 040000 4b825dc642cb6eb9a060e54bf8d69288fbee4904 subdir

One can trigger this by reading an empty tree (for example, the tree
corresponding to an empty root commit) and trying to move it to a
subtree.  It is better and more closely analogous to 'git read-tree
--prefix' to treat such commands as requests to remove the subtree.

Noticed-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:

> Hmm, why not on top of v1.7.3-rc0~75^2 aka 334fba6 (Teach fast-import to
> import subtrees named by tree id, 2010-06-30) then?

Okay, I found time to try it.  Some other small simplifications while
at it.

 fast-import.c          |    6 ++++++
 t/t9300-fast-import.sh |   42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index ad6843a..cd9310d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2163,6 +2163,12 @@ static void file_change_m(struct branch *b)
 		p = uq.buf;
 	}
 
+	/* Git does not track empty, non-toplevel directories. */
+	if (S_ISDIR(mode) && !memcmp(sha1, EMPTY_TREE_SHA1_BIN, 20) && *p) {
+		tree_content_remove(&b->branch_tree, p, NULL);
+		return;
+	}
+
 	if (S_ISGITLINK(mode)) {
 		if (inline_data)
 			die("Git links cannot be specified 'inline': %s",
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 50d5913..8487734 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -818,6 +818,48 @@ test_expect_success \
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
 	'N: modify copied tree' \
 	'cat >expect <<-\EOF &&
 	:100644 100644 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 fcf778cda181eaa1cbc9e9ce3a2e15ee9f9fe791 C100	newdir/interesting	file3/file5
-- 
1.7.4.rc3
