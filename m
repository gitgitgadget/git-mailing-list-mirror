From: Conley Owens <cco3@android.com>
Subject: [BUG] Halt during fetch on MacOS
Date: Fri, 28 Feb 2014 15:26:28 -0800
Message-ID: <CAFFUb6X455R4OD5FKnVFHFmvTyRqtV300bc=a8Xs03agM+=uLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 00:26:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJWp8-0007je-8e
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 00:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbaB1X03 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 18:26:29 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:58897 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbaB1X03 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 18:26:29 -0500
Received: by mail-ie0-f175.google.com with SMTP id at1so4110091iec.34
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 15:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20120917;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=BLWgywxFOgc3oLHh5KmQtwSlw8vN4lvhA9qO6PP0WJI=;
        b=SaPxXgNaBxeg5kAXhek2zism4TbwPdqHtK9bZxyYH6VYpGf1udDbEOBKlx/ExyS+1J
         KqV7EL5lvF5QqrbGz6Tnj2JB6lw9MA0Vwo4Xi4u8HsJ16ebe5YK2rK4emwQFroOSi9i6
         aWcbLl3Q3xbgY56N1GGK2WS7PTZwf/OKX6OzDP5MonG2IC4lF+hsaTAQW+aRepH3Qt0c
         u/wRqfd0+6EGOnkPY06tEWIYaCtnlb2+TGSSDOcH44QKKp0jkkF1SmZ6LLA9DOKTEjBt
         pY/624Xv5ZVO7Q5Azp3i9TqDinGo4B8aX/7+/qcGMls2Gxz7u/WnrkJdbHzKgrlVbyGk
         VVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=BLWgywxFOgc3oLHh5KmQtwSlw8vN4lvhA9qO6PP0WJI=;
        b=kO1LYrEStsiNeQWc4KGdofXC5qi35xVsOVgNLtLuKxZLdcfpznc++qHYvHhBLy80Ov
         +EL/w7JUW5OfeqM5Zxm++dHqq6/pUZ6RunineN+iATFCwoLNFvn0rUQ+mqLUDvDJB6l4
         aFqhovfWEl5xnZ5bArnE6igR4Tvs42fJmLHzv3ymOf2VwYWSH4T2Innj/kfI8CgiQnIB
         DpvJMUIxyEUfjjxi8uJHqGu3wAF7Qgk+/HBrHxuhy7Srb2JCtZStJp6Fglc8riQQiZte
         qS6Lw0Jv2WoEsBpu1IawudjGZga3DMQFYP+3LKl8/xNQFSR47QSmg5zX8JBguenTiP0M
         tJBw==
X-Gm-Message-State: ALoCoQmQMaTS+ydHOgPWyGWbbKuEIHNnMnrMfcE0jCwaGX5yTBLOTP1IIFPc/7n3EiW6VJMF2Thd
X-Received: by 10.50.128.101 with SMTP id nn5mr7186267igb.7.1393629988595;
 Fri, 28 Feb 2014 15:26:28 -0800 (PST)
Received: by 10.64.145.101 with HTTP; Fri, 28 Feb 2014 15:26:28 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243026>

$ git --version  # This is just the git from MacPorts
git version 1.8.5.5
$ sw_vers
ProductName:    Mac OS X
ProductVersion: 10.8.5
BuildVersion:   12F45

test.sh
"""""""""""""""""""""""""""""""""""""
#!/bin/bash
rungit() {
    mkdir $1
    GIT_DIR=$1 git init --bare
    echo '[remote "aosp"]' > $1/config
    echo '    url =
https://android.googlesource.com/platform/external/tinyxml2' >>
$1/config
    GIT_DIR=$1 git fetch aosp +refs/heads/master:refs/remotes/aosp/master
    rm -rf $1
}

for i in $(seq 1 100)
do
    rungit testdir$i &
done
"""""""""""""""""""""""""""""""""""""""
$ ./test.sh  # Warning! This script fetches ~40MB of data

When everything cools, you can see that there are some fetches hanging
(typically).
$ ps | grep 'git fetch'
...
63310 ttys004    0:00.01 git fetch aosp
+refs/heads/master:refs/remotes/aosp/master
63314 ttys004    0:00.01 git fetch aosp
+refs/heads/master:refs/remotes/aosp/master
63319 ttys004    0:00.01 git fetch aosp
+refs/heads/master:refs/remotes/aosp/master
63407 ttys004    0:00.00 git fetch aosp
+refs/heads/master:refs/remotes/aosp/master
63414 ttys004    0:00.00 git fetch aosp
+refs/heads/master:refs/remotes/aosp/master
63420 ttys004    0:00.00 git fetch aosp
+refs/heads/master:refs/remotes/aosp/master
...

You can look at the parent process of each and see that one half
spawned the other half, or you can look at the environment variables
for each to see that there are two processes operating in the same
directory for each directory where there's an issue.
$ echo "$(for pid in $(ps | grep 'git fetch' | grep -o '^[0-9]*'); do
ps -p $pid -wwwE | grep 'GIT_DIR=[^ ]*' -o; done)" | sort
GIT_DIR=testdir14
GIT_DIR=testdir14
GIT_DIR=testdir32
GIT_DIR=testdir32
GIT_DIR=testdir47
GIT_DIR=testdir47

I've searched through the mailing list, but this doesn't seem to be a
known issue.  I've only seen this occur on macs (and with a good deal
of regularity).  It doesn't occur on my Ubuntu box.

~cco3
