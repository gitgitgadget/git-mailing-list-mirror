From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: [PATCH] run-command.c: Accept EACCES as command not found
Date: Tue, 22 Nov 2011 00:06:46 +0100
Message-ID: <op.v5bjtk1r0aolir@keputer>
References: <1321912387-4569-1-git-send-email-fransklaver@gmail.com>
 <7vbos5f7ix.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 22 00:06:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RScwy-0001Qp-MU
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 00:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754121Ab1KUXGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 18:06:51 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42646 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940Ab1KUXGu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2011 18:06:50 -0500
Received: by eye27 with SMTP id 27so5958225eye.19
        for <git@vger.kernel.org>; Mon, 21 Nov 2011 15:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=fvslp0++ge46OAbYhC8YlhfGOLEKALOzkKzuq57jusk=;
        b=h3JcVO8EC+A9v7DR71NsGR59VSPkMMpi1U0XeOEtIL6JAwbK3b/gTsEmfC73O/cZ3n
         9JfaSFjh30FYav4HVj0LQmXUdq/Ku3Ostm0OcOKimENZ0iWAwpuTolHbBVA4vQcJHgWs
         79YYxtkCbTcPcVT/ubjTxhhJiJAsce3n84RX8=
Received: by 10.213.15.134 with SMTP id k6mr1507876eba.146.1321916809142;
        Mon, 21 Nov 2011 15:06:49 -0800 (PST)
Received: from keputer (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id z58sm35758501eea.3.2011.11.21.15.06.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Nov 2011 15:06:48 -0800 (PST)
In-Reply-To: <7vbos5f7ix.fsf@alter.siamese.dyndns.org>
User-Agent: Opera Mail/12.00 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185769>

On Mon, 21 Nov 2011 23:13:58 +0100, Junio C Hamano <gitster@pobox.com>  
wrote:

> Frans Klaver <fransklaver@gmail.com> writes:
>
>> execvp returns ENOENT if a command was not found after searching PATH.
>> If path contains a directory that current user has insufficient
>> privileges to, EACCES is returned. This may still mean the program
>> wasn't found.
>>
>> If the latter case is encountered, git errors out without giving aliases
>> a try,...
>
> Isn't that a *good* thing in general, though, so that the user can
> diagnose the breakage in the $PATH and fix it?

Actually I went through diagnosing and fixing it. After tracking it down,  
I did wonder about this question myself and I didn't come to a definitive  
conclusion on it. On one hand I do agree that it may be an incentive for  
the user to fix his path. On the other hand I found it an obscure one to  
track down; git's behavior doesn't match bash behavior:

$ git config --global alias.aliasedinit init &&
mkdir searchpath && chmod 400 searchpath && PATH=$(pwd)/searchpath:$PATH  
&& export PATH &&
mkdir someproject && cd someproject &&
git aliasedinit
fatal: cannot exec 'git-aliasedinit': Permission denied

$ git-aliasedinit
bash: git-aliasedinit: command not found

This isn't very intuitive to track down an incorrect PATH with, imo. You  
have to dig into git core code, learn about how git handles commands,  
learn about debugging forked processes, and find out that execvp uses  
EACCES for more than just "permission denied" _just_ to find out you've  
got a wrong environment variable lying about. That's a full day of work  
gone for a newbie. If bash would also tell me in natural language that  
permission was denied, I wouldn't even have considered doing this patch.

For my part the root of the problem lies with the use of EACCES by execvp  
here, not so much with how git uses it. For this particular case, EACCES  
doesn't just mean "it exists, but you cannot execute this", it may also  
mean "not found, but one of the paths could not be accessed". If git were  
to provide a really helpful message, we'd have to detect which paths got  
denied. Once we know that, we can even on the spot decide to error out or  
not. In other words, we'd have to figure out which meaning of EACCES is  
actually used. Based on that, git can error out, warn or ignore at will.

In any case, I thought it best to have other developers have a look at it.  
I can put a bit more of that information in the commit message, but I'd be  
just as happy to drop the patch and keep the exercise.

Frans
