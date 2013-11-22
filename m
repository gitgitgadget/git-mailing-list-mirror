From: Sergey Sharybin <sergey.vfx@gmail.com>
Subject: Git issues with submodules
Date: Fri, 22 Nov 2013 13:53:33 +0600
Message-ID: <CAErtv26Q_YN+U+trjNac1aKLi9BvNHNNuaUkrr2RE0nB+yxWsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 22 08:53:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjlYY-0003qX-Mk
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 08:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638Ab3KVHxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 02:53:34 -0500
Received: from mail-vb0-f54.google.com ([209.85.212.54]:59528 "EHLO
	mail-vb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132Ab3KVHxe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 02:53:34 -0500
Received: by mail-vb0-f54.google.com with SMTP id p6so638792vbe.27
        for <git@vger.kernel.org>; Thu, 21 Nov 2013 23:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=z1L9M0D7vfqjEPdqEKv8o45Kq1REWf2Y4XleCsTaaHc=;
        b=wSYlYAl9TonCPeYh1ccaYGkZPdAeFqrBKkzdDj7TJahAfWHyI7JxKF53UD/goBhFMd
         E/oJL4e1khVZ+P3Xgsccx1Xb+/mXTxIvJ/gvZOyxILwEbedbGmgxxrxeV12HOtDJ2i6O
         HRk3RKysCqS+9L+oOTLypUGcm0uplyW4/jrffK6zPG+ux7WUQmZdheEMKx40zLAVXHlN
         P4sgcHXgdKTsf5PV9M0GJk3yQu5mZG5lUAPpNfb9jtITiPfEDCrtbzeqIlHJZDiA1KUg
         kdBtfcRY8z8Vf1zfpsYJz68OqeaL7i4/yhQC8FQC3QxYObPtqhrzHa7g6j5DvEMJ8LOS
         GQyw==
X-Received: by 10.220.11.7 with SMTP id r7mr10149430vcr.12.1385106813540; Thu,
 21 Nov 2013 23:53:33 -0800 (PST)
Received: by 10.52.169.2 with HTTP; Thu, 21 Nov 2013 23:53:33 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238173>

Hey everyone from Blender developers!

As you might already know, we've recently switched from SVN to Git to
host Blender sources. In general it works really awesome, but we've
got some issues with submodules.

in SVN we had separate repositories for addons and translations which
were attached to main tree as svn:external. The reason for this was:

1. Separate commit access between core sources and addons so nobody
accidentally breaks anything in the core.
2. Separate commit history to help tracking issues down.

For the most developers and all artists (yes, we've got loads of
artists who builds blender on their own) it makes sense to always
checkout latest versions of addons and translations when updating
working tree.

We used Git submodules as a replacement for svn:external, with some
tweaks and specific of update procedure.

Namely, we always do `git submodule update --remote` to pull all the
latest changes from submodules. This will mark checkout as modified
because submodule hash changes. To avoid infinite commits of submodule
hash we've added ignore=all to their configuration.

In most cases it works fine, but there're some circumstances when it
gives weirdo issues.

Namely, `git ls-files -m` will show addons as modified, regardless
ignore=all configuration. In the same time `git diff-index --name-only
HEAD --` will show no changes at all.

This leads to issues with Arcanist (which is a Phabricator's tool) who
considers addons as uncommited changes and either complains on this or
just adds this to commits.

This issue i might easily reproduce on my laptop with latest Git
1.8.4.3. There're also some more issues which happens to our
developers and which i can not quite reproduce.

Sometimes it happens so git checkout to another branch yields about
uncommited changes to addons and doesn't checkout to another branch.

My guess here is that submodule hash in master and branch was
different and having hash modified in master somehow prevented changes
from another branch to be checked out. In this case question would be:
what would be the proper way to checkout branches when having
submodules configured this way?

Second issue is that some developers still manages to commit changes
to submodule hash, which i have totally no idea why Git allows to
include such a changes. I could not do such a commits on purpose even.

Here're some links to help understanding what's going on:

- Blender repository browser: http://developer.blender.org/diffusion/B/
- Task in our tracker about issues we've got with Git:
http://developer.blender.org/T37528
- History of changes to addons hash:
http://developer.blender.org/diffusion/B/history/master/release/scripts/addons

We're totally new to git submodules and clarification (and maybe even
confirmed bug with ls-files -m :) would really be appreciated. We're
also open for suggestions about re-configuring our submodules so they
works in a way we'd expect this.

Thanks in advance!

-- 
With best regards, Sergey Sharybin
