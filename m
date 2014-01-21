From: Cosmin Apreutesei <cosmin.apreutesei@gmail.com>
Subject: Re: GIT_WORK_TREE and GIT_DIR with git clone
Date: Tue, 21 Jan 2014 23:37:16 +0200
Message-ID: <CAKJdRakBWR7ofvcc8uhQ09QwiAJs7uvRNwP3WyuF4ve7FWONgw@mail.gmail.com>
References: <CAKJdRamFDDWRZDHBCe7GrXg0OWhLfBPq_ofsvowaW9d8VOGTMA@mail.gmail.com>
 <xmqq4n4xulrm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 21 22:37:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5j0y-00070D-MP
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 22:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755238AbaAUVhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 16:37:39 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:43552 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754706AbaAUVhg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 16:37:36 -0500
Received: by mail-pa0-f50.google.com with SMTP id kp14so8987115pab.37
        for <git@vger.kernel.org>; Tue, 21 Jan 2014 13:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jXAv7vhrPJMGRT3tagC0RgLy9gSWDb8oXGt5h9vAOlo=;
        b=TZrEw09JJeSvPDJs2ZiqxhiPcvay4VVEuoEriqk+G4e2z2mKkau1wCdML7n1NkoTDk
         jJVqranKE3gi1PHBNMo+PMFkBUUzwtx54w3HBTG9b8cecq1r23lfWmR4e1mm2MZEFqpk
         qQDJcRpE1efkGiiJ4tV1DXdLn9ObO+cg3Jw61x/0WTLUGGBnf3JPmfJN456BDMWA/3Hq
         uI34v2IjNzGyOAsaP+CxNf9o1XhyuYfPMQAUq5wTD4dc03g0ZVgeF4R2aaAqAEQzp/9u
         1BfU2sV4sanXQuUT88nT33N7WvkNCbR0gVyCPE4wOw5W9LVX6R96FZFhMvvYkKHQWOJ5
         PB2Q==
X-Received: by 10.66.189.193 with SMTP id gk1mr27330108pac.105.1390340256308;
 Tue, 21 Jan 2014 13:37:36 -0800 (PST)
Received: by 10.70.42.228 with HTTP; Tue, 21 Jan 2014 13:37:16 -0800 (PST)
In-Reply-To: <xmqq4n4xulrm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240778>

Hi, thanks for answering.

>> I would like to be able to tell my users that they can simply do:
>>
>> git clone --git-dir=_/git/module1/.git module1-url
>> git clone --git-dir=_/git/module2/.git module2-url
>>
>> which will overlay the files from both modules into the current
>> directory, which from git's perspective is the work-tree for both
>> modules.
>
> Would there be a sensible semantics in the resulting working tree?
> Which repository would a new file in such a combined working tree
> belong to?

The developer would have to decide by way of `git add`.

Ignoring other repos' files would be done by way of local config
option `excludesfile` (.gitignore is out).

To make it easier to work with git this way, a script that creates a
subshell in the context of a repo can be done with something like
`PS1="[$1 $PS1]" GIT_DIR=_git/$1/.git bash -i" -- git would then work
as usual in that subshell for that specific repo, never leaving the
working tree.


I successfully employed the above scheme with luapower[1] packages,
which are all different and mostly unrelated libraries, but which need
to be overlaid over a common directory structure. And that's just an
example. I can think of many projects that are modularized and yet the
modules need to place many files in many places to make a working
system (web frameworks, the linux filesystem, etc.)

Currently, to clone a repo one has to do:

export GIT_DIR=_git/submodule/.git
git init
git config --local core.worktree ../../..
git remote add origin ssh://git@github.com/luapower/submodule.git
git fetch
git branch --track master origin/master
git checkout

That's 6 commands for what could be:

    git clone --git-dir=_git/submodule/.git
ssh://git@github.com/luapower/submodule.git

Or even better:

    git clone --git-dirs=_git ssh://git@github.com/luapower/submodule.git

[1] http://luapower.com
