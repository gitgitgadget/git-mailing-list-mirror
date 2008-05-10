From: Florian Koeberle <florianskarten@web.de>
Subject: [JGIT PATCH 0/m] Implementation of a file tree iteration using ignore rules.
Date: Sat, 10 May 2008 15:00:18 +0200
Message-ID: <1210424440-13886-1-git-send-email-florianskarten@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 10 15:01:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Juohl-0007ej-KA
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 15:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755479AbYEJNAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 09:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755404AbYEJNAn
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 09:00:43 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:44561 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754193AbYEJNAm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 09:00:42 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 35868DE983BB
	for <git@vger.kernel.org>; Sat, 10 May 2008 15:00:41 +0200 (CEST)
Received: from [84.150.90.150] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1Juogq-000860-00
	for git@vger.kernel.org; Sat, 10 May 2008 15:00:41 +0200
X-Mailer: git-send-email 1.5.5.1
X-Sender: florianskarten@web.de
X-Provags-ID: V01U2FsdGVkX1/DthVKaXBo+m1kYbVCZoCMgxVhpvPrk9TlR50B
	dnoK9S76zuQuq2qjdYYsWWdeeHR+C6oECTahCX38UXQ3BmsJ0H
	F12e++E64DA/bmtwoSgg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81664>

Hi

here are the patches.

The implementation does a lot of performance optimizations:

1.) Instead of checking all the rules from top to bottom, I simply take the first matching rule beginning from bottom. I actually have intern a list with a inversed order and take then the first matching rule.


2.) Each sub directory has it's own optimized rules.

2.1.) Rules which can never match are removed. e.g. There is no need to check the rule "/a" in the directory b.

2.2.) The list is cut at the first rule which match always. *.txt\n/a for example would result in an internal list "ignore all, ignore *.txt" which is then reduced to "ignore all".

2.3.) Ignore rules which are direcly before an "ignore all" all rule are removed. /a\n*.txt for example would result in an intern "ignore *.txt, ignore all" list which is then reduced to "ignore all",

2.4.) "do not ignore" rules at the bottom of the intern list are removed. This optimization would remove !a from "!a\n/b" as it is in the inversed list at the bottom.

2.5.) When converting the rule list into an instance of the Rules interface, rule lists with only one always matching rule are converted to Rules.IGNORE_NOTHING and Rules.IGNORE_ALL objects. These special objects avoid unessary object construction as they reuse themself for sub directories.


3.) Only rules are evaluated which could match at the current directory level. e.g. You don't need to check the rule /a/b/c for every file in /a, but only for files in the directory /a/b


4.) The Iterator doesn't walk into trees from which it knows that they will never match. It can do so by comparing the rules instance for the directory with the value of Rules.IGNORE_ALL.

Best regards,
Florian Koeberle
