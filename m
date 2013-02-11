From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Mon, 11 Feb 2013 10:21:33 +0700
Message-ID: <CACsJy8BvN0xX_=fx78hVLw=2Wyk=RUHYs_x9r5RJ0TvBAoA83g@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
 <7vliaxwa9p.fsf@alter.siamese.dyndns.org> <CAKXa9=qQwJqxZLxhAS35QeF1+dwH+ukod0NfFggVCuUZHz-USg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Robert Zeh <robert.allan.zeh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 04:22:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4jyR-0003rf-7A
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 04:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367Ab3BKDWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 22:22:07 -0500
Received: from mail-ob0-f171.google.com ([209.85.214.171]:44881 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238Ab3BKDWG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 22:22:06 -0500
Received: by mail-ob0-f171.google.com with SMTP id x4so5526717obh.2
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 19:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=kbcZRfwKBBxrVMaBUO1998B/V+UCXBYxygUd/Z6ax2k=;
        b=mVBysHWlNpCQjWJ/IZ3Qo/xYwbDht9ecXDHxL5GRBgbq/AYZKGf/wxewuev1SYy6C/
         dtdj+LDHCKP80mAAXGoRH83qd72C46qOp2OroBkPRS7U3qxjaKw3/PjLBoDdJ/fMvUW2
         7HOmn/tPyF2opy2IDR22IIWsjD9NUD+eCAhtse5mqEQonSnTUUhI9Q/ZZry6ByyiS0uF
         AWo35HWUZ1ec3ZNmQoRzohXrrcHCYnGpkKx62Ju/VIXNccxo4FZQrC87G+jKa5I1z6Pw
         1TxXjC0Q+YAdmsdloceJdWQQW6U+cA05zdRNeNe3cDX14KYTpmMRBqcB53dbtKQyi2O/
         EQSg==
X-Received: by 10.182.89.36 with SMTP id bl4mr9739918obb.22.1360552923913;
 Sun, 10 Feb 2013 19:22:03 -0800 (PST)
Received: by 10.76.154.197 with HTTP; Sun, 10 Feb 2013 19:21:33 -0800 (PST)
In-Reply-To: <CAKXa9=qQwJqxZLxhAS35QeF1+dwH+ukod0NfFggVCuUZHz-USg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215979>

On Mon, Feb 11, 2013 at 2:03 AM, Robert Zeh <robert.allan.zeh@gmail.com> wrote:
> On Sat, Feb 9, 2013 at 1:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>>
>>> This is much better than Junio's suggestion to study possible
>>> implementations on all platforms and designing a generic daemon/
>>> communication channel.  That's no weekend project.
>>
>> It appears that you misunderstood what I wrote.  That was not "here
>> is a design; I want it in my system.  Go implemment it".
>>
>> It was "If somebody wants to discuss it but does not know where to
>> begin, doing a small experiment like this and reporting how well it
>> worked here may be one way to do so.", nothing more.
>
> What if instead of communicating over a socket, the daemon
> dumped a file containing all of the lstat information after git
> wrote a file? By definition the daemon should know about file writes.
>
> There would be no network communication, which I think would make
> things more secure. It would simplify the rendezvous by insisting on
> well known locations in $GIT_DIR.

We need some sort of interactive communication to the daemon anyway,
to validate that the information is uptodate. Assume that a user makes
some changes to his worktree before starting the daemon, git needs to
know that what the daemon provides does not represent a complete
file-change picture and it better refreshes the index the old way
once, then trust the daemon.

I think we could solve that by storing a "session id", provided by the
daemon, in .git/index. If the session id is not present (or does not
match what the current daemon gives), refresh the old way. After
refreshing, it may ask the daemon for new session id and store it.
Next time if the session id is still valid, trust the daemon's data.
This session id should be different every time the daemon restarts for
this to work.
-- 
Duy
