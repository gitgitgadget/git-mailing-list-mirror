From: Alexandru Juncu <alexj@rosedu.org>
Subject: Re: [PATCH] git-p4: Fix occasional truncation of symlink contents.
Date: Mon, 12 Aug 2013 10:46:28 +0300
Message-ID: <CAPhGq=YBVvejZ2gacwroX3cw0K3nDo02kWmMdP6Uwgd5sfPXKQ@mail.gmail.com>
References: <1375967858-10615-1-git-send-email-ajuncu@ixiacom.com> <20130811115738.GA26658@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Alexandru Juncu <ajuncu@ixiacom.com>,
	Alex Badea <abadea@ixiacom.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 09:46:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8mq5-0000Ul-Q9
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 09:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475Ab3HLHqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 03:46:50 -0400
Received: from mail-qe0-f52.google.com ([209.85.128.52]:46363 "EHLO
	mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926Ab3HLHqt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 03:46:49 -0400
Received: by mail-qe0-f52.google.com with SMTP id cz11so3436808qeb.11
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 00:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=EpCIwCZ9p6AVBl/4L2CSvULfo70/NbKxKQc30wCor78=;
        b=FANCURAkrVk8rAaxHKzvdY/HnTJ1/qM5Gxbr63BYa4mhKvaYtrtk2Lbxn64vYXDFhD
         wwzK9ubevGJo9ufXE6QopF6ewsxHTUG/4NkZmzQ7fTs99mg57z3E1h/9ddnyAqr+Vs4a
         6Vesy5eM6U1OA9uWCV3Vw8MPTqcCWvUlW9fGfQ7rFvopSw7RoZlXnQEBb2YMlJsOKXGy
         frKEt2uKc5mmCwCwug88N84MK4+N6m+30YVOxTWvhx63CWxeaswAW3Qf3wSIKZ/Ak2kn
         sAVHxf65ObFYVR5awRlDI/ufUOSWxdyuAwsWJcCPiwUZwX96wdbHOmjetN5LSXqAerU0
         Q9Xg==
X-Received: by 10.224.113.209 with SMTP id b17mr23204970qaq.85.1376293608339;
 Mon, 12 Aug 2013 00:46:48 -0700 (PDT)
Received: by 10.49.39.196 with HTTP; Mon, 12 Aug 2013 00:46:28 -0700 (PDT)
In-Reply-To: <20130811115738.GA26658@padd.com>
X-Google-Sender-Auth: f2gFNF6UegFu7ZFBroFpnZLe708
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232169>

On 11 August 2013 14:57, Pete Wyckoff <pw@padd.com> wrote:
> alexj@rosedu.org wrote on Thu, 08 Aug 2013 16:17 +0300:
>> Symlink contents in p4 print sometimes have a trailing
>> new line character, but sometimes it doesn't. git-p4
>> should only remove the last character if that character
>> is '\n'.
>
> Your patch looks fine, and harmless if symlinks continue
> to have \n on the end.  I'd like to understand a bit why
> this behavior is different for you, though.  Could you do
> this test on a symlink in your depot?
>
> Here //depot/symlink points to "symlink-target".  You can
> see the \n in position 0o332 below.  What happens on a
> symlink in your repo?
>
>     arf-git-test$ p4 fstat //depot/symlink
>     ... depotFile //depot/symlink
>     ... clientFile /dev/shm/trash directory.t9802-git-p4-filetype/cli/symlink
>     ... isMapped
>     ... headAction add
>     ... headType symlink
>     ... headTime 1376221978
>     ... headRev 1
>     ... headChange 6
>     ... headModTime 1376221978
>     ... haveRev 1
>
>     arf-git-test$ p4 -G print //depot/symlink | od -c
>     0000000   {   s 004  \0  \0  \0   c   o   d   e   s 004  \0  \0  \0   s
>     0000020   t   a   t   s  \t  \0  \0  \0   d   e   p   o   t   F   i   l
>     0000040   e   s 017  \0  \0  \0   /   /   d   e   p   o   t   /   s   y
>     0000060   m   l   i   n   k   s 003  \0  \0  \0   r   e   v   s 001  \0
>     0000100  \0  \0   1   s 006  \0  \0  \0   c   h   a   n   g   e   s 001
>     0000120  \0  \0  \0   6   s 006  \0  \0  \0   a   c   t   i   o   n   s
>     0000140 003  \0  \0  \0   a   d   d   s 004  \0  \0  \0   t   y   p   e
>     0000160   s  \a  \0  \0  \0   s   y   m   l   i   n   k   s 004  \0  \0
>     0000200  \0   t   i   m   e   s  \n  \0  \0  \0   1   3   7   6   2   2
>     0000220   1   9   7   8   s  \b  \0  \0  \0   f   i   l   e   S   i   z
>     0000240   e   s 002  \0  \0  \0   1   5   0   {   s 004  \0  \0  \0   c
>     0000260   o   d   e   s 006  \0  \0  \0   b   i   n   a   r   y   s 004
>     0000300  \0  \0  \0   d   a   t   a   s 017  \0  \0  \0   s   y   m   l
>     0000320   i   n   k   -   t   a   r   g   e   t  \n   0   {   s 004  \0
>     0000340  \0  \0   c   o   d   e   s 006  \0  \0  \0   b   i   n   a   r
>     0000360   y   s 004  \0  \0  \0   d   a   t   a   s  \0  \0  \0  \0   0
>     0000400
>
> Also, what version is your server, from "p4 info":
>
>     Server version: P4D/LINUX26X86_64/2013.1/610569 (2013/03/19)
>
>                 -- Pete
>

Hello!

Let me give you an example. Here are the links as resulted in the git
p4 clone (one was correct, one wasn't):

./lib/update.sh -> ../update.sh
./apps/update.sh -> ../update.s


alexj@ixro-alexj ~/perforce $ p4 print path/lib/update.sh
//path/update.sh#6 - edit change 119890 (symlink)
../update.sh
alexj@ixro-alexj ~/perforce $ p4 print path/apps/update.sh
//path/apps/update.sh#144 - edit change 116063 (symlink)
../update.shalexj@ixro-alexj ~/perforce/unstable $

Notice the output and the prompt.

(I removed the exact path to the file from the output)

The fstat output is kind of irrelevant, but the hexdump shows the missing \n:

p4 -G print lib/update.sh|od -c

0000360   t   e   .   s   h  \n   0

p4 -G print apps/update.sh|od -c
0000360   p   d   a   t   e   .   s   h   0


Server version: P4D/LINUX26X86_64/2013.1/610569

>> Signed-off-by: Alex Juncu <ajuncu@ixiacom.com>
>> Signed-off-by: Alex Badea <abadea@ixiacom.com>
>> ---
>>  git-p4.py | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/git-p4.py b/git-p4.py
>> index 31e71ff..a53a6dc 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -2180,9 +2180,13 @@ class P4Sync(Command, P4UserMap):
>>              git_mode = "100755"
>>          if type_base == "symlink":
>>              git_mode = "120000"
>> -            # p4 print on a symlink contains "target\n"; remove the newline
>> +            # p4 print on a symlink sometimes contains "target\n";
>> +            # if it does, remove the newline
>>              data = ''.join(contents)
>> -            contents = [data[:-1]]
>> +            if data[-1] == '\n':
>> +                contents = [data[:-1]]
>> +            else:
>> +                contents = [data]
>>
>>          if type_base == "utf16":
>>              # p4 delivers different text in the python output to -G
>> --
>> 1.8.4.rc0.1.g8f6a3e5
