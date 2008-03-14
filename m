From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] merge-recursive: handle file mode and links similarly to
	file content
Date: Fri, 14 Mar 2008 10:21:05 +0100
Message-ID: <20080314092105.GA18683@localhost>
References: <20080308171726.GA16129@localhost> <alpine.LSU.1.00.0803081850470.3975@racer.site> <20080313125229.GA24758@localhost> <alpine.LSU.1.00.0803131607030.1656@racer.site> <20080313192246.GA30361@localhost> <alpine.LSU.1.00.0803132216580.4174@racer.site> <20080313224741.GA5000@localhost> <alpine.LSU.1.00.0803140039250.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 14 10:21:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja66h-0005r7-3r
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 10:21:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbYCNJVE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 05:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752699AbYCNJVD
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 05:21:03 -0400
Received: from hu-out-0506.google.com ([72.14.214.232]:35987 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053AbYCNJVA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 05:21:00 -0400
Received: by hu-out-0506.google.com with SMTP id 19so2572545hue.21
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 02:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=NDKtPZNouRRoCkJ1I9G7E+jdZvGw1kzzOg8B3B9x3KE=;
        b=jj8Z7463qg5DuaB/2qfr0pDMFyQbXbR98cJxhYFF29ndAwTu6V5EQqb7jJi0Co920641OFqeuPpWmNboSXnxoWFY53ypGGcBcYJv82UwoD7EtN9/4cUtpiiaV2RPEHo0WYV7EhtrI7zOH3mHibvxg4xQN8+TlX0/sxaOhnbvpS0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=UZlzyx1NcAymRTGbMPiW5e+8yhPgaX4hS68pLpPAY8GNfxptQcBhKKbAoBeO3eaIDEk1TX0sl95Lsr66Dl2ZjtCgTeHd72ObxoG8/LTS7VVJu59SQmQEmSxgYm5elnuV7mfS/lmdEtuhsPJnQe2ub9bmRA+lTsswIay4W/Odtco=
Received: by 10.67.15.15 with SMTP id s15mr228232ugi.27.1205486457891;
        Fri, 14 Mar 2008 02:20:57 -0700 (PDT)
Received: from darc.dyndns.org ( [88.117.115.33])
        by mx.google.com with ESMTPS id j33sm264473ugc.63.2008.03.14.02.20.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Mar 2008 02:20:56 -0700 (PDT)
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1Ja665-0005gk-Sa; Fri, 14 Mar 2008 10:21:05 +0100
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803140039250.4174@racer.site>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77195>

If the file mode or link changed in only one branch, keep the changed
version. If the file mode or link changed differently in both branches,
report a conflict. If this happens, the user is more likely to be aware of
the change in the head branch. Choose the remote version by default, in
order to make the user think about the change.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Fri, Mar 14, 2008 at 12:40:05AM +0100, Johannes Schindelin wrote:
> On Thu, 13 Mar 2008, Clemens Buchacher wrote:
> > +		result.merge = !result.clean;
> 
> That is new.  Doesn't this overwrite what has been set in
> 
>         } else {
>                 if (!sha_eq(a->sha1, o->sha1) && !sha_eq(b->sha1, o->sha1))
>                         result.merge = 1;

Yeah, that's no good. I think I understand the meaning of result.merge and
result.clean now.

result.merge indicates that there are changes in both branches, whereas
result.clean indicates that the merge was trivial.

I amended the patch to reflect this.

I also noticed that in case of LINKs or GITLINKs which changed in both
branches, the head version is kept by default. By the same rationale I gave for
the file modes, I think the remote version should be kept instead, in order to
make the user aware of this change.

Regards,
Clemens

 merge-recursive.c          |   34 +++++++++++++++++++++++-----------
 t/t6031-merge-recursive.sh |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 11 deletions(-)
 create mode 100755 t/t6031-merge-recursive.sh

diff --git a/merge-recursive.c b/merge-recursive.c
index 34e3167..36f78a2 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1025,16 +1025,31 @@ static struct merge_file_info merge_file(struct diff_filespec *o,
 			hashcpy(result.sha, b->sha1);
 		}
 	} else {
-		if (!sha_eq(a->sha1, o->sha1) && !sha_eq(b->sha1, o->sha1))
-			result.merge = 1;
+		/*
+		 * If the file changed in only one branch, keep the changed
+		 * version. If the file changed in both, try to merge
+		 * automatically. If the merge is not trivial, report a
+		 * conflict. In case of conflicting file modes or links, choose
+		 * remote version by default. They can only be merged trivially
+		 * if they are equal.
+		 */
 
-		result.mode = a->mode == o->mode ? b->mode: a->mode;
+		if (a->mode != o->mode && b->mode != o->mode) {
+			result.mode = b->mode;
+			if (a->mode != b->mode)
+				result.clean = 0;
+			result.merge = 1;
+		} else
+			result.mode = o->mode == a->mode ? b->mode : a->mode;
 
 		if (sha_eq(a->sha1, o->sha1))
 			hashcpy(result.sha, b->sha1);
 		else if (sha_eq(b->sha1, o->sha1))
 			hashcpy(result.sha, a->sha1);
-		else if (S_ISREG(a->mode)) {
+		else if (sha_eq(a->sha1, b->sha1)) {
+			hashcpy(result.sha, a->sha1);
+			result.merge = 1;
+		} else if (S_ISREG(a->mode)) {
 			mmbuffer_t result_buf;
 			int merge_status;
 
@@ -1051,14 +1066,11 @@ static struct merge_file_info merge_file(struct diff_filespec *o,
 
 			free(result_buf.ptr);
 			result.clean = (merge_status == 0);
-		} else if (S_ISGITLINK(a->mode)) {
+			result.merge = 1;
+		} else if (S_ISGITLINK(a->mode) || S_ISLNK(a->mode)) {
+			hashcpy(result.sha, b->sha1);
 			result.clean = 0;
-			hashcpy(result.sha, a->sha1);
-		} else if (S_ISLNK(a->mode)) {
-			hashcpy(result.sha, a->sha1);
-
-			if (!sha_eq(a->sha1, b->sha1))
-				result.clean = 0;
+			result.merge = 1;
 		} else {
 			die("unsupported object type in the tree");
 		}
diff --git a/t/t6031-merge-recursive.sh b/t/t6031-merge-recursive.sh
new file mode 100755
index 0000000..36cd664
--- /dev/null
+++ b/t/t6031-merge-recursive.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+
+test_description='merge-recursive: handle file mode'
+. ./test-lib.sh
+
+test_expect_success 'mode change in one branch: keep changed version' '
+	: >file1 &&
+	git add file1 &&
+	git commit -m initial &&
+	git checkout -b a1 master &&
+	: >dummy &&
+	git add dummy &&
+	git commit -m a &&
+	git checkout -b b1 master &&
+	chmod +x file1 &&
+	git add file1 &&
+	git commit -m b1 &&
+	git checkout a1 &&
+	git merge-recursive master -- a1 b1 &&
+	test -x file1
+'
+
+test_expect_success 'mode change in both branches: expect conflict' '
+	git reset --hard HEAD &&
+	git checkout -b a2 master &&
+	: >file2 &&
+	chmod +x file2 &&
+	git add file2 &&
+	git commit -m a2 &&
+	git checkout -b b2 master &&
+	: >file2 &&
+	git add file2 &&
+	git commit -m b2 &&
+	git checkout a2 &&
+	! (git merge-recursive master -- a2 b2 || test $? -ne 1) &&
+	! test -x file2
+'
+
+test_done
-- 
1.5.4.4
