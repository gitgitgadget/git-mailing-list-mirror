From: "David Euresti" <evelio@gmail.com>
Subject: Problem with merge when renaming
Date: Tue, 18 Sep 2007 13:34:53 -0700
Message-ID: <95b3d0af0709181334y1e21507ey485860e4d45aa26f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 22:35:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXjn2-0001Kh-4F
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 22:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265AbXIRUe4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 16:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752985AbXIRUe4
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 16:34:56 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:34844 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755AbXIRUez (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 16:34:55 -0400
Received: by wr-out-0506.google.com with SMTP id 36so851236wra
        for <git@vger.kernel.org>; Tue, 18 Sep 2007 13:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=jJNZ9VkPjCMHk7oBj3llsmftVyEuFM1acOCA8Q6MFXs=;
        b=dhDNf2JWnY1y5W1qoiruDeqH8w66ayVkQxnKX3fMtpsuGz6f9Yrb05NDQUqEMIJ66uNTII3TQjGBMu16DLiwh0A3Z2ke42ykJGq4y2CNUDk/N1k1x+pWE0/fgQo3nYKxGahxEYCMFtwQhalAPcn7ow6dxjaF8/B+Tsch1ubkMpM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=U9P5UmU5eSU6I5vrsNpFmSHzR8OwAiU3wGtmxkDZRyeTGZYtRskZd+Vz2LJZ6xdQlxhOF8JTBLGCdq9c6vuueBO9yDWytG/D02pLWL2galxAPWMUthwtg193Kiyy20ghvaRauwIo27CzGhp4mAy+RLtqF8drpJt/WscEGCfOgXM=
Received: by 10.142.142.16 with SMTP id p16mr516202wfd.1190147693488;
        Tue, 18 Sep 2007 13:34:53 -0700 (PDT)
Received: by 10.143.167.13 with HTTP; Tue, 18 Sep 2007 13:34:53 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58631>

Hi,

I think I found a problem when you move a file into a directory of the
same name.  Here's what I did.

In a repository I created a directory with a file in it.  Commit it.
Then I move the file into a tmp name, make a directory with that name,
and move it into the directory.
git-mv dir/foo dir/foo.bin
mkdir dir/foo
git-mv dir/foo.bin dir/foo/foo.bin

Then in another branch I make a completely unrelated change.  I create
a file in another directory.

If I try to merge in the changes from the other branch or if the other
branch tries to merge in these changes I get this error:

dir/foo/foo.bin: unmerged (257cc5642cb1a054f08cc83f2d943e56fd3ebe99)
fatal: git-write-tree: error building trees
Merge with strategy recursive failed.

This is the script I've been using
#!/bin/bash
#

# Make sure it's all clean
rm -rf git-repo

mkdir git-repo
pushd git-repo
git-init
mkdir dir
git-add dir
pushd dir
echo foo > foo
git-add foo
popd
git-commit -a -m "one"
popd

# Developer A moves file into dir of same name
pushd git-repo
git-checkout -b branch-a
git-mv dir/foo dir/foo.bin
mkdir dir/foo
git-mv dir/foo.bin dir/foo/foo.bin
git-commit -a -m "File renamed"
git-checkout master
popd

# Developer B makes completely unrelated changes.
pushd git-repo
git-checkout -b branch-b
echo baz > foo.txt
echo bar > bar.txt
git-add bar.txt
git-add foo.txt
git-commit -a -m "unrelated changes"
git-checkout master
popd

# Developer A wants to merge changes from B
pushd git-repo
#git-merge branch-a
echo
#git-merge branch-b
#popd
