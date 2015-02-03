From: =?utf-8?Q?Micha=C3=ABl_Fortin?= <fortinmike@gmail.com>
Subject: Weird output of git status in pre-commit hook when providing a pathspec on commit
Date: Tue, 3 Feb 2015 08:14:06 -0500
Message-ID: <80E24BA2-84FE-47FC-A5C0-D291E3C63BD5@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 03 14:14:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIdJ2-0002vV-4a
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 14:14:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933777AbbBCNOM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Feb 2015 08:14:12 -0500
Received: from mail-qa0-f54.google.com ([209.85.216.54]:40940 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754040AbbBCNOK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Feb 2015 08:14:10 -0500
Received: by mail-qa0-f54.google.com with SMTP id w8so33685270qac.13
        for <git@vger.kernel.org>; Tue, 03 Feb 2015 05:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version;
        bh=rMxAVIKz91Al3usGR2dE3h2VFV0FVxv+F2r5iJG0ZrQ=;
        b=nmiWvC7qwCoFbypfcB50sjm41fM8wzKZ+dcv04NsY9wn8H7O0dbZn7V6edJlXbzxaX
         jhc7DZkUpERf/kvWggbnReJ6EzhCyuzy+N34XBFMWkY8LQu5z4I3W90hHkMRzPxGTne3
         5ed6YbbByYtU04mb8y/SmHXHGLUD4hzeZu0PYF+c6ijw4q6P2Yqph7AjELYmXy5JF/6u
         L6kuCm1EZZeLclksm4afJ/Pdl6GWuiwWwbtKjqYWDhkh+IowiklYJ0ECGsKmO49pNumz
         mtE2HibEdNNkg6HCwKgbhbHmNi9P6rokYilzAN3Z3SQ0Soh/ZYaQSJ3guIcB7e7LYMU6
         3JRA==
X-Received: by 10.224.40.195 with SMTP id l3mr52725811qae.61.1422969248954;
        Tue, 03 Feb 2015 05:14:08 -0800 (PST)
Received: from [172.20.10.2] (out-pq-129.wireless.telus.com. [216.218.29.129])
        by mx.google.com with ESMTPSA id d62sm21185391qga.15.2015.02.03.05.14.06
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 03 Feb 2015 05:14:07 -0800 (PST)
X-Mailer: Apple Mail (2.2070.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263319>

Hi all,

I'm seeing behavior that I *think* might be a bug in git (I'm running 2=
=2E2.2). At least I couldn't find anything about this anywhere, so here=
 goes:

I'm trying to run git commands outside of the current working copy (e.g=
=2E inside another repo) from a pre-commit hook. However I'm encounteri=
ng a very weird issue that occurs when a pathspec is provided when perf=
orming a commit.

More precisely, what I'm trying to do is check whether a repository bes=
ide the current repository is clean (no uncommitted changes) or not, fr=
om a pre-commit hook.

My repositories look like this on disk:

ContainerDirectory
|-- Repo1 (contains one untracked file)
|-- Repo2 (no uncommitted changes)

Repo1 has the following pre-commit hook:

#!/bin/bash
git -C "../Repo2" status --porcelain

I then commit in Repo1 using the following (this is actually ran by a G=
UI, I have no control over the commands themselves):

git add --force -- MyNewFile
git commit -m "My message" -o -- MyNewFile

This results in some very puzzling output. I would expect the hook to o=
utput nothing because Repo2 contains no changes. However, it returns th=
e following:

D  Repo2-File1.txt
D  Repo2-File2.txt
D  Repo2-File3.txt
?? Repo2-File1.txt
?? Repo2-File2.txt
?? Repo2-File3.txt

As you can see, the files are listed as both deleted and untracked, whi=
ch makes no sense to me because there are in fact no uncommitted change=
s in that repo. There are only these three files in the repo. Removing =
the pathspec ("-- MyNewFile") from the commit command shows the expecte=
d output (nothing, because there are no changes in Repo2).

I have reproduced this behavior on OS X and Windows (with the latest gi=
t for Windows).

Can you explain what's going on?

Thanks in advance for any info!

Micha=C3=ABl Fortin
www.irradiated.net
