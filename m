From: Alexandru Juncu <alexj@rosedu.org>
Subject: Re: [PATCH] git-p4: Fix occasional truncation of symlink contents.
Date: Mon, 12 Aug 2013 16:30:59 +0300
Message-ID: <CAPhGq=a5=enAAkPH5ooRNWrQU+BwYX57=dqTnNKRF1qK3Q33QQ@mail.gmail.com>
References: <1375967858-10615-1-git-send-email-ajuncu@ixiacom.com>
 <20130811115738.GA26658@padd.com> <CAPhGq=YBVvejZ2gacwroX3cw0K3nDo02kWmMdP6Uwgd5sfPXKQ@mail.gmail.com>
 <20130812123850.GA25532@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Alexandru Juncu <ajuncu@ixiacom.com>,
	Alex Badea <abadea@ixiacom.com>,
	Alexander Tomlinson <alex@aivor.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 15:31:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8sDV-0005Y4-4b
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 15:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755582Ab3HLNbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 09:31:21 -0400
Received: from mail-qc0-f171.google.com ([209.85.216.171]:45927 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518Ab3HLNbU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 09:31:20 -0400
Received: by mail-qc0-f171.google.com with SMTP id n1so831155qcw.2
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 06:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=7+Sl6sdj2S8z87mui1gmDDTy8SP2d+CFd4+dTmGbemE=;
        b=eMY1Uq89/qIZ46SLJieb9qFzJkaRtfhZHqbupj/uuz915FBh0ftghSsc7lDxqk0Fps
         Cizyi1st/QoUySHpZn5YEVmKbmwRQSiK0jJT9yiTi4P3LGHmH9wn+PFiYiyvkpi78qaJ
         +P4etmsTeDXZCy70RKMal+Gu79TWeLSFYkZMRuieYRFAYyfdbH2SHFM5evrtvbgZ4lF7
         cqXG9dlP6weFv6xztzGDdDo5ifAcBvan7aQfFbIc778mM2v+JlrtUB8zcFB5vTGMhogF
         MJXAfl2XjOjm+CvMad/jzVL9+yOglZMLuYR0uPhdkfdPKAi9iA5rSd5KgI1ddhkBk8b5
         ND4Q==
X-Received: by 10.49.127.179 with SMTP id nh19mr13685383qeb.1.1376314279469;
 Mon, 12 Aug 2013 06:31:19 -0700 (PDT)
Received: by 10.49.39.196 with HTTP; Mon, 12 Aug 2013 06:30:59 -0700 (PDT)
In-Reply-To: <20130812123850.GA25532@padd.com>
X-Google-Sender-Auth: B5p0TjL8Z5aqzMNOm_BDDXAhzKw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232192>

On 12 August 2013 15:38, Pete Wyckoff <pw@padd.com> wrote:
> alexj@rosedu.org wrote on Mon, 12 Aug 2013 10:46 +0300:
>> On 11 August 2013 14:57, Pete Wyckoff <pw@padd.com> wrote:
>> > alexj@rosedu.org wrote on Thu, 08 Aug 2013 16:17 +0300:
>> >> Symlink contents in p4 print sometimes have a trailing
>> >> new line character, but sometimes it doesn't. git-p4
>> >> should only remove the last character if that character
>> >> is '\n'.
>> >
>> > Your patch looks fine, and harmless if symlinks continue
>> > to have \n on the end.  I'd like to understand a bit why
>> > this behavior is different for you, though.  Could you do
>> > this test on a symlink in your depot?
>> >
>> > Here //depot/symlink points to "symlink-target".  You can
>> > see the \n in position 0o332 below.  What happens on a
>> > symlink in your repo?
>> >
>> >     arf-git-test$ p4 fstat //depot/symlink
>> >     ... depotFile //depot/symlink
>> >     ... clientFile /dev/shm/trash directory.t9802-git-p4-filetype/cli/symlink
>> >     ... isMapped
>> >     ... headAction add
>> >     ... headType symlink
>> >     ... headTime 1376221978
>> >     ... headRev 1
>> >     ... headChange 6
>> >     ... headModTime 1376221978
>> >     ... haveRev 1
>> >
>> >     arf-git-test$ p4 -G print //depot/symlink | od -c
>> >     0000000   {   s 004  \0  \0  \0   c   o   d   e   s 004  \0  \0  \0   s
>> >     0000020   t   a   t   s  \t  \0  \0  \0   d   e   p   o   t   F   i   l
>> >     0000040   e   s 017  \0  \0  \0   /   /   d   e   p   o   t   /   s   y
>> >     0000060   m   l   i   n   k   s 003  \0  \0  \0   r   e   v   s 001  \0
>> >     0000100  \0  \0   1   s 006  \0  \0  \0   c   h   a   n   g   e   s 001
>> >     0000120  \0  \0  \0   6   s 006  \0  \0  \0   a   c   t   i   o   n   s
>> >     0000140 003  \0  \0  \0   a   d   d   s 004  \0  \0  \0   t   y   p   e
>> >     0000160   s  \a  \0  \0  \0   s   y   m   l   i   n   k   s 004  \0  \0
>> >     0000200  \0   t   i   m   e   s  \n  \0  \0  \0   1   3   7   6   2   2
>> >     0000220   1   9   7   8   s  \b  \0  \0  \0   f   i   l   e   S   i   z
>> >     0000240   e   s 002  \0  \0  \0   1   5   0   {   s 004  \0  \0  \0   c
>> >     0000260   o   d   e   s 006  \0  \0  \0   b   i   n   a   r   y   s 004
>> >     0000300  \0  \0  \0   d   a   t   a   s 017  \0  \0  \0   s   y   m   l
>> >     0000320   i   n   k   -   t   a   r   g   e   t  \n   0   {   s 004  \0
>> >     0000340  \0  \0   c   o   d   e   s 006  \0  \0  \0   b   i   n   a   r
>> >     0000360   y   s 004  \0  \0  \0   d   a   t   a   s  \0  \0  \0  \0   0
>> >     0000400
>> >
>> > Also, what version is your server, from "p4 info":
>> >
>> >     Server version: P4D/LINUX26X86_64/2013.1/610569 (2013/03/19)
>> >
>> >                 -- Pete
>> >
>>
>> Hello!
>>
>> Let me give you an example. Here are the links as resulted in the git
>> p4 clone (one was correct, one wasn't):
>>
>> ./lib/update.sh -> ../update.sh
>> ./apps/update.sh -> ../update.s
>>
>>
>> alexj@ixro-alexj ~/perforce $ p4 print path/lib/update.sh
>> //path/update.sh#6 - edit change 119890 (symlink)
>> ../update.sh
>> alexj@ixro-alexj ~/perforce $ p4 print path/apps/update.sh
>> //path/apps/update.sh#144 - edit change 116063 (symlink)
>> ../update.shalexj@ixro-alexj ~/perforce/unstable $
>>
>> Notice the output and the prompt.
>>
>> (I removed the exact path to the file from the output)
>>
>> The fstat output is kind of irrelevant, but the hexdump shows the missing \n:
>>
>> p4 -G print lib/update.sh|od -c
>>
>> 0000360   t   e   .   s   h  \n   0
>>
>> p4 -G print apps/update.sh|od -c
>> 0000360   p   d   a   t   e   .   s   h   0
>
> I had forgotten, in fact, another thread on this very topic:
>
> http://thread.gmane.org/gmane.comp.version-control.git/221500
>
> Now with your evidence, I think we can decide that no matter how
> the symlink managed to sneak into p4d, git p4 should be able to
> handle it.
>
> The only problem is that due to the \n ambiguity, in your setup
> where p4d loses the \n, git p4 will not handle symlinks with a
> target that ends with a newline, e.g.:
>
>     symlink("foo\n", "bar");
>
> But the small chance of someone actually doing that, coupled with
> the fact that for you git p4 is unusable with these symlinks,
> says we should go ahead and make the change.
>
> You should send the patch to junio for inclusion in pu/ for the
> next release, with:
>
> Acked-by: Pete Wyckoff <pw@padd.com>
>
> Thanks for fixing this!
>
>                 -- Pete

Sorry, I didn't get where I am supposed to submit the patch (I thought
I was supposed to send it here, lkml style).

>
>> Server version: P4D/LINUX26X86_64/2013.1/610569
>>
>> >> Signed-off-by: Alex Juncu <ajuncu@ixiacom.com>
>> >> Signed-off-by: Alex Badea <abadea@ixiacom.com>
>> >> ---
>> >>  git-p4.py | 8 ++++++--
>> >>  1 file changed, 6 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/git-p4.py b/git-p4.py
>> >> index 31e71ff..a53a6dc 100755
>> >> --- a/git-p4.py
>> >> +++ b/git-p4.py
>> >> @@ -2180,9 +2180,13 @@ class P4Sync(Command, P4UserMap):
>> >>              git_mode = "100755"
>> >>          if type_base == "symlink":
>> >>              git_mode = "120000"
>> >> -            # p4 print on a symlink contains "target\n"; remove the newline
>> >> +            # p4 print on a symlink sometimes contains "target\n";
>> >> +            # if it does, remove the newline
>> >>              data = ''.join(contents)
>> >> -            contents = [data[:-1]]
>> >> +            if data[-1] == '\n':
>> >> +                contents = [data[:-1]]
>> >> +            else:
>> >> +                contents = [data]
>> >>
>> >>          if type_base == "utf16":
>> >>              # p4 delivers different text in the python output to -G
>> >> --
>> >> 1.8.4.rc0.1.g8f6a3e5
>>
