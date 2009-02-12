From: Eric Kidd <eric.kidd@gmail.com>
Subject: [RFC] What's the best UI for 'git submodule split'?
Date: Thu, 12 Feb 2009 16:50:28 -0500
Message-ID: <431341160902121350x45076c8cj26afab0b7a51cac5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 22:52:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXjTU-0000rL-5I
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 22:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757612AbZBLVud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 16:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756312AbZBLVuc
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 16:50:32 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:47861 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754932AbZBLVub (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 16:50:31 -0500
Received: by yw-out-2324.google.com with SMTP id 5so497211ywh.1
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 13:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=h7nI1/boJhNK3qCAxF1YDJJJu0QsgpZYlTXm4IysfpE=;
        b=eLuMQnsQKOdbAxyDpHcxe9101ZD9K8I/+/VpXrBdoM9R9Qpw01wQSSZ1u0/K8qPktX
         WmXGmce+P/cYIBGhBVljGehH9XkLPxRkWovz16dR5Y8sxxyLkR6JndmNb4XNx2qCAij/
         pROSX+nnCMCjIo3K9Me1f2V6qvLx0+q4CZu8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=hcsGD5mcmVph5DHBhZWC+GIfFrZadGzvkheHhUwdkLF0d/jOPGb24Vgn9TvWtzOxK4
         7jAwd7voLIiIaQk9lHU61+GDv+fP9gQrgY0ZBE68QtN8Ht4xXg308MXxSqH9XNS/yzYv
         frPVrMgqjGRN2ojm5D0xF4Z5KcIe3CKBhGbP0=
Received: by 10.150.230.8 with SMTP id c8mr1374993ybh.88.1234475430076; Thu, 
	12 Feb 2009 13:50:30 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109667>

The problem: At work, we're converting a large git repository to
Subversion. This repository contains an optional "streaming/media"
directory which we want to split into a submodule. Some constraints:

  1) We want 'git bisect' to work with the converted repository, so
the submodule should exist all throughout the repository's history,
and not just in the HEAD revision.
  2) The submodule has moved around the tree in the past, and it has
occasionally disappeared for a commit or two. For example, it used to
live in "Media", not "streaming/media". We want to hook up these
different historical locations into a single submodule.

The proposed solution: I'm working on a 'git submodule split' script
which works as follows:

  git submodule split streaming/media Media
  rm .git/refs/original # or just use --force below
  git submodule split other-binaries

This will create two submodules, one at streaming/media and one at
other-binaries. It will rewrite the parent repository's history to
create correct submodule links, and update .gitmodules as necessary at
each point in the history. The new modules will be placed at their
most recent locations in the tree.

Some Q&A:

Q. Why not merge 'submodule split' into the existing 'filter-branch' loop?

A. Internally, 'submodule split' needs to make two separate passes
with 'filter-branch': One to create the new submodule, and one to
update the parent. If I were to merge 'submodule split' into the
existing filter-branch loop, filter-branch would need to keep track of
two repositories. Writing 'submodule split' as a wrapper around
filter-branch helps keep filter-branch simple.

Q. Why only process one submodule at time?

A. If there were multiple submodules, each with several different
historical locations, the data structures in sh would get too tricky
for me to implement well. But I'm happy to take patches and UI
suggestions.

Q. Why operate on the current directory, and why output the new
submodule in place?

A. An earlier version of 'submodule split' took the arguments
'src-repo dst-repo sub-repo sub-repo-dir...'. This required the user
to do more typing, and it didn't feel very "git like". Johannes
Schindelin suggested the current interface. The new interface feels
more natural to me, and it's certainly easier to use in the common
cases.

Q. What's the status of the code?

A. I'll have a very basic implementation of this interface shortly--I
can already handle simple splits, but I want to add more test cases
and add support for directories which move around the tree.

Thank you very much for your feedback! I appreciate the time that the
reviewers spent helping to improve my filter-branch patch, and I'd
like to make this patch as good as possible.

Cheers,
Eric
