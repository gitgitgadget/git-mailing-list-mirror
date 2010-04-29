From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: seeing a combined diff (no-conflict files) before committing a merge
Date: Thu, 29 Apr 2010 17:43:47 +0530
Message-ID: <r2k2e24e5b91004290513j4e5e2ebm1163a5c8fa1fdf8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 30 22:07:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7wUd-0006vh-5H
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 22:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119Ab0D3UHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Apr 2010 16:07:15 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50871 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756236Ab0D3UHK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 16:07:10 -0400
Received: by vws19 with SMTP id 19so521195vws.19
        for <git@vger.kernel.org>; Fri, 30 Apr 2010 13:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=KmgwPpnRGnzU+zqCcemzQEYQy+mmKIYfMDMmBQegp6I=;
        b=teYfxvA5IVFAZV0ydP5g2bz8eso8MB41XqQ3ZXteosaZSc609tS5pBfpIfMa1XBq1F
         +hmHrZu1cnstfl7Um34sF14W4PmbepOSDOdo9x+gjXEFVtLKvCSb93UtYR76/cmjUdTw
         L8ND4Mq3/Teoes7cCjjkjfRxbIof6LA3Z+26M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=ATLUh5IcydpA33bHCdXrPm4hr8FNh00SXZGQvxzt9J6lZS1J3LY2I0hP6KiO+R+Z+k
         5as0lEb25Q0zdM0mypdwBoPwT+C0wHBjz3zWGFnyiDUbM3e+mjQrmIYveTwTU4jj2tGH
         ejFq5pE5ZNyUOJKOV/08FJzLbt+MrbySXTXRE=
Received: by 10.220.127.75 with SMTP id f11mr6535948vcs.218.1272543227309; 
	Thu, 29 Apr 2010 05:13:47 -0700 (PDT)
Received: by 10.220.94.78 with HTTP; Thu, 29 Apr 2010 05:13:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146059>

I saw the thread at
http://kerneltrap.org/mailarchive/git/2010/3/18/25850, but there
doesn't seem to have been any resolution or further discussion.

I am thinking of two possible solutions:

(1) is there a way we can "simulate" a conflict by putting back stage
1/2/3 files, for a successfully merged file, into the index so "git
diff" will work

(2) is there some way to just pass along 3 files names (parent1,
parent2, and merged) and it would show the combined diff output.

Of course, I came up with this shell script (see below sig), but is
there a better way?  It seems like a horrible kludge!

Thanks,

-- 
Sitaram


#!/bin/bash

export TEMPDIR=$(mktemp -d)
trap "/bin/rm -rf $TEMPDIR" 0
export GIT_INDEX_FILE=$TEMPDIR/index

[[ -n $1                ]] || { echo I need a filename;    exit 1; }
[[ -f $1                ]] || { echo I need a filename;    exit 1; }
[[ -f .git/MERGE_HEAD   ]] || { echo no MERGE_HEAD;        exit 1; }
[[ -f .git/ORIG_HEAD    ]] || { echo no ORIG_HEAD;         exit 1; }

git add $1
fake_commit=$(echo fake commit to view combined diff of $1 | git
commit-tree $(git write-tree) -p ORIG_HEAD -p MERGE_HEAD)
git log -p -c -1 $fake_commit -- $1
