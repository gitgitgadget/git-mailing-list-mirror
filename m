From: Ciprian Dorin Craciun <ciprian.craciun@gmail.com>
Subject: Issue: `git apply` doesn't respect `--work-tree`
Date: Sat, 26 Mar 2016 10:21:45 +0200
Message-ID: <CA+Tk8fwhjwj9qjgWiiDsJnCupAQT1JJTfYYgDykQhfBnXE09SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 26 09:22:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajjUV-0001MK-B9
	for gcvg-git-2@plane.gmane.org; Sat, 26 Mar 2016 09:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbcCZIW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2016 04:22:28 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34941 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbcCZIW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2016 04:22:26 -0400
Received: by mail-ob0-f169.google.com with SMTP id fp4so70405374obb.2
        for <git@vger.kernel.org>; Sat, 26 Mar 2016 01:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=Hup0FQeFyXflu2En4fgObLWncxfSVYzpoVzPp59Sdhs=;
        b=UJZe57wFcIaqVcoUXym8skWcn4ag/NfNm4kRWliiuhgWOx0SITK6QEOCW+RmE+JOtY
         QRAhQRN1X7Z7VNadVOqioJvzOFp4tVbQQt2u6gt3CDxZ1YvUz9cFg5suzxcG1m0ijBrx
         vxGN7mYqlcrPJJ2rIfiExgX1BXejRb59JBzPW2dbhCMY8u5K2ORKsKBXSNhoa0Ovh7Cv
         MBaKXQrJfdbZzj+9WtiELKDgj8aUNPjmhorUx1qgYd7fvh7fFvywBL/ohDWp4iW67tkg
         wF7N842egBMyx7JD1k8lCyJyX/IS33L2lyGtRDyQEcVXh9btvbD5qdVaFeLxvY5qy4YE
         qlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Hup0FQeFyXflu2En4fgObLWncxfSVYzpoVzPp59Sdhs=;
        b=fyOoZvN/M26Q0wznOalAlx1AHl6Dee/SwiowoU3I2L8I/e1/V7cVBm2tkCtp2+Ejoc
         cFgq74tfbMM04UhoI09Km7V3k78mABcQi9ydWJ8enEi/6lmlSv4q9hLBsasxJMbJ0iho
         FxQ2Dvc6B/TRXNjesWZTLO4acef0rGB7KY+UNP8+QuwmbW8aE1rj0xc+jzjjaRQKK6ls
         orc6IC6Yr9fPNsv8On2BSs7FiLIz0mfFBwzvaOeuB5tK8YV9em6ifqSqoZTBbPE4Bjc6
         xBRQrjoJvkg4rivPVyHQQ8IPAput+1V4fuHnK8AQ5C1ZEgn1GT3Wr3a1kIh+h+QvPz1/
         EAaw==
X-Gm-Message-State: AD7BkJLF091i27sWz5FRpn9Fzs2hijBM5RTuV2cKNBIm00KqFEXvbqTAJq0+dp7mT+bcnJ3SQwxGaa/MoFaq0A==
X-Received: by 10.182.27.199 with SMTP id v7mr8160709obg.16.1458980545572;
 Sat, 26 Mar 2016 01:22:25 -0700 (PDT)
Received: by 10.202.59.139 with HTTP; Sat, 26 Mar 2016 01:21:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289978>

[I've quickly looked at the mailing list archive and didn't see this
issue reported.  However I might be wrong.]


The issue is simple:  `git apply` does not respect the `--work-tree`
argument when called outside the repository.

The version of Git I used is OpenSUSE's official 2.1.4 but also 2.7.4
from their repositories.

The command I used is:
  git --work-tree /.../some-repo --git-dir /.../some-repo/.git apply
/.../some-patch

The current working directory is completely unrelated with the
targeted work-tree (i.e. it is not a subdirectory of the work-tree).


I confirmed the above by using `strace -f -e file -- git ...`, and
although Git picks the correct path for the target work-tree and
switches there, it then switches back to the initial working directory
(the one being invoked from).  See bellow the (redacted) output of
`strace`:

~~~~
getcwd("{current-working-dir}", 129) = 79
stat("{target-working-dir}/.git", {st_mode=S_IFDIR|0700, st_size=300, ...}) = 0
lstat("{target-working-dir}/.git/HEAD", {st_mode=S_IFREG|0600,
st_size=23, ...}) = 0
open("{target-working-dir}/.git/HEAD", O_RDONLY)  = 3
lstat("{target-working-dir}/.git/commondir", 0x7ffe0231eb90) = -1
ENOENT (No such file or directory)
access("{target-working-dir}/.git/objects", X_OK) = 0
access("{target-working-dir}/.git/refs", X_OK)    = 0
lstat("{target-working-dir}/.git/commondir", 0x7ffe0231eb80) = -1
ENOENT (No such file or directory)
access("{home}/.config/git/config", R_OK) = -1 ENOENT (No such file or
directory)
access("{home}/.gitconfig", R_OK) = 0
open("{home}/.gitconfig", O_RDONLY) = 3
access("{target-working-dir}/.git/config", R_OK)  = 0
open("{target-working-dir}/.git/config", O_RDONLY) = 3
stat("{target-working-dir}", {st_mode=S_IFDIR|0700, st_size=880, ...}) = 0
getcwd("{current-working-dir}", 129) = 79
chdir("{target-working-dir}")                     = 0
getcwd("{target-working-dir}", 139)               = 11
lstat("{target-working-dir}", {st_mode=S_IFDIR|0700, st_size=880, ...}) = 0
chdir("{current-working-dir}") = 0
stat("{target-working-dir}/.git", {st_mode=S_IFDIR|0700, st_size=300, ...}) = 0
lstat("{target-working-dir}/.git/commondir", 0x7ffe0231eb40) = -1
ENOENT (No such file or directory)
access("{home}/.config/git/config", R_OK) = -1 ENOENT (No such file or
directory)
access("{home}/.gitconfig", R_OK) = 0
open("{home}/.gitconfig", O_RDONLY) = 3
access("{target-working-dir}/.git/config", R_OK)  = 0
open("{target-working-dir}/.git/config", O_RDONLY) = 3
open("{target-diff}", O_RDONLY)           = 3
open("{home}/.config/git/attributes", O_RDONLY) = -1 ENOENT (No such
file or directory)
open(".gitattributes", O_RDONLY)        = -1 ENOENT (No such file or directory)
open("{target-working-dir}/.git/info/attributes", O_RDONLY) = -1
ENOENT (No such file or directory)
lstat("{file-to-be-patched}", 0x7ffe0231e1f0)       = -1 ENOENT (No
such file or directory)
error: {file-to-be-patched}: No such file or directory
+++ exited with 1 +++


Hope it helps,
Ciprian.
