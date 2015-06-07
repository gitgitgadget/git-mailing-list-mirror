From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 0/3] git-p4: fixing --changes-block-size support
Date: Sun,  7 Jun 2015 11:21:42 +0100
Message-ID: <1433672505-11940-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Lex Spoon <lex@lexspoon.org>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 07 12:22:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1Xj5-0004so-Of
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jun 2015 12:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889AbbFGKWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2015 06:22:36 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37554 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbbFGKWe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2015 06:22:34 -0400
Received: by wifx6 with SMTP id x6so58052480wif.0
        for <git@vger.kernel.org>; Sun, 07 Jun 2015 03:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bM/ZG9r/3AlAkj0u1iTtJc/PDr0nHxzh7uOt3aOeGPw=;
        b=DTGMxOf2HZig10QXCB7WokZjkegv6MFPvpqozrhjl1GHPrvdpbRzbaO6xBvS86dv2x
         SEaJi6zlqOye3j2nPD5Hq4rWXWMOO0Wv/DWswk0u+kj+5+Z87IIF0XgwkFcOGjgtZH3R
         hBp1phaAOAx8S1MIveWdYCuixTqbrWy5CY6Io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bM/ZG9r/3AlAkj0u1iTtJc/PDr0nHxzh7uOt3aOeGPw=;
        b=QGnQhUJMpjt3z8y2H8nekggNoLfGIE7JOps5q6wdaAFuLjWUkftSNpDuishHhu2Xx0
         XmSDrcnE2v9GuyotHBjTLUue0mMHEdz/YfUZDIS0VZTPvbbTnodxIUvcm27e++92G1/b
         ZuuNBwtsXrjsdFZsX75I9wjIc1pEdeKWkGBTDJtubE952JuJAJqyFV8LzHD5GVjDQkqs
         KfdEl/vxDCG2gX1Vt5jLrdTIlgNBEplDox5XTdbMs7xNJpxXQ2p63ZPiP011qWz3liOR
         Woi/laEcNK7n1EjsWz2sRVxVzLc7OgH3NR3gxCvCTXM0YAD9auz17Z6a7NPp9G9u1PWW
         8VAQ==
X-Gm-Message-State: ALoCoQnF5TDE4XSyY8bQs9LN27ZsVedoqo33KnstbeRMXABL/tLUB+3v1w4Jcy5dnUR6ciKo3/ar
X-Received: by 10.180.14.193 with SMTP id r1mr12023221wic.47.1433672553736;
        Sun, 07 Jun 2015 03:22:33 -0700 (PDT)
Received: from ethel.local.diamand.org. (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id w11sm18911961wjr.48.2015.06.07.03.22.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Jun 2015 03:22:32 -0700 (PDT)
X-Mailer: git-send-email 2.3.4.48.g223ab37
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270960>

We recently added support to git-p4 to limit the number of changes it
would try to import at a time. That was to help clients who were being
limited by the "maxscanrows" limit. This used the "-m maxchanges"
argument to "p4 changes" to limit the number of results returned to
git-p4.

Unfortunately it turns out that in practice, the server limits the
number of results returned *before* the "-m maxchanges" argument is
considered. Even supplying a "-m 1" argument doesn't help.

This affects both the "maxscanrows" and "maxresults" group options.

This set of patches updates the t9818 git-p4 tests to show the problem,
and then adds a fix which works by iterating over the changes in batches
(as at present) but using a revision range to limit the number of changes,
rather than "-m $BATCHSIZE".

That means it will in most cases require more transactions with the server,
but usually the effect will be small.

Along the way I also found that "p4 print" can fail if you have a file
with too many changes in it, but there's unfortunately no way to workaround
this. It's fairly unlikely to ever happen in practice.

I think I've covered everything in this fix, but it's possible that there
are still bugs to be uncovered; I find the way that these limits interact
somewhat tricky to understand.

Thanks,
Luke

Luke Diamand (3):
  git-p4: additional testing of --changes-block-size
  git-p4: test with limited p4 server results
  git-p4: fixing --changes-block-size handling

 git-p4.py               | 48 +++++++++++++++++++++++---------
 t/t9818-git-p4-block.sh | 73 +++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 99 insertions(+), 22 deletions(-)

-- 
2.3.4.48.g223ab37
