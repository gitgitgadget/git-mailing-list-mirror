From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 0/3] gitweb: Dealing with being on unborn branch
Date: Wed, 15 Feb 2012 16:36:40 +0100
Message-ID: <1329320203-20272-1-git-send-email-jnareb@gmail.com>
Cc: rajesh boyapati <boyapatisrajesh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 16:37:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxguj-0007fO-JE
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 16:37:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084Ab2BOPg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 10:36:57 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:58019 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712Ab2BOPgz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 10:36:55 -0500
Received: by wics10 with SMTP id s10so595904wic.19
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 07:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=EJsEzZWyyw8r1CZdK9zkm3pQar0Averf4B2Naxtm2tM=;
        b=YI+vQnOTZFSewGCl/EbE18YjpImLk4SAAhkz3vhtKIjSJKuYwj+uJx+xBH55JQxsUo
         dbnvphDpKOPBP4uoRMvQH+M1jwPfd0wgeXLyR2nowg1OUDm8lMSLeyn1p2De1jHhyVj0
         t6inlmNPnXnCbbfm8OlJv4orvxmJJPzESjbQU=
Received: by 10.180.89.71 with SMTP id bm7mr9078503wib.20.1329320214836;
        Wed, 15 Feb 2012 07:36:54 -0800 (PST)
Received: from localhost.localdomain (abwo207.neoplus.adsl.tpnet.pl. [83.8.238.207])
        by mx.google.com with ESMTPS id q2sm34200366wiy.7.2012.02.15.07.36.51
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Feb 2012 07:36:54 -0800 (PST)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190832>

This is resend (as series) of patches that were sent first time
individually in "Fwd: Git-web error" thread sent to git mailing list
by rajesh boyapati:

  http://thread.gmane.org/gmane.comp.version-control.git/189228

Unfortunately the thread is heavily fragmented in GMane interface,
because Rajesh responses were not sent to git mailing list.

The problem that original poster seen was caused by the fact that:

rb> For my git projects on gerrit, our main branch name is "base".
rb> We don't have any code on "master" branch. [...]
rb> [...] the HEAD file is pointing to "ref: refs/heads/master".
rb> So, I think that's the reason for errors.

Some of errors might appear in the way Rajesh sees them because gitweb
in this case is deployed from Gerrit (Git-based review board, in Java);
at least I couldn't reproduce some of errors in exactly the same way
as presented.

Note that there is no problem if repository is totally empty, without
any valid branch.  The problem is when HEAD doesn't point to the valid
commit object, but there are other commits and branches.

Anyway beside not using 'master' branch, but not renaming it /
repointing HEAD, such situation might happen when you have just
created an orphan branch, but haven't made any commits on it yet.


Table of contents:
~~~~~~~~~~~~~~~~~~
* [PATCHv2 1/3] gitweb: Deal with HEAD pointing to unborn branch
  in "heads" view

This fixes a real issue, and is a true fix (for current way of
generating "heads" view).  Note that there is "heads" excerpt in
"summary" view.

* [PATCHv2/RFC 2/3] gitweb: Harden parse_commit and parse_commits

Just add an early exit in the case of invalid parameters.  Though if
caller is passing undefined value for commit identifier, it would
probably not deal correctly with parse_commit() returning undef,
though it should deal correctly with parse_commits() returning empty
list.

More of band-aid than a real fix.

* [RFC/PATCHv2 3/3] gitweb: Silence stderr in parse_commit*()
  subroutines

This adds an overhead of forking a shell, and possibility of code
injection if our quote_command() is incorrect... and actually does not
fix issue for the original poster, and is not a problem for ordinary
(non-Gerrit) gitweb.


Shortlog:
~~~~~~~~~
Jakub Narebski (3):
  gitweb: Deal with HEAD pointing to unborn branch in "heads" view
  gitweb: Harden parse_commit and parse_commits
  gitweb: Silence stderr in parse_commit*() subroutines


Diffstat:
~~~~~~~~~
 gitweb/gitweb.perl                     |   21 ++++++++++++++-------
 t/t9500-gitweb-standalone-no-errors.sh |    9 +++++++++
 2 files changed, 23 insertions(+), 7 deletions(-)

-- 
1.7.9
