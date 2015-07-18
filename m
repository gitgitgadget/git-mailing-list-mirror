From: Gaurav Chhabra <varuag.chhabra@gmail.com>
Subject: Re: Git tag: pre-receive hook issue
Date: Sun, 19 Jul 2015 01:38:28 +0530
Message-ID: <CAGDgvc2F7UMWTVrRFt5eK2xmbfz-kyWh6Vp-eQNEj7tixzRPYQ@mail.gmail.com>
References: <1437159533304-7635764.post@n2.nabble.com>
	<CA+P7+xoXgSHPVhMTm_GZbq+6Pps5yttK2rBZpMycTUFGfqOCvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 22:13:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGYUV-0000Yd-IK
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 22:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090AbbGRUIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 16:08:30 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:34455 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbbGRUIa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 16:08:30 -0400
Received: by wgkl9 with SMTP id l9so104068159wgk.1
        for <git@vger.kernel.org>; Sat, 18 Jul 2015 13:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=E8c7EfF1qgjBpUsoN8fGg3WibvnCLQGuZNIIcIdOglI=;
        b=O28X/VdzPqlvq4vTo7u07kdYTPV/wPMgtj+OhBbeba8rDCkHNb/AVRHEQolgBi8ViE
         +8gOlJnV85FwkjIv5jx5j8tn4yZkGtl/cHdql0+4gQn6WCqAcD+JnXA0gSjUjG4TSHqA
         bfDNQCc4lINR5XYrOX43VQQsxPpusCJ0ZrGT8yvAg0O6GyGkELY3/XGLOp9xKTGCCymi
         PbefTJ4g27xKjKhXwVJI5HxNQrhxZLmCL2AU6Y664q7tj3wG+KzrHBD3FiuXbDf+8lrC
         qReqXEjrJTzrSYeXHDEDMiaRH+RFUs4pjeP3nu1qf3cS9c4zshKaNJyG+nQ337Gcx1ym
         X3fA==
X-Received: by 10.180.210.234 with SMTP id mx10mr7302365wic.42.1437250108506;
 Sat, 18 Jul 2015 13:08:28 -0700 (PDT)
Received: by 10.28.143.1 with HTTP; Sat, 18 Jul 2015 13:08:28 -0700 (PDT)
In-Reply-To: <CA+P7+xoXgSHPVhMTm_GZbq+6Pps5yttK2rBZpMycTUFGfqOCvw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274176>

Thanks for the comments Junio/Jacob! Actually, the script was written
by someone before i came and the tag check was also done by my
colleague recently. I was also trying to implement the tag check
(using refs/tags which i did saw in few links online) but since my
colleague implemented this 'git describe' thing first and it looked
like it was working for few cases that we tried, so we left it as is.
Frankly, since everything 'seemed' to be working well so far, i never
really quite looked into it. Now i guess, it's time to correct it.


@Junio: From the example you gave, i could conclude the following:

1) : gitster garbage/master; git commit --allow-empty -m third
  [master d1f1360] third
  : gitster garbage/master; git describe --exact-match HEAD ;# third
  fatal: no tag exactly matches 'd1f1360b46dfde8c6f341e48ce45d761ed37e357'

> Since after # third commit, no tag was applied to HEAD, so --exact-match resulted in fatal error

2)  : gitster garbage/master; git commit --allow-empty -m second
[master d1de78e] second
: gitster garbage/master; git tag -a -m 'v0.1' v0.1
: gitster garbage/master; git describe --exact-match HEAD^ ;# second
    v0.1
> Since annotated tag was applied after # second commit, so --exact-match did referenced the commit as expected.

3) : gitster garbage/master; git commit --allow-empty -m initial
  [master (root-commit) b18cac2] initial
  : gitster garbage/master; git tag v0.0 ;# lightweight
  : gitster garbage/master; git describe --exact-match HEAD^^ ;# first
  fatal: no tag exactly matches 'b18cac237055d9518f9f92bb4c0a4dac825dce17'

> In this case, it's a lightweight tag and i read today that by default, git describe only shows annotated tags (without --all or --tags). I think it's because of the missing option (--all or --tags) that it resulted in fatal error in this case.

Please correct me if i misunderstood any/all of the above cases.

My queries:
A) When you mentioned: "I am feeding three _commits_, not tags.", i
didn't really get what you're trying to highlight. Is it that the code
i shared 'incorrectly' uses 'git describe' command because it's
passing the commit ($new_sha1) associated with pushing of the tag
_instead_ of passing the commit id that the tag actually points to?

B) Coming to the earlier part of the code that you questioned. Thanks
for that. As i mentioned above, some guy had written it long time back
(few years). And again, since this never caused any issue, we never
looked into it. I did read a little about rev-list today but i think
i'll have to try it out on my machine to understand it well. Will read
more and then implement the check but yes, i do get an idea what
you've tried to question. Basically, for new branch or new
development, we are not really doing complete checks. Correct?

You've also mentioned that "And you check everything on that list.  Why?"
> Was this comment for the portion where the code is validating commits (git rev-list $old_sha1..$new_sha1) for existing branch? If yes, then i didn't really get your concern. Can you kindly elaborate a bit?

And thanks for sharing the modified version! :)


@Jacob: You're right. If i understood correctly what Junio explained,
then what the code is doing really shouldn't make any sense at all. :)

By the way, you mentioned, "Ok, so the issue I believe is this: you're
running git describe on the local side. But the pre-receive hook
hasn't actually accepted the ref yet so git-describe on the server
will fail."
> When i push a tag, then as per the output i shared, the commit id associated with my tag push is ac28ca721e67a. So if i do a "git describe --exact-match ac28ca721e67a", then

1) First of all, it shouldn't make any sense because as "git describe"
should accept _actual_ commit id and not the commit id generated for
tag push, isn't it?

2) If i got the above right, then shouldn't Git throw an error even on
my local machine when i'm running "git describe --exact-match
ac28ca721e67a"?


@Junio/Jacob: I think i've asked quite a number of questions above but
i will really appreciate if you could spare some time to clear these
doubts. I'm definitely going to change this junk code but i would like
to be sure that i've understood your explanations well.


Thanks!

On Sat, Jul 18, 2015 at 9:30 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Fri, Jul 17, 2015 at 11:58 AM, Garbageyard <varuag.chhabra@gmail.com> wrote:
>> We have a pre-receive hook that checks for JIRA ID whenever someone pushes
>> code to Git server. I'm trying to avoid this check when someone is applying
>> a tag. Here's the link for the script: http://pastebin.com/VnMQp5ar
>>
>> This is the link for output: http://pastebin.com/tBGmYaZF
>>
>> Problem is that if i run the following command, the output that i get on
>> command line is 0
>>
>> git describe --exact-match ac28ca721e67adc04078786164939989a5112d98 2>&1 |
>> grep -o fatal | wc -w
>>
>> So i'm wondering why it's not entering the IF block (as confirmed in the
>> output link)
>>
>
> Probably due to environment variables set by the git hook. But.. this
> is definitely not at *ALL* what you want to do. Junio has a good
> explanation below. This doesn't make even any sense at all to me...
>
>> I agree this is a bad implementation (and i will change it soon) for
>> checking tags and can be easily done by just checking whether $refname
>> starts with refs/tags/ but i'll really appreciate if someone could tell me
>> the mistake i'm committing. I've spent few hours banging my head on this.
>>
>>
>>
>
> Ok, so the issue I believe is this:
>
> you're running git describe on the local side. But the pre-receive
> hook hasn't actually accepted the ref yet so git-describe on the
> server will fail.
>
> This is why you should just check refs/tags/* as regular pre-receive
> hook examples do.
>
> Regards,
> Jake
>
>> --
>> View this message in context: http://git.661346.n2.nabble.com/Git-tag-pre-receive-hook-issue-tp7635764.html
>> Sent from the git mailing list archive at Nabble.com.
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
