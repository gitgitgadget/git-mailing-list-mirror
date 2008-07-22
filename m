From: "Luuk Paulussen" <luuk.paulussen@gmail.com>
Subject: Difficulty with getting an accurate changelog after cherry-picking and merging.
Date: Wed, 23 Jul 2008 08:38:19 +1200
Message-ID: <7dc909980807221338g707d6104ob8b1534cdf02a77a@mail.gmail.com>
Reply-To: luuk@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 22 22:39:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLOdl-0001XK-G4
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 22:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbYGVUiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 16:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752079AbYGVUiW
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 16:38:22 -0400
Received: from ti-out-0910.google.com ([209.85.142.187]:39943 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbYGVUiV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 16:38:21 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1023932tic.23
        for <git@vger.kernel.org>; Tue, 22 Jul 2008 13:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=N9t5gxwZY0ME44/xYvwJZCpTWCX868DVwyjEmNB95/w=;
        b=Ms/+XtSJcAAF6vwYjSg3v3sSz2AOJk3chYJlNI+Awx0irSBroX3jJIrgzZcC6zrY1x
         u3u76FBD4q7yo/xRJVRqZxI705EGK+KwqtlwJa6HXPp5ht4JE5dcHxPqu2Id88NftHw6
         VYu/tD+bBBEIVEV2afSlq4HJ/kH7ZJCVY20Y0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=DwAjncS2L709LKWIRiIAdmdcckNzECR28uuSte6XgjqlO/wkjWMnlfZ4tq0gZFxIY/
         I5vcy8fXmQjhxM2GpbtIGqCTxWBIR6rMPfU3S3iRZm22wUWIbJhOgtlfm2QAMmCAEfry
         zHOniSnWSZBJHntWmPtuEKl010zahgitYkIkQ=
Received: by 10.110.10.16 with SMTP id 16mr4981467tij.15.1216759099987;
        Tue, 22 Jul 2008 13:38:19 -0700 (PDT)
Received: by 10.110.28.2 with HTTP; Tue, 22 Jul 2008 13:38:19 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89526>

Hi,

I'm trying to generate an accurate changelog of changes between 2 tags
on a branch.  There is a merge between these 2 points which includes
changes that were cherry-picked before the start point.  This causes
the changelog to show these changes, despite them already existing
before the start point of the log.

I've included a test script below that creates a repository that shows
a simplified version of the issue.  Basically, I want the changelog to
only show the changes between the start and end tags, which are test4
and test5, but I get a list that also includes other commits.  I have
tried git-cherry and git-log with --cherry-pick and various things
with git-rev-list and git-merge-base.

#!/bin/sh
mkdir testrepo
cd testrepo
git init
echo initial > testfile
git add testfile
git commit -m initial
git branch stable
for f in $(seq 1 5)
do
    echo test$f >> testfile
    git commit -a -m test$f
done
#without this sleep the cherry-picks end up with the same hash as
their original commit...
sleep 1
git checkout stable
git cherry-pick :/test1
git cherry-pick :/test2
git cherry-pick :/test3
git tag start
git cherry-pick :/test4
git merge master
#Clean up the merge error.
if [ ! $? -eq 0 ]
then
    sed -i "/[:=]/ d" testfile
    git commit -a -m "Merge branch 'master' into stable"
fi
git tag end
##########################

Thanks,
Luuk
