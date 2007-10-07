From: "Elijah Newren" <newren@gmail.com>
Subject: Trying to use git-filter-branch to compress history by removing large, obsolete binary files
Date: Sun, 7 Oct 2007 15:23:59 -0600
Message-ID: <51419b2c0710071423y1b194f22gb6ccaa57303029d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 07 23:24:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IedcI-0004F3-Ka
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 23:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756313AbXJGVYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 17:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756032AbXJGVYE
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 17:24:04 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:17176 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753948AbXJGVYB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 17:24:01 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1430347wah
        for <git@vger.kernel.org>; Sun, 07 Oct 2007 14:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=LxJhrsBYkOmnLAh+pQE1h3uGK0CSjn/8QO6y41LSo/E=;
        b=UUc4ysjVfDDCklLhpB3z6rfokti/00dt+a9yd+qRrgRqrnpQOO7EhMTKNoEPSt2SeX5qGAdwUXa4juwG4V3fAbsMNYxWowCde3HNawuIYXcA5gfbHQRdEbvXzx690h7cVAPO435PlnMVPpWEHv1S9CxE5BzFEBJZc1H4zPvSdOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=n+2oHSPvEMie3gkifcqnZF7kXce7ABn9W9A8h2VFkqUyDpUb4n+a92vLwL/7HRefFq0MjkW9FFnp08JKcYqaBPXHw4kUHVt99p5yuJuXlO/Nv0wIJDW1xpqCRe621N7PtKdDyyb4iiQdXN9ICAALkzPLRyoZQlDlUhd1jWzooDk=
Received: by 10.115.72.1 with SMTP id z1mr4723271wak.1191792239754;
        Sun, 07 Oct 2007 14:23:59 -0700 (PDT)
Received: by 10.114.211.8 with HTTP; Sun, 7 Oct 2007 14:23:59 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60219>

Hi,

I'm using git-cvsimport to import some CVS repos, which unfortunately
included dozens of large regression test output files in their ancient
history...some of which measure hundreds of megabytes in size.  I'd
like to prune them out of the git history (I don't have access to
prune them out of the CVS history), but I'm running into problems.

The following set of instructions will duplicate my problem with a
smaller repo; why is the local git repository bigger after running
git-filter-branch rather than smaller as I'd expect?  I'm probably
missing something obvious, but I have no idea what it is.

The steps:

# Make a small repo
mkdir test
cd test
git init
echo hi > there
git add there
git commit -m 'Small repo'

# Add a random 10M binary file
dd if=/dev/urandom of=testme.txt count=10 bs=1M
git add testme.txt
git commit -m 'Add big binary file'

# Remove the 10M binary file
git rm testme.txt
git commit -m 'Remove big binary file'

# Compress the repo, see how big the repo is
git gc --aggressive --prune
du -ks .                       # 10548K
du -ks .git                    # 10532K

# Try to rewrite history to remove the binary file
git-filter-branch --tree-filter 'rm -f testme.txt' HEAD
git reset --hard

# Try to recompress and clean up, then check the new size
git gc --aggressive --prune
du -ks .                       # 10580K !?!?!?
du -ks .git                    # 10564K


Thanks,
Elijah
