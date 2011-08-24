From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: rebase -i: Should --continue auto-amend after failed exec?
Date: Wed, 24 Aug 2011 15:36:52 +0200
Message-ID: <vpqk4a3rkwb.fsf@bauges.imag.fr>
References: <4E40511B.7090206@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org List" <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Aug 24 15:37:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwDdf-0006Si-Vy
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 15:37:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751772Ab1HXNg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 09:36:59 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37484 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751087Ab1HXNg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 09:36:58 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p7ODaZj9028445
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 24 Aug 2011 15:36:35 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QwDdU-0007NZ-Dh; Wed, 24 Aug 2011 15:36:52 +0200
In-Reply-To: <4E40511B.7090206@kdbg.org> (Johannes Sixt's message of "Mon, 08
	Aug 2011 23:11:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 24 Aug 2011 15:36:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p7ODaZj9028445
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1314797797.85667@AiiS2TNj6I4jDiSiVA2E5g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180001>

Johannes Sixt <j6t@kdbg.org> writes:

> If after a failed "exec" instruction there are staged changes, then currently rebase
> --continue fails with:
>
> .../git-rebase--interactive: line 774: .../.git/rebase-merge/author-script: No such file or directory

That's obviously bad, there should at least be an accurate error
message.

> But shouldn't this amend the HEAD commit? The documentation is not clear
> (from git-rebase.txt):
>
>   The interactive rebase will stop when a command fails (i.e. exits with
>   non-0 status) to give you an opportunity to fix the problem. You can
>   continue with `git rebase --continue`.
>
> This may be interpreted to work like "edit", and IMO would be a very useful
> modus operandi.

I'm not sure. What happens in "edit" is that when reaching the "edit"
line, git-rebase--interactive.sh calls die_with_patch, which writes
author information in .git/rebase-merge/author-script, which really
means "I've stopped on this commit, this is the one that we should
implicitely amend with --continue".

The case of "exec" is a bit different: you don't stop "on a commit", but
after doing something else. You can hardly guess whether the staged
changes are meant to amend the existing commit, or to make a new one.

Actually, that could even be

pick deadbeef Existing commit
exec foo > bar.txt; git add bar.txt; git commit -m "added during rebase"
exec false
pick c00ffee Another commit

then auto-amending may be really confusing: should it amend the HEAD
commit that you've just created (this would really go against the logic
of .git/rebase-merge/author-script) or the last picked commit (which you
can't really do since it's not HEAD)?

I think it's best to abort, with an accurate error message pointing the
user to both solutions (commit --amend && rebase --continue or commit &&
rebase --continue). I'll try a patch.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
