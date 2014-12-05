From: Jesse Hopkins <jesse.hops@gmail.com>
Subject: git bundle vs git rev-list
Date: Fri, 5 Dec 2014 15:36:18 -0700
Message-ID: <CAL3By--xYnXFUdDP3MDxAxvfeBT3ArFrdAV=apzdWg6_kiD2Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 05 23:36:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx1U9-0003YV-Ko
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 23:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbaLEWgU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Dec 2014 17:36:20 -0500
Received: from mail-qc0-f178.google.com ([209.85.216.178]:59835 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbaLEWgT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Dec 2014 17:36:19 -0500
Received: by mail-qc0-f178.google.com with SMTP id b13so1329052qcw.23
        for <git@vger.kernel.org>; Fri, 05 Dec 2014 14:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=nknVj+YRtH4XhrgLot9IythMWAV2DhgZS8dKifNRmTE=;
        b=FY+v45u5jj0suvfAcWEhxnn9lzoh44wSUY+pqrGCuRFwcibf8mXRZylja6blFjWBth
         Kj7+Zym025vivXRSA8UQJfxv921W44nG9kbs1k2YS+n1MD/vRmWVUfQz/hvFHgTz6/BW
         bxcBAaxBWKyTdJbQLccacqtRP19+RNq9+28DmVLxZbrHzXRZrI+h3Psi+w6ehhnK+0sq
         PCC+DOxMN3RMBm61iOPBmyTDOTWUwRVWJVm6Xx1nxeIpwS2WKexj/d3v7wSmeNUPK++9
         giQwmJLJ4sOlh7zYCMxK1dVLapdJuyK5UVLUbZj6jdM7hM0itYedxffqd6M0oD26Zku/
         EpPA==
X-Received: by 10.140.18.240 with SMTP id 103mr29398346qgf.1.1417818978851;
 Fri, 05 Dec 2014 14:36:18 -0800 (PST)
Received: by 10.96.199.167 with HTTP; Fri, 5 Dec 2014 14:36:18 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260904>

Hello all =E2=80=93



I am working to create a wrapper around git bundle to  synchronize of
git repos via sneakernet from network =E2=80=98a=E2=80=99 to network =E2=
=80=98b=E2=80=99 transfer on a
fairly frequent basis (daily to weekly).   Network =E2=80=98b=E2=80=99 =
has a
gatekeeper who is persnickety about what content might end up on his
network. The gatekeeper wants to know about the content being
transferred.



I=E2=80=99ve come up with a scheme to list the final form of all files
included in the bundle in whole or in part, see the psuedo code below:



# BEGIN PSEUDOCODE

#Create the bundle
git bundle create out.bundle --all "--since=3D<last_bundle_date>"

#Get list of commits
included_commits =3D git rev-list --all "--since=3D<last_bundle_date>"


#For each commit, get the immediate parent(s), and find objects in its
parents' tree that are not in its tree
foreach commit in included_commits:
               #Get all blobs in this commit's tree, map blob to file n=
ame
               CommitBlobsMapToFilename =3D Process(git ls-tree -r comm=
it)

               #Now find the parent commit(s)
               ParentCommits =3D git rev-list --parents -n 1 commit

               foreach parent in ParentCommits:
                              #Get all blobs in the parent's tree
                              ParentBlobsMapToFilename =3D Process(git
ls-tree -r parent)

                              #Find blobs in this commit's tree that
are not in the parent's commit tree
                              NewBlobs =3D
setdiff(CommitBlobsMapToFilename , ParentBlobsMapToFilename);

                              #Write each new blob contents to a unique=
 filename
                              foreach blob in NewBlobs
                                             filename =3D
CommitBlobsMapToFilename(blob)
                                             filename =3D makeUnique(fi=
lename)
                                             git show blob > filename
 # END PSEUDOCODE


This scheme has worked well, but this is approach is predicated on the
assumption that

git bundle create  =E2=80=93all =E2=80=93since=3D<last_bundle>

uses the same commits that are returned by

git rev-list --all --since=3D<last_bundle>

However, I=E2=80=99ve noticed a scenario where that is not the case.  I=
 create
a bundle using --since=3Dyesterday, where no activity has been made
within the past few days.  As expected, 'git rev-list --all
--since=3Dyesterday' returns 0 commits.  However, the command 'git
bundle create --all --since=3Dyesterday' creates a bundle containing th=
e
full history.

Tags seem to be the culprit, but I don=E2=80=99t know why. I do notice =
in the
output of git bundle that it mentions =E2=80=9Cskipping ref =E2=80=A6=E2=
=80=9D and =E2=80=9Cskipping
tag =E2=80=A6=E2=80=9D, and sure enough all branches and most tags are =
shown as being
skipped.  However there are a few tags that are missing from that
list.

If I use --branches rather than --all as the limiter, then all is
well.  In that case, git rev-list still returns 0 commits, and git
bundle reports that it is refusing to make an empty bundle, as
expected.

So after all that, I have a two questions:

1. Any thoughts on why a tag would be included by 'git bundle', when
'git rev-list' with the same arguments returns empty?

2. Is there a way to list commits contained in the bundle file itself?
 This seems like it would be more robust than trying to re-create the
commit list via 'git rev-list'.

Thanks,

Jesse
