From: Stefan Beller <sbeller@google.com>
Subject: Re: deadlock git upload-pack command when GIT_TRACE is enabled
Date: Mon, 9 May 2016 10:53:41 -0700
Message-ID: <CAGZ79kbhbLZpXe+Af+6PXioM-0xLz7S02=KAUavfuUSL6xM+jw@mail.gmail.com>
References: <CAJNyVBAr7dJFxXA2+dXCJUMs=mB9u3-Ja7r4wemk9C_HBZ3W2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Eugene Petrenko <eugene.petrenko@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 09 19:53:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azpNL-0005n4-DG
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 19:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbcEIRxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 13:53:43 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:35440 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbcEIRxn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 13:53:43 -0400
Received: by mail-io0-f181.google.com with SMTP id d62so180103199iof.2
        for <git@vger.kernel.org>; Mon, 09 May 2016 10:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=H+ORgZbppARYUuutwCXWExM3i5QgR8B3KRYo4JJVst4=;
        b=Dk9fbKjw7T9Vrnn+EzENZKLAMGpBXfgY1gfrLZaY2CwuxRzjbyzQYSr0Y56OAfgpFx
         Zr2VFUOBO4A42jEMLCg3YbQmrWQhwNnCiomtPALSgXiCXNA1YF92jnJ8f0CMO1+aehyf
         Jg7BkDd1+v03N07wOsr4UulKnRjRVgCYWlOrSLKjS+zC5pS9py1vCh1nAg6Lg3xvmqq6
         gYhJLJrRpww2E3FzeaRtid9k/gVcxmXhAUfJp/HmvjLbTkbxJpAZZwk9HVyy8uRTdtVd
         X530/MdlqAM/9uB3l+JurxHM98JlVjqHuDDY94O276JZa17I/JAvT6ykR9cvzkNoJHES
         PwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=H+ORgZbppARYUuutwCXWExM3i5QgR8B3KRYo4JJVst4=;
        b=WfC4xygEc/1mFN4W0hwz41oXSEfH6jAXpvTCm1XV0F8nB1YM4xJu9+toneINLjc+sM
         tQYXEAfJYxl8INynT8F5/TZaqu4F2d5Hl7cmGV5w/IRqRPfgO7WLTG3BDgtPyBFCdbQw
         colDnFBgqlzIzw3SM+TcDfUKumqcnrIKVXP7PJS6i81J6mW8hwJcuzPxl8hTw9xzzVzg
         CrxgPTMcd8WCLvxEWfh16QCbL9g0afKO1WhrDboDQXrIbdvW1g5hZu96G6rM2jFQFqeG
         t48/f/b97lVO0THBzU3FERajkOTKtmsyA7Ja0wOC+sAqx1b4rtjtA+R7rEdEG2nDhtWn
         kUNA==
X-Gm-Message-State: AOPr4FWpxqtBAFBP8I4Olu+Ay3U0kKd8Jp/zjkkH900kr5kRcTZzvrmnxOos79EQPprYn7ONttPItjU2lCQbrqSR
X-Received: by 10.107.53.204 with SMTP id k73mr38025491ioo.174.1462816421867;
 Mon, 09 May 2016 10:53:41 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 9 May 2016 10:53:41 -0700 (PDT)
In-Reply-To: <CAJNyVBAr7dJFxXA2+dXCJUMs=mB9u3-Ja7r4wemk9C_HBZ3W2A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294030>

On Mon, May 9, 2016 at 10:49 AM, Eugene Petrenko
<eugene.petrenko@gmail.com> wrote:
> Hello,
>
> I stuck around the deadlock inside git when running git upload-pack .
> command. A debugging shown that the bottom process (it starts several
> processes to implement the task) hangs writing to stderr. I managed to
> reproduce the issue with a tiny bash script. The repository and the
> script is found here
> https://github.com/jonnyzzz/git-upload-pack-deadlock
>
> I saw the issue reproducing both under Windows and Linux/Mac.

GIT_TRACE=true GIT_TRACE_PACKET=true GIT_TRACE_PACK_ACCESS=true

What do you mean by true?


           If this variable is set to "1", "2" or "true" (comparison
is case insensitive), trace messages will be printed to stderr.

           If the variable is set to an integer value greater than 2
and lower than 10 (strictly) then Git will interpret this value as an
open file descriptor and will try to write the trace
           messages into this file descriptor.

           Alternatively, if the variable is set to an absolute path
(starting with a / character), Git will interpret this as a file path
and will try to write the trace messages into it.

           Unsetting the variable, or setting it to empty, "0" or
"false" (case insensitive) disables trace messages.

>
> Windows thread dumps are available here
> https://github.com/jonnyzzz/git-upload-pack-deadlock/tree/master/debug
>
>
> According to those thread dumps I see the following problem around
> upload-pack.c line 129. There the pack_objects command is executed.
> First the wants block is pushed to the command, next the stdout
> processing is started. This means, that pack_objects process output is
> not processed until all output is put there. In the case I have, the
> pack_objects process writes TRACE logging into stderr and eventually
> (on hug repo) the OS buffer runs-out deadlocking the execution.
>
>
> Best regards,
> Eugene Petrenko
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
