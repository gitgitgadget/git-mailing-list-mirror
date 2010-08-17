From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 01/24] merge: do not mistake (ancestor of) tag for branch
Date: Tue, 17 Aug 2010 01:52:48 -0500
Message-ID: <20100817065248.GA22057@burratino>
References: <20100817065147.GA18293@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 08:54:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlG47-0005I4-4p
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 08:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755987Ab0HQGy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 02:54:26 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61756 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298Ab0HQGy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 02:54:26 -0400
Received: by ywh1 with SMTP id 1so2267270ywh.19
        for <git@vger.kernel.org>; Mon, 16 Aug 2010 23:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Q3OX2oWvmDYHiYfQRnPqkLT8qVEukCPKFR4BxYPbgIg=;
        b=qbij1JxlhDkXBMsm/d5JnPpzPiG03yw4Hu5/IW0wYPdQGir6xWV6Uw/+tSIEN2lBlL
         qyz7SY+HYiD+6+kYzGy7Rrb3/mjXnPiv1nRcw1MK/RJRCicyNILV/KdoLd7ex8TajeWj
         BBhpOsHSpelyVKz3jGcntv7scVyn+zQ6NlrYw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=B6uUMiITIJ7tdoBaSYOKoE7cVp0qF4pDSI2Io55BnXcaTCp3Ma71pQB4H1FMaNrKC4
         H1tIi6y3sLFbX+iF5hKpc1ol0mHedb11vR/BkDlnItkaH+a9A7sqJICNVmDQng91K1qw
         PbD+Sj0yTcrGmcfpYBlRTcMjrhl1d9J9fNb0c=
Received: by 10.150.55.23 with SMTP id d23mr6571080yba.408.1282028065329;
        Mon, 16 Aug 2010 23:54:25 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id a17sm168535ybh.21.2010.08.16.23.54.24
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Aug 2010 23:54:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100817065147.GA18293@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153704>

If no branch 'foo' exists but a tag 'foo' does, then
git merge foo^ results in

	Merge branch 'foo' (early part)

as a commit message, because the relevant code path checks that
refs/heads/foo is a valid refname for writing rather than for
reading.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/merge.c  |    2 +-
 t/t7600-merge.sh |   16 ++++++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index b836e9c..f285b7e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -437,7 +437,7 @@ static void merge_name(const char *remote, struct strbuf *msg)
 		strbuf_addstr(&truname, "refs/heads/");
 		strbuf_addstr(&truname, remote);
 		strbuf_setlen(&truname, truname.len - len);
-		if (resolve_ref(truname.buf, buf_sha, 0, NULL)) {
+		if (resolve_ref(truname.buf, buf_sha, 1, NULL)) {
 			strbuf_addf(msg,
 				    "%s\t\tbranch '%s'%s of .\n",
 				    sha1_to_hex(remote_head->sha1),
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index cde8390..16e5ba1 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -558,8 +558,11 @@ test_expect_success 'refresh the index before merging' '
 	git merge c3
 '
 
-cat >expected <<EOF
-Merge branch 'c5' (early part)
+cat >expected.branch <<\EOF
+Merge branch 'c5-branch' (early part)
+EOF
+cat >expected.tag <<\EOF
+Merge commit 'c5~1'
 EOF
 
 test_expect_success 'merge early part of c2' '
@@ -577,9 +580,14 @@ test_expect_success 'merge early part of c2' '
 	git add c6.c &&
 	git commit -m c6 &&
 	git tag c6 &&
+	git branch -f c5-branch c5 &&
+	git merge c5-branch~1 &&
+	git show -s --pretty=format:%s HEAD >actual.branch &&
+	git reset --keep HEAD^ &&
 	git merge c5~1 &&
-	git show -s --pretty=format:%s HEAD > actual &&
-	test_cmp actual expected
+	git show -s --pretty=format:%s HEAD >actual.tag &&
+	test_cmp expected.branch actual.branch &&
+	test_cmp expected.tag actual.tag
 '
 
 test_debug 'gitk --all'
-- 
1.7.2.1.544.ga752d.dirty
