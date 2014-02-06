From: Lasse Makholm <lasse.makholm@gmail.com>
Subject: attr.c doesn't honor --work-tree option
Date: Thu, 6 Feb 2014 13:48:43 +0100
Message-ID: <CAB7pA0_2kLJmRZb8Z_9+xOcrbwMZLgnZwC5f7etbE4OuJ1wgmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 06 13:48:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBONu-000778-Ii
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 13:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbaBFMsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 07:48:46 -0500
Received: from mail-we0-f177.google.com ([74.125.82.177]:43942 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932326AbaBFMsp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 07:48:45 -0500
Received: by mail-we0-f177.google.com with SMTP id t61so1220110wes.8
        for <git@vger.kernel.org>; Thu, 06 Feb 2014 04:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=jmIfeBOBmyqiLDxDX2c9xYy6c0ft5AJEMFXqEUqvrzg=;
        b=YNnNj/r/0bdzlCEXB81E4h9KrIiqr6/MiK6q4HYUo7PthwpQxCB/zQnLH2tfbRu4Zm
         gmK5zgJB1nFRqmHMuz9nt/APm42fOTrA+e8Xh49U37C72HgF/ikFm2fsAXpmVtfYT3+q
         pemN1a9gs3mmwKBvWut7b+i3/3F3LocZqrED78GwHMtilTzinlNLU9u6t1lnj3Ddlwpl
         /nwgRjmzxZ+OjGhc6k9m3mEwJtcHYe44x4JiD8wzlwHSbhY8bfBKe9huyjH09Mn2sLwq
         GC+BFKyf41dCCNo7+dNZdDBwRnujvza4BPFRtAMZMFu6jkFoA+UPHNX145ap/c+BIUVa
         z2BQ==
X-Received: by 10.180.12.115 with SMTP id x19mr21341121wib.19.1391690923664;
 Thu, 06 Feb 2014 04:48:43 -0800 (PST)
Received: by 10.194.90.161 with HTTP; Thu, 6 Feb 2014 04:48:43 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241690>

Hi,

It seems that code in attr.c does not honor the current work tree path
(set by e.g. --work-tree ...) and simply always assumes CWD. When the
current dir is not in the work tree, git will attempt to find
.gitattributes under ./ instead of under the correct work tree.

Here's a repro with -DDEBUG_ATTR=1 and a printf() in read_attr_from_file():

$ cd /tmp/
$ mkdir -p attr-test/repo
$ cd attr-test/repo
$ git init
Initialized empty Git repository in /tmp/attr-test/repo/.git/
$ echo 'dir/* filter=foo' >.gitattributes
$

Inside the working tree, it works:

$ ~/src/git.git/git check-attr -a dir/file
read_attr_from_file: /home/lasse/etc/gitattributes
read_attr_from_file: /home/lasse/.config/git/attributes
read_attr_from_file: .gitattributes
push:
read_attr_from_file: .git/info/attributes
read_attr_from_file: dir/.gitattributes
push: dir
fill: filter => foo (dir/*)
dir/file: filter: foo
$

Outside, it fails to find the .gitattributes file:

$ cd ..
$ ~/src/git.git/git --work-tree /tmp/attr-test/repo --git-dir
/tmp/attr-test/repo/.git check-attr -a dir/file
read_attr_from_file: /home/lasse/etc/gitattributes
read_attr_from_file: /home/lasse/.config/git/attributes
read_attr_from_file: .gitattributes
push:
read_attr_from_file: /tmp/attr-test/repo/.git/info/attributes
read_attr_from_file: dir/.gitattributes
push: dir
$

This is with the latest rev on master:

$ ~/src/git.git/git --version
git version 1.8.5.2.192.g7794a68.dirty
$

It (sort of) works with a committed .gitattributes file because git
will find it in the index, but that will still yield incorrect results
if the .gitattributes file happens to be dirty.

Looking at the code, I'm not really sure if this can be fixed in
read_attr_from_file() by resolving relative paths against
get_git_work_tree(). I doubt it's that simple though...

Thoughts?

/Lasse
