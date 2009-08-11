From: tarmigan <tarmigan+lists@gmail.com>
Subject: unpack a single object
Date: Tue, 11 Aug 2009 13:15:52 -0700
Message-ID: <905315640908111315j459b81f2jc414f2a09c6b830e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 11 22:16:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Maxlg-0008PP-Kx
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 22:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbZHKUQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 16:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752435AbZHKUQO
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 16:16:14 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:3288 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbZHKUQN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 16:16:13 -0400
Received: by an-out-0708.google.com with SMTP id d40so4282309and.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 13:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=Hzed3Awj0qK4DVMbwoAcFkjvnH3okhhwSC0Ulkw0SiQ=;
        b=op4G3nis/9HhngqC5ZZrO31fsnvN5/whiUffgdFscDZhcHl/HojnNuqwCOqhBM5qHI
         LY0AH88O394u1FzZI8wcqqMBrwJAv+6xHPkSuKaajnzAixk8h2EdwrNvnBxIjERDTzR7
         I5zLmtc7tEiqCsi+q2cAvEONYoexmaDfhYWNI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type:content-transfer-encoding;
        b=oC7hsB0Gy4SghVmj+j2ZEPAl/IMSiPv1rKUUpZQ0I0Xy1NobDV/SCiHc59cd5Ycgtm
         adTmcRx2I+Uaye++NdulbapjS6jEOhC4Briqgqqmn6gqu5WlQXyowuVi4gIq1G5nQn+R
         wXW+/ZdKZNz+6cyMKdvnKaEjwr/AhrBHT//k0=
Received: by 10.100.8.17 with SMTP id 17mr5948320anh.158.1250021774159; Tue, 
	11 Aug 2009 13:16:14 -0700 (PDT)
X-Google-Sender-Auth: cf8da1fe5c9b7f38
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125588>

Hi,

At work we use SVN.  To deal with this I mirror the svn repo with
git-svn and have a cron job that runs git svn rebase every hour, and
then I rebase from that git repo.

Unfortunately, on the computer that runs the cron job, /home ran out
of space.  After making more space and deleting the
svn/trunk/.rev_map, my 'git svn rebase' dies with a
> git svn rebase
Rebuilding .git/svn/trunk/.rev_map.4279b43a-dd95-8640-b069-b0d2992e4ff2 ...
error: Could not read 3d4c2b0225e7605a7e2a38ffc44dcb888589f4ce
fatal: Failed to traverse parents of commit
31c4379db99f05d0942e7c204b38f7b587fb4d3b
rev-list --pretty=raw --no-color --reverse refs/remotes/trunk --:
command returned error: 128

So I look for corruption with
> git fsck --full --strict
broken link from  commit 31c4379db99f05d0942e7c204b38f7b587fb4d3b
              to  commit 3d4c2b0225e7605a7e2a38ffc44dcb888589f4ce
dangling blob a6027cd01178f19243342c0f6ccaef8fb798dcf4
                <snipped more dangling blobs>
dangling blob 4348d7ebd189208716b44bcf4198c1f29d18e6c3
missing commit 3d4c2b0225e7605a7e2a38ffc44dcb888589f4ce  ******
dangling blob 22757bac2e3433cccd9d7e32fa79d90031e14353
dangling blob 1276575eca02976ff677b61a6873562db7db31d7
dangling blob f98343007ac9d2f33a81fe25f4d446b045c3167a
dangling blob d29043a6e2b87cd0be1f3fb39f0c88283b79409b
dangling blob f7d08b39830709c044279d17d3d85cbe813998bb
dangling blob 64f14b305164f65c788dc9970deb7dfc79ac7446

Thankfully, I have copies of the repo and this object (3d4c2b) in
other location and that passes git-fsck.  Strangely, it is a commit
object from about 18 month ago and should have been in a pack for a
long time, so maybe running out of disk space was not the cause.

I would rather not copy the whole good repo back to the one that ran
out of space because it's multiple gigs.  My plan is to just explode
the bad pack on of the corrupted repo, explode good pack and then,
copy the corrupted object back.  So my question is how do I tell which
pack contains that object?  (I would rather not explode all the packs
because of the repo size.)  Is there a way to extract a single object
from a pack without exploding the whole pack?

git is version 1.6.4 on CentOS 5.3

Thanks,
Tarmigan
