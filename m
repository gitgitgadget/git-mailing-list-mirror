From: Brian Vandenberg <phantall@gmail.com>
Subject: Re: [PATCH] [RFC] Make git-update-ref invoke the update and
 post-update hooks
Date: Mon, 15 Jun 2015 13:49:36 -0600
Message-ID: <CAEJ-0i-BB=5W-Ah3nkeLFCe5-4XW4CvYaDgdqv1mMp4UGF81qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 15 21:49:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4aO6-0002Wc-Nl
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 21:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756024AbbFOTtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 15:49:39 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]:32781 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948AbbFOTth (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 15:49:37 -0400
Received: by yhpn97 with SMTP id n97so50306789yhp.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 12:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=0ZBGYnQsS6aYPFm/DbxO3+c6UUIaeWbfqk7VrX08/NI=;
        b=jIvoPvY6EtXtMem6I4AVNh8EvFT2zBVzOK0rq0IwzA6yl4v1gB6FzXGI4RQY8cWBVv
         pFSdWa50YKzfQHoadMr1hjacyYD0menDUPnu3ZUGxcJoKoHQ9Nu/gqRPo/YAJHChO1Zf
         Lvho/6n9prh8wHiEiDOgEkEy+JpA98mCGNSwyG2pKCfHJI+xnI9rUoCTrRe5/ovrbzyX
         0DmvRUMY68oCShyPpvvozSLYNdbp7V9UiF7dDueWF7j+9yLeVBNJQ3f6FEB5t8cIwUNX
         nTN/YEJyVLPPif0muB+aJZTXN73f8Rt6yuRQredsXSQu+/XXwwXX4SW5BH6cGOGYQRnF
         +Oog==
X-Received: by 10.170.188.206 with SMTP id f197mr36130371yke.63.1434397776960;
 Mon, 15 Jun 2015 12:49:36 -0700 (PDT)
Received: by 10.37.24.67 with HTTP; Mon, 15 Jun 2015 12:49:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271719>

From: Junio C Hamano <junkio@cox.net>
Date: 2006-10-08 15:00:32
Petr Baudis <pasky@suse.cz> writes:

>> Someone raised a concern that the update and post-update hooks are not
>> invoked at fetch time in the similar way as they are invoked at push
>> time, and the idea sort of makes sense. But this patch goes further - it
>> makes Git invoke those hooks each time a ref is updated in a repository
>> using the git-update-ref command, which I believe makes a lot of sense as
>> well - the behaviour is consistent with the current pushing behaviour
>> and you suddenly finally get a hook where you can properly notify even
>> about fast-forwards etc.

>In principle I do not have problem with this approach per-se,
>but I wonder if we were to do this we might want to make
>receive-pack.c::update() and cmd_update_ref() call the same
>underlying function, and make that underlying function implement
>this "ask the hook if updating is ok" dance.  It might even make
>sense to have update-ref honor deny_non_fast_forwards for that
>matter (I am mildly doubtful of this last point, though).

Was this rejected?

I'm tweaking the configuration on our master repo; among other things:
I've enabled reflog and disabled altering history or deleting branches
through receive-pack, instead requiring that someone make history
alterations directly (using update-ref).

update-ref can optionally accept a comment explaining why the history
needed to be altered, but we would prefer to make it mandatory.  Hooks
seem like a natural place to do that, but after running update-ref
under strace/truss & looking through builtin/update-ref.c, it looks as
though it doesn't make use of hooks.

-Brian
