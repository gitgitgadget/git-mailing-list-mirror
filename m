From: Lewis Diamond <me@lewisdiamond.com>
Subject: Re: The fetch command should "always" honor remote.<name>.fetch
Date: Mon, 7 Apr 2014 14:46:04 -0400
Message-ID: <CAHwd=G=zV97H7eEK5dJ0XrfbF0bpZD6-YOvk0O8nVuqMGSz=jw@mail.gmail.com>
References: <5340871D.8070503@lewisdiamond.com>
	<xmqqioqlm21y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Lewis Diamond <git@lewisdiamond.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 20:46:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXEYe-0004sR-Mm
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 20:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755566AbaDGSqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 14:46:07 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:65048 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190AbaDGSqF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 14:46:05 -0400
Received: by mail-qg0-f46.google.com with SMTP id j107so1847391qga.19
        for <git@vger.kernel.org>; Mon, 07 Apr 2014 11:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=wGjAW0YLAvw0wrAVV9sdBx13O7onrOzVj2tycQuAz84=;
        b=X8Qk92H7k0Xv8AglPAW3gyQ5mKNe+Nm0f5QcMsGI55nlE+kg8s2hBbzbQJ600ZR/dR
         KxNlJDoPF+peZqeWF6nJ9nyNTSV5y8+5rRKpxBUm5k74ceVq5QMEiuHIQPyYNK/+dsij
         nrdQr+4FFfCfZ5eswUwkJ34hXYTESS1LYLjNDQnQnGAUk+7TSw2/Wt5V8ywbW87gQ26x
         svXpyqE6nhZMlOg6MuhYaLt4+KFHJ7VxJkq3vImOUWFDY18Vp5NSbBI6/nqFkB5GV4QM
         LOL39T6E9Y8tLQjQvXfA6Q/ETtnUp6q2xSG1ubMtCEXTaaf17hQw7gMh4ZWN73L/E8t6
         bDjw==
X-Gm-Message-State: ALoCoQl2X46Mw5sDWqt1YnjFEo9jurIXYqMT25ANtXcKG9mv98rxKzMLmHcdCWnlRo7k+FD0GAvr
X-Received: by 10.224.137.5 with SMTP id u5mr36720176qat.12.1396896364284;
 Mon, 07 Apr 2014 11:46:04 -0700 (PDT)
Received: by 10.140.38.166 with HTTP; Mon, 7 Apr 2014 11:46:04 -0700 (PDT)
X-Originating-IP: [216.251.112.134]
In-Reply-To: <xmqqioqlm21y.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245886>

On Mon, Apr 7, 2014 at 2:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Lewis Diamond <git@lewisdiamond.com> writes:
>
>> 'git fetch foo develop' would result in:
>> fatal: Couldn't find remote ref test2 //Not OK, (case 1)
>
> I have no idea where the "test2" comes from, as it does not appear
> anywhere in the above write-up, and it could be a bug.
>

Sorry, "test2" was a local test to copy the error message. It should read "foo".

>> 'git fetch foo master' would result in (FETCH_HEAD omitted):
>> [new ref] refs/heads/master -> foo/master //OK, but missing another
>> ref! (case 2)
>> //It should also fetch refs/users/bob/heads/master -> foo/bob/master
>
> This is an incorrect expectation.

Indeed this is the "correct" behaviour since it works as designed.
However, this behaviour is inconsistent with the push command. An
expectation is never "incorrect" as we are talking about intuitive vs
non-intuitive.

>
> The user who gave the command line said only "master", and did not
> want to grab "users/bob/heads/master".  If the user wanted to get it
> as well, the command line would have said so, e.g.
>
>         git fetch there master users/bob/heads/master
>

Actually, the user specifically configured the remote to fetch
refs/users/bob/heads/*, meaning "those are the branches I'm interested
in".

>> If you remove this configuration line: fetch =
>> +refs/heads/*:refs/remotes/foo/*
>> Then you run 'git fetch foo master', this would result in:
>>  * branch master -> FETCH_HEAD //Debatable whether this is OK or not,
>> but it's definitely missing bob's master! (case 3)
>
> Likewise.
>
> The 'master' short-hand is designed not to match refs/users/any/thing.
>

Sure, this shorthand is designed to match refs listed in the rev parse
rules list. However, a quick survey showed me that most people would
expect their configuration to be honoured when using the shorthand for
fetching (like it is for push). This thread is about improving the
fetch command so that the short-hand works in such cases (and make it
consistent with what push does).
