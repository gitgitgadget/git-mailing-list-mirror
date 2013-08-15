From: Matan Nassau <matan.nassau@gmail.com>
Subject: Bug: commit -p breaks with -m
Date: Thu, 15 Aug 2013 00:43:39 -0400
Message-ID: <6EC98F2F-98FC-439B-BD9C-B1D0DB1F5E10@gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 15 06:44:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9pPt-0001GM-ED
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 06:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150Ab3HOEnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 00:43:45 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:35792 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab3HOEno convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Aug 2013 00:43:44 -0400
Received: by mail-qa0-f46.google.com with SMTP id bq6so1520465qab.12
        for <git@vger.kernel.org>; Wed, 14 Aug 2013 21:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:from:content-type:message-id:date:to
         :content-transfer-encoding:mime-version;
        bh=D7a4qnrXvPzTIzFMpGCS7qk0VjpdaShvH26vruVP0sc=;
        b=F7euO6EZKEF2LTlLlOmrtnTLFuTnP9bnkWt+GTVCyaxNpVlhk/EzRa3G145bvl9wz7
         Zd0kk3jCvWGB9LlDOTVtgMWiBlbyLiegAbftboDPkqJ6Q/HT5fKdi0YhdH0dD86qtWZk
         I9129O+5j7s4np1kTW2GwrMe6nxBFhSbnHmqLFijZ76U85M/ejyftMeTzpMuESHPZfL7
         Mm3PZWVxtyZ7onjHcs7tvzzbIpkSdmnWyWpRdnPb/rqzvnh87VZLAlCzgXPmaGzOcbG9
         QDGmoGgON0Q7P2ysXbXQFc+FYm407A9fQvtyYSo0MvGR/xM+YD+xS48cmEzcTvrfSBal
         jDRA==
X-Received: by 10.224.70.84 with SMTP id c20mr258287qaj.33.1376541823488;
        Wed, 14 Aug 2013 21:43:43 -0700 (PDT)
Received: from [10.0.1.25] (modemcable084.206-19-135.mc.videotron.ca. [135.19.206.84])
        by mx.google.com with ESMTPSA id y1sm56206803qaj.2.2013.08.14.21.43.42
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 14 Aug 2013 21:43:42 -0700 (PDT)
X-Mailer: iPod Mail (10B329)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232331>

With git 1.8.3.3,

 $ seq 5 >data
 $ git add data
 $ git commit -mdata
 $ sed -i '2 d' data
 $ git commit -pmchange

At the prompt, type e to edit the hunk. The editor doesn't start, but git records a commit.

I found that builtin/commit.c sets the GIT_EDITOR env var to ":" when the user specifies the -m option. This was done in 406400ce4f69. Removing these two lines,

 if (!use_editor)
     setenv("GIT_EDITOR", ":", 1);

seems to fix the issue, but I'm not sure this won't break the prepare-commit-msg hook. I'd like to submit a patch: can I get a hint if this change would break commit hooks or anything else I'm not seeing?