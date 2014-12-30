From: Josh Bleecher Snyder <josharian@gmail.com>
Subject: Bug report: checkout-index --temp path is not always relative to the
 current directory
Date: Tue, 30 Dec 2014 14:21:57 -0800
Message-ID: <CAFAcib9tz+EDqWx=nohxEbH3FRbwUweabKHTyBF-dioh6G-KKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 30 23:22:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y65Ba-0003qQ-Tz
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 23:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbaL3WWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 17:22:38 -0500
Received: from mail-qc0-f172.google.com ([209.85.216.172]:44468 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbaL3WWi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 17:22:38 -0500
Received: by mail-qc0-f172.google.com with SMTP id m20so11211996qcx.3
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 14:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=G+ykBM8m7lOlKdzQnLHopGqRojp6yFGGl/7jPAeD+uQ=;
        b=TumT85ukBVW/IeaolljMhmoQIq4uEXBw4gY4yStiPIgu5LCby4M29cIWqq7uoaT0fI
         fe0OUaQZXyeIcOHBZT6DrCgM+qUC0SrOet1x00q5fNkIS73LjapLRgS6NBwbgXcYSBxR
         ujHmzUulMVeDn7KdU0u7pUvVQcfNgdyiU5FmWIC8ss1YwleCJGtbv+b8o7RsScS+JMxs
         bXGAU0puBvWg1SDe9n8ix9rXliO8CK8ABdzhMzX0TSLHzWwErM3+Ws0avgKu5RFqswuA
         Em4GzwgXzwow+zsa9sVHcx1hanehuuk+FYT/JkwV6I9asQXAAef8pzwkVAt9aG9oBy/9
         ppcQ==
X-Received: by 10.224.55.145 with SMTP id u17mr104588308qag.12.1419978157310;
 Tue, 30 Dec 2014 14:22:37 -0800 (PST)
Received: by 10.140.39.69 with HTTP; Tue, 30 Dec 2014 14:21:57 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261950>

In the section on using --temp, 'git help checkout-index' says:

"The path field is always relative to the current directory and the
temporary file names are always relative to the top level directory."

However, this can be false when an absolute path to the file is provided.

Reproduction:

~$ git version
git version 2.2.1
~$ mkdir demo
~$ cd demo
~/demo$ mkdir a
~/demo$ echo "a" > a/f
~/demo$ mkdir b
~/demo$ echo "b" > b/f
~/demo$ git init .
Initialized empty Git repository in ~/demo/.git/
~/demo$ git add .
~/demo$ git commit -m "init"
[master (root-commit) 2afa910] init
 2 files changed, 2 insertions(+)
 create mode 100644 a/f
 create mode 100644 b/f
~/demo$ echo "b2" > b/f
~/demo$ cd a
~/demo/a$ git checkout-index --temp -- `git rev-parse --show-toplevel`/b/f
.merge_file_xm8RTd f
~/demo/a$ cat ../.merge_file_xm8RTd
b

Note that if f in the checkout-index output is interpreted as relative
to the current directory, it would refer to a/f, whereas in fact is it
b/f.

This led to https://github.com/golang/go/issues/9476.

Thanks,
Josh
