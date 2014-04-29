From: David Turner <dturner@twopensource.com>
Subject: Bug: Case-insensitive filesystems can cause merge and checkout problems
Date: Tue, 29 Apr 2014 15:02:00 -0400
Message-ID: <CAE+yK_m_bPt2pS6MQOrpvVDuLAJf8NFxYOgM8i98tU6-gLcTDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 21:02:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfDI8-0005Vj-Jc
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 21:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965011AbaD2TCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 15:02:03 -0400
Received: from mail-we0-f175.google.com ([74.125.82.175]:44232 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965000AbaD2TCC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 15:02:02 -0400
Received: by mail-we0-f175.google.com with SMTP id q58so657339wes.34
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 12:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=AtxSNHgs6szyfpQ7ACpeDjCt+V9Q+f9ZjajQBUkpLlU=;
        b=ia//QTzQDOLrAqI5HtRcxPx+6FDn8+ub05YOSbt7DlNAsz3nISYrgOqcAtx3JyhxtL
         zzGaP4VkOXdyykmbawBbFhbYjBdQZ3yLdmWh5vMBE1r2r/Ml7gvWq7kNEBzQKwZ4pOl4
         lqGPFjCvFQMaNxTv4iQFBaeCpDNGrb+CVcFOZ2PclMd03JkBfDq6u78Enmp9hBlPutgG
         YxvVzOZPDumIAfdave08mN6JFBTMSaStiSFqG4UafFehd3y+Ne5pYsOASN9Wi7lKvEpw
         p1np+kzGU/tMeuJL9z2WlCU1lG9ZblN75wSKGIoUAH+phn0b021diUyQ0Wm0qGkCweWj
         59aA==
X-Gm-Message-State: ALoCoQmD25bRFcrMwBaq2jwt4W+wMZdskHM5Oo0aIa6zxGWjw1jhjzzL7nxzHJX+vP757UP7+huP
X-Received: by 10.194.203.170 with SMTP id kr10mr981823wjc.19.1398798120926;
 Tue, 29 Apr 2014 12:02:00 -0700 (PDT)
Received: by 10.180.18.104 with HTTP; Tue, 29 Apr 2014 12:02:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247604>

By default, git sets core.ignorecase=true when git init or git clone
is run on a machine with a case-insensitive filesystem.  Here's a
test-case for some problems that this causes:

git checkout master
touch TestCase
git add TestCase
git commit -m 'add TestCase'
git checkout -b with-camel
touch foo
git add foo
git commit -m 'intervening commit'
git checkout master
git rm TestCase
touch testcase
git add testcase
git commit -m 'rename to testcase'
git checkout with-camel
git merge master -m 'merge'

One would expect a clean working copy at this point, but in fact, the
file 'testcase' will be deleted.

With core.ignorecase=false, we get a different failure.  The
penultimate command fails with:
$ git checkout with-camel
error: The following untracked working tree files would be overwritten
by checkout:
        TestCase
Please move or remove them before you can switch branches.
Aborting

Of course, there is no untracked working tree file by that name; there
is a tracked working tree file named testcase (all-lowercase).
