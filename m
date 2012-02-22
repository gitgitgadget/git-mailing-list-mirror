From: Jannis Pohlmann <jannis.pohlmann@codethink.co.uk>
Subject: Problems with unrecognized headers in git bundles
Date: Wed, 22 Feb 2012 16:05:45 +0000
Message-ID: <4F451259.7010304@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 17:52:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0FQw-0002Os-J7
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 17:52:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754613Ab2BVQv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 11:51:57 -0500
Received: from auth.codethink.co.uk ([208.78.96.188]:46688 "EHLO
	auth.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754139Ab2BVQvz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 11:51:55 -0500
X-Greylist: delayed 2762 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Feb 2012 11:51:55 EST
Received: from [192.168.1.207] (host86-184-106-216.range86-184.btcentralplus.com [86.184.106.216])
	(authenticated bits=0)
	by auth.codethink.co.uk (8.14.4/8.14.4) with ESMTP id q1MG5jwI007990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 22 Feb 2012 16:05:46 GMT
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0) Gecko/20111222 Thunderbird/9.0
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on auth.codethink.co.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191265>

Hi,

creating bundles from some repositories seems to lead to bundles with 
incorrectly formatted headers, at least with git >= 1.7.2. When cloning 
from such bundles, git prints the following error/warning:

   $ git clone perl-clone.bundle perl-clone
   Cloning into 'perl-clone'...
   warning: unrecognized header: --work around mangled archname on...

This can be reproduced easily with git from any version >= 1.7.2 or from 
master, using the following steps:

   git clone git://perl5.git.perl.org/perl.git perl
   GIT_DIR=perl/.git git bundle create perl-clone.bundle --all
   git clone perl-clone.bundle perl-clone

The content of the bundle is:

   # v2 git bundle
   -- work around mangled archname on win32 while finding...
   39ec54a59ce332fc44e553f4e5eeceef88e8369e refs/heads/blead
   39ec54a59ce332fc44e553f4e5eeceef88e8369e refs/remotes/origin/HEAD
   ...

The "--work around mangled archname..." line is rather long, so I've 
omitted most of it. What it contains is a series of commit messages all 
combined into a single line. It appears that this line is the problem 
because it's neither a comment (like '#v2 git bundle') nor a SHA1 
followed by a ref name.

Note that this problem does not occur with all repositories. A bundle 
created from a test repository with a single text file and just one 
commit does not have this problem.

Note also that "git clone <bundle> <dest>" does not fail with corrupted 
bundles if the git version is something like 1.7.2 or 1.7.7.6. Those 
version print the above warning but still succeed in cloning. "git 
clone" from master however treats this as an error and fails.

Without any knowledge of how git works internally, I would assume that 
this is either a bug in how bundles are created, or a hint at a slightly 
broken perl repository (other's have the same thing though, perhaps it 
is because of a conversion from another SCM software to git in the 
past). Does this sound reasonable?

Is there a way to work around this or fix it properly? I'm not sure what 
lead to the decision to no longer ignore unrecognized headers in git 
master, would it be sensible to revert this change if nothing can be 
done to solve this during bundle creation?

   - Jannis
