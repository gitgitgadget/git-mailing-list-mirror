From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 0/3] git-p4: fixing import with labels when commit is not transferred
Date: Thu, 27 Aug 2015 08:18:55 +0100
Message-ID: <1440659938-12952-1-git-send-email-luke@diamand.org>
Cc: marcus.holl@sap.com, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 27 09:19:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUrSx-000571-Vb
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 09:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbbH0HTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 03:19:15 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33706 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbbH0HTO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 03:19:14 -0400
Received: by wijn1 with SMTP id n1so45899840wij.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 00:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7zaMjc8VuSHJk7x7/OWtpEoCrstDztDpDr+SLR0CY14=;
        b=YCP6HxKfMVnRTfYAMstK7E+7kF8jzsZl9+XOXgRhfLVeUY7xiDhmQincXqtUHeZH6+
         TSEJKUYV6iD+ZMPVMqGPlxtx6sXj6AyblQgwpvfS9t6RODwOmaNmcFFgaBRVrwfGwKX9
         MvKuSe7jAI0UJ7ssmKmmVrBAkXx1l7IuxZUdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7zaMjc8VuSHJk7x7/OWtpEoCrstDztDpDr+SLR0CY14=;
        b=LNg/1ieD/04qO+c4ioHNw+D80MZuQoblm8FmcVQWUTd06t2OvSuHfEkCGRLtdjcGof
         UNlbpay03ftKH9mP/VLVxh3oO/tkTq9mMZtfDTLVURrB5G4aYM9e7e4s5KJtBmPPp/1f
         EvvbL2MPRd5BFGkxHp0A1ZxBaaYEn+vVeNUCJPaLdwq5h9pOT2ZhCj+1gKqD12H0fL/l
         nyxAI5eE35wn66UApzw8wlNJpHBBomBCRyGutvLOh70A1TUyO76eaUmu7PtQ5pcHGsyf
         H6GzBuJWF/AiqKkaGoKJcuMnZS5aru4WdHS/Mu6JoK43cRiqeIJ7jAT54ahvJNNCEG3C
         vJWQ==
X-Gm-Message-State: ALoCoQlw3QOs7hlu+JlDV0cdu/zcRq5b8G6aEEQxIIrkKCWbkCii0sfuUEkkYmxmKfsXaqBnvyIp
X-Received: by 10.180.8.68 with SMTP id p4mr8947564wia.27.1440659953105;
        Thu, 27 Aug 2015 00:19:13 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by smtp.gmail.com with ESMTPSA id ne7sm2140308wic.12.2015.08.27.00.19.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Aug 2015 00:19:12 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276663>

Marcus Holl discovered that git-p4 fails to import labels sometimes.

http://permalink.gmane.org/gmane.comp.version-control.git/273034

It turns out there are at least two related problems.

The first is that if git-p4 tries to import a P4 tag which references
a commit that we don't know about at all (e.g. because the P4
changelist was created before the point at which the repo was
cloned) then when it tries to find the commit, the git rev-list
command fails, and git-p4 terminates.

This can be fixed by detecting the problem and ignoring that label.

The second problem is that git-p4 can end up trying to find out
about a commit which is still in the git fast-import stream and not
yet processed. This is fixed by using fast-import "marks" to reference
these commits, which avoids having to query for commits which don't
yet exist. The normal path is used for commits that have not been
imported during this run of the program (and so won't have marks).

A test case is added to demonstrate the problem.

Marcus - if you're able to take a look at this and see if it
fixes your problem that would be very useful.

Thanks,
Luke

Luke Diamand (3):
  git-p4: failing test for ignoring invalid p4 labels
  git-p4: do not terminate creating tag for unknown commit
  git-p4: fix P4 label import for unprocessed commits

 git-p4.py                      | 25 +++++++++++++++--------
 t/t9811-git-p4-label-import.sh | 45 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 8 deletions(-)

-- 
2.5.0.rc0
