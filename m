From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: [BUG] Silent data loss on merge with uncommited changes + renames
Date: Mon, 22 Apr 2013 11:24:45 +0200
Message-ID: <vpqobd6q5nm.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 22 11:24:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUCzV-0003vB-SK
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 11:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755477Ab3DVJYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 05:24:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58289 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754733Ab3DVJYt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 05:24:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r3M9OicM027986
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 22 Apr 2013 11:24:45 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UUCzN-0006NT-On; Mon, 22 Apr 2013 11:24:45 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 22 Apr 2013 11:24:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r3M9OicM027986
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1367227485.28312@0hLV5JtZpUIM6HwNslNPwQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222001>

Hi,

Following the discussion on "merge with uncommited changes" inside the
"git pull --autostash" thread, I did a bit of testing, and encountered a
case with silent data loss. In short: merge a branch introducing changes
to a file. If the file has been renamed in the current branch, then "git
merge" follows the rename and brings changes to the renamed file, but
uncommited changes in this file are overriden silently.

I could have expected "git merge --abort" to fail, but the problem is
really more serious here: data loss is done silently before giving me an
opportunity to do or abort anything.

Reproduction script below:

#! /bin/sh

# Create repo
git init git.$$
cd git.$$
echo init > test.txt
git add test.txt
git commit -m init

# Make a branch changing test.txt
git checkout -b branch
echo new > test.txt
git commit -am new

# Move test.txt on master
git checkout master
git mv test.txt moved.txt
git commit -m move

# Make uncommited changes to moved.txt
echo precious > moved.txt

# Merge loses uncommited content "precious" in "moved.txt" silently
git merge --no-edit branch
ls # lists just moved.txt
git status # nothing to commit, working directory clean
cat moved.txt # Says "new".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
