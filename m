From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH] add a reflog_exists and delete_reflog abstraction
Date: Mon,  5 May 2014 15:57:56 -0700
Message-ID: <1399330677-17930-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 19:02:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiCV-0007Xo-Oj
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbaEEW6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 18:58:01 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:41906 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756752AbaEEW6A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 18:58:00 -0400
Received: by mail-vc0-f202.google.com with SMTP id if11so1963vcb.1
        for <git@vger.kernel.org>; Mon, 05 May 2014 15:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/ayY17CZrngJ9C4Iy3SLyM3qwMicf+3Ci+Z7pQO/DDI=;
        b=mwzcsq5RHiAQZjOelvxXDHmF3EzCpVo0OtXPKlhxU08fPti/d0N8N4iig1pzlNSSzB
         +1xhRpxu7sjFSJx7ru7bxVdtr6fBK1tiapCyWdX/eS2vD/wG0Lz6YuHcty0js3WUhjt7
         UHbaBVZqd8dkUBlc0gZzoet9eGDb/kWBLs0ttyI9ihr4Y4qQ8tx7sHegAzI1MatP32Sy
         iHrD9YPdn04lQZLeaFZdiPTpZJ4q44Au63mAr9DJbZHUvQ58Ndv2qSNeeiVcq+MMGee2
         fd7+MDxg3729vPmgJjFEcrqJk+AwYO4L22vWbj3jd315meq6fyEFos7YxIdBl9Iqy0QG
         ss9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/ayY17CZrngJ9C4Iy3SLyM3qwMicf+3Ci+Z7pQO/DDI=;
        b=E+/pa74PoF2EUemIU7e0OX7+DMT6sIgymo7pmQ7Qi8ZFB+eYV8Rfa4lmuxyKNxL4T9
         /cUM1X6eorbOPBBhoVRVHqqwwf0YkbMLmYqsJpchCK+2gsM0qa66MSNvG0yxpTMS3XNt
         /vyEJZWW3OBKXXrCNKUUuZtvpyqh7wmIKKzuNjCm/c7o2BExN06UfzFaxRQjszE6Kv1o
         qu0dTw6rHaCWszUB61eB1UdA7qtlz7sxPoCzrbmEjA1K6dRYPuAnsG3y7413FoLnsQEv
         /9s1rj8QR7zJWYbsKWGya67xeBXG6Al0irK376LA1kOPWt7yK8mAcTDeF9w7X3dfvdib
         ayXA==
X-Gm-Message-State: ALoCoQkk5//Z+P71yd916TIWWu0zYcA99ddy8l8ycqpmjTFmP6uwJ/K7IesZl7ymy3lVCuhkCiyE
X-Received: by 10.236.77.194 with SMTP id d42mr15424383yhe.21.1399330680154;
        Mon, 05 May 2014 15:58:00 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id g21si437779yhe.3.2014.05.05.15.58.00
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 May 2014 15:58:00 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 04F2531C0AF;
	Mon,  5 May 2014 15:58:00 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 99782E1A8A; Mon,  5 May 2014 15:57:59 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.gd2b7e18.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248166>

This is a single patch that adds two new functions to try to hide the reflog
implementation details from the callers in checkout.c and reflog.c.
It adds new functions to test if a reflog exists and to delete it, thus
allowing checkout.c to perform this if-test-then-delete operation without
having to know the internal implementation of reflogs (i.e. that they are files
that live unde r.git/logs)

It also changes checkout.c to use ref_exists when checking for whether a ref
exists or not instead of checking if the loose ref file exists or not.
Using ref_exists instead both hides the reflog implementation details from
checkout.c as well as making the code more robust against future changes.
It currently has a hard assumption that the loose ref file must exist at this
stage or else it would end up deleting the reflog which is true today, as far
as I can tell, but would break if git would change such that we could have
a branch checked out without having a loose ref file for that branch.


Ronnie Sahlberg (1):
  refs.c: add new functions reflog_exists and delete_reflog

 builtin/checkout.c |  8 ++------
 builtin/reflog.c   |  2 +-
 refs.c             | 20 ++++++++++++++------
 refs.h             |  6 ++++++
 4 files changed, 23 insertions(+), 13 deletions(-)

-- 
2.0.0.rc1.351.gd2b7e18.dirty
