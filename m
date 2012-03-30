From: Martin Fick <mfick@codeaurora.org>
Subject: Git push performance problems with ~100K refs
Date: Thu, 29 Mar 2012 18:18:49 -0600
Organization: CAF
Message-ID: <201203291818.49933.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 30 02:19:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDPYo-0000Hq-EN
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 02:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760322Ab2C3ASw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 20:18:52 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:40304 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759505Ab2C3ASv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 20:18:51 -0400
X-IronPort-AV: E=McAfee;i="5400,1158,6664"; a="174870735"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/ADH-AES256-SHA; 29 Mar 2012 17:18:50 -0700
Received: from mfick-lnx.localnet (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id E586510004AB
	for <git@vger.kernel.org>; Thu, 29 Mar 2012 17:18:50 -0700 (PDT)
User-Agent: KMail/1.13.5 (Linux/2.6.32-37-generic; KDE/4.4.5; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194306>

Hello,

I am back to talk about git performance with lots of refs: 
~100K.  This time I am investigating pushes to a repo with 
about ~100K ref, a gerrit mirror which includes the gerrit 
changes.  When I push just a simple one line change to a 
file, the push takes about ~43s.  If I delete the changes
from the destination repo, this push takes about 6s.  This 
seems rather excessive to me, in fact given that the repo 
with 100K refs has more data in it and is more likely to 
have the objects I am pushing in it, if things are done 
right, it should be a faster push (in theory).

So, upon early investigation, I noticed that the time to 
push seems mostly determined by the receiving end which is 
processing all out for 100% on a CPU.  During this time 
period, the receiving end git commands look like this:

  git-receive-pack path/to/repo.git

and:

  git rev-list --objects --stdin --not --all

The latter of these two commands is the one burning CPU.

Does anyone have any hints as to what might be wrong with 
the receiving end algorithm that would cause a small change 
to use so much CPU?  Is there anything that can be done 
about it?  I noticed that the --all option will effectively 
feed  all the 100K refs to rev-list, is this really 
necessary?  Are there any tests that I can perform to help 
debug this?

I am using git 1.7.8.3 and I also tried 1.7.10.rc3, same 
results.

Thanks,

-Martin


-- 
Employee of Qualcomm Innovation Center, Inc. which is a 
member of Code Aurora Forum
