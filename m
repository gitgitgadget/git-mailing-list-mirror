From: Chris Packham <judge.packham@gmail.com>
Subject: [BUGLET] resuming git am when using applypatch-msg hook
Date: Mon, 3 Mar 2014 11:30:57 +1300
Message-ID: <CAFOYHZDmhp9orTJPaPfeLDqNzWPuMuwKhujfRD7rET5_Akrh5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 02 23:31:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKEuU-0000i7-8l
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 23:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbaCBWa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2014 17:30:58 -0500
Received: from mail-pd0-f171.google.com ([209.85.192.171]:48520 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746AbaCBWa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2014 17:30:57 -0500
Received: by mail-pd0-f171.google.com with SMTP id r10so2921371pdi.16
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 14:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Km8ksAzl7qx7htQAtrxAASn6gnK3D3uHl8uMJ3fxG74=;
        b=LgNPFwAlXWVWCMWR9o+YuWeiho1//FSBCREPvPEH7cuwJ5A8kcL7kWZFi8bnYZAnJ/
         h20aTJ9ZNaQXEjLVc+x3be6U+vi0qfSE+ah90OFLOK8B6Z1XJsh0nXA1pXCurnCNqzgw
         ka7AVcOsQoUO856okgzMxH2iBL6rq2Y55BlzouBLw1V2Bwh3sYCpJrFRyIqK/gpjJSvY
         xqPljH2wB4sMkyJFNtLX8/dpIDoS6VD3u8+Aet/u+z9XE5PmTMOTkILic8ccmvy75W2t
         zfoA/zyWwjvkVd8+Suhh2UbhrUa0ppKAYUJanu16GAZZ2GrcPZf/nDVDwa0Oq8bVoX1Y
         pP2w==
X-Received: by 10.68.125.164 with SMTP id mr4mr15921845pbb.27.1393799457504;
 Sun, 02 Mar 2014 14:30:57 -0800 (PST)
Received: by 10.70.9.99 with HTTP; Sun, 2 Mar 2014 14:30:57 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243162>

Hi,

I don't know if this really counts as a bug but it is a little
annoying from a user experience point of view.

We're using an applypatch-msg hook to check that certain things
(reviewer, bug entry etc) are recorded correctly in commit messages.
My expectation is that if our applypatch-msg hook rejects a patch then
we should be able to invoke 'git am -i --continue' edit the message to
fixup the content and resume applying. However it seems even though I
can invoke 'git am -i --continue' to edit the message, the actual
patch contents are lost.

I'm guessing the problem is that the applypatch-msg hook is invoked
after the message part is saved but before the patch part is saved.
Alternatively the "problem" could be that I'm using a hook that is not
intended for this purpose, however the man page does say
"[applypatch-msg] can also be used to refuse the commit after
inspecting the message file".

Below is an example of this (if anyone has an idea on how to automate
the 'git am -i' part I'll be able to turn this into a proper test).

Thanks,
Chris
--

  git --version
    git version 1.9.0.rc3.21.g475c52b

  mkdir test && cd test && git init

  cat >.git/hooks/applypatch-msg <<EOF
  #!/bin/sh
  grep -q "foo" "\$1" && echo "Rejecting patch message" && exit 1
  EOF
  chmod +x .git/hooks/applypatch-msg

  echo "hello world" > a.txt && git add a.txt && git commit -m "Initial commit"

  git checkout -b temp
  echo "Hello world!"  > a.txt && git add a.txt && git commit -m "foo:
update text"

  git checkout master
  git format-patch temp -1 --stdout | git am
    Rejecting patch message

  GIT_EDITOR="sed -i 's/foo: //'" git am -i --continue
    Commit Body is:
    --------------------------
    foo: update text
    --------------------------
    Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all e
    Commit Body is:
    --------------------------
    update text
    --------------------------
    Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all y

  git status
    On branch master
    You are in the middle of an am session.
    The current patch is empty.
      (use "git am --skip" to skip this patch)
      (use "git am --abort" to restore the original branch)

  stat -c"%s" .git/rebase-apply/patch
    0
