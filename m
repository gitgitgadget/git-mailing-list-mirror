From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: git-pack-objects dying with errors due to possible RHEL kernel bug
Date: Fri, 4 Mar 2011 12:08:56 +0100
Message-ID: <AANLkTimZ08_fJKgwqtiKBbd0pSJ3EFSnJ6jem=fPqRWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: demerphq <demerphq@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 04 12:09:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvSsZ-0000YU-NV
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 12:09:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759440Ab1CDLI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 06:08:58 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36189 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759005Ab1CDLI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2011 06:08:57 -0500
Received: by fxm17 with SMTP id 17so2011626fxm.19
        for <git@vger.kernel.org>; Fri, 04 Mar 2011 03:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=iAVINatyBoLr5gdMUepEdTbxFkwqmkWjejNGrr58BgI=;
        b=Z3089SYrkpTrmkVbm/uQPPurK+wKJ1oe9Cjy8em/lhFjpVmYRAZwXcz7Fxufm9fV0d
         WL3DiN+dbsmCAfqQjr0hMeFNMXCjzNMHrchhHFPYRaXNO4kNbItZcW0eOr2a8GPxMqst
         4zWtLI3OUKGZTONcPqcw+/jAP9OYy5NPOgFYE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=pb0HSI6G9qhP+hKr8bc0/t5RwgQKRchn9PRU9dSojhGcb5JHkLLEAfASb+qJUkKZVF
         VLo6WmhzB8ONYODrrzLDvDFGoEbRbRxu3Tv9D8Ty4EhgAv3hgkVJfIo3jht4g5oOmG+3
         OAhxkMtzF6nMc6f8bzTenKA+jjf5sCzTJCYvk=
Received: by 10.223.78.138 with SMTP id l10mr612259fak.106.1299236936249; Fri,
 04 Mar 2011 03:08:56 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Fri, 4 Mar 2011 03:08:56 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168436>

This is a summary of an issue I've been looking at with a very large
centralized Git repository. It's a repository that gets approximately
100 commits per day, almost all to its master branch.

I think I've found why the issue I'm describing happens (not confirmed
yet), I mainly wanted to write something to the list to have a record
of this in case anyone runs into it in the future.

Last week we upgraded form Git 1.6.5 to 1.7.2.1 on the server housing
our repository, and started getting errors like these from developers
running variants of git-fetch:

    $ git pull --rebase
    remote: Counting objects: 2, done.
    remote: Compressing objects: 100% (2/2), done.
    remote: Total 2 (delta 0), reused 0 (delta 0)
    remote: aborting due to possible repository corruption on the remote side.
    error: waitpid for pack-objects failed: No child processes
    error: git upload-pack: git-pack-objects died with error.
    fatal: git upload-pack: aborting due to possible repository
corruption on the remote side.
    Unpacking objects: 100% (2/2), done.
    fatal: error in sideband demultiplexer

That error is from
https://github.com/git/git/commit/b1c71b72815cb82a8bad14020a047320b88a04eb
by Junio from 2006, we're refusing to send an incomplete pack file on
failure.

We've also been getting this error from git-fetch directly (from a
wrapper script):

    # INFO : Checking working directory
    # ERROR: failed to git fetch --tags from 'origin' errorcode: 128
    # ERROR: git fetch --tags origin
    # ERROR: error: waitpid for pack-objects failed: No child processes
    # ERROR: error: git upload-pack: git-pack-objects died with error.
    # ERROR: fatal: git upload-pack: aborting due to possible
repository corruption on the remote side.
    # ERROR: remote: aborting due to possible repository corruption on
the remote side.
    # ERROR: fatal: error in sideband demultiplexer

And from git-remote-update(1):

    $ git remote update
    Fetching origin
    remote: Counting objects: 9, done.
    remote: Compressing objects: 100% (5/5), done.
    remote: Total 5 (delta 4), reused 0 (delta 0)
    error: waitpid for pack-objects failed: No child processes
    error: git upload-pack: git-pack-objects died with error.
    fatal: git upload-pack: aborting due to possible repository
corruption on the remote side.
    remote: aborting due to possible repository corruption on the remote side.
    Unpacking objects: 100% (5/5), done.
    fatal: error in sideband demultiplexer
    error: Could not fetch origin

All of these except maybe the first one (wasn't able to contact the
dev in question) come from Git 1.7.2.1 clients talking to the 1.7.2.1
server.

Anyway, I think this issue is caused by this RHEL bug:
https://bugzilla.redhat.com/show_bug.cgi?id=166669 ([RHEL3 U5]
waitpid() returns unexpected ECHILD) which was fixed in this RHEL
update: http://rhn.redhat.com/errata/RHSA-2006-0144.html

This is our Git server:

    $ cat /etc/redhat-release && uname -r
    CentOS release 4.1 (Final)
    2.6.9-11.ELsmp

And if I run:

    wget https://bugzilla.redhat.com/attachment.cgi?id=118759 -O killipf.c &&
    gcc -O2 -o killipf killipf.c -lpthread &&
    PASS=0; while ./killipf; do let PASS=++PASS; echo $PASS; done

It'll die within a minute with a message like this:

    PASS : received expected signal 9
    14605

    child pid:2563
    waitpid failed!: No child processes

It does *not* die on these machines:

    $ cat /etc/redhat-release && uname -r
    CentOS release 4.6 (Final)
    2.6.9-67.0.7.ELsmp

    $ cat /etc/redhat-release && uname -r
    CentOS release 5.5 (Final)
    2.6.18-194.el5PAE

Or on my personal Debian box:

    $ cat /etc/debian_version && uname -r
    wheezy/sid
    2.6.32-5-amd64

I haven't been able to trigger this issue with Git itself. I tried
putting a copy of the repository in /tmp, then one on client running
in a while loop:

    while true; do
        head -n 10 /dev/urandom >a_file &&
        git commit -m"more crap" a_file &&
        git push
    done

And on another client running:

    while true; do
        git pull
    done

And I never got this waitpid error message, I might have just been
unlucky though, or perhaps it wasn't triggered in that case for some
reason.

Given this information we're going to upgrade CentOS on the relevant
machine, I'll follow up on the list in a couple of weeks indicating
whether or not that worked. We have enough users that if I ask people
to tell me if we get this error and I don't hear anything for two
weeks I can safely assume it went away.

What we might want to do in Git is to work around this broken waitpid
behavior (if that's indeed the issue). I haven't dug into what the
RHEL kernel patch is solving, so I don't know if we can inexpensively
detect this when this is happening and warn users about it.

Then again it would be a lot of work to work around a specific kernel
bug. What I *mainly* wanted to do was to insert some note of this into
the Git mailing list archive. Which I've now done.
