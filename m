From: Brandon Casey <drafnel@gmail.com>
Subject: Re: Did we break receive-pack recently?
Date: Sun, 5 Aug 2012 20:32:29 -0700
Message-ID: <CA+sFfMdXc+usFRnCNVoke91_X2qWZARTvPHO=B7Ukxr-j7JB2g@mail.gmail.com>
References: <7vk3xe6r1w.fsf@alter.siamese.dyndns.org>
	<CA+sFfMcA2qUcigPg_ijWJmiTKYY9V4f4f6XQp8xT76wLaUXSxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 05:32:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyE3l-0002JX-MR
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 05:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755552Ab2HFDcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 23:32:32 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:59061 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755513Ab2HFDcb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 23:32:31 -0400
Received: by ggnl2 with SMTP id l2so2076077ggn.19
        for <git@vger.kernel.org>; Sun, 05 Aug 2012 20:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oQidIKYOHOX5DWgRK7iIj8jCqPLgpmP/h9mJngZn1Cw=;
        b=WxHiuBi+6m7B3gLBfAMBdgPAbYNscr5YP5KJIrhUBhdzOVKDZb2QOT3OvzlESq408C
         3qZoh2oJy0/5x9lZfOH9FVU5aOhvzC9v2hCrScYlgZKim6ITcsj08MGQN9J7xRQoc8Ub
         r27sCfAxH4gby/g/XgjsmGYp8LQr9LknLAyI2Tg3+VnQJ1rMSOtiUfweF9BeQpdEpr79
         83EPCUkzx6uev9a1VvM91TJW5tU4ugH3jY/XGBYvfeXJcWzDgTWXPMBOyF/dnMTpUden
         /5Da7PV+gYM0UxXez0aO7ZeFi4ggx+lNBM5sLZVAj7cgUZUg/U67bTSDeJeBGPsz3YfZ
         PAOQ==
Received: by 10.50.213.1 with SMTP id no1mr4096352igc.71.1344223949994; Sun,
 05 Aug 2012 20:32:29 -0700 (PDT)
Received: by 10.64.48.174 with HTTP; Sun, 5 Aug 2012 20:32:29 -0700 (PDT)
In-Reply-To: <CA+sFfMcA2qUcigPg_ijWJmiTKYY9V4f4f6XQp8xT76wLaUXSxA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202956>

On Sun, Aug 5, 2012 at 6:37 PM, Brandon Casey <drafnel@gmail.com> wrote:
> On Sat, Aug 4, 2012 at 6:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> I just saw this:
>>
>>     $ git push ko
>>     ko: Counting objects: 332, done.
>>     Delta compression using up to 4 threads.
>>     Compressing objects: 100% (110/110), done.
>>     Writing objects: 100% (130/130), 32.27 KiB, done.
>>     Total 130 (delta 106), reused 21 (delta 20)
>>     Auto packing the repository for optimum performance.
>>     fatal: protocol error: bad line length character: Remo
>>     error: error in sideband demultiplexer
>>     To ra.kernel.org:/pub/scm/git/git.git
>>     ...
>>
>> What is unusual with this push is that it happened to trigger the
>> auto-gc on the receiving end and the message "Auto packing the
>> repository..." came back to the pusher just fine, but somebody
>> nearby seem to have tried to say "Remo"(te---probably) without
>> properly using the sideband.
>
> Or perhaps "Remo" is short for "Removing...".
>
> Perhaps this is the source:
>
>    $ grep Remo builtin/prune.c
>    printf("Removing stale temporary file %s\n", fullpath);

Verified...

test_path=`pwd` &&
git init test_repo1 &&
( cd test_repo1 &&
  echo D >file.txt &&
  git add . &&
  git commit -m 'Commit something that hashes to 17...' &&
  echo MN >file.txt &&
  git commit -a -m 'Commit something else that hashes to 17...'
) &&
git init --bare test_repo2.git &&
( cd test_repo2.git &&
  git config gc.auto 1 &&
  touch -d '2012-07-01' objects/tmp_test
) &&
( cd test_repo1 &&
  git push "file://$test_path/test_repo2.git" HEAD:refs/heads/master
)

It seems to have been broken since we added 'gc --auto' to receive
pack in 2009 (or maybe since I added that printf to prune.c in 2008
depending on how you look at it :b ).  Apparently it's something not
very likely to be triggered.  Probably because most servers running
git daemon frequently run 'git gc'.  Wonder what k.org's policy is?

I think the original thinking behind writing to stdout
indiscriminately was that removing a temporary object was something
that was considered unusual, so the user should always be informed.
This is unlike removing a stale object, which is something that is
expected during normal usage.  If a stale temporary object is removed,
then it means that some piece of git which should have removed it,
failed to do so.

We could write the message to stderr instead, but I think the full
path to a temporary stale object is not appropriate to communicate to
remote users over the wire.

So, I think it's best just to protect it with 'if (show_only ||
verbose)' like the other informational messages.

Patch forthcoming, hopefully with a test.  Doesn't look like we have
anything testing the auto-gc spawned from receive-pack.  I'll see if I
can come up with something.

-Brandon
