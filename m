From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [PATCH v4 1/2] for-each-repo: new command used for multi-repo operations
Date: Mon, 28 Jan 2013 20:42:16 +0100
Message-ID: <CAFXTnz4x1K1cwYKWUJK1ExCjGti8vaW_endoJg20wTYUf4C5NQ@mail.gmail.com>
References: <1359290777-5483-1-git-send-email-hjemli@gmail.com>
	<1359290777-5483-2-git-send-email-hjemli@gmail.com>
	<7vk3qywiqf.fsf@alter.siamese.dyndns.org>
	<CAFXTnz6GTVgY4DK-FLELGF-Cb1=iNYyWcUsUiaUytGRx9Tr4Ow@mail.gmail.com>
	<20130128081006.GA2434@elie.Belkin>
	<7vham1xktx.fsf@alter.siamese.dyndns.org>
	<CAFXTnz6xBMo42jWdqahYX-bnTBucVmQpFPN29X8tGRd7L=g2wQ@mail.gmail.com>
	<7vr4l5w385.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 20:42:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzubI-0006CD-2q
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 20:42:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757Ab3A1TmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 14:42:19 -0500
Received: from mail-bk0-f45.google.com ([209.85.214.45]:33038 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060Ab3A1TmR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 14:42:17 -0500
Received: by mail-bk0-f45.google.com with SMTP id i18so1590936bkv.18
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 11:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=rKZiMjmliV6yjO99J42c8i3vhVNQbJHnM3kd+cPP4SA=;
        b=NA+5lQh+G/fkoHAq4PjBnuubiZz3ftGs7CzNi++s++Y2dSf7GVTbTRMcPgriLV+xYC
         ORYRSdUofJZscJCqHcBJe1sSMxZX5vwvQiTX75ROJDbR2VDNcQ85672cGL9vxI2I6l3z
         k3vq2xuBUulNa+9+ZSQjBNpw0wL1tAB/HeEcpJccaY3yhWuqG8prys/UKvldxo4E9Fr7
         kBtOS1NsQMd432NnPCP/98z7LD1xj0eF4UfvMZF33T8mFKLLYtGo8bSWnlXnFTEYUZEi
         R3csKvjIvo9TxT7BiuEzjz/BXQa8jlCjp2gvhO0bCPl0bV54XydcvqTPUBh/lPGnRd6s
         K1RA==
X-Received: by 10.204.145.195 with SMTP id e3mr1087889bkv.27.1359402136380;
 Mon, 28 Jan 2013 11:42:16 -0800 (PST)
Received: by 10.205.83.199 with HTTP; Mon, 28 Jan 2013 11:42:16 -0800 (PST)
In-Reply-To: <7vr4l5w385.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214860>

On Mon, Jan 28, 2013 at 7:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Lars Hjemli <hjemli@gmail.com> writes:
>
>>> Come to think of it, is there a reason why "for-each-repo" should
>>> not be an extention to "submodule foreach"?  We can view this as
>>> visiting repositories that _could_ be registered as a submodule, in
>>> addition to iterating over the registered submodules, no?
>>
>> Yes, but I see some possible problems with that approach:
>> -'git for-each-repo' does not need to be started from within a git worktree
>
> True, but "git submodule foreach --untracked" can be told that it is
> OK not (yet) to be in any superproject, no?

Yes.

>
>> -'git for-each-repo' and 'git submodule foreach' have different
>> semantics for --dirty and --clean
>
> That could be a problem.  Is there a good reason why they should use
> different definitions of dirtyness?

I suspected that 'submodule foreach --dirty' might want to compare the
HEAD sha1 in the submodule against the one recorded in the
superproject (similar to what 'git submodule status' does), but such a
check could be triggered by a different flag (e.g. --behind/--ahead or
something similar).

>> -'git for-each-repo' is in C because my 'git-all' shell script was
>> horribly slow on large directory trees (especially on windows)
>
> Your for-each-repo could be a good basis to build a new builtin
> "submodule--foreach" that is a pure helper hidden from the end users
> that does both; cmd_foreach() in git-submodule.sh can simply delegate
> to it.

Ok, I'll rework my patches in this direction. Thanks.

--
larsh
