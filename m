From: Max W <max.w.7777777@googlemail.com>
Subject: .gitattributes on branch behaves unexpected. Should it be more stateless?
Date: Sat, 17 Jan 2015 11:05:13 +0100
Message-ID: <CAGJ-DzH0meYgpE8My+UW4wbTxs6vo=wrgo0o21Lzh5Hg38ibEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 11:05:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCQFy-0005I5-Gx
	for gcvg-git-2@plane.gmane.org; Sat, 17 Jan 2015 11:05:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbbAQKFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2015 05:05:16 -0500
Received: from mail-wi0-f172.google.com ([209.85.212.172]:58769 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbbAQKFP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2015 05:05:15 -0500
Received: by mail-wi0-f172.google.com with SMTP id bs8so8695887wib.5
        for <git@vger.kernel.org>; Sat, 17 Jan 2015 02:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=yKa3IW1X1MhGlf0IVIBWigihYoWj8OdZ98WVncFXyBM=;
        b=wKjcziZIHkbihFk0KmjYIDuFiZKXYZw2z+8edDp6xo/CZ7g6c1Rpqm9bZCikUlY9Dx
         aq4Qk6MdlCKKnzUd2eLNtBp08a3jaJcRmf1F9I6iO0N9aoZ0dAckQCnDxEnX2hLp0FJ/
         OP7EUrg8mFZg70wrJRQaExDEpWixHtU8sfywxafreNlt1gUONzyQKB5pklIokqNS2QMk
         K0r/DClO1t6abVg7q+IUauUrRP5jaaLKlvegLXnuhRLWIrN0IavQLwchOvMu6EPdvUbx
         HEtYJm7XPuM7UYpukkJgpcZjZIq85MiyWDZ1St8/iTji4tyFsSh3FBAEfOazwHuWMrb/
         ef1Q==
X-Received: by 10.180.83.228 with SMTP id t4mr15206587wiy.28.1421489113564;
 Sat, 17 Jan 2015 02:05:13 -0800 (PST)
Received: by 10.27.178.134 with HTTP; Sat, 17 Jan 2015 02:05:13 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262583>

Hi,

I am asking myself if git and .gitattributes should be more stateless? i.e.
whatever you have done before is irrelevant, when you reach status XYZ with your
git repo, it is EXACTLY and BINARY the same all the time and everywhere.

It took some time for me to figure out, that depending on HOW you clone, the
resulting local repo may differ. I did not expect this. I assumed that when I
clone, it is a clone (meaning: 100% identical). And that the things I have done
in my local repo before, don't have any relevance at all.



** How to reproduce **
1) create a repo, add a file with LF ending, add a .gitattributes telling git to
   do a CRLF conversion
2) clone the repo
3) on brach development, change .gitattributes to LF
4) clone again
5) clone again, directly onto the branch development (git clone -b)


** Expected result, (I) **
clone 2) and original repo 1) are bytewise identical

** Actual result (I) **
clone 2) and original repo 1) differ, 1) has LF, 2) has CRLF
as I have been warned before, I am (more or less) fine/OK with this


** Expected result, (II) **
- clone without -b (4) and clone with -b (5) are bytewise identical
- I would have expected, that whatever I do, as soon as I have a clone and I am
  on branch "development", my file should be LF
- I would have expected, that HOW you clone is irrelevant

** Actual result (II) **
without -b (4) I have a CRLF file on my disk. with -b (5) I have a LF file on my
disk. The clones are not bytewise indentical. It appears as if the
.gitattributes in branch development does not have any reliable effect.



A potential solution might be be that
- checkout
- commit (a modified .gitattribues)
- <further git commands>
  do change the files in the local repo.
As of now my understanding is that this is not how .gitattributes (or
.gitignore) are designed. .gitattributes only has influence on pushing/fetching.

I don't know if and which side effects would occur if this design would be
changed. Hence I am glad to hear any feedback on the issue described above. And
yes, I agree that this is a minor issue and that all .gitattribute things are
kind of edge cases.

Thanks and with best regards,
Max






1)
mkdir git-bug-or-feature
cd git-bug-or-feature
git init
echo "foo.bar eol=crlf" > .gitattributes
echo "hello world" > foo.bar
git add .
git commit -m "now crlf"
# [master (root-commit) 7f3f6b0] now crlf
# warning: LF will be replaced by CRLF in foo.bar.
# The file will have its original line endings in your working directory.
file foo.bar
# foo.bar: ASCII text
cd ..

2)
git clone git-bug-or-feature git-bug-or-feature_clone
cd git-bug-or-feature_clone
file foo.bar
# foo.bar: ASCII text, with CRLF line terminators
cd ..
rm -rf git-bug-or-feature_clone

3)
cd git-bug-or-feature
git branch development
git checkout development
echo "foo.bar eol=lf" > .gitattributes
git add .
git commit -m "now lf on branch development"
file foo.bar
# foo.bar: ASCII text
git checkout master
file foo.bar
# foo.bar: ASCII text
cd ..

4)
git clone git-bug-or-feature git-bug-or-feature_clone
cd git-bug-or-feature_clone
file foo.bar
