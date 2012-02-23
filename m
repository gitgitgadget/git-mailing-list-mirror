From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] [PATCH] mingw: work around stat-limitation
Date: Thu, 23 Feb 2012 22:36:40 +0100
Message-ID: <CABPQNSZ+=no5PKkaa8_44FbOzh_W4A5knoxKgDQ2wTvOaeKdew@mail.gmail.com>
References: <1330028744-5280-1-git-send-email-kusmabite@gmail.com> <alpine.DEB.1.00.1202231525320.3340@s15462909.onlinehome-server.info>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org,
	msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 23 22:37:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0gLu-0005Ea-4d
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 22:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755368Ab2BWVhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 16:37:21 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:41905 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207Ab2BWVhU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 16:37:20 -0500
Received: by daed14 with SMTP id d14so1708535dae.19
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 13:37:20 -0800 (PST)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 10.68.73.225 as permitted sender) client-ip=10.68.73.225;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of kusmabite@gmail.com designates 10.68.73.225 as permitted sender) smtp.mail=kusmabite@gmail.com; dkim=pass header.i=kusmabite@gmail.com
Received: from mr.google.com ([10.68.73.225])
        by 10.68.73.225 with SMTP id o1mr8989224pbv.77.1330033040284 (num_hops = 1);
        Thu, 23 Feb 2012 13:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=NVGfpf02dtAOUsk9pJbgNYQUhNON+rOt2x5yn0+10fc=;
        b=OeJtIBbCeGIHswIu8mF5eORx52M464ShXmBQTz+6vCzSP9sTfB7e9GMQUkoIadrBmD
         p760vRCvnDEhvfnIge9VCmXQZtVNPWwfigdCsXOA9XZXSXTy0Y/q7E4iIXF/70hQSH9o
         Kt7VOP60blgSALMEwAsLAkOySkyS0voWlc7AI=
Received: by 10.68.73.225 with SMTP id o1mr7341024pbv.77.1330033040243; Thu,
 23 Feb 2012 13:37:20 -0800 (PST)
Received: by 10.68.12.194 with HTTP; Thu, 23 Feb 2012 13:36:40 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1202231525320.3340@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191401>

On Thu, Feb 23, 2012 at 10:26 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 23 Feb 2012, Erik Faye-Lund wrote:
>
>> Our stat implementation for Windows always sets st_ino to 0. This
>> means that checking if isatty(0) and comparing the reported inodes
>> of stdout and stdin is not sufficient to detect that both are
>> pointing to the same TTY.
>>
>> Luckily, there's only one console on Windows, so adding a check for
>> isatty(1) should do the trick. For platforms where inodes are
>> reported correctly, this should still be correct.
>
> Sorry to ask so stupidly, but why does isatty(1) work and isatty(0) does
> not? Should they not access the very same console object?
>

The point is that they might not. The old test would draw the wrong
conclusion if isatty(0) was true, but isatty(1) was not because it
used st_ino to verify that stdin and stdout pointed to the same
terminal. The reason it did that was to catch cases where stdin and
stdout pointed to different terminals, AFAICT. Not checking isatty(1)
was simply an optimization, which works when st_ino is filled out
correctly.

On Windows there is only one terminal, so it's sufficient to check if
both are connected.
