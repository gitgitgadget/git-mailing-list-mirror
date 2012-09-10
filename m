From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [RFC] Add "edit" action for interactive rebase?
Date: Mon, 10 Sep 2012 16:13:01 -0400
Message-ID: <CADgNjakmRsfqBajpeob0e2pA9tSj5KSS+0m6rkR+9bdBV+ZepA@mail.gmail.com>
References: <1347293683-27996-1-git-send-email-andrew.kw.w@gmail.com>
	<504E3145.9070006@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Sep 10 22:13:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBAM5-000585-4F
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 22:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758175Ab2IJUNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 16:13:05 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:38670 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758108Ab2IJUND (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 16:13:03 -0400
Received: by lbbgj3 with SMTP id gj3so1482625lbb.19
        for <git@vger.kernel.org>; Mon, 10 Sep 2012 13:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4xvqyqcJwY7X2whR2HIPAY3Kjzab4GN2AS/5fHzSx1M=;
        b=ZKhz0hGe6vVhlU8oUlRrMAZqekaU2e2sKd1snY77imMsbtwmIaFicxVhd1S9NpCIQF
         xGf/qWv+uZ4C4fVZrKGKyogTeFLoIWKozxzyFA9BQafZtBpte1Qs1KxARKnJa01XP/4L
         deeN0HZ240leyao25KJonkK6E8VzbpSbekvzKshlOSpB8I53Mpz7KMgfMCBhfOru0iVm
         dDQvQrzl0Gs0eME/KMjVZc2aTXhdKM42Ll21qudiLuLqL/ZOKmwz6iVKDAzAVPkn7ZSi
         t58gKGeiLQFs1JbTvu1VYxbELvWarBflK10/K9muD2a3qVIY4U5pl6ixXtmLC9bdUhT2
         B8BQ==
Received: by 10.152.124.76 with SMTP id mg12mr13490873lab.10.1347307981193;
 Mon, 10 Sep 2012 13:13:01 -0700 (PDT)
Received: by 10.112.28.129 with HTTP; Mon, 10 Sep 2012 13:13:01 -0700 (PDT)
In-Reply-To: <504E3145.9070006@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205172>

On Mon, Sep 10, 2012 at 2:28 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Did you think about what can go wrong? For example, starting with this
> todo sheet:
>
>   exec false
>   pick 1234567

Ah, that's definitely a problem.

I was going to say we probably just to check the "done" file, same as
the one we do for a fresh "rebase -i", but it turns out the "exec
false" will fool the "has_action" check for a fresh "rebase -i" too.
Heh.

Maybe we should improve the check for a fresh "rebase -i" case, then
we can do the same check for this case. Maybe we can grep for a "pick"
in "done" file? Or we can check if there's anything in "rewritten"?
Though I'm not sure if any of those is really foolproof. Or should we
just ignore this case and assume the user knows what s/he's doing?

Incidentally, if the starting todo file is:
    pick A
    exec false
    pick B

If the user then changes the "pick B" to "squash B", it should be a
valid I think, and "rebase -i" should handle that properly. It should,
because that's the same thing as:
    pick C (which results in a conflict and stopped)
    squash D

OT: That "exec false" !
I ran into numerous occasions where I wanted to manually do something
before the "first commit after upstream", such as creating a new
commit or merge.  And I only had two ways of doing it:
1. to rebase against "upstream^", and then mark the upstream as edit
2. insert a "exec bash" in front of the "first commit"
But "exec false" will work much much nicer. :)
