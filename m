From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Mon, 15 Apr 2013 20:34:04 +0530
Message-ID: <CALkWK0kUoW22d67Ufc0i2OTVuRC8G6xGiR4Joz9vLh_4+bkuZQ@mail.gmail.com>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
 <1365887729-9630-4-git-send-email-artagnon@gmail.com> <vpq38us2oov.fsf@grenoble-inp.fr>
 <CALkWK0mdC_tK2CGqAa67fr189PQCjSjzAOPujipOHFfoiYW0qA@mail.gmail.com>
 <vpqppxvoqsc.fsf@grenoble-inp.fr> <CALkWK0nqrw7DFQSnMvULYjJtBHRnadKWqCLQOAjzJH0o7USo+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 15 17:04:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URkxe-0008Nh-Ua
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 17:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136Ab3DOPEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 11:04:46 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:35460 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab3DOPEp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 11:04:45 -0400
Received: by mail-ie0-f182.google.com with SMTP id at1so5926719iec.27
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 08:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=YoqITCeSeFjBlzVEUHwZ348zwiLDrrss/nPDWv2opAc=;
        b=CaExdOWabhiH057/9cJgAc2jHNxQS5eTsSiCB9wLKj83125tvM0vY9AY3Zx8Uy8uiw
         MgnBcF2s2q3A0cxyp5CuKl9LUPuxRNHRXHD5qruXuMFhHUxcjoCVDVww0QxyMFdi8JVQ
         u6Wt3X7TLPfdHGbVyvnnFIswv3KU2iDNJGNRrCloNPL2xwU2HczQ9P601Z4fA3/PRICY
         iSh5ULtbhFBcKtbTJwo0McOcLDzYVZFz/Ohdcf5LiZ/qhJoJ+MS/Z2Syi6VBq12dUhut
         B6hrmzcX9ZkneUpA46y5DXwgnIjAt5SIRwpwpuqCgZhRXfCstJKCkcpGH2CApbfoZr5w
         rduw==
X-Received: by 10.50.50.71 with SMTP id a7mr5424258igo.14.1366038285341; Mon,
 15 Apr 2013 08:04:45 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Mon, 15 Apr 2013 08:04:04 -0700 (PDT)
In-Reply-To: <CALkWK0nqrw7DFQSnMvULYjJtBHRnadKWqCLQOAjzJH0o7USo+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221236>

Ramkumar Ramachandra wrote:
> Okay, so you're proposing a uniform --autostash feature for both merge
> and rebase.  Sorry, I didn't get it last time due to the typos in your
> email; yeah, this is worth investigating.

So, I thought about this and have concluded that pull is the Right
place for autostash because of the following reasons:

0. autostash is purely a convenience function that's useful in simple
reduced cases like a dumb 'git pull'; when the script we're
implementing it for doesn't have a ton of command-line options.

1. git stash; git pull; git stash pop; is a very common idiom.  git
stash; git rebase master; git stash pop; is a less common idiom, but I
agree that it is one rebase case where autostash could be useful.
Having git rebase -i show "exec git stash pop" at the end of a
user-editable instruction sheet is less than ideal.  Having git rebase
--onto master HEAD~3 do an autostash _might_ be useful, but I'm not
sure about it.  git stash; git merge feature-branch; git stash pop; is
not a common idiom at all.

2. git-stash.sh is a helper script, in the same spirit as git-pull.sh
and git-rebase.sh.  It is natural and easy to implement autostash for
pull and rebase, but not for a C builtin like merge.  In fact, it's
impossible to implement it for merge unless we make git commit execute
git stash pop (yuck!).

If you want, you can implement a rebase.autostash, but that is not my
itch.  Considering the gymnastics the implementation would have to do,
I'd be against a merge.autostash.  So, again: what is your gripe
against my pull.autostash implementation, apart from the fact that git
status doesn't show stash information? (I _might_ decide to fix this)
