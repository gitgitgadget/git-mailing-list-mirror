From: Marius Vollmer <marius.vollmer@uni-dortmund.de>
Subject: git-rebase --merge gets stuck on --skip
Date: Wed, 13 Aug 2008 04:51:01 +0300
Message-ID: <87y731adiy.fsf@uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 03:52:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT5Wz-00040Q-FQ
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 03:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252AbYHMBvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 21:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753106AbYHMBvF
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 21:51:05 -0400
Received: from smtp6.pp.htv.fi ([213.243.153.40]:56930 "EHLO smtp6.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752626AbYHMBvE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 21:51:04 -0400
Received: from zagadka.ping.de (cs178034.pp.htv.fi [213.243.178.34])
	by smtp6.pp.htv.fi (Postfix) with SMTP id 2AC3A5BC02F
	for <git@vger.kernel.org>; Wed, 13 Aug 2008 04:51:02 +0300 (EEST)
Received: (qmail 17411 invoked by uid 1000); 13 Aug 2008 04:51:01 +0300
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92163>

Hi,

I might have found a bug with "git-rebase --merge".

When skipping over more than one commit in a row, only the first skip
has any effect.  The second and subsequent skips do not change the state
in .git/.dotest-merge.

This works fine with the regular git-rebase.

I use Debian's git-core 1:1.5.6.3-1.1.  I haven't tried newer versions.

How to reproduce:

  $ git clone http://zagadka.vm.bytemark.co.uk/git/project2.git
  $ cd project2/
  $ git checkout -b dev-1 origin/dev-1
  $ git rebase --merge master
  (fails with a conflict)
  $ cat .git/.dotest-merge/msgnum
  1
  $ git rebase --skip
  (fails with a different conflict)
  $ cat .git/.dotest-merge/msgnum
  1
  $ git rebase --skip
  (fails with the same conflict again)
  $ cat .git/.dotest-merge/msgnum
  1
  $ git rebase --skip
  $ cat .git/.dotest-merge/msgnum
  1
  $ git rebase --skip
  $ cat .git/.dotest-merge/msgnum
  1
  $ git rebase --skip
  $ cat .git/.dotest-merge/msgnum
  1

And so on ad infinitum...

In contrast, git-rebase without --merge eventually finishes:

  $ git clone http://zagadka.vm.bytemark.co.uk/git/project2.git
  $ cd project2/
  $ git checkout -b dev-1 origin/dev-1
  $ git rebase master
  (fails with a conflict)
  $ cat .dotest/next
  1
  $ git rebase --skip
  $ cat .dotest/next
  2
  $ git rebase --skip
  $ cat .dotest/next
  3
  $ git rebase --skip
  HEAD is now at 060b191 Master 2.
  Nothing to do.
