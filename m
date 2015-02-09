From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: EOL handling (EGit/svn/Windows)
Date: Mon, 9 Feb 2015 23:22:19 +0100
Message-ID: <CAA01Csrp0ZOouM5zhVuHQW9sWCnbMMLRkmcbRtgsU3k8wNtSqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 23:22:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKwio-0006oQ-9R
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 23:22:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761453AbbBIWWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 17:22:22 -0500
Received: from mail-wg0-f47.google.com ([74.125.82.47]:56136 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbbBIWWV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 17:22:21 -0500
Received: by mail-wg0-f47.google.com with SMTP id n12so29790323wgh.6
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 14:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=nEi/2dZrLxvVEvL2sKe4TMz4zkh1zm1vI7G+9BdyPho=;
        b=QsidjFSVQWf1IkbYZ/jpj4q2jz7CuuwGk8XsUDZdFYtpvzwzX+iGYdyZrt2TXNdllX
         CiYClUOmnxwN4b4WBAakkmYVYc9toFWNwCfUYOa5UPcIa7J4dG17B5uMSM9j30z4y8fQ
         I4z80uFteGtexGFEZzg4iigIE4SgRrpQgs4+aC2F/811HQ1oCHgehBz1aEARPdiathGT
         olMTgZOVL+YX549k0uvjO0Kwi3aIDR0nVFHMj5LrsuMX5rjrDyvcOZZ2zZBrcOXO3vcD
         a3hmz0uoeZcVs04Vm9iOU4zn+lgFFXEDXx7LJiYTsT8ZKaYOxwL3oGanHZ3EP39GH/0U
         fTkQ==
X-Received: by 10.180.221.232 with SMTP id qh8mr31478317wic.6.1423520540084;
 Mon, 09 Feb 2015 14:22:20 -0800 (PST)
Received: by 10.180.207.4 with HTTP; Mon, 9 Feb 2015 14:22:19 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263612>

Hi,

in short: how to do svn->git conversion, or how to configure git/EGit
so that Windows/Linux users are happy with EOLs?


Long story:

recently I converted (with git-svn) an svn repository to git. This
created git repository with Windows (CRLF) end of line files. I
suppose the original svn repository had Windows EOLs (I did the
conversion on linux). The development is done in Eclipse (mostly on
Windows), so the EGit is a natural choice for git client.

But the problem appears: what should be the core.eol and core.autocrlf settings?

EGit seems to have problems with core.autocrlf=true - it always
converts files to LF on commit. So if someone modifies one line in a
file which was not modified yet since the git->svn conversion, each
line is seen as modified (CRLF changed to LF). It seems like a bug in
EGit - git-config man page says "files that contain CRLF in the
repository will not be touched" for core.autocrlf=true. "Normal"
command line git works better - if a file has CRLF in it in
repository, it will not convert it (it will convert new files from
CRLF to LF though - that's OK).

I could also set core.autocrlf=false which should avoid any conversion
to LF on check-in. This will move the responsibility of using correct
EOL to users. Everyone, both Windows and Linux users, will have to use
the same EOLs. Probably core.eol will have to be set to crlf, the same
as in repo. But I suppose this will not work - new files will be
created with native EOLs so the files will end up being checked in
like that. I also think it might create some problems with programs
not accepting non-native EOLs. On the other hand, it would prevent
problems caused by CRLF->LF conversion on "binary" files incorrectly
detected as "text" files...

So maybe I should re-write the repository (all the history) so that
the files are converted to LF? (examples:
http://superuser.com/questions/293941/rewrite-git-history-to-replace-all-crlf-to-lf
http://blog.gyoshev.net/2013/08/normalizing-line-endings-in-git-repositories/).This
way I should be able to use core.autocrlf for both git and EGit.
That's what I'm favoring currently. The downside is that, if I assume
correctly that SVN repo kept files in CRLF format, the conversion to
LF might break something (not sure what - some UTF files? or some
unexpected stuff...).

This re-writing of repo would not be needed if EGit did work like
normal git... should I drop EGit? I would prefer not to :(

Any other suggestions?

BTW, core.autocrlf documentation in git-config is a bit hard to
understand... it's not obvious what it affects - working dir? commits?
Does it convert to CRLF or LF? What is the "input" setting (what is
"output conversion")?  I found some explanation here:
http://thread.gmane.org/gmane.comp.version-control.git/174413


Thanks,
-- 
Piotr Krukowiecki
