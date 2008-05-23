From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH v3 0/23] Implementation of a file tree iteration using ignore rules.
Date: Fri, 23 May 2008 22:34:09 +0200
Message-ID: <1211574872-23676-1-git-send-email-florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 22:36:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzdzu-0006CA-UX
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 22:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756990AbYEWUei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 16:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756750AbYEWUeh
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 16:34:37 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:39632 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756357AbYEWUeg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 16:34:36 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 4C10BDE1A897
	for <git@vger.kernel.org>; Fri, 23 May 2008 22:34:33 +0200 (CEST)
Received: from [84.150.81.80] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JzdyD-0005iq-00
	for git@vger.kernel.org; Fri, 23 May 2008 22:34:33 +0200
X-Mailer: git-send-email 1.5.5.1
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX19L5TEJJr0uVMqUxQosKv5Ldtl+Z/L/YhSexX50
	QG+OjFBv1hqxWH3F7MTlbSL2RpaLYTEN5+s5XPFGFCiCfFg0OE
	W4kKJLWtUWF4Hj5/l2Rg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82733>


Hi

This patch set contains a new fnmatch implementation.

I dropped the idea of an regex based Matcher and implemented my own one.

The matcher matches character for character and can produce another matcher, which always starts at the position where it's parent was at creation time.

If you need to match:
very/long/path/a.txt
very/long/path/b.txt
very/long/path/c.txt

Then you can match "very/long/path" in matcher p and then "a.txt", "b.txt" and "c.txt" in another matcher c.

That works for any input pattern which are currently supported:
* characters
* the wildcards ? and *
* the wildcards ? and * with one character which should not appear like '/' 
* simple groups like [ab]
* ranges in groups like [a-c]
* inversed groups like [!ab]

Unsupported are colon expressions like ":alpha:". I didn't expect git-add to support it, but as I just noticed git does.
 
Also backslashes expressions like "\d" for digits are evaluated as the characters \ and d. Looks like git does the same for backslashes. In "git-add" patterns \  characters get replaced by / characters, as windows users might want to type a\b.txt instead of a/b.txt.

All implementations of FilePattern are now based on this matcher.
I combined as suggested the TreeFilePattern and the ComplexFilePattern into one class named FilePathPattern. I furthermore renamed the GlobalFilePattern into FileNamePattern.

"git add" patterns are now handled very similar to git, except that
a/\*/b.txt is also a valid pattern. It would match any path that starts with "a/" and ends with "/b.txt" independent of the number of slahes between.

 .../org/spearce/jgit/lib/FileNameMatcherTest.java  |  311 +++++++++++++
 .../jgit/treewalk/LightFileTreeIteratorTest.java   |  114 +++++
 .../treewalk/rules/AddCommandIterationTest.java    |  321 +++++++++++++
 .../treewalk/rules/OverallIgnoreRulesTest.java     |  375 +++++++++++++++
 .../jgit/errors/InvalidPatternException.java       |   44 ++
 .../jgit/errors/NoGitRepositoryFoundException.java |   28 ++
 .../errors/PathNotInProjectDirectoryException.java |   25 +
 .../src/org/spearce/jgit/lib/Constants.java        |   30 +-
 .../src/org/spearce/jgit/lib/FileNameMatcher.java  |  376 +++++++++++++++
 .../src/org/spearce/jgit/lib/Repository.java       |  482 +++++++++++++-------
 .../src/org/spearce/jgit/lib/WorkTree.java         |   67 +++
 .../jgit/treewalk/LightFileTreeIterable.java       |   59 +++
 .../jgit/treewalk/LightFileTreeIterator.java       |  112 +++++
 .../jgit/treewalk/rules/AddRuleListFactory.java    |   75 +++
 .../jgit/treewalk/rules/AddRulesFactory.java       |   90 ++++
 .../jgit/treewalk/rules/FileNamePattern.java       |   58 +++
 .../jgit/treewalk/rules/FilePathPattern.java       |   76 +++
 .../spearce/jgit/treewalk/rules/FilePattern.java   |  107 +++++
 .../jgit/treewalk/rules/IgnoreRuleListFactory.java |   94 ++++
 .../src/org/spearce/jgit/treewalk/rules/Rule.java  |   61 +++
 .../treewalk/rules/RuleListToObjectConverter.java  |  130 ++++++
 .../src/org/spearce/jgit/treewalk/rules/Rules.java |   99 ++++
 .../jgit/treewalk/rules/RulesImplementation.java   |   73 +++

Best regards,
Florian Koeberle
