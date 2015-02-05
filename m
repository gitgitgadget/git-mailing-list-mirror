From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [BUG] Move tracking in git diff is not as good as in git status
Date: Wed, 4 Feb 2015 23:39:25 -0800
Message-ID: <099A7D2D-6033-4A16-91DD-E2288BC5C729@gmail.com>
References: <20150205061142.GA31599@odin.ulthar.us>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Scott Schmit <i.grok@comcast.net>
X-From: git-owner@vger.kernel.org Thu Feb 05 08:39:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJH2D-00019w-Ry
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 08:39:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755518AbbBEHj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 02:39:29 -0500
Received: from mail-pd0-f182.google.com ([209.85.192.182]:40747 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755141AbbBEHj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 02:39:29 -0500
Received: by pdjy10 with SMTP id y10so6141862pdj.7
        for <git@vger.kernel.org>; Wed, 04 Feb 2015 23:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=UB/Idrrylv8qoGlk47vSK17SWecuW29fM26pJkp7vds=;
        b=RM+HMpya3Ccf6HtsF5JVkRiGsdWu0o7r3nEm88R1gpEvm8+gD5ffIhAu1GjZ7oWrwX
         Ffjuf1vMysv79IyB/r0PDAPCFuxrBwf2YfqxNuBzLaj7SHvifq/VVMY1oG2zf2hy4gYq
         MUDKjaI2FuS1rKJlxa6H5A7o5lrGiwp6zKRmAxsX/JbPcfr5uKzyHDpgwpGl2jHqmN5U
         s1knNhNRt6AaqTUGkMA3Afd83RmUORqtFasM6GauvNBFeCwboRJmOJ1YJgJhtvaW3W2y
         LWweqtNi7gqRhI82MiJuKV+c5/H8GDR1RlbCG50IHXVoUoz2dqwFEpP39RKAQ6EILohw
         5iFQ==
X-Received: by 10.68.98.98 with SMTP id eh2mr3757243pbb.112.1423121968484;
        Wed, 04 Feb 2015 23:39:28 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id y2sm1182785pbt.36.2015.02.04.23.39.27
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 04 Feb 2015 23:39:27 -0800 (PST)
In-Reply-To: <20150205061142.GA31599@odin.ulthar.us>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263364>

On Feb 4, 2015, at 22:11, Scott Schmit wrote:

> In my use of git, I've noticed that "git status" is a lot better at
> tracking moves and renames than "git diff", and this has recently  
> caused
> me a lot of headaches because a large number of moves were made in a
> single commit, and it was very difficult to figure out which moves  
> were
> right and which were wrong.
>
> I was using a fairly old version of git (1.7.11), but was able to
> reproduce it on git 2.2.1.
>
> Here's a reproduction recipe:
[...]
> # Now "shift" the files
> git mv 2 3
> git mv 1 2
[...]
> git commit -m "2=1;3=2;"
>
> # Neither of these commands get it (but -C gets a glimmer of the  
> truth)
> git diff -M --stat --summary HEAD~..
> git diff -C --stat --summary HEAD~..

Ah, but did you try this:

   git diff -B -M --stat --summary HEAD~..

> # Swap the files in place
> git mv 3 tmp
> git mv 2 3
> git mv tmp 2
[...]
> git commit -m "Swap 2 & 3"
>
> # Diff has no idea
> git diff -M --stat --summary HEAD~..
> git diff -C --stat --summary HEAD~..

Again, try this:

   git diff -B -M --stat --summary HEAD~..

You can even use this:

   git log -B -M --summary

to see them all.

While you can configure -M (or -C) to be on by default (see git config  
diff.renames), there does not appear to be a config option to turn on - 
B (--break-rewrites) by default.

And according to a recent thread [1], using -B and -M together can  
produce incorrect results so you might not want them both on by  
default anyway.

-Kyle

[1] http://thread.gmane.org/gmane.linux.kernel/1879635
