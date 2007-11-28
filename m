From: Markus Armbruster <armbru@redhat.com>
Subject: Cover grafting in the Git User's Manual
Date: Wed, 28 Nov 2007 19:23:01 +0100
Message-ID: <87ejeateka.fsf@pike.pond.sub.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 19:23:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxRZS-0006XI-Lb
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 19:23:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305AbXK1SXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 13:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752308AbXK1SXR
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 13:23:17 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:45136 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751007AbXK1SXQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Nov 2007 13:23:16 -0500
Received: from mail-in-16-z2.arcor-online.net (mail-in-16-z2.arcor-online.net [151.189.8.33])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id C745917F92D
	for <git@vger.kernel.org>; Wed, 28 Nov 2007 19:23:13 +0100 (CET)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-16-z2.arcor-online.net (Postfix) with ESMTP id B847C2540B3
	for <git@vger.kernel.org>; Wed, 28 Nov 2007 19:23:13 +0100 (CET)
Received: from pike.pond.sub.org (dslb-088-064-167-107.pools.arcor-ip.net [88.64.167.107])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 5EE758C47B
	for <git@vger.kernel.org>; Wed, 28 Nov 2007 19:23:08 +0100 (CET)
Received: by pike.pond.sub.org (Postfix, from userid 1000)
	id 3646990066; Wed, 28 Nov 2007 19:23:01 +0100 (CET)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4943/Wed Nov 28 17:41:29 2007 on mail-in-12.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66398>

The only mention of grafting in the manual is in the glossary:

    Grafts enables two otherwise different lines of development to
    be joined together by recording fake ancestry information for
    commits. This way you can make git pretend the set of parents
    a commit has is different from what was recorded when the
    commit was created. Configured via the .git/info/grafts file.

I believe it would be useful to cover this better, perhaps in chapter
5. Rewriting history and maintaining patch series.  It certainly would
have saved me a few hours of digging.  I already understood enough of
git to *know* that what I wanted must be possible (supply missing
parents of merges in a repository imported with parsecvs), but I
didn't know the magic keyword was graft.  I managed to figure it out
from the glossary, git-filter-branch(1) and GitWiki's GraftPoint page.

I'm neither writer nor git expert, but here's my try anyway:

Rewriting ancestry with grafts

Grafts enables two otherwise different lines of development to be
joined together by recording fake ancestry information for commits.
This way you can make git pretend the set of parents a commit has is
different from what was recorded when the commit was created.

Why would you want to do that?  Say, you imported a repository from an
SCM that doesn't record merges properly, e.g. CVS.  Grafts let you add
the missing parents to the merge commits.  Or you switched your
project to git by populating a new repository with current sources,
and later decide you want more history.  Committing old versions is
easy enough, but you also need to graft a parent to your original root
commit.

Graft points are configured via the .git/info/grafts file.  It has one
record per line describing a commit and its fake parents by listing
object names separated by a space and terminated by a newline.

    <commit sha1> <parent sha1> [<parent sha1>]*

A graft point does not actually change its commit.  Nothing can.  What
can be done is rewriting the commit and its descendants.
git-filter-branch does that:

    $ cat .git/info/grafts
    db5a561750ae87615719ae409d1f50c9dfc3fa71 08f2fa81d104b937c1f24c68f56e9d5039356764 8c231303bb995cbfdfd1c434a59a7c96ea2f0251
    git-filter-branch HEAD ^08f2fa81d104b937c1f24c68f56e9d5039356764 ^8c231303bb995cbfdfd1c434a59a7c96ea2f0251

This rewrites history between head and the graft-point to include the
grafted parents.
