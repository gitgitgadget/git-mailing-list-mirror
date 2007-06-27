From: Brian Gernhardt <benji@silverinsanity.com>
Subject: t9400-git-cvsserver-server failures
Date: Tue, 26 Jun 2007 23:07:58 -0400
Message-ID: <3E98C380-541B-479F-9E8F-6BBE82EE2930@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 27 05:08:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3Nt5-00089U-HZ
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 05:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756252AbXF0DIF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 23:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756196AbXF0DIE
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 23:08:04 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:39800 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754760AbXF0DID (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 23:08:03 -0400
Received: from [192.168.1.4] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 4A1351FFC1C0
	for <git@vger.kernel.org>; Wed, 27 Jun 2007 03:08:01 +0000 (UTC)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51015>

I'm getting several failures in the git-cvsserver tests.  I don't  
even know where to start with that code, so here's as detailed an  
error report as I can give.

The first category appears to be that several of the tests use  
test_expect_failure, which expects the error codes to be less than  
127 and the error it gets is 255 (-1).

* FAIL 9: req_Root failure (strict-paths)
         cat request-anonymous | git-cvsserver --strict-paths pserver  
$WORKDIR >log 2>&1
* FAIL 11: req_Root failure (w/o strict-paths)
         cat request-anonymous | git-cvsserver pserver $WORKDIR/ 
gitcvs >log 2>&1
* FAIL 13: req_Root failure (base-path)
         cat request-anonymous | git-cvsserver --strict-paths --base- 
path $WORKDIR pserver $SERVERDIR >log 2>&1


The other seems to be that git-cvsserver is erroring with "error 1  
Conflicting roots specified" unexpectedly.  The log has the expected  
"I LOVE YOU" line, but then also has an error line.

* FAIL 12: req_Root (base-path)
         cat request-base | git-cvsserver --strict-paths --base-path  
$WORKDIR/ pserver $SERVERDIR >log 2>&1 &&
            tail -n1 log | grep -q "^I LOVE YOU$"
* FAIL 16: req_Root (everything together)
         cat request-base | git-cvsserver --export-all --strict-paths  
--base-path $WORKDIR/ pserver $SERVERDIR >log 2>&1 &&
            tail -n1 log | grep -q "^I LOVE YOU$"


And, finally, one test fails because apparently the environment is  
not set up as it expects.

* FAIL 14: req_Root (export-all)
         cat request-anonymous | git-cvsserver --export-all pserver  
$WORKDIR >log 2>&1 &&
            tail -n1 log | grep -q "^I LOVE YOU$"

This fails with:

E GITCVS emulation needs to be enabled on this repo
E the repo config file needs a [gitcvs] section added, and the  
parameter 'enabled' set to 1
E
error 1 GITCVS emulation disabled
E Invalid root /Users/brian/dev/git/t/trash/gitcvs.git

I checked gitcvs.git/config, and it has "[gitcvs] enabled = false".

~~ Brian
