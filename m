From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] trace: add GIT_TRACE_STDIN
Date: Wed, 17 Jun 2015 17:04:04 +0700
Message-ID: <CACsJy8DaJOOu7PA8jL+Mu3HQua-TRmzN378Mek1HuWVmRzT+ww@mail.gmail.com>
References: <20150616193102.GA15856@peff.net> <20150616193716.GC15931@peff.net>
 <20150616194907.GA15988@peff.net> <20150616212039.GA11353@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Augie Fackler <augie@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 17 12:04:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5AD2-00042O-RE
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 12:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300AbbFQKEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 06:04:36 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:33915 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544AbbFQKEf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 06:04:35 -0400
Received: by iebmu5 with SMTP id mu5so30362337ieb.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 03:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6IOh3/ZUlr4nkkL91/LCJJ3SbGd3xehSv+8yWSn5YxY=;
        b=NR/d0Fu9oMZ4F6rWDYRq8yePDpI//gmJQ7t0UKsODk4G0Rd4+WMpvwEGxdIXWNR3zl
         MGjfhy3Cr4gqC5ORUJA+aCQT8zN+bqDhDzzjGDBiKi0yTdMHgD7GKC69O+7dHSY+r9bN
         yEraPG1o7ktnSLDK12C9nuUYX2x9w3un1QiY6+tZkgnPxgqrQsmJU9oO/prNK/Yy/T9N
         dr3f6sTv4wakBfbUp1+bTnCjvidhbEid/H57yHI8M3cCtda+mPwh0q5C/zdVKgA9+/Hp
         EH7jAVcGAcNJQicu6pB2QZ9rGOLx+DL4b7/rGwMjrdSLFO1kg8o3+QNmRZqFxEPi6WhD
         k3YQ==
X-Received: by 10.50.138.136 with SMTP id qq8mr34191168igb.27.1434535475155;
 Wed, 17 Jun 2015 03:04:35 -0700 (PDT)
Received: by 10.107.6.226 with HTTP; Wed, 17 Jun 2015 03:04:04 -0700 (PDT)
In-Reply-To: <20150616212039.GA11353@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271825>

On Wed, Jun 17, 2015 at 4:20 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 16, 2015 at 03:49:07PM -0400, Jeff King wrote:
>
>> Another option would be to stop trying to intercept stdin in git.c, and
>> instead make this a feature of run-command.c. That is, right before we
>> exec a process, tee its stdin there. That means that you cannot do:
>>
>>   GIT_TRACE_STDIN=/tmp/foo.out git foo
>>
>> to collect the stdin of foo. But that is not really an interesting case
>> anyway. You can run "tee" yourself if you want. The interesting cases
>> are the ones where git is spawning a sub-process, and you want to
>> intercept the data moving between the git processes.
>
> Hmm. I guess we do not actually have to move the stdin interception
> there. We can just move the config-checking there, like the patch below.
>
> It basically just converts trace.foo.bar into GIT_TRACE_BAR when we are
> running "foo" as a git command.  This does work, but is perhaps
> potentially confusing to the user, because it only kicks in when _git_
> runs "foo". IOW, this works:
>
>   git config trace.upload-pack.foo /path/to/foo.out
>   git daemon

I wonder if we could do it a bit differently. Instead of
GIT_TRACE_STDIN, I would add GIT_TRACE_HOOK that points to a script.
Whenever a command is run via run-command interface, the actual
command line to be executed would be "<hook script> <command>
<arguments>".

Because this script is given full command line, it can decide to trace
something if the command name is matched (or arguments are matched) or
just execute the original command. It's more flexible that trace.*
config keys. We also have an opportunity to replace builtin commands,
like pack-objects, in command pipeline in fetch or push with something
else, to inject errors or whatever. It can be done manually, but it's
not easy or convenient.
-- 
Duy
