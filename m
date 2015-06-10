From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv3 0/4] git-p4: fixing --changes-block-size handling
Date: Wed, 10 Jun 2015 08:30:55 +0100
Message-ID: <1433921459-16555-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Lex Spoon <lex@lexspoon.org>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 10 09:32:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2aUW-0008VX-BF
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 09:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbbFJHb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 03:31:58 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37223 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753997AbbFJHby (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 03:31:54 -0400
Received: by wifx6 with SMTP id x6so37736161wif.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 00:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=mT37/8bwR/0Gzk2qzeAGpql3yCMdHMz4zYB6pir/10Y=;
        b=V29ra+HvqUulRzTAk6YfRkDKFpxulT/30bV7BNAazZnhFbG84ch83XiooUSnRnYbp8
         vCLt2dGDXXEY7MxgbzoD0vWTb0dclFhRwcUlAV02M8RFV2C4tkwqyrRx6xGobiCFzFv0
         LB+ZRQkGPcxMlOo29/glekrR3AUMdlMSbDd9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mT37/8bwR/0Gzk2qzeAGpql3yCMdHMz4zYB6pir/10Y=;
        b=OKFFcdLOIX0Y3BIdpPMX05cbfrDrN6Cfmqkg+jI4jKgRoZVp95OJ9BpSW6lNwpQB30
         Hfu7cVzQLRKnyrYdonTWCCnYhEg5OzgEEaY2XbHaySfo81mndssa1xmlaXO5tNViED59
         9bHPbAL7nIPU3+6gy2dRhhNUkS4+Po95CfUQ3wR6ZHCDS6PgbaUHv8UChVE9d/JeiDIJ
         GmaY8vQWi0ChqCzsHDtajA/WxGFuHWA0cDUow6JXiuFMCCsfcOg+NnPknwWV7CkgR8If
         KfYbXzkwMzsKSiDDYI+6m4pdAO+YT+nSX72bsOtRW550gMTfUDs8EobUqUHDdX3rGFrS
         +yyA==
X-Gm-Message-State: ALoCoQkH9bDHrtOHZ1IasvksZomHFcB++5+G16aoTtQsu1+FsIOHpDe85yVbi05FmNvtRHiKKcX0
X-Received: by 10.180.24.40 with SMTP id r8mr5739149wif.24.1433921513157;
        Wed, 10 Jun 2015 00:31:53 -0700 (PDT)
Received: from ethel.local.diamand.org. (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id n8sm6453997wiy.19.2015.06.10.00.31.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Jun 2015 00:31:51 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.502.gb11c5ab
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271262>

This series of patches teaches git-p4 to break up calls to the
P4 server into smaller chunks, to avoid hitting the maxresults and
maxscanrows server-side limits.

The previous iteration of this series didn't handle non-integer
P4 revision ranges (e.g. //depot/...@2014/1/1,2015/1/1).

This version now breaks up the commit into blocks iff the revision
range specified is an integer range: @all, M,N or N,#head. If the
range is non-numeric then it falls back to relying on Perforce to
parse the revisions. In this mode it is no longer possible to fetch
changes in blocks (and requests to do so will be rejected).

Another alternative would be to turn the date (or whatever) revisions
into numeric revision numbers, but there doesn't seem to be a simple
way to do this. The best I can come up with is to get the changes
"around" the date in question (perhaps binary-chopping from years down
to seconds to find a range that works?) and then take the lowest
revision supplied. But that's quite a bit more complex.

Luke Diamand (4):
  git-p4: additional testing of --changes-block-size
  git-p4: test with limited p4 server results
  git-p4: add tests for non-numeric revision range
  git-p4: fixing --changes-block-size handling

 git-p4.py               | 85 ++++++++++++++++++++++++++++++++++++-------------
 t/t9800-git-p4-basic.sh | 38 ++++++++++++++++++++++
 t/t9818-git-p4-block.sh | 73 ++++++++++++++++++++++++++++++++++++------
 3 files changed, 165 insertions(+), 31 deletions(-)

-- 
2.4.1.502.gb11c5ab
