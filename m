From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [RFC] plumbing git-notes
Date: Fri, 29 Jul 2011 19:24:38 +0600
Message-ID: <CA+gfSn_ay555SCfW=BzcF=73GpG1fckQoiAzpGcR-J5AyoV-mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 29 15:24:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qmn3W-00082W-In
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 15:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532Ab1G2NYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 09:24:40 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:34982 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145Ab1G2NYj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 09:24:39 -0400
Received: by qwk3 with SMTP id 3so1822269qwk.19
        for <git@vger.kernel.org>; Fri, 29 Jul 2011 06:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=poWnPNTEoh9Jdcepx5gnlPZkAWPXBhPPMfTbvYf65MM=;
        b=bfujVzRQnyldWcDHkgvDsKejAa9hu/+8jAtu35+Om3KQYflhpuFI7FqKOyhlazvNfr
         ivmwKMgonJEA/ug71pU92Dr28ugEukn9mlYs86e62NBJ9GBzp57TGUQJ3NnnSimdU2iF
         r5cOVCA1IUmb9mGWgJ9Z0J42gkJ/5fNcIu6JY=
Received: by 10.229.101.93 with SMTP id b29mr400563qco.112.1311945878423; Fri,
 29 Jul 2011 06:24:38 -0700 (PDT)
Received: by 10.229.189.3 with HTTP; Fri, 29 Jul 2011 06:24:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178149>

Hi,

Currently git accepts notes tree specification only as a ref under ref/notes/.
We can't say
GIT_NOTES_DISPLAY_REF=  GIT_NOTES_REF= \
  git log --show-notes=refs/notes/commits^
# this one is weird, we neither say "ref is invalid" nor show the notes
or
GIT_NOTES_DISPLAY_REF=  GIT_NOTES_REF= \
  git log --show-notes=`git rev-parse refs/notes/commits`

There is a problem if for some plumbing we'd want to read or write notes
from some other place. From a temporary branch for example. A remote
helper may want to utilize notes as a private map from objects to some
data that is not a part of commit (say it can change for old objects, like
revprops in svn). And also it may want to expose this map.

Another problem is working with a notes tree like with a regular tree.
Merging, rebasing, etc can be done, but we can't map temporary
notes revs to objects, unless they are kept as refs/notes/some_tmp_note.

One more question is the notes for a remote repository. We don't clone
refs/notes/ by default, but where do we keep them if we'd want them to
be tracked?
refs/remotes/origin/notes/
refs/notes/remotes/origin/
refs/notes/origin/
refs/remote-notes/origin/
refs/notes/user_decides_which

We have remote refspec defaults:
refs/heads/*:refs/remotes/origin*
refs/tags/*:refs/tags/*.
What will be the destination for:
refs/notes/*?

Btw, isn't it a bug:
(git init a && cd a && touch a && git add a && git commit -m a && git tag 123)
(git init b && cd b && touch b && git add b && git commit -m b && git tag 123)
(cd a && git remote add b ../a && git remote update)
Fetching b
From ../a
 * [new branch]      master     -> b/master
# we didn't store refs/tags/123 from b to anywhere and didn't say
anything about it
