From: Valentin Stanciu <svalentin@google.com>
Subject: git config credential.helper with absolute path on windows not
 working properly
Date: Mon, 5 Oct 2015 16:40:21 -0400
Message-ID: <CADmzSDHbH-=bX=PFqvoe23iQPF7Mq6ogV7D9c0XjdXUsORgmBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 05 22:40:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjCYx-0008S0-CG
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 22:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbbJEUkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 16:40:42 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:36845 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbbJEUkl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 16:40:41 -0400
Received: by oibi136 with SMTP id i136so98129875oib.3
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 13:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=1s/sWKLzsWFa9FHNgj/Zzy7JJcqsHlFDdxQCmWMxP30=;
        b=UC9PF8afIfY7xqRpDnIuh81Us0IkzG8yZKifw8R9zG4ppRHqum+Z4/3H7dqV//vgK3
         RjKhLydz3XQmq/KaOG+CSfWHg31mZdVgS7JlrK8rTCCTL+58MImy6sFeotyclfsqKxpn
         F7waHdRGD0gqIgCV8UPEJUJbImYnBg9zVdPVs5OShkZwwuK+oVIEt7lZ6qmdWim/Nfs9
         ZZ3YqyQWLy8W+Lv/aWdRZshZrEBPcrhuKHUsmRqzprV7moxI6La87jIdiuk7gNa3y1vf
         5yPoYglFvtwnjnrIL/U3iCS5dvqc+x7zXGG4NxS1aP+Y0okD2ArzBH72jDMrFIYVZvLR
         jLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=1s/sWKLzsWFa9FHNgj/Zzy7JJcqsHlFDdxQCmWMxP30=;
        b=NmwLFXoQybI+QBCvSOd9//mvO0s0BJdchoT3MyejohUZfnLzXKsBTAT6fc5hp4zE+8
         Bqbj+tql+j/JP0QtzyDb6mMRIcGHF8HcUDLoasCxHKX7V95ery/fDHJXzBNu7NtVJvGk
         hpbgWVbDvWv3DLYFUQQX1oRngFd34NVxW6NS8rzWZc+kpn2FIRU18c0Rk7wnp59RfGLs
         u28qlZD6r6JXQWFiNZV90wSz/wYsicLNmrYK78Bvbu3QaskPbVZ0u8OVAzNrnmBzQaSQ
         0FRI2X5uPxlmbQLA1Ew+OE0jvv+woq2FOn3ReDXjs9Vl4sRHcmegBTNlOdkIdcUhgeu6
         0ASw==
X-Gm-Message-State: ALoCoQn6siUjiQj5jE48t1qaDCUyK7/MH863P6DdC3nBKFrpo0XC5gJwgsd5hKkshMD6rUO3pdAM
X-Received: by 10.202.169.65 with SMTP id s62mr17854237oie.28.1444077640782;
 Mon, 05 Oct 2015 13:40:40 -0700 (PDT)
Received: by 10.182.4.134 with HTTP; Mon, 5 Oct 2015 13:40:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279089>

Hey guys,

I recently found that specifying absolute paths for credential helper
on windows does not work correctly if the path has spaces or non
alphanumeric characters like parentheses. From what I gather it seems
to do with how args are passed to subprocesses.

example:
git config credential.helper "C:\tmp\a (b)\git-credential-helper.cmd"

Running `git config credential.helper` shows that git got the full path:
C:\tmp\a (b)\git-credential-helper.cmd

However, when running `git push`, for example, git has problems
invoking the credential helper. If the path has no spaces or
parentheses, then everything is fine.

I tried countless ways of escaping the path, but couldn't find a
proper way to pass this to git and make it work. Tried adding more
quotes, slashes, and '^' (escape character for batch). Escaping spaces
with slashes seems to work, but couldn't find a way to escape
characters like '(' and '('.
I think git needs to add some escaping or quotes when running the
credential helper.

This affects commands that inline the credential helper too:
git clone https://path.to.repo.com C:\tmp\default --config
credential.helper="c:\tmp\a (b)\git-credential-gcloud.cmd"

Not sure if this is limited to credential helper or any config in git,
but this is a case I could repro easily.

Tested on Windows 7 x64 with all updates installed, from the command
line, using git version 2.6.0.windows.1. Git is installed to be
available from the command line.


Thanks,
Valentin
