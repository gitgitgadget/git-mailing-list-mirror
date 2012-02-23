From: Nikolaj Shurkaev <snnicky@gmail.com>
Subject: Re: git log -z doesn't separate commits with NULs
Date: Thu, 23 Feb 2012 15:17:37 +0300
Message-ID: <4F462E61.4020203@gmail.com>
References: <4F46036F.3040406@gmail.com> <20120223102426.GB2912@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 23 13:17:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0XcK-00061o-S6
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 13:17:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400Ab2BWMRo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Feb 2012 07:17:44 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64574 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002Ab2BWMRn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 07:17:43 -0500
Received: by bkcjm19 with SMTP id jm19so945627bkc.19
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 04:17:42 -0800 (PST)
Received-SPF: pass (google.com: domain of snnicky@gmail.com designates 10.205.121.136 as permitted sender) client-ip=10.205.121.136;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of snnicky@gmail.com designates 10.205.121.136 as permitted sender) smtp.mail=snnicky@gmail.com; dkim=pass header.i=snnicky@gmail.com
Received: from mr.google.com ([10.205.121.136])
        by 10.205.121.136 with SMTP id gc8mr542507bkc.126.1329999462693 (num_hops = 1);
        Thu, 23 Feb 2012 04:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=oJwfyHbhlML5xHM6Y4xg3XBlHLnnYUDMls3YluYR4hY=;
        b=eILfGPLVkWwcn3R2Kr9BU9A/9Z2VTFcGaqS+/luAMlxu6k3a8/IPKSBlVEYexTSkTh
         aEstMjleI4Zfrz49LR0g8ZBtfOAlI3Necs8Ii+/Deq1tuGyWE6q2e2ZrwwXYAn/RGNly
         nH4xb7vkV2g85UEDwf3HypLVxsXWCFZR+y+gI=
Received: by 10.205.121.136 with SMTP id gc8mr446869bkc.126.1329999462610;
        Thu, 23 Feb 2012 04:17:42 -0800 (PST)
Received: from [192.168.1.130] ([80.249.81.45])
        by mx.google.com with ESMTPS id o7sm2376297bkw.16.2012.02.23.04.17.41
        (version=SSLv3 cipher=OTHER);
        Thu, 23 Feb 2012 04:17:41 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <20120223102426.GB2912@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191356>

Hello.

Thank you very much for your tips. They really helped me. I was trying=20
to create patches that would affect only some given files or folders. B=
y=20
this moment I have the following:

GeneratePatches.sh
---------------------
#!/bin/bash
#parameter 1 - <since>..<to>
#parameter 2 - path to file
git log -z --reverse --format=3Demail --patch "$1" -- "$2" | xargs --nu=
ll=20
--max-args=3D1 ./CreatePatchFile.sh
---------------------

and CreatePatchFile.sh
---------------------
#!/bin/bash

myPatchNumber=3D$(ls ./*-patch.patch 2>/dev/null | wc -l)
let "myPatchNumber +=3D 1"

patchFile=3D"./"$(printf "%04d" $myPatchNumber)"-patch.patch"
echo "$@" > "$patchFile"
---------------------

I call
=2E/GeneratePatches.sh HEAD~3..HEAD SomePath
and that produces something very similar to what I want.

Perhaps there is a better way to do that.

Thank you once again.
---
Best regards,
Nikolaj

23.02.2012 13:24, Jeff King =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Thu, Feb 23, 2012 at 12:14:23PM +0300, Nikolaj Shurkaev wrote:
>
>> I wanted to generate several files with some statistics using "git
>> log -z" command.
>> I did something like this:
>> git log -z --patch HEAD~10..HEAD -- SomePathHere | xargs -0
>> --max-chars=3D1000000 ~/1.sh
> I'm not sure what "1.sh" is expecting to take as input, but that will
> feed entire commits, including their commit message and entire diff, =
to
> the script on its command line.
>
> That seems like an awkward interface, but we don't really know what y=
our
> script intends to do. Maybe it is worth sharing the contents of the
> script.
>
>> If I put echo "started" into the file  ~/1.sh I see that the file is
>> called only once instead of multiple times.
> Yes. The point of xargs is usually to cram as many arguments into eac=
h
> invocation of "1.sh" as possible, splitting into multiple invocations
> only when we hit the argument-list memory limit that the OS imposes.
>
> If you want xargs to give each argument its own invocation of the
> script, use "xargs -n1".
>
>> I'm newbie to xargs, thus I tested with and that worked as I expecte=
d.
>> find . -type f -print0 | xargs -0  ./1.sh
>> That produced a lost of "started" lines.
> If you instrument your 1.sh more[1], you will find that is not execut=
ing
> once per file, but rather getting a large chunk of files per invocati=
on.
>
> [1] Try adding: echo "got args: $*"
>
>> Thus I suspect there is a but in git log -z command and that doesn't
>> "Separate the commits with NULs instead of with new newlines." as
>> promised in the documents.
> You could verify that assertion by looking at the output. Try piping
> your "git log" command through "cat -A | less". When I try it, I see =
a
> NUL between each commit (cat -A will show it as "^@").
>
> -Peff
>
