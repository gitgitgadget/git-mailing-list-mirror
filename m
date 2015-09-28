From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why not git reset --hard <path>?
Date: Mon, 28 Sep 2015 14:19:55 -0700
Message-ID: <xmqqvbaub5s4.fsf@gitster.mtv.corp.google.com>
References: <20150928203449.29024.qmail@ns.horizon.com>
	<xmqq612ucm3p.fsf@gitster.mtv.corp.google.com>
	<CA+P7+xoTHFL_KU+qBz1KwytxqNTxf1JkjXK7_Ej79uLLnCWD8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: George Spelvin <linux@horizon.com>, Git List <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 23:20:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgfqB-0005bN-SI
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 23:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816AbbI1VUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 17:20:01 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35776 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754958AbbI1VT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 17:19:57 -0400
Received: by pacfv12 with SMTP id fv12so188479104pac.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 14:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=aW94zRVbgjBddR3aOGNi4Cez5SdkDn/+BTsorkJanWs=;
        b=eu/dwScGz+baz2zZrwLZrFkEA3w7vAYAIKIOh4C9RxjNMswG38M1yGYgmgOcUzrwFg
         aoIeMfav0IgbZbopJiMcRsuXEWKSShDTCrbwBw5aO/ibG2iWjds9MRkDbp01s3h655dG
         Q+R8k92Ny6IZP2iIVnXsIgq5VyFbjkTJmx9AeRzxsI7PPbApHUgrMs4Rabpysn5YEs5U
         TfSkt2zTjReFl0ABowG5KZo7rJxozQyEpy9ql+zh8vrY0GgOphGvIi0jLr26LYqUtBoa
         defEZrCDCR0xcyVx7beuBEn2fVneHm+Ftb0sIIlowpwDcgaDjgsOx8d87YiS6lKdIx+m
         CKKg==
X-Received: by 10.67.15.100 with SMTP id fn4mr28893407pad.120.1443475197100;
        Mon, 28 Sep 2015 14:19:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:66:24f2:2685:8011])
        by smtp.gmail.com with ESMTPSA id i9sm21173945pbq.84.2015.09.28.14.19.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Sep 2015 14:19:56 -0700 (PDT)
In-Reply-To: <CA+P7+xoTHFL_KU+qBz1KwytxqNTxf1JkjXK7_Ej79uLLnCWD8g@mail.gmail.com>
	(Jacob Keller's message of "Mon, 28 Sep 2015 13:53:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278753>

Jacob Keller <jacob.keller@gmail.com> writes:

> On Mon, Sep 28, 2015 at 1:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> "George Spelvin" <linux@horizon.com> writes:
>>> I understand that "git reset --soft" makes no sense with a path, but
>>> why not --hard?
>>
>> I do not think there is anything fundamentally wrong for wishing for
>> "reset --hard <pathspec>".  It probably is just that nobody needed
>> it, because "git checkout HEAD <pathspec>" is a 99% acceptable
>> substitute for it (the only case where it makes a difference is when
>> you added a path to the index that did not exist in HEAD).
>
> Personally, I would like to see this simply given the number of times
> that I use git reset --hard <path> and then realize I should have used
> git checkout instead. I conceptually think reset --hard should do
> that, and that checkout is really not meant to do that as a concept.

I agree with you if we limit the scope to "reset --hard" that does
not mention any commit on the command line (or says "HEAD").

However, for things like:

    $ git reset --hard HEAD^ Makefile
    $ git reset --hard HEAD@{4.hours.ago} Makefile

I do not think "reset --hard" is a good match.  Conceptually, you
are grabbing what was stored in a given commit and checking that out
to your current workspace (that is, the index and the working tree).

All modes of "git reset" are primarily about updating where in the
history DAG your HEAD points at, and then adjusting your current
workspace to that update, taking into account the reason why you are
repointing your HEAD in the history DAG (e.g. when doing --hard
reset, you want the workspace to match what the commit your HEAD now
points at; when doing --soft reset, you don't want any changes
done).

It is only when you use "git reset" to update your HEAD to point at
the exact same commit when interaction with <pathspec> could make
sense, but conceptually the use case is covered better by
"checkout", which does _not_ futz with the history at all.  The
command is primarily about preparing your workspace (that is, the
index and the working tree) toward the work you do to prepare for
the next commit you are going to make.  Either you check out a
branch so that your next commit goes to that branch (and you take
your local changes with you when you do so), or you grab contents
from other existing commits to prepare for your work.

So while I am OK with loosening "reset --hard" with <pathspec> if
the command weren't given any commit from the command line, I doubt
that would be a real improvement.

I suspect it may even hurt the users by placing them in a wrong
mental model (i.e. I doubt you would wish "reset --hard <path>" to
work if your starting point were "reset is primarily about moving in
the history DAG and adjust the workspace accordingly").
