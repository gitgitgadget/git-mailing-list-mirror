From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Basename matching during rename/copy detection
Date: Wed, 20 Jun 2007 23:06:22 -0400
Message-ID: <20070621030622.GD8477@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: govindsalinas <govindsalinas@yahoo.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 21 05:07:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1D0i-0005zH-Ns
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 05:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbXFUDGa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 23:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753494AbXFUDGa
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 23:06:30 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:34736 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023AbXFUDG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 23:06:29 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I1Czv-0005RT-PE; Wed, 20 Jun 2007 23:06:15 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2A0E920FBAE; Wed, 20 Jun 2007 23:06:23 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50585>

So Govind Salinas has found an interesting case in the rename
detection code:

  $ git clone git://repo.or.cz/Widgit.git
  $ git diff -M --raw -r 192e^ 192e | grep .resx
  :100755 000000 4c8ab79... 0000000... D  Form1.resx
  :100755 100755 9e70146... 9e70146... R100       CommitViewer.resx       UI/CommitViewer.resx
  :100755 100755 90929fd... b40ff98... C091       RepoManager.resx        UI/Form1.resx
  :100755 100755 90929fd... 90929fd... C100       PreferencesEditor.resx  UI/PreferencesEditor.resx
  :100755 100755 90929fd... 90929fd... R100       PreferencesEditor.resx  UI/RepoManager.resx
  :100755 100755 90929fd... 8535007... R097       RepoManager.resx        UI/RepoTreeView.resx

In this case several files had identical old images, and some
kept that old image during the rename.  Unfortunately because of
the ordering of the files in the tree Git has decided to "rename"
the PreferencesEditor.resx file to UI/RepoManager.resx, rather than
renaming RepoManager.resx to UI/RepoManager.resx.  Go Git.

I'm wondering if we shouldn't play the game of trying to match
delete/add pairs up by not only similarity, but also by path
basename.  In the case above its exactly what Govind thought should
happen; he moved the file from one directory to another, and didn't
even change its content during the move.  But Git decided "better"
to use a totally different file in the "rename".

-- 
Shawn.
