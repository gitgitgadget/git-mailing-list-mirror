From: Tuomo Tanskanen <tuomo@tanskanen.org>
Subject: BUG: git_work_tree issue with git alias and scripting
Date: Fri, 18 Sep 2015 11:09:31 +0300
Message-ID: <CAE_UwRqMnmgDEUjcuxNDXgx_D3MTFxNRTgA9xGB1OvK6_d-bMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 18 10:10:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zcqkd-0001Uf-64
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 10:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbbIRIKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 04:10:18 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:34180 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbbIRIKL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 04:10:11 -0400
Received: by wicfx3 with SMTP id fx3so53598887wic.1
        for <git@vger.kernel.org>; Fri, 18 Sep 2015 01:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:content-type;
        bh=R9yOlTe+AqYduxABVRqNax6o0MV2jkjqtF7/5RY6YKs=;
        b=X7J4ponvy5NxEThD41iAFtbKvcv72AkZ4Wc+eV8ziF2+Z8CHdNi1K9vG/4ENyvBu+z
         EY97D/KXLw8/DYCqfkfV0P3D8fugbO/DxaJ0O5X4204gvCZd3olPcwBC7qGSznBYJRmX
         oX2Kq4jUROwGzy0MUGN3A/abCGcQPDJzpXyuW1zML4I50T7F0Roq8tMyzT07FZSiP4BN
         Oz/DEB8fKRHvq1RQ5HprBSA8fNbyEV9cOAW0xhhASdQo6q+yzF9FJsBkEKfQE5zODoln
         BlwxYurKj09/EOe6SXVn+3aJCQ/sR+oa0HsEm/CYtzBa1YZyVJBfh9gcSiWkdl4yQ188
         AX8A==
X-Received: by 10.180.74.47 with SMTP id q15mr14857907wiv.73.1442563810733;
 Fri, 18 Sep 2015 01:10:10 -0700 (PDT)
Received: by 10.28.127.131 with HTTP; Fri, 18 Sep 2015 01:09:31 -0700 (PDT)
X-Google-Sender-Auth: 1SAlLRQL-jvPU_UW7qwJ1IlkCB0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278183>

Hello,

Attached is a simple script exposing a possible bug when git alias is
combined with git commands in script. It should be pretty self-explanatory.
Check what it does and execute it. On my Linux and OSX, both with git 2.5.1
behave the same, ie. git add fails even the file "test" is in $PWD.

Summary: $GIT_WORK_TREE persists in env, and then some git commands operate
on repo in $PWD (like git log), while some others (like git add) operate on
repo in $GIT_WORK_TREE, making it inconsistent and results in very
unexpected results.

Cheers, Tuomo


---
#!/bin/sh

# setup a test repo
mkdir bar
cd bar
git init
echo "test" > bar
git add bar
git commit -m "test commit in bar"
echo "adding this will fail later on" > test
cd ..

# setup a repo with an alias and script alias will execute
mkdir foo
cd foo
git init

cat >foo.sh <<EOF
#!/bin/sh -x
cd $PWD/../bar
env | egrep "^(GIT_WORK_TREE|PWD)"
echo "Git log works (bar log shows up):"
git log --oneline | head -1
echo "Git add does not (tries to add files in GIT_WORK_TREE=foo, while
PWD=bar):"
git add test
EOF
chmod 755 foo.sh

cat >>.git/config <<EOF
[alias]
  foo = !$PWD/foo.sh
EOF

git add foo.sh
git commit -m "committing foo.sh"

# run test via alias
git foo
