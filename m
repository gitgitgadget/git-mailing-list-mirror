From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/4] test: commit --amend should honor --no-edit
Date: Wed, 7 Dec 2011 08:54:14 -0600
Message-ID: <20111207145414.GE30157@elie.hsd1.il.comcast.net>
References: <4EDDD0E4.6040003@st.com>
 <87fwgxwvn9.fsf@gmail.com>
 <7vobvlfowk.fsf@alter.siamese.dyndns.org>
 <7vk469fm9j.fsf@alter.siamese.dyndns.org>
 <20111207144217.GA30157@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Vijay Lakshminarayanan <laksvij@gmail.com>,
	Viresh Kumar <viresh.kumar@st.com>,
	Shiraz HASHIM <shiraz.hashim@st.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 15:54:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYIt7-0001zH-RF
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 15:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756156Ab1LGOyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 09:54:21 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59175 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756019Ab1LGOyV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 09:54:21 -0500
Received: by yenm11 with SMTP id m11so130075yen.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 06:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=TzjSuWmXiBSvfZmWzdWlujsEy8MBVOIblmIrkyqGh2o=;
        b=jkO9a8PQ+66XUYA/bya73dNrPRGJwigTwpBSv6x1dE1PmFXGWYdC2DSKGUgi+l9U7N
         tnzBbxIU23+PHGrtwJeaCs6v1BU3tsOyizrt4qgW/WS1rRcJSWXLEVJVaAzH2tRxaR5i
         TcBTG8y6jZei+uZgMWXu1bc0oIU5/L4/IbwDI=
Received: by 10.236.187.1 with SMTP id x1mr27235986yhm.58.1323269660442;
        Wed, 07 Dec 2011 06:54:20 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id 11sm5585406anp.13.2011.12.07.06.54.19
        (version=SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 06:54:19 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111207144217.GA30157@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186461>

A quick test to make sure git doesn't lose the functionality added by
the recent patch "commit: honor --no-edit", plus another test to check
the classical --edit use case (use with "-m").

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t7501-commit.sh |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index bf025df6..c462bf3b 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -94,6 +94,46 @@ test_expect_success 'amend commit' '
 	EDITOR=./editor git commit --amend
 '
 
+test_expect_success 'set up editor' '
+	cat >editor <<-\EOF &&
+	#!/bin/sh
+	sed -e "s/unamended/amended/g" <"$1" >"$1-"
+	mv "$1-" "$1"
+	EOF
+	chmod 755 editor
+'
+
+test_expect_success 'amend without launching editor' '
+	echo unamended >expect &&
+	git commit --allow-empty -m "unamended" &&
+	echo needs more bongo >file &&
+	git add file &&
+	EDITOR=./editor git commit --no-edit --amend &&
+	git diff --exit-code HEAD -- file &&
+	git diff-tree -s --format=%s HEAD >msg &&
+	test_cmp expect msg
+'
+
+test_expect_success '--amend --edit' '
+	echo amended >expect &&
+	git commit --allow-empty -m "unamended" &&
+	echo bongo again >file &&
+	git add file &&
+	EDITOR=./editor git commit --edit --amend &&
+	git diff-tree -s --format=%s HEAD >msg &&
+	test_cmp expect msg
+'
+
+test_expect_success '-m --edit' '
+	echo amended >expect &&
+	git commit --allow-empty -m buffer &&
+	echo bongo bongo >file &&
+	git add file &&
+	EDITOR=./editor git commit -m unamended --edit &&
+	git diff-tree -s  --format=%s HEAD >msg &&
+	test_cmp expect msg
+'
+
 test_expect_success '-m and -F do not mix' '
 	echo enough with the bongos >file &&
 	test_must_fail git commit -F msg -m amending .
-- 
1.7.8.rc3
