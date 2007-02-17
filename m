From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: test suite failures because cmp behaves oddly
Date: Sat, 17 Feb 2007 22:25:12 +0100
Message-ID: <200702172225.12758.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 17 22:25:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIX3Z-0004YC-6h
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 22:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932955AbXBQVZR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 16:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932963AbXBQVZR
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 16:25:17 -0500
Received: from smtp1.noc.eunet-ag.at ([193.154.160.117]:42212 "EHLO
	smtp1.noc.eunet-ag.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932955AbXBQVZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 16:25:16 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.noc.eunet-ag.at (Postfix) with ESMTP id 132C133EBC
	for <git@vger.kernel.org>; Sat, 17 Feb 2007 22:25:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 7FCD5531E7
	for <git@vger.kernel.org>; Sat, 17 Feb 2007 22:25:13 +0100 (CET)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40014>

Does anyone know how 'cmp' can signal success when its output is redirected 
to /dev/null, even if the compared files are different?

$ cmp M.sum actual7.sum; echo $?
M.sum actual7.sum differ: char 20, line 2
1
$ cmp M.sum actual7.sum > /dev/null; echo $?
0
$ bash --version
GNU bash, version 3.1.17(1)-release (i586-suse-linux)
$ cmp --version
cmp (GNU diffutils) 2.8.7
[...]

Due to this behavior I see reproducible failures in the test suite, unless the 
tests are run in --verbose mode:

$ make GIT_TEST_OPTS=-i t1002-read-tree-m-u-2way.sh
*** t1002-read-tree-m-u-2way.sh ***
*   ok 1: setup
*   ok 2: 1, 2, 3 - no carry forward
*   ok 3: 4 - carry forward local addition.
*   ok 4: 5 - carry forward local addition.
*   ok 5: 6 - local addition already has the same.
* FAIL 6: 7 - local addition already has the same.
        rm -f .git/index nitfol bozbar rezrov frotz &&
             git-read-tree --reset -u $treeH &&
             echo frotz >frotz &&
             git-update-index --add frotz &&
             echo frotz frotz >frotz &&
             git-read-tree -m -u $treeH $treeM &&
             git-ls-files --stage >7.out &&
             diff -U0 M.out 7.out &&
             check_cache_at frotz dirty &&
             sum bozbar frotz nitfol >actual7.sum &&
             if cmp M.sum actual7.sum; then false; else :; fi &&
             : dirty index should have prevented -u from checking it out. &&
             echo frotz frotz >frotz1 &&
             diff frotz frotz1 &&
             rm -f frotz1
make: *** [t1002-read-tree-m-u-2way.sh] Error 1


Has anyone seen something like this?

-- Hannes
