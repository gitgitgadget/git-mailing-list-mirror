From: "Philip Oakley" <philipoakley@iee.org>
Subject: git gui: fail on dual entries in recent repo list
Date: Sun, 13 Dec 2015 12:59:31 -0000
Organization: OPDS
Message-ID: <3453668A49C94C2AA39911FC594AE151@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Alexey A" <asstv7@gmail.com>
To: "Git List" <git@vger.kernel.org>,
	"Pat Thoyts" <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sun Dec 13 14:00:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a86GU-0006N9-Bo
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 14:00:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbbLMM7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Dec 2015 07:59:51 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:52169 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751064AbbLMM7u (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Dec 2015 07:59:50 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BOLABqa21WPFEAFlxeJAECBQEBAoMKU2gGAYcgASusNlWKPhIRhWMCAQMBAYEaTQEBAQEBAQcBAQEBQSQbhC8UAQEuHgEBIQsCCAIBJDkBBBoGBwMaARoCAQIDAYgiBAWjA45niwshhlaJMoNxgRoFjW2JCQGBLoQGiWpJhySKaoEXh0uEZz40gymBSgEBAQ
X-IPAS-Result: A2BOLABqa21WPFEAFlxeJAECBQEBAoMKU2gGAYcgASusNlWKPhIRhWMCAQMBAYEaTQEBAQEBAQcBAQEBQSQbhC8UAQEuHgEBIQsCCAIBJDkBBBoGBwMaARoCAQIDAYgiBAWjA45niwshhlaJMoNxgRoFjW2JCQGBLoQGiWpJhySKaoEXh0uEZz40gymBSgEBAQ
X-IronPort-AV: E=Sophos;i="5.20,422,1444690800"; 
   d="scan'208";a="570205481"
Received: from host-92-22-0-81.as13285.net (HELO PhilipOakley) ([92.22.0.81])
  by out1.ip03ir2.opaltelecom.net with SMTP; 13 Dec 2015 13:20:48 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282329>

A user, Alexey A, reported
(https://groups.google.com/forum/#!topic/git-users/msev4KsQGFc, Warning:
gui.recentrepo has multiply values while executing) on the Git User list
that the Git Gui start-up could barf if there were duplicate entries in the
user's recent repo list within their --global .gitconfig, but found no fix 
on
the internet.

Alexey had posted a screenshot of the script error, which, with a little
digging, got down to the _unset_recentrepo procedure in the
choose_repository.tcl file where the line
https://github.com/git/git/blob/master/git-gui/lib/choose_repository.tcl#L250

 git config --global --unset gui.recentrepo "^$p\$"

should read

 git config --global --unset-all gui.recentrepo "^$p\$"

for the case where duplicate entries are present.

This fix resolved Alexey's problem.

So far, so good.


Unfortunately this doesn't explain how duplicate entries are created, and if
the fix will affect other code, which I need some help on.

The 'proc _append_recentrepos {path}' code
https://github.com/git/git/blob/master/git-gui/lib/choose_repository.tcl#L254
has some code to avoid both duplicate entries and to limit the number of
entries in the recent repo list.

A web search to understand the code got me to the lreplace function
(http://wiki.tcl.tk/1485 #Performance: Modifying a List In-Place), which
suggest that the de-dup may (randomly) fail in some cases. In addition it
looks like the code may fail if there are multiple entries returned from the
earlier search of the recentrepo list, whereby the following lreplace would
have more args in the arg list (4 rather than two) and so confusing it,
though my ignorance of tcl precedes me here.

Even if all that tcl works fine, my proposed update will still have issues
for that code, because the append_recentrepos de-dup code keeps its own list
of the recent repos, and thinks that it removed entries one at a time, yet
the change can remove multiple entries if duplicates are present, completely
confusing the counting of entries in the local copy '$recent'.


So, have I understood the code correctly? Are more fixes needed for the
append_recentrepos code to refactor the re-ordering of the recent repos list
and limiting the list to 10 entries once the --unset-all fix is added?
--

Philip
