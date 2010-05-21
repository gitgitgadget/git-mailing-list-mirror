From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: [PATCH 0/7] Various updates to make core.ignorecase=true work better
Date: Thu, 20 May 2010 22:50:28 -0600
Message-ID: <1274417435-2344-1-git-send-email-jjensen@workspacewhiz.com>
Cc: Joshua Jensen <jjensen@workspacewhiz.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 21 06:50:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFKCC-0007X7-C9
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 06:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986Ab0EUEuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 00:50:44 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:39240 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116Ab0EUEuo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 00:50:44 -0400
Received: (qmail 28834 invoked by uid 399); 20 May 2010 22:50:43 -0600
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on jeltz.qwknetllc.net
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=14.0 tests=AWL,HELO_LH_LD,RDNS_NONE
	autolearn=disabled version=3.2.5
X-Virus-Scan: Scanned by ClamAV 0.95.2 (no viruses);
  Thu, 20 May 2010 22:50:42 -0600
Received: from unknown (HELO localhost.localdomain) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 20 May 2010 22:50:42 -0600
X-Originating-IP: 76.27.116.215
X-Mailer: git-send-email 1.7.1.1930.gcd3ce
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147435>

This is a follow up patch to one I posted mid last year specifically for 
making .gitignore entries be processed in a case insensitive manner. I 
have used the patch with success since then, but I was unable to make 
the updates requested by list members. 

Over the past month, I have been able to clean up the code and extend 
the core.ignorecase=true support to better handle git status, ls-files, 
log, add, and fast-import. 

git status and add both use an update made to name-hash.c where 
directories, specifically names with a trailing slash, can be looked up 
in a case insensitive manner. After trying a myriad of solutions, this 
seemed to be the cleanest. Does anyone see a problem with embedding the 
directory names in the same hash as the file names? I couldn't find one, 
especially since I append a slash to each directory name. 

The new directory_exists_in_index_icase() duplicates some of the 
functionality in directory_exists_in_index(). I don't understand some of 
the functionality I just mindlessly cloned. Can anyone clue me in on 
what directory_exists_in_index() achieves in the case of S_ISGITLINK()? 

Updating match_one() bought case insensitive matching support for git 
ls-files? Are there other side effects I haven't found yet? 

The git add path case folding functionality is a somewhat radical 
departure from what Git does now. It is described in detail in patch 6. 
Does anyone have any concerns? 


Joshua Jensen (7):
  Add string comparison functions that respect the ignore_case
    variable.
  Case insensitivity support for .gitignore via core.ignorecase
  Add case insensitivity support for directories when using git status
  Add case insensitivity support when using git ls-files
  Add support for case insensitive directory and file lookups to git
    log
  Support case folding for git add when core.ignorecase=true
  Support case folding in git fast-import when core.ignorecase=true

 dir.c         |  110 +++++++++++++++++++++++++++++++++++++++++++++++----------
 dir.h         |    5 +++
 fast-import.c |    3 +-
 name-hash.c   |   44 ++++++++++++++++++++++-
 read-cache.c  |   16 ++++++++
 tree-diff.c   |    9 +++--
 6 files changed, 162 insertions(+), 25 deletions(-)
