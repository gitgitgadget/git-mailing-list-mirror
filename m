From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/6] t1500: reduce dependence upon global state
Date: Tue, 10 May 2016 01:20:51 -0400
Message-ID: <20160510052055.32924-3-sunshine@sunshineco.com>
References: <20160510052055.32924-1-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 07:21:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b007G-0003v6-My
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 07:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbcEJFVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 01:21:44 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:34263 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbcEJFVd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 01:21:33 -0400
Received: by mail-io0-f195.google.com with SMTP id d62so413963iof.1
        for <git@vger.kernel.org>; Mon, 09 May 2016 22:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gv9n21joDjCtPJouN49GjKqx/Aa3pnHp90aXOPtS2FI=;
        b=n9gTvzH2LvYXBCCJw4DjjSn4qSIyuj52xtXc8g+M9f5yGWMdPT/87biRm3Nw5RR90m
         2DrUh1GeCM4h1Bo3NpZn6J+xDsVe56bhpOhHzOL+wKfX6esXerywwvJbO5u1zQ52jXBh
         pAB0AARzTWpZeqvfBdcNRvbYEL5HeHZ1HsA/HiSmFb/Rbc7t4zVYoFmBa3eMmYN46230
         F5HJcCZbKoxiAuvdzpgK93/Wqvk0hPpfeAt2AyAM4tZAxWIcxG5P8Dgc2APPr9ngt1l5
         2lqOlXuaOWTYhWzFMnaSw0o/UliqX6yWqwiS6Ui4TF0k3dL5iyxiAHpAUdQmy+z6GW7E
         ivgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Gv9n21joDjCtPJouN49GjKqx/Aa3pnHp90aXOPtS2FI=;
        b=b15fvA/CpuSNAAtt2WrS1foojrKYFqusOruQbdE1vRr1OtArzpEk09zpud6oPzMJkm
         MG87K+U+Y/j1VLfw+OKgO1a7PAX9bMPgTWmpfEvnb7PGSNGJoHMzXHXk13oVaebB9Q1m
         xKyEIpZt2yw2TP+oCIS+r8Gu6DXFjwY7CRZJ8pn60egXtVludf3UA/dxAL57ykMWxguE
         DveeolObI2lsTa3iMsAqSRZADgzHcWktS4vEm6bqt2GSBJP0NZHWP6+i9/IeTj3FBH5D
         K11MgblRjyx5G0KDrH6g3DjKp7dS1UAeIJf18kjpR0dNXNDYRBtTu9rKctqLUXtejiZb
         4cQA==
X-Gm-Message-State: AOPr4FXVQUvDuhYXTVGdMRNUcMWmbjHsWNvgcBS1I/FoM2eh33iC0IdScQ3lJ3Z4kE0GKg==
X-Received: by 10.107.173.69 with SMTP id w66mr44644997ioe.182.1462857692656;
        Mon, 09 May 2016 22:21:32 -0700 (PDT)
Received: from localhost.localdomain (user-12l3c5v.cable.mindspring.com. [69.81.176.191])
        by smtp.gmail.com with ESMTPSA id vu8sm458336igb.1.2016.05.09.22.21.31
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 09 May 2016 22:21:32 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.530.g51d527d
In-Reply-To: <20160510052055.32924-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294093>

This script pollutes its global state by changing its working directory
and capturing that state via $(pwd) in the GIT_CONFIG environment
variable. This makes it difficult to modernize the script since tests
ideally should be self-contained and not rely upon such transient global
state.

With the ultimate goal of eliminating working directory changes, as a
first step, avoid capturing global state by instead taking advantage of
$ROOT which captured $(pwd) prior to any working directory changes, and
compose GIT_CONFIG from it and local knowledge of the working directory.

Subsequent patches will eliminate changes of working directory and drop
GIT_CONFIG altogether.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t1500-rev-parse.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 03f22fe..3d79568 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -49,7 +49,7 @@ test_rev_parse 'core.bare undefined' false false true
 mkdir work || exit 1
 cd work || exit 1
 GIT_DIR=../.git
-GIT_CONFIG="$(pwd)"/../.git/config
+GIT_CONFIG="$ROOT/work/../.git/config"
 export GIT_DIR GIT_CONFIG
 
 git config core.bare false
@@ -63,7 +63,7 @@ test_rev_parse 'GIT_DIR=../.git, core.bare undefined' false false true ''
 
 mv ../.git ../repo.git || exit 1
 GIT_DIR=../repo.git
-GIT_CONFIG="$(pwd)"/../repo.git/config
+GIT_CONFIG="$ROOT/work/../repo.git/config"
 
 git config core.bare false
 test_rev_parse 'GIT_DIR=../repo.git, core.bare = false' false false true ''
-- 
2.8.2.530.g51d527d
