From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH v2 2/3] contrib/subtree/t: Added tests for .gitsubtree support
Date: Tue, 19 Feb 2013 12:31:20 +0000
Message-ID: <CALeLG_nfq9eSNw6UMYK0OzpK3r2NKTeK4H4Qyot-4r_r342+nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, Adam Tkac <atkac@redhat.com>,
	"David A. Greene" <greened@obbligato.org>,
	"Jesper L. Nielsen" <lyager@gmail.com>,
	Michael Schubert <mschub@elegosoft.com>,
	Techlive Zheng <techlivezheng@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 19 13:31:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7mMM-0003V8-H2
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 13:31:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932724Ab3BSMbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 07:31:22 -0500
Received: from mail-ee0-f54.google.com ([74.125.83.54]:40798 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754510Ab3BSMbW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 07:31:22 -0500
Received: by mail-ee0-f54.google.com with SMTP id c41so3621743eek.13
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 04:31:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=S64v/aYxrqY0ztkFognUoMjajPrI8fi5DLPkCfyQv3M=;
        b=jGcJc9OyOwP6h2NHr5kDmJv4lsjL+z3jK9knj8yZelvQGXZvnrTtwDtTrTaqi7+4vy
         GQICzSRzx8x36bgIccoZ6yMrlAoXUlfFMUEujqh2gbWB8yRHbsGQ4IMoLX7COl8ECsNS
         IhObrpmubavKDspc02Su+L5t/jPFslokuKn3P/d6uceUoM6N08DuCxZevldnjRwLt4b2
         m2KBtuaOlGVIxPOfrKCzgUvIT75vRKgg8PLQMRSJ2vT3dEUg++pqpbn2LMq7tDNJ6U6g
         H1DQds3GvdBacUBjytjJxVxHWr+wQR3xcOqO/K55VN0e8ix0hVAFMNYFdrXQj1If8miL
         ocEA==
X-Received: by 10.14.179.194 with SMTP id h42mr56008860eem.46.1361277080618;
 Tue, 19 Feb 2013 04:31:20 -0800 (PST)
Received: by 10.14.45.4 with HTTP; Tue, 19 Feb 2013 04:31:20 -0800 (PST)
X-Originating-IP: [212.219.195.16]
X-Gm-Message-State: ALoCoQksfoWaN5BVQV8C54RkUYFtPV0/2HUsHwpPANa6wRyz9e8MWx58fFvt7STfkO/EiBK0ncf5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216611>

add: ensure details are added to .gitsubtree
push: check for a SHA1 update line
pull: add a file on one subtree, push it to a branch, then pull into
    another subtree containing the same branch and confirm the files match
add: ensure stale .gitsubtree entry is replaced

Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/t/t7900-subtree.sh | 42 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/contrib/subtree/t/t7900-subtree.sh
b/contrib/subtree/t/t7900-subtree.sh
index 80d3399..f1a24cf 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -465,4 +465,46 @@ test_expect_success 'verify one file change per commit' '
         ))
 '

+# return to mainline
+cd ../..
+
+# .gitsubtree
+test_expect_success 'added repository appears in .gitsubtree' '
+	git subtree add --prefix=copy0 sub1 &&
+	grep "^copy0 \. sub1$" .gitsubtree
+'
+
+test_expect_success 'change in subtree is pushed okay' '
+	(
+		cd copy0 &&
+		create new_file &&
+		git commit -m"Added new_file"
+	) &&
+	git ls-tree refs/heads/sub1 >output &&
+	! grep "new_file$" output &&
+	git subtree push --prefix=copy0 &&
+	git ls-tree refs/heads/sub1 >output &&
+	grep "new_file$" output
+'
+
+test_expect_success 'pull into subtree okay' '
+	git subtree add --prefix=copy1 sub1 &&
+	git subtree add --prefix=copy2 sub1 &&
+	(
+		cd copy1 &&
+		create new_file_in_copy1 &&
+		git commit -m"Added new_file_in_copy1"
+	) &&
+	git subtree push --prefix=copy1 &&
+	git subtree pull --prefix=copy2 >output &&
+	grep "^ create mode 100644 copy2/new_file_in_copy1$" output
+'
+
+test_expect_success 'replace outdated entry in .gitsubtree' '
+	echo "copy3 . sub2" >>.gitsubtree &&
+	git subtree add --prefix=copy3 sub1 &&
+	! grep "^copy3 . sub2$" .gitsubtree &&
+	grep "^copy3 . sub1$" .gitsubtree
+'
+
 test_done
-- 
1.8.2.rc0.16.g20a599e
