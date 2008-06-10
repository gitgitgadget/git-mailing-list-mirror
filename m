From: "Benjamin Lynn" <blynn@google.com>
Subject: git import/export bug?
Date: Tue, 10 Jun 2008 01:41:10 -0700
Message-ID: <ac789dbd0806100141x55bf1d01k707034af3ec86b0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 10:42:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5zQf-0006Ao-I4
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 10:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139AbYFJIlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 04:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752696AbYFJIlP
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 04:41:15 -0400
Received: from smtp-out.google.com ([216.239.33.17]:30488 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358AbYFJIlO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 04:41:14 -0400
Received: from spaceape23.eur.corp.google.com (spaceape23.eur.corp.google.com [172.28.16.75])
	by smtp-out.google.com with ESMTP id m5A8fB71016634
	for <git@vger.kernel.org>; Tue, 10 Jun 2008 09:41:11 +0100
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1213087271; bh=KYjvHZmpJk0Rkt0Yluvzr8aWmGw=;
	h=DomainKey-Signature:Message-ID:Date:From:To:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Content-Disposition; b=sBRw
	zZ1CdgmcuNFyHZCOzQViltQ2lTiDyook98axvGj8NribEeuFokXohI0Ot1unp8ewn/m
	+ddTybBT3ZXQfsA==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:mime-version:
	content-type:content-transfer-encoding:content-disposition;
	b=YnG+GWUQNhzxRPqCAH7LegWiOLRUFYKpDcupq2KNLm0glNd0qp/dFKBiMa1GAA+xQ
	s/QziSPVcDb1S6U8zO/zg==
Received: from wf-out-1314.google.com (wfc28.prod.google.com [10.142.3.28])
	by spaceape23.eur.corp.google.com with ESMTP id m5A8egLX022277
	for <git@vger.kernel.org>; Tue, 10 Jun 2008 09:41:10 +0100
Received: by wf-out-1314.google.com with SMTP id 28so2744683wfc.18
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 01:41:10 -0700 (PDT)
Received: by 10.142.107.1 with SMTP id f1mr1931407wfc.10.1213087270217;
        Tue, 10 Jun 2008 01:41:10 -0700 (PDT)
Received: by 10.143.40.10 with HTTP; Tue, 10 Jun 2008 01:41:10 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84484>

Sorry if this is a well-known problem, but I only just came across it.
I tried searching for it briefly, but to no avail. Maybe nobody cares
because there's usually no need to export from git! And it's only one
of the satellite features, not the core. Nonetheless, if you export
git repos, you might want to know about it.

Try this:

$ git clone git://git.kernel.org/pub/scm/git/git.git  # clone git source
$ git checkout -b test 60ea0fdd7de001405fcc7591beb18a66a1f0dd09
$ git fast-export test > /tmp/x

$ cd /some/empty/dir
$ git init
$ git fast-import < /tmp/x
$ git checkout test

You'd expect exporting a pristine import to result in a faithful copy.
But type "git log" and you'll see the hash of the top commit differs.
(It's 56fe9d6d474f5c88c5c9af578802a5479346ea4a.) In fact, most hashes
are wrong, because two distinct initial commits are now related. The
root cause is git-fast-import: give it two commits with the same
branch name, and it assumes the latter is the descendant of the
former.

Normally this is what you want. But if your project, like git, ever
merges distinct initial commits, then all but the first will
unexpectedly gain parents, corrupting all their descendants' hashes.

-Ben

P.S: I found this because I wrote a git importer/exporter (mostly
copying git's fast-import.c) for my git clone for testing. To work
around it, I have a special "git-import" command that looks for "from"
commands: the current git-fast-export omits them from initial commits.
But clearly a better solution is needed.

It can't be fixed in the code. The importer language simply is too
weak. They ought to add a "initial" command that explicitly marks a
commit as such.
