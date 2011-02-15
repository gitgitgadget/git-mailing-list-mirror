From: Kevin Ballard <kevin@inkling.com>
Subject: [BUG] Replacing dir with submodule causes weird issues with cherry-pick
Date: Tue, 15 Feb 2011 15:19:04 -0800
Message-ID: <22F69B3E-600C-41AC-911D-B9808A3705E6@inkling.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 16 00:19:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpUAs-0005nw-Ns
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 00:19:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756114Ab1BOXTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 18:19:09 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:34243 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106Ab1BOXTI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 18:19:08 -0500
Received: by pva4 with SMTP id 4so103307pva.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 15:19:07 -0800 (PST)
Received: by 10.143.17.13 with SMTP id u13mr4660124wfi.269.1297811947446;
        Tue, 15 Feb 2011 15:19:07 -0800 (PST)
Received: from [10.8.8.46] ([69.170.160.74])
        by mx.google.com with ESMTPS id w42sm6307901wfh.15.2011.02.15.15.19.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 15 Feb 2011 15:19:06 -0800 (PST)
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166898>

If I replace a directory in my project with a submodule, then later attempt to
cherry-pick a commit that predates this change (but does not touch the directory),
git always marks the submodule path as containing an created/deleted merge conflict.
This makes absolutely no sense, as the change in question has nothing to do with
the directory, but git seems convinced that it did.

% mkdir a b
% cd b
% git init
% touch b && git add b && git commit -m 'initial'
% cd ../a
% git init
% touch a && git add a && git commit -m 'initial'
% mkdir b && touch b/b && git add b/b && git commit -m 'add file b/b'
% git checkout -b test && touch c && git add c && git commit -m 'add file c'
% git checkout master
% git rm -rf b
% git submodule add file://$PWD/../b b
% git commit -m 'replace dir b with submodule'
% # everything is fine at this point
% git cherry-pick test

At this point, the spurious merge conflict exists. Even more annoyingly, if I run
git mergetool, it actually moves the submodule out of the way, which requires manual
repairs after I've aborted the command.

If instead of cherry-pick I run `git show --pretty=email test | git am` everything
works as expected.

This was reproduced using git version 1.7.4.45.g3c41d, built from the next branch.

-Kevin Ballard