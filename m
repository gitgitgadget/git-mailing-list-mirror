From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Could #-ignoring in commit message be smarter?
Date: Sat, 4 Sep 2010 22:24:36 +0000
Message-ID: <AANLkTimgt6kjTkc+gxyOmTz03bdnfiRzgt4p8vymQ=VY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramana Kumar <ramana.kumar@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 00:24:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os1AL-0008CS-8z
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 00:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131Ab0IDWYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 18:24:37 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33771 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754136Ab0IDWYg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 18:24:36 -0400
Received: by iwn5 with SMTP id 5so2807140iwn.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 15:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=cVD3x2asgrMVWbfMAP+qrkNManc/2yuwTNJKPPVqWU0=;
        b=NlXNEy585q0fE1f62x/3zYHSJEITSp6wf8tXuDXsKm6A6vaSsM4Z89NoIjo5p5ZwJO
         Mq33/BsGVPCqeAM8g5TKNkL/CXYZxQyD8kGjC0ZC1xtCKc8fccqkUkbLg9q6oyREZ79G
         d5qKivKtDzExCvlJmCxBNNmj3JOYwYHGEmMuk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=mS1aKbpaCjG2LajnC5otGRBi8mtGJM/DkpUmsFn8ZGayqXI0sTIPfC0FTh7cNkdf6w
         pI7mLI5eFtCZSch0U3x1nKgGbTdnMd+0g4vhB2bMlqozJ7sKIGWflSVCs4/ReEvXO6EW
         IzZT+n8//+jfOp7WkVkCNyJXDqk5iVvD/nReY=
Received: by 10.231.172.83 with SMTP id k19mr3433697ibz.114.1283639076178;
 Sat, 04 Sep 2010 15:24:36 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sat, 4 Sep 2010 15:24:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155378>

On Sat, Sep 4, 2010 at 21:55, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Sat, Sep 4, 2010 at 16:37, Ramana Kumar <ramana.kumar@gmail.com> wrote:
>> The commit message message says "Lines starting with '#' will be
>> ignored", but fails to say "Lines below this message will be ignored,
>> even if they don't start with '#'".
>
> Because they're not. Only those starting with # are ignored.

Which also sucks a bit. I've been bit by writing commits messages like
this numerous times:

    parser: fix non-\W issues

    This change is here to fix screwups of special characters like %, !,
    #, ^ and other non-\W chars.

    These characters screw up our parser.

    # Please enter the commit message for your changes. Lines starting
    # with '#' will be ignored, and an empty message aborts the commit.
    # On branch master
    # Changes to be committed:
    #   (use "git reset HEAD <file>..." to unstage)
    #
    #   modified:   parser.c

Where I'm referencing the #-character in the commit message itself for
some reason, and due to word wrapping it just *happens* to end up at
the start of a line. So the commit message silently becomes:

    parser: fix non-\W issues

    This change is here to fix screwups of special characters like %, !,

    These characters screw up our parser.

The main reason for why this probably can't be fixed is that we've
painted ourselves into a corner with git rebase -i squash and fixup
messages, which will insert comments themselves.

Still *maybe* we could handle this better for the common case. E.g. if
we're *not* inside a rebase only ignore the continuous and unbroken
lines starting with # at the bottom. But that'd probably break
something I'm not thinking of.
