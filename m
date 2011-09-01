From: Tzu-Jung Lee <roylee17@gmail.com>
Subject: git-checkout silently throws away the dirty status of index without a warning?
Date: Thu, 1 Sep 2011 23:47:59 +0800
Message-ID: <CAEvN+1h+mY+f3dzK7LFOwkqokOZSS-LosCzBqtYGbyjz=Dg7Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 01 17:48:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qz9Uy-0005go-9p
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 17:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490Ab1IAPsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 11:48:01 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33873 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932396Ab1IAPsA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 11:48:00 -0400
Received: by bke11 with SMTP id 11so1858406bke.19
        for <git@vger.kernel.org>; Thu, 01 Sep 2011 08:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=SFRIn3wrvRNDCusnip0aIuKr1XPFb+vfx/VFXBfaw6M=;
        b=Usx7b/TyV7ZUFmEaMxZMio6BkHAc8CC8Vjb3aIzIUU2g0eYPqCpfxmRLmE/ilj8Stx
         e6FepTpXW5r1AgDdKOiGtSZOBE4Gf2nznO0ALeyCv8/7MRf25RKmZfh+iW8yicbX6wHE
         O0fUxe6bfkLZsAdZPI81L1ZWi48jyKFbtMuos=
Received: by 10.204.135.6 with SMTP id l6mr1158289bkt.284.1314892079300; Thu,
 01 Sep 2011 08:47:59 -0700 (PDT)
Received: by 10.204.152.81 with HTTP; Thu, 1 Sep 2011 08:47:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180533>

Hi guys,

Correct me if I'm wrong:

    git-checkout saves the changes to index and working-tree, and
tries to apply them to the destined commit.
    If the changes are applicable, then git-checkout the destined
commit and apply the changes.
    Otherwise, git-checkout fails with warnings and leaves the current
status untouched.

If the above correct. Please help me clarify if the following corner
case an intended or unexpected behavior.

Setup and git repo with two commits to illustrate the scenario:

    $ git init
    $ echo aaa >> aaa.txt
    $ echo bbb >> bbb.txt
    $ git add .
    $ git commit -a -m commit1

    $ echo bbb >> bbb.txt
    $ echo aaa >> aaa.txt
    $ git commit -a -m commit2

Forge a unclean index with changes that are subset of the destined
commit we are about to switching to.

    $ git checkout -b br1
    $ git reset HEAD^
    Unstaged changes after reset:
    M       aaa.txt
    M       bbb.txt

    $ git checkout HEAD aaa.txt
    $ git status --short
    M bbb.txt
    $ git add bbb.txt
    $ git status

    # On branch br1
    # Changes to be committed:
    #   (use "git reset HEAD <file>..." to unstage)
    #
    #       modified:   bbb.txt
    #

    $ git checkout master
    Switched to branch 'master'

git silently switch to master without warning against the index are
"RESTORE/RESET" to clean.

    $ git checkout br1
    $ git status
    # On branch br1
    nothing to commit (working directory clean)

Is this an intended behavior?
Though the status and changes can be safely restore from the database
with some manipulation.
But it may become difficult and tedious if the number of involved
files are large.


Regards,
Roy
