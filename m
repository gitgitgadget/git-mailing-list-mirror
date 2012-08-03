From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: GSOC remote-svn: branch detection
Date: Fri, 03 Aug 2012 11:43:30 +0200
Message-ID: <12682331.q6WHVv9EKU@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: David Michael Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 03 11:44:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxEQH-0005B3-1P
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 11:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723Ab2HCJnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 05:43:53 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51071 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658Ab2HCJng (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 05:43:36 -0400
Received: by bkwj10 with SMTP id j10so166863bkw.19
        for <git@vger.kernel.org>; Fri, 03 Aug 2012 02:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding:content-type;
        bh=e7yVCJt7tPH9dzRq1G/Cb2mSCdtOQzXRtGW0TTALrvY=;
        b=h7pkx6wFNC7aN0fP7wMzo4TAT7FbxW4WZVhW6bUdzF9THFI2toxB+805WveTeWu0RK
         Tf9cdIANQROKn1kwBnWvavwcHs+hnPrn13PN4VwKNjTm6WqtKyYA/dVePSCNwgQ4fjOn
         I/QXG3Op8ohDBVBP7y0g8ybOQz3URnGqunbvE9xzr4f0UhS2+EAEk5AnjT/NWoEszQDx
         9tmBNH/1o/4baEI3vnCyDq9zik2ETng2zkKo38EZ42p4Hym0Y/kzD3xQzapNHufIb5b0
         1iunw6INTcRr1zJ+jmzGG9/VaVWZ46XhE9e1qjo5p84E4uvi806zFLkeEFAKDkQmg+nY
         km4A==
Received: by 10.204.155.69 with SMTP id r5mr391826bkw.49.1343987014921;
        Fri, 03 Aug 2012 02:43:34 -0700 (PDT)
Received: from flomedio.localnet (cm56-227-93.liwest.at. [86.56.227.93])
        by mx.google.com with ESMTPS id gq2sm4503511bkc.13.2012.08.03.02.43.32
        (version=SSLv3 cipher=OTHER);
        Fri, 03 Aug 2012 02:43:33 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.2.0-27-generic; KDE/4.8.4; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202825>

Hi!

I'm playing around in vcs-svn/ to start a framework for detecting and 
processing branches  in svndumps. So I wanted to let you know about my ideas.

Two approaches:
1. Import linearly and split later:
One idea is to import from svn linearly, i.e. one revision on top of it's 
predecessor, like now, and detect and split branches afterwards. The svn 
metadata is stored in git notes, so the required information would be 
available.
+ allows recovery, because the linear history is always here.
+ it's easier to peek around in the git history than in the svn dump during 
import to do the branch detection.
- requires creation of new commits in the branch detection stage.
- this results in double commits and awkward history, linear vs. branched.

2. Split during import:
Detect branches as they are created while reading the svn dump and identify to 
which branch a following node belongs.
First step is to restructure svndump.c to be able to buffer one complete 
revision for inspection before starting to write a commit to fast import.
Probably it's possible to feed the blobs to fast import directly and only 
buffer node data and defer commit creation, but not the data.
Currently, at the beginning of a new revision on the svn side, a new commit is 
created on top of a constant ref. When we support branches, we don't know the 
ref, i.e. the branch(es), the revision changes, before reading all the 'Node-
*' lines.
+ feels more 'right'
- requires revision buffering

Generally:
Detect branches as they are created by 'Node-copyfrom*' to some commonly used 
branch directories, like branches/. More complex branch detection can be 
implemented later, of course.
Store detected branches permanently (necessary for incremental fetches), and 
assign every file modification to one of those branches, if possible. Else 
assign them to, hm .. 
If a revision modifies more than one branch, create multiple commits.

Thanks for your comments and ideas! 

--
Florian
