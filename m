From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v3 6/7] rebase: write better reflog messages
Date: Mon, 24 Jun 2013 12:37:46 +0530
Message-ID: <CALkWK0kj3UOx8sq+h=L0giUC-vn+h3by9o_6YbjA8ArRXZfgZw@mail.gmail.com>
References: <1371629089-27008-1-git-send-email-artagnon@gmail.com>
 <1371629089-27008-7-git-send-email-artagnon@gmail.com> <7vfvw8dw9m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 09:08:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur0t7-00053c-0z
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 09:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440Ab3FXHI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 03:08:28 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:58897 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473Ab3FXHI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 03:08:28 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so22563671ief.26
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 00:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gv1IlkOE62J3Q0rGTFMGX9Yhll7OMJOS8V+yYevpHbI=;
        b=ZvZ8z2GsbWpIUzostT/l42LvNr/TtC31/blHor+nOHT3D52npZOrr/BulaaPSuWkLi
         0uSwRY7aGLuH6x0BnjMTyWgH2ckP5u2BtSmaWlQy3r5xp4kPzSexuS+KHK7Zw18LCu1e
         IJEx6Yi/a42BkOojSMQVnS73W64JD6PGpMTcNIqC8RldEmwT0aM01hZ+pMbM4Smo6OSC
         vNGDhHXUHu58Roc9WTY4brB88B6CjNvv8dj47unuYGwinhZnqZu1iZvO5cUuCqe5d2++
         rWTnEIX2K2UPPDKD9hPI/KZrEcbju3eiGFkh1EDsdbcGXSfawTiNi+D1gOzU/EBz7kZV
         S1vg==
X-Received: by 10.50.1.37 with SMTP id 5mr4888642igj.29.1372057707719; Mon, 24
 Jun 2013 00:08:27 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 24 Jun 2013 00:07:46 -0700 (PDT)
In-Reply-To: <7vfvw8dw9m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228780>

Junio C Hamano wrote:
>> @@ -59,6 +63,9 @@ else
>>               return $?
>>       fi
>>
>> +     # always reset GIT_REFLOG_ACTION before calling any external
>> +     # scripts; they have no idea about our base_reflog_action
>> +     GIT_REFLOG_ACTION="$base_reflog_action"
>>       git am $git_am_opt --rebasing --resolvemsg="$resolvemsg"
>
> Why does this reroll still use this base_reflog_action convention?

Because it's simple and it makes sense.

> The original orig_reflog_action you borrowed this may have been an
> acceptable local solution inside
> git-rebase--interactive that does not call out to amyting, but
> the above comment a good demonstration that shows why this cannot be
> a good general solution that scales across scriptlets.

Nonsense.  How do I set a custom reflog action when a certain flag is
passed to my script (like git-rebase.sh:333) without *overriding* an
existing GIT_REFLOG_ACTION?  How do I construct cute start/pick/reword
prefixes elegantly (like in
git-rebase--interactive.sh:comment_for_reflog()) without *overriding*
an existing GIT_REFLOG_ACTION?  In both these examples, I'm setting a
GIT_REFLOG_ACTION for the "rest of the code" to use.  I don't care
about the exact command sequence, but I know that they respect
GIT_REFLOG_ACTION; so I'm setting one in advance.

When calling out to an external scriptlet, I want to define my own
reflog message: when I call out to "am" from "rebase -i", it should
write a "rebase -i: " message, and ignoring its own
set_reflog_message().  _That_ can be done using the subshell thing you
proposed.  And I have absolutely no clue why

  (
    export GIT_REFLOG_ACTION
    git am
  )

is "more scalable" than

  GIT_REFLOG_ACTION="$base_reflog_action"
  git am

> And I already explained that to you at least twice.

You just gave set_reflog_action() and GIT_REFLOG_ACTION some sort of
God status, and proposed to make the scripts more ugly and less
extensible.

... and we're discussing absolutely trivial inconsequential rubbish
once again.  In any case, I've given up on arguing with you as it is
clear that I can't possibly win.  Do whatever you want.
