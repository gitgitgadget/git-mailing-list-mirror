From: Russ Cox <rsc@golang.org>
Subject: mangled file names in git checkout-index --temp output when run in
 repo subdirectory
Date: Tue, 23 Dec 2014 11:36:53 -0500
Message-ID: <CAA8EjDRsw6o8T1sS=rpSt_+KaKt9QnONCmF23yHDdKhgKHcdww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 23 17:37:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3SSB-0000NJ-2o
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 17:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbaLWQgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 11:36:55 -0500
Received: from mail-qa0-f44.google.com ([209.85.216.44]:56843 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932270AbaLWQgy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 11:36:54 -0500
Received: by mail-qa0-f44.google.com with SMTP id bm13so4690850qab.3
        for <git@vger.kernel.org>; Tue, 23 Dec 2014 08:36:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=25OtPDIJXWD7fkcU+nXiutvENKA6xKQqQMBAwY+TcSE=;
        b=bZS9i8RrGuFdyH20WvC2QwtJeMchC+kQJ98o+a+ikSX0NVPsvH7PaHtvrQstBa9rPe
         A/LOxDcRg+Vfy6ZiAdgmkDIbWLF7WHOr4hBEdw86txQ4oF0GDdXWL3ukhiwu0lkF1eiK
         REC7HZkKvGWoSl6JzQIVvlPy7ffO7Cwl1H+6fuIPqPGxtf94/J4IO5VsuweWY8OnUmPt
         YlJYzr0QFx7RY5lnhb1Czbeq95olU8SEc7/pdAeayMR3yFQ9dAwwkzttMDTDZOcCr5V0
         XavZXkLhRn1HpdtReaGtQo+/YzTLMeI39wUyzwvYEi2L/BjIaydrr83jA/4KVXHQ2emf
         sCag==
X-Gm-Message-State: ALoCoQnOE5WmFzG9083DGD7nGK+B8reEWZ6vQ+3gU9Ii8dEzE9YgXWjJKhFxoM2Mv0b9o4Wd2J2J
X-Received: by 10.140.35.114 with SMTP id m105mr33044613qgm.79.1419352613466;
 Tue, 23 Dec 2014 08:36:53 -0800 (PST)
Received: by 10.96.68.40 with HTTP; Tue, 23 Dec 2014 08:36:53 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261739>

I am using git checkout-index --temp to obtain copies of files from
the index, but it does not always print valid file names unless run
from the repository root.

git checkout-index --temp prints names of files in the index
interpreted relative to the current directory below the repository
root.

If you have a git repo in /tmp/gitbug, you are in /tmp/gitbug/dir1,
and you run git checkout-index --temp /tmp/gitbug/dir1/file1, the file
listing prints just "file1". So far so good.

However, this file name shortening appears to assume that all file
names being printed will be within the subtree rooted at the current
directory, and it just skips over the first N characters in the name,
where N is the length of the current directory name relative to the
repo root (in the above example, N = len("dir1/") = 5).

That is, if you have a git repo in /tmp/gitbug, you are in
/tmp/gitbug/dir1, and you run git checkout-index --temp
/tmp/gitbug/longdir2/file2, the file listing prints "ir2/file2", not
"../longdir2/file2". If you arrange things just right you can get ""
as the file name. I've never seen arbitrary binary garbage, so
(without inspecting the source code) it does appear that something is
keeping the printed string pointer within the original string, even in
the case when N > the length of the string being printed.

I have seen this in a few different versions of Git. I just downloaded
and built Git 2.2.1 from sources and confirmed that it has the buggy
behavior. Below is a shell script demonstrating the bug and an
annotated transcript of the execution of the script on my system.

The workaround seems to be that, until the bug is fixed, git
checkout-index must be run in the repository root.

Thanks.
Russ

% cat /tmp/gitbugdemo
#!/bin/bash

git=${1:-git}
set -e
rm -rf /tmp/gitbug
mkdir /tmp/gitbug
cd /tmp/gitbug
$git init .
mkdir dir1 longdir2 veryveryverylongdir3
echo hello world >dir1/file1
echo hello world >longdir2/file2
echo hello world >veryveryverylongdir3/file3
files="/tmp/gitbug/dir1/file1 /tmp/gitbug/longdir2/file2
/tmp/gitbug/veryveryverylongdir3/file3"
relfiles=$(echo $files | sed 's;/tmp/gitbug/;../;g')
rootfiles=$(echo $relfiles | sed 's;\.\./;;g')
set -x
$git version
cd /tmp/gitbug
$git add .
$git checkout-index --temp $files
$git checkout-index --temp $rootfiles
cd /tmp/gitbug/dir1
$git checkout-index --temp $files
$git checkout-index --temp $relfiles
cd /tmp/gitbug/longdir2
$git checkout-index --temp $files
$git checkout-index --temp $relfiles
cd /tmp/gitbug/veryveryverylongdir3
$git checkout-index --temp $files
$git checkout-index --temp $relfiles
%

% /tmp/gitbugdemo git2.2.1
warning: templates not found /usr/local/share/git-core/templates
Initialized empty Git repository in /private/tmp/gitbug/.git/
+ git2.2.1 version
git version 2.2.1
+ cd /tmp/gitbug
+ git2.2.1 add .

### In root directory, all is well.
+ git2.2.1 checkout-index --temp /tmp/gitbug/dir1/file1
/tmp/gitbug/longdir2/file2 /tmp/gitbug/veryveryverylongdir3/file3
.merge_file_TRqU2e dir1/file1
.merge_file_7uajP4 longdir2/file2
.merge_file_L4OD1U veryveryverylongdir3/file3
+ git2.2.1 checkout-index --temp dir1/file1 longdir2/file2
veryveryverylongdir3/file3
.merge_file_77EMra dir1/file1
.merge_file_DpKgMu longdir2/file2
.merge_file_w8yfxA veryveryverylongdir3/file3

### In dir1/, loses first 5 chars of file paths outside current directory.
### Both absolute and relative command-line arguments trigger bug.
+ cd /tmp/gitbug/dir1
+ git2.2.1 checkout-index --temp /tmp/gitbug/dir1/file1
/tmp/gitbug/longdir2/file2 /tmp/gitbug/veryveryverylongdir3/file3
.merge_file_2SwQmt file1
.merge_file_g0rOvr ir2/file2
.merge_file_3uDW54 eryverylongdir3/file3
+ git2.2.1 checkout-index --temp ../dir1/file1 ../longdir2/file2
../veryveryverylongdir3/file3
.merge_file_BwUlNt file1
.merge_file_gQji59 ir2/file2
.merge_file_hNNjc9 eryverylongdir3/file3

### In longdir2/, loses first 9 chars of file paths outside current directory.
### Both absolute and relative command-line arguments trigger bug.
+ cd /tmp/gitbug/longdir2
+ git2.2.1 checkout-index --temp /tmp/gitbug/dir1/file1
/tmp/gitbug/longdir2/file2 /tmp/gitbug/veryveryverylongdir3/file3
.merge_file_ljy0oC 1
.merge_file_ANLgpx file2
.merge_file_1lDbMp erylongdir3/file3
+ git2.2.1 checkout-index --temp ../dir1/file1 ../longdir2/file2
../veryveryverylongdir3/file3
.merge_file_ugqOsC 1
.merge_file_reoXBo file2
.merge_file_p4tQn9 erylongdir3/file3

### In veryveryverylongdir3/, inconsistent truncation of file paths
outside current directory.
### Absolute command-line arguments trigger bug but relative ones do not (!).
+ cd /tmp/gitbug/veryveryverylongdir3
+ git2.2.1 checkout-index --temp /tmp/gitbug/dir1/file1
/tmp/gitbug/longdir2/file2 /tmp/gitbug/veryveryverylongdir3/file3
.merge_file_VvT0uT 1
.merge_file_UfAT1x file2
.merge_file_Fon1Ex file3
+ git2.2.1 checkout-index --temp ../dir1/file1 ../longdir2/file2
../veryveryverylongdir3/file3
.merge_file_YDHkDe ../dir1/file1
.merge_file_F7M27m ../longdir2/file2
.merge_file_ZkkXnQ file3
%
