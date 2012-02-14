From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] test: check that "git blame -e" uses mailmap correctly
Date: Tue, 14 Feb 2012 14:36:03 -0600
Message-ID: <20120214203603.GD13210@burratino>
References: <1329235894-20581-1-git-send-email-felipe.contreras@gmail.com>
 <20120214203431.GB13210@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 21:36:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxP6o-0000kT-4r
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 21:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760848Ab2BNUgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 15:36:14 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44692 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757253Ab2BNUgN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 15:36:13 -0500
Received: by ggnh1 with SMTP id h1so295457ggn.19
        for <git@vger.kernel.org>; Tue, 14 Feb 2012 12:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jORoSzW/4KwxrHn7uXSyMrozQeNNEi0P+8pOx9aZBjs=;
        b=nrDMZaILdfKNOeALiVyaxxK1V3ITd94h9saumGFG869kEs8BU6TLewEMC2a//cepiU
         0zRZUhHHo28/Yj5ql58UkwxTa7ePeZYfum+cb9aJ41CxOCPw4/YO4uv53bB5/mZv/glX
         FFTBjGXjASE9YR4PLVMKhn0PpwbYMCS78G3Hs=
Received: by 10.50.11.129 with SMTP id q1mr37610776igb.23.1329251772748;
        Tue, 14 Feb 2012 12:36:12 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ak10sm731177igc.6.2012.02.14.12.36.12
        (version=SSLv3 cipher=OTHER);
        Tue, 14 Feb 2012 12:36:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120214203431.GB13210@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190755>

From: Felipe Contreras <felipe.contreras@gmail.com>

Until f026358e ("mailmap: always return a plain mail address from
map_user()", 2012-02-05), git blame -e would add a spurious '>' after
the unchanged email address with brackets it passed to the mailmap
machinery, resulting in lines with a doubled '>' like this:

 620456e6 (<committer@example.com>>   2005-04-07 15:20:13 -0700 8) eight

Add a test to make sure it doesn't happen again.  This reuses the test
data for the existing "shortlog -e" test so it also tests other kinds
of mail mapping.

[jn: fixed some cut+paste cruft, added a patch description]

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t4203-mailmap.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 45526395..ef900d84 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -267,4 +267,20 @@ test_expect_success 'Blame output (complex mapping)' '
 	test_cmp expect actual.fuzz
 '
 
+cat >expect <<\EOF
+^OBJI (<author@example.com>       DATE 1) one
+OBJID (<some@dude.xx>             DATE 2) two
+OBJID (<other@author.xx>          DATE 3) three
+OBJID (<other@author.xx>          DATE 4) four
+OBJID (<santa.claus@northpole.xx> DATE 5) five
+OBJID (<santa.claus@northpole.xx> DATE 6) six
+OBJID (<cto@company.xx>           DATE 7) seven
+OBJID (<committer@example.com>    DATE 8) eight
+EOF
+test_expect_success 'Blame -e output' '
+	git blame -e one >actual &&
+	fuzz_blame actual >actual.fuzz &&
+	test_cmp expect actual.fuzz
+'
+
 test_done
-- 
1.7.9
