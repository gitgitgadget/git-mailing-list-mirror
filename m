From: szager@google.com (Stefan Zager)
Subject: regression in multi-threaded git-pack-index
Date: Fri, 15 Mar 2013 15:42:40 -0700
Message-ID: <20130315224240.50AA340839@wince.sfo.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 15 23:43:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGdLD-0006vh-3O
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 23:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755223Ab3COWmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Mar 2013 18:42:43 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:36659 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754994Ab3COWmn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 18:42:43 -0400
Received: by mail-qc0-f202.google.com with SMTP id k26so391689qcs.1
        for <git@vger.kernel.org>; Fri, 15 Mar 2013 15:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:to:subject:user-agent:mime-version:content-type
         :content-transfer-encoding:message-id:from;
        bh=59DfiQ0p9rrOPPW8AEOd3qOX4R/MZiD8SIQtwHeAtgM=;
        b=Dv42GLry7uqFUdEgK+GQ1miubsyO5ZhG2gKHHGY3Tw47PRRiMrE1ntUstSDO0YNEG/
         VjqCj2+9E7Ivsu3xdJcH+x3hrHOV/B41ZMbaOFSenLyxcOlChSEtzMnmkhzkd/4DReKM
         g7eKbsa2dJk0milyEgFcmMcgXX52IDq6gGy+HouP9qHT7Wz41Nd9qCpvgr+S56B2U3rU
         KnFeBHxb5Rp+s2QQqSQ78iC/ZFwR0MbmbpHfipVK1Svmf1lh/Kmf9Cpdoh2vTNs/w51r
         ipiJouoqDo6KGLlq+TFF28XP7n+WyMhhFHCeVQxCgrpoNCoBl4jVrz6VaDtvLEOs3Yfw
         yGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:to:subject:user-agent:mime-version:content-type
         :content-transfer-encoding:message-id:from:x-gm-message-state;
        bh=59DfiQ0p9rrOPPW8AEOd3qOX4R/MZiD8SIQtwHeAtgM=;
        b=pzyzB5yGHanilpWBm/xkNiCz+SZFDgNRqjNdiJpdCCdnNNDIsLQ9QUUz3GFOBcjigG
         9PoN/nWlCT5BJgHeEz/iKfvRBvgq3W6O59fQgIX/kUg1Gss85RF+5IsBANNeRI0M40do
         YZeiuDvAkQWA9bHAaub0t/Tt1+8CHfHl7xyP8qbJ+1Ea4NcVW1bxOvHnZs7Kjga5KTZq
         70VuhioobefH11Z3d0Xv7Ptk0cgHe2sy8PNdjEDj2Pr3RQ2GxGP65fOJMFWeMXbSJKnl
         tH4OWWGwidJikcMXYEHB3VyiRkkKZ0C50p40W0mZ6Hgr4gDPbU0a0K1oBm7N8pPG6BqZ
         zlQw==
X-Received: by 10.52.91.204 with SMTP id cg12mr4345037vdb.1.1363387361117;
        Fri, 15 Mar 2013 15:42:41 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id i65si971821yhh.5.2013.03.15.15.42.41
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Fri, 15 Mar 2013 15:42:41 -0700 (PDT)
Received: from wince.sfo.corp.google.com (wince.sfo.corp.google.com [172.31.53.43])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id F096031C1E1
	for <git@vger.kernel.org>; Fri, 15 Mar 2013 15:42:40 -0700 (PDT)
Received: by wince.sfo.corp.google.com (Postfix, from userid 138314)
	id 50AA340839; Fri, 15 Mar 2013 15:42:40 -0700 (PDT)
User-Agent: Heirloom mailx 12.5 6/20/10
X-Gm-Message-State: ALoCoQlZw/hXjmyYlbnN3TSb0igBxZzcdW6rG7710+4qYtUxJI14BTBejMeEfyQEz/Je5RGrJzaluod9+tmokg6aA7yNMQGuiApbdVxEBOhk95OddX6cqQoMofOCzJo9VsKJO5a2FxrOlrYE7IjT6b/cJuBMAEo3FsvJ5HAw8GmCphuHv3a9vprzJFMluXYPMPN/RpUkSXiwQEXvKqxgZIywD8fB1LfggA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218267>

We have uncovered a regression in this commit:

b8a2486f1524947f232f657e9f2ebf44e3e7a243

The symptom is that 'git fetch' dies with:

error: index-pack died of signal 10
fatal: index-pack failed

I have only been able to reproduce it on a Mac thus far; will try ubuntu next.  We can make it go away by running:

git config pack.threads 1

To reproduce it, download this working copy:

http://commondatastorage.googleapis.com/chromium-browser-snapshots/tmp/src.git.tar.gz

Then:

tar xvfz src.git.tar.gz
cd src.git
git fetch origin refs/heads/lkgr

(That is the shortest reproduction I could come up with; sorry).

Thanks,

Stefan
