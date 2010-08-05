From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 03/12] t6038 (merge.renormalize): check that it can be
 turned off
Date: Thu, 5 Aug 2010 06:13:04 -0500
Message-ID: <20100805111304.GE13779@burratino>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
 <20100804031935.GA19699@burratino>
 <20100804032338.GF19699@burratino>
 <7vocdifdrk.fsf@alter.siamese.dyndns.org>
 <20100805110822.GB13779@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 13:14:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgyPL-0001Q8-Qj
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 13:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760158Ab0HELOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 07:14:30 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36394 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760143Ab0HELO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 07:14:28 -0400
Received: by iwn33 with SMTP id 33so81021iwn.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 04:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ix4xeaEfG6jkfYOd+Hs3e8QWVH5qirkT4aEi91zxCtc=;
        b=p1ot4+He1xzqahHpwOzn2xnZR3jrKTkGJmQatTlbXJROBQ62zxktXRFIqQ8GbwKiCh
         a6bdouLIktxybUtpMeBhKx1hBDyy3O1GqhS2jwsnImaC9poBpBx6wpXZhvE3IigQLogO
         F5mfsSmcd5rgqvDY7D2DUh3DdKVv+50oQ3Hi4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nWldFJI+9yrBrDIRgzgjNLxDym3/1D+l4eRMo7nKf//Adr/p57Rm9p8SWF6hRtiBWP
         HJPKKzXXDn1QqvdnBQnceYbR5mRuPyvGSfFPQko1vxBrMRKCv/jm/qyX8GaoO98emk5j
         vTeTYyuKnczlpbZeGXR2zgWhkE6X3qDTSAhbU=
Received: by 10.231.194.219 with SMTP id dz27mr11911872ibb.104.1281006867163;
        Thu, 05 Aug 2010 04:14:27 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id n20sm49430ibe.5.2010.08.05.04.14.26
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 05 Aug 2010 04:14:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100805110822.GB13779@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152635>

An unusual sort of person (not me) may even enjoy the conflicts
from line-ending changes.  But more importantly, it is useful to
document that behavior so we can more easily notice if it changes
in an uncontrolled way while no one is watching.

Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t6038-merge-text-auto.sh |   50 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 49 insertions(+), 1 deletions(-)

diff --git a/t/t6038-merge-text-auto.sh b/t/t6038-merge-text-auto.sh
index a7ea4b6..52d0dc4 100755
--- a/t/t6038-merge-text-auto.sh
+++ b/t/t6038-merge-text-auto.sh
@@ -15,7 +15,6 @@ test_description='CRLF merge conflict across text=auto change
 . ./test-lib.sh
 
 test_expect_success setup '
-	git config merge.renormalize true &&
 	git config core.autocrlf false &&
 
 	echo first line | append_cr >file &&
@@ -59,12 +58,19 @@ test_expect_success setup '
 	git checkout master
 '
 
+test_expect_success 'set up fuzz_conflict() helper' '
+	fuzz_conflict() {
+		sed -e "s/^\([<>=]......\) .*/\1/" "$@"
+	}
+'
+
 test_expect_success 'Merge after setting text=auto' '
 	cat <<-\EOF >expected &&
 	first line
 	same line
 	EOF
 
+	git config merge.renormalize true &&
 	git rm -fr . &&
 	rm -f .gitattributes &&
 	git reset --hard a &&
@@ -78,6 +84,7 @@ test_expect_success 'Merge addition of text=auto' '
 	same line
 	EOF
 
+	git config merge.renormalize true &&
 	git rm -fr . &&
 	rm -f .gitattributes &&
 	git reset --hard b &&
@@ -85,12 +92,51 @@ test_expect_success 'Merge addition of text=auto' '
 	test_cmp expected file
 '
 
+test_expect_success 'Detect CRLF/LF conflict after setting text=auto' '
+	q_to_cr <<-\EOF >expected &&
+	<<<<<<<
+	first line
+	same line
+	=======
+	first lineQ
+	same lineQ
+	>>>>>>>
+	EOF
+
+	git config merge.renormalize false &&
+	rm -f .gitattributes &&
+	git reset --hard a &&
+	test_must_fail git merge b &&
+	fuzz_conflict file >file.fuzzy &&
+	test_cmp expected file.fuzzy
+'
+
+test_expect_success 'Detect LF/CRLF conflict from addition of text=auto' '
+	q_to_cr <<-\EOF >expected &&
+	<<<<<<<
+	first lineQ
+	same lineQ
+	=======
+	first line
+	same line
+	>>>>>>>
+	EOF
+
+	git config merge.renormalize false &&
+	rm -f .gitattributes &&
+	git reset --hard b &&
+	test_must_fail git merge a &&
+	fuzz_conflict file >file.fuzzy &&
+	test_cmp expected file.fuzzy
+'
+
 test_expect_failure 'checkout -m after setting text=auto' '
 	cat <<-\EOF >expected &&
 	first line
 	same line
 	EOF
 
+	git config merge.renormalize true &&
 	git rm -fr . &&
 	rm -f .gitattributes &&
 	git reset --hard initial &&
@@ -105,6 +151,7 @@ test_expect_failure 'checkout -m addition of text=auto' '
 	same line
 	EOF
 
+	git config merge.renormalize true &&
 	git rm -fr . &&
 	rm -f .gitattributes file &&
 	git reset --hard initial &&
@@ -119,6 +166,7 @@ test_expect_failure 'cherry-pick patch from after text=auto was added' '
 	same line
 	EOF
 
+	git config merge.renormalize true &&
 	git rm -fr . &&
 	git reset --hard b &&
 	test_must_fail git cherry-pick a >err 2>&1 &&
-- 
1.7.2.1.544.ga752d.dirty
