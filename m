From: Breck Yunits <breck7@gmail.com>
Subject: Re: Specifying a private key when connecting to a remote SSH repo
Date: Thu, 12 Sep 2013 10:48:31 -0700
Message-ID: <CAOgHBysgqX7cDxuJ_TWL_RFtty60O6gb7LBEvSAfR33HWoAC-w@mail.gmail.com>
References: <CAOgHByvTtNDho50B+pECMeXkq=3FF8EheFbP4iQbKYTiAPTwYw@mail.gmail.com>
	<xmqqeh8ur6uc.fsf@gitster.dls.corp.google.com>
	<20130912051913.GA1977@sigill.intra.peff.net>
	<xmqq1u4uqc3q.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 19:49:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKB0g-0002JN-4O
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 19:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754942Ab3ILRsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 13:48:33 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:40851 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662Ab3ILRsb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 13:48:31 -0400
Received: by mail-ie0-f173.google.com with SMTP id ar20so300805iec.4
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 10:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1gikN91on8Wzl6uTFgXwJswgUUoDQ7cFVGeEq42Lzco=;
        b=W3NaVwdd86A+yGajNdgE3dwEQnYdL0FpcmZq1khXz5LFlB6Pbda5LJpjQJ50dlvtF4
         X3iCIfGSYBM7G2gqitX17EwGhXBBKwO4G9EkcBdvWET139e8IF29zmhIZSZq8hkyKVYm
         PO9MwFpbwsAq7JlkLuvjU4YujZcYP/fsW2337igzftEKF9cUlBHV1YJpG6VECW71zlQi
         GLp09n1evssEvhofq4VEEfURE7hOpMyEcdBpUPhyNoL6ZPsovPfdc5KjfAw10E5dSo5N
         L4QVL6VoIHGOps8IWic4xmmmfoFZ9Hy4mnvAM9lxAMTMMoI77eYEEpXcpswJf4ybvxSu
         tPWQ==
X-Received: by 10.50.138.165 with SMTP id qr5mr2106861igb.25.1379008111531;
 Thu, 12 Sep 2013 10:48:31 -0700 (PDT)
Received: by 10.50.57.229 with HTTP; Thu, 12 Sep 2013 10:48:31 -0700 (PDT)
In-Reply-To: <xmqq1u4uqc3q.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234664>

Thanks very much for the feedback and implementation suggestions.

> If the only thing you are interested in supporting is a one-shot
> invocation, i.e. giving which identity file to use from the command
> line when you run either "git push" or "git fetch",

Yes, this is the new option that could benefit the most people.

I think this workflow would be very fast and make it very easy to have
1 key per project right where you need it:

```
mkdir project
cd project
ssh-keygen -t rsa -N "" -f deploy.key
git init
echo "deploy.key*" > .gitignore
echo "Hello world" > readme.md
git add .
git commit -m "Initial commit"
git remote add origin git@github.com:breck7/project.git
git push -u origin master -ssh "-i deploy.key"
```

This probably wouldn't be the option used most frequently, but could
be a neat option to have for both power users and new users.

For power users, I could see this being useful if you have many
projects that all have different keys.

For new users, I could see this is as a quick way to "get out of
trouble" if you are running into ssh problems.

-Breck


On Thu, Sep 12, 2013 at 8:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> We already have GIT_SSH, so I would expect:
>>
>>   GIT_SSH='ssh -i $HOME/.ssh/id_for_example_com' git push
>>
>> to work. But sadly, GIT_SSH does not use the shell, unlike most other
>> configure git commands. :(
>
> You read me correctly ;-)
>
>> We could consider it a consistency bug and fix it, though I suspect we
>> may be annoying people on Windows who have spaces in their paths.
>
> Again, you read me correctly ;-)
>
>> You could write a credential helper shell script that knows about
>> classes of remotes (e.g., selecting an identity file based on the
>> hostname), and write only a few lines to cover a large number of hosts.
>
> Yes, but the same trick can be used in $HOME/.ssh/config to let one
> entry cover the same large number of hosts, so...
>
>> For example:
>>
>>   #!/bin/sh
>>   test "$1" = "get" || exit 0
>>   while IFS== read key val; do
>>     test "$key" = "host" || continue
>>     case "$val" in
>>       *.example.com) echo sshident=com_key ;;
>>       *.example.net) echo sshident=net_key ;;
>>     esac
>>   done
>>
>> But it feels a bit hacky to be using the credential helpers at all for
>> ssh connections.
>
> Yeah, perhaps.
