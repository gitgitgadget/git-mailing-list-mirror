From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH] pull: remove --tags error in no merge candidates case
Date: Wed, 13 May 2015 18:06:47 +0800
Message-ID: <1431511607-18251-1-git-send-email-pyokagan@gmail.com>
References: <xmqq38311zi0.fsf@gitster.dls.corp.google.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>, mhagger@alum.mit.edu,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 12:07:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsTZL-0001Bm-TF
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 12:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932707AbbEMKHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 06:07:10 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33425 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933242AbbEMKHI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 06:07:08 -0400
Received: by pdbnk13 with SMTP id nk13so46875405pdb.0
        for <git@vger.kernel.org>; Wed, 13 May 2015 03:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yFgLjieuwojs8asJIPDmazwx6cx461Dqt4SutQI+cXU=;
        b=GLuz1+fRwU0yz1+LlAFFjLsgtgZU3VvcC23z1DAW8GZKs3wqfO9aVssjP1dRzKlcKx
         +MWlkW/by/Du7omgp8BbQXAKeNEVhEmVNq+HX8Pps9aE9mA+/F0dV4xSNk9mBUPXckPF
         r/2iT5/q12eGkzb3iZQ/X3O4JgPcmPmXoTGwMbD1oChlILkbTt33jOB+6PFxYxBaDhs1
         ZlaJ2mRobF2WwyHBfcd4l1hTzIz9J63FvssMfZZDNOtSfM1+vDtjnXcz3LUSzRh8fQ43
         +m8H/h315IynEkpqeNJptn7WEzxi8oMBa5UlD5iWt4OL9V2b4iD2cNUlDYIkpm6B6lYO
         vCNw==
X-Received: by 10.66.139.138 with SMTP id qy10mr36715612pab.30.1431511628220;
        Wed, 13 May 2015 03:07:08 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id k3sm18834105pde.18.2015.05.13.03.07.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 May 2015 03:07:06 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <xmqq38311zi0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268976>

Since 441ed41 ("git pull --tags": error out with a better message.,
2007-12-28), git pull --tags would print a different error message if
git-fetch did not return any merge candidates:

   It doesn't make sense to pull all tags; you probably meant:
        git fetch --tags

This is because at that time, git-fetch --tags would override any
configured refspecs, and thus there would be no merge candidates. The
error message was thus introduced to prevent confusion.

However, since c5a84e9 (fetch --tags: fetch tags *in addition to*
other stuff, 2013-10-30), git fetch --tags would fetch tags in addition
to any configured refspecs. Hence, if any no merge candidates situation
occurs, it is not because --tags was set. As such, this special error
message is now irrelevant.

To prevent confusion, remove this error message.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 git-pull.sh | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 9ed01fd..9005171 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -190,15 +190,6 @@ esac
 
 error_on_no_merge_candidates () {
 	exec >&2
-	for opt
-	do
-		case "$opt" in
-		-t|--t|--ta|--tag|--tags)
-			echo "It doesn't make sense to pull all tags; you probably meant:"
-			echo "  git fetch --tags"
-			exit 1
-		esac
-	done
 
 	if test true = "$rebase"
 	then
-- 
2.1.4
