From: Peter Krefting <peter@softwolves.pp.se>
Subject: git pull --rebase and losing commits
Date: Mon, 2 Nov 2009 13:26:37 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0911021318400.3919@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 02 13:26:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N4vzh-0003Ay-N6
	for gcvg-git-2@lo.gmane.org; Mon, 02 Nov 2009 13:26:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857AbZKBM0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 07:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754846AbZKBM0e
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 07:26:34 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:48963 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754747AbZKBM0d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 07:26:33 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id nA2CQbQw010267
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 2 Nov 2009 13:26:37 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id nA2CQbmc010263;
	Mon, 2 Nov 2009 13:26:37 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Mon, 02 Nov 2009 13:26:37 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131902>

Hi!

I have put my web site under Git control, and am running into some problems.

Whenever I push changes, I go via a bare repository, which then is pulled 
into a checked out tree in my "public_html" directory. However, some scripts 
I have does create files directly under the "public_html", and some of them 
I want to push into the Git history.

I am trying to use --rebase everywhere to get a linear history in the cases 
where I have pushed changes to the bare repository while there were 
uncommited changes to the public_html directory.

I have come up with a script that does this (I have removed the 
uninteresting non-git commands):

  # Commit local changes
  git add path/to/script/output/*
  for file in $(git diff-index --cached --name-only HEAD); do
   havenew=1
  done
  if [ $havenew = 1 ]; then
   git commit --quiet -m 'Automatic' path/to/script/output/*
  fi

  # Update tree (--strategy=ours avoids merge conflicts)
  git pull --rebase --strategy=ours origin master

  # Push rebased local changes
  git push origin master

  # Update all references
  git fetch origin master:remotes/origin/master

However, this seems to lose commits. When I ran it today, it commited an 
automatic change, and then pulled a tree that did not contain that change, 
making the changed file just disappear. I had to dig through the reflog to 
find it:

- This is the auto-commit:
   608b7eda553552841f4a16167c680fc74ed3c55a 
509926edd306bb2f09f563a7cfda800a4f0fdaed Peter Krefting 
<peter@softwolves.pp.se> 1257162580 +0100      commit: Automatisk 
bloggkommentarsuppdatering

- This is the "git pull":
   509926edd306bb2f09f563a7cfda800a4f0fdaed 
9088bd4801a9008fe3fca0d351f97544cee014f1 Peter Krefting 
<peter@softwolves.pp.se> 1257162583 +0100      rebase finished: 
refs/heads/master onto 9088bd4801a9008fe3fca0d351f97544cee014f1

The history of 9088bd... does not contain the rebased version of 509926..., 
it just went missing.

I guess I am missing something vital here.

  $ git --version
  git version 1.5.6.5

-- 
\\// Peter - http://www.softwolves.pp.se/
