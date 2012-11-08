From: "McHenry, Matt" <mmchenry@carnegielearning.com>
Subject: git-svn with ignore-paths misses/skips some revisions during fetch
Date: Thu, 8 Nov 2012 08:50:56 -0500
Message-ID: <D377A9280DB18546A2471214D5CBB0E9054C25E071@exchdb01>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 08 14:57:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWSbp-0000Sy-De
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 14:57:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755586Ab2KHN5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 08:57:16 -0500
Received: from webmail.carnegielearning.com ([67.109.87.207]:47427 "EHLO
	webmail.carnegielearning.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753278Ab2KHN5P convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Nov 2012 08:57:15 -0500
X-Greylist: delayed 323 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Nov 2012 08:57:14 EST
Received: from exchdb01.carnegielearning.com ([127.0.0.1]) by exchdb01
 ([127.0.0.1]) with mapi; Thu, 8 Nov 2012 08:51:49 -0500
Thread-Topic: git-svn with ignore-paths misses/skips some revisions during
 fetch
Thread-Index: Ac29uBOsPAvjRB1eQXmOU1cpVTHhzw==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
x-exclaimer-md-config: 4a2a7f2a-5ce0-45d8-a978-59e527d0c9d2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209158>


        My company has a fairly large SVN repository, and I'm running into a bug with git-svn where some revisions aren't being fetched.

        The repository has a standard trunk/tags/branches layout, but there are some top-level directories under trunk/ that clearly don't belong in Git, and some that do.  So, I've been experimenting with two approaches: a single git-svn clone that uses 'ignore-paths' to exclude the stuff that I don't want; and a series of per-subdir clones that use "fetch = trunk/<subdir>:refs/remotes/trunk" to pull in only that subdir.

        The problem is that the 'ignore-paths' approach sometimes misses commits during a fetch, and then at some later time will "realize" it and squash those changes onto some other, unrelated commit.  (I've never seen this happen with the per-subdir 'fetch' approach.)  Here are three commits in SVN:

$ svn log -v -r 172602 -r 172605 -r 172626 svn://dev
------------------------------------------------------------------------
r172602 | matt | 2012-10-31 16:03:08 -0400 (Wed, 31 Oct 2012) | 1 line
Changed paths:
   M /branches/localization-merge/buildprocess/antfiles/dmg.xml
   D /branches/localization-merge/buildprocess/resources/CDs/JavaApplicationStub
   M /branches/localization-merge/buildprocess/resources/launchanywhere/Cognitive Tutor.app.zip

update to use newer java application stub
------------------------------------------------------------------------
r172605 | matt | 2012-10-31 16:29:25 -0400 (Wed, 31 Oct 2012) | 1 line
Changed paths:
   M /branches/localization-merge/buildprocess/antfiles/dmg.xml
   M /branches/localization-merge/buildprocess/antfiles/lmstree.xml

ensure that sdk-fe code is installed; fix to get correct app-dir value for antcalls; add problem authoring tool
------------------------------------------------------------------------
r172626 | leslie | 2012-11-01 08:49:36 -0400 (Thu, 01 Nov 2012) | 1 line
Changed paths:
   M /branches/localization-merge/authoring/sdk/src/sdk-cc/src/main/java/cl/sdk/tdde/problemspace/problemtypes/geo/area/AreaPerimeterTutorInstance_PPV.java

check the right shape-values for the gn
------------------------------------------------------------------------


        The first two are not to be found in git: 'git log --all --grep 17260[25]' returns nothing.  However, the third commit is there, and has had the changes from the earlier two (and some others) squashed into it somehow:

$ git log --grep 172626 --numstat --summary
commit 6d9a10abc17c74396e07bb4bc7692059ac0e8b99
Author: leslie <leslie@752fcc94-cd22-0410-baa8-ef54ac2c6973>
Date:   Thu Nov 1 12:49:36 2012 +0000

    check the right shape-values for the gn

    git-svn-id: svn://dev.carnegielearning.com/branches/localization-merge@172626 752fcc94-cd22-0410-baa8-ef54ac2c6973

13      8       authoring/sdk/src/sdk-cc/src/main/java/cl/sdk/tdde/problemspace/problemtypes/geo/area/AreaPerimeterTutorInstance_PPV.java
11      2       buildprocess/antfiles/dmg.xml
2       0       buildprocess/antfiles/lmstree.xml
-       -       buildprocess/resources/CDs/JavaApplicationStub
-       -       buildprocess/resources/launchanywhere/Cognitive Tutor.app.zip
0       25      runtime/sdk-be/src/main/resources/cl/sdk/common/localized_words_es.properties
9815    5143    runtime/sdk-be/src/main/resources/cl/sdk/tdde/problemspace/problemtypes/scratchpads/scratchpad-tutor.ctrules
773     5       runtime/sdk-be/src/main/resources/cl/sdk/tdde/problemspace/problemtypes/scratchpads/scratchpad-tutor.ctrules_strings
773     5       runtime/sdk-be/src/main/resources/cl/sdk/tdde/problemspace/problemtypes/scratchpads/scratchpad-tutor.ctrules_strings_es
1562    79      runtime/sdk-be/src/main/resources/cl/sdk/tdde/problemspace/problemtypes/scratchpads/scratchpad-tutor.cttypes
261     3       runtime/sdk-be/src/main/resources/cl/sdk/tdde/problemspace/problemtypes/scratchpads/scratchpad-tutor.cttypes_strings
261     3       runtime/sdk-be/src/main/resources/cl/sdk/tdde/problemspace/problemtypes/scratchpads/scratchpad-tutor.cttypes_strings_es
217     17      runtime/sdk-be/src/main/resources/cl/sdk/tdde/problemspace/problemtypes/scratchpads/scratchpad-tutor.ttspec
25      0       runtime/sdk-be/src/main/resources_es/cl/sdk/common/localized_words_es.properties
246     0       runtime/ui/src/main/resources/tp-tx-formula-sheet_es.html
 delete mode 100755 buildprocess/resources/CDs/JavaApplicationStub
 delete mode 100644 runtime/sdk-be/src/main/resources/cl/sdk/common/localized_words_es.properties
 create mode 100644 runtime/sdk-be/src/main/resources_es/cl/sdk/common/localized_words_es.properties
 create mode 100644 runtime/ui/src/main/resources/tp-tx-formula-sheet_es.html


        The directories on the server are:

$ svn ls svn://dev/trunk
IDEs/
QA-automation/
authoring/
bugtracking/
buildprocess/
curriculum/
doc/
images/
installer/
lib/
misc-tools/
research/
runtime/
scripts/
serversearch/
user-assistance/
web/


        My config file is:

$ cat .git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
        ignorecase = true
[svn-remote "svn"]
        url = svn://dev.carnegielearning.com
        fetch = trunk:refs/remotes/trunk
        ignore-paths="^(trunk|tags/[^/]*|branches/[^/]*)/(doc|doc-old|IDEs|images|marathon-testing|QA-automation|research|Sikuli-Automation|bugtracking)/"
        branches = branches/{sdk-bug-258,2007-Q2-problemcounter,2008-Q2-bugfix,WEBEQ-REDUCTION,proof-gng,2009-Q2-marathon,2008-Q4,2009-Q4-bugfix,2009-Q2-bugfix-client,modules,2009-Q2-bugfix,2007-Q2-webstart,2011-Q3-math-lounge,2011-Q3-nyc,2011-Q2,2011-Q3-bugfix,cstoy,2010-Q2-bugfix,localization,localization-merge,2012-Q2-bugfix,hs_web_20120524,2012-research-casl,2012-Q3-math-208-9,2012-Q3-aug-localization}:refs/remotes/branches/*
        tags = tags/{webeq-3.7,2009-Q2-release,2010-Q2-release,ui-old-impl-code,2011-Q3-release,2011-Q2-release,2012-Q2-release}:refs/remotes/tags/*


        My git and OS versions are:

$ uname -a
Linux alpha 3.3.8-gentoo #1 SMP PREEMPT Thu Jul 26 21:25:22 EDT 2012 i686 Intel(R) Core(TM)2 Duo CPU E8400 @ 3.00GHz GenuineIntel GNU/Linux

$ git svn --version
git-svn version 1.7.8.6 (svn 1.6.17)

        On the svn server, I have:

mmchenry@dev:~$ svnserve --version
svnserve, version 1.6.16 (r1073529)
   compiled Mar  4 2011, 09:05:11


Matt McHenry
Software Developer
Carnegie Learning, Inc.
(888) 851-7094 x150 toll free
(412) 690-2444 fax
mmchenry@carnegielearning.com
www.carnegielearning.com

Decision 2012: Election Math | Engaging Video Content | FREE Interactive Math Problems
http://www.nbclearn.com/portal/site/learn/decision2012
