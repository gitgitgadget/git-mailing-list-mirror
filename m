From: Yurii Shevtsov <ungetch@gmail.com>
Subject: Re: [PATCH/RFC][GSoC] make "git diff --no-index $directory $file"
 DWIM better.
Date: Mon, 16 Mar 2015 19:47:27 +0200
Message-ID: <CAHLaBN+FZ5LLwU-6VnFoPva=omtPpCEPzmdvY_3H43dag8kqxg@mail.gmail.com>
References: <CAHLaBN+93mp6PQmtfjOHSvfW7iwDXwPitGQ5W1am9KBm9EZV2Q@mail.gmail.com>
	<vpq1tkq5fsw.fsf@anie.imag.fr>
	<xmqqr3spsir2.fsf@gitster.dls.corp.google.com>
	<CAHLaBNJxRx9jkNHCM+djq7KEZBV2n5PFZN0-UUtzhO=ikR+Kuw@mail.gmail.com>
	<xmqq61a0sw48.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 18:47:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXZ6z-0007yS-EE
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 18:47:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757126AbbCPRr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 13:47:29 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34979 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756950AbbCPRr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 13:47:28 -0400
Received: by oiag65 with SMTP id g65so44493421oia.2
        for <git@vger.kernel.org>; Mon, 16 Mar 2015 10:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QtTrw9YYRyneV46aXjo2RQbXmkJc/I/wgzBwlRwSJqM=;
        b=AghT+JrrX6/pvoLZkRw9E66TnfD7QF0/RhxbpBk/cmK5ck+8ulA1CNJW/7aDGrobmg
         25/86tBUtiPdh2F18NmXLdjCrtV0nKA7A2d7WUDz56Aqv0r2vVu/44GfO51M9dxIf0Dc
         RqbzM8fritJmNCaYMaX66GJwmN65H6rQcM50G01h+2FMB9o6BYKVvoxdqrzk4YCOj/VO
         RDFgxdFIDC/16f48yNyfnCi4u9dQ7STmN1H3anqNnx6OC3SAhz/fE9kMYodQPbH/36kl
         FkpSma3h2YLJQGV7lRB+2R07AhLNYzzWP4Lkv7ZvPgQRcBESMHoxUIakMVA9H+YUZ1D/
         ZLBw==
X-Received: by 10.202.87.215 with SMTP id l206mr24202658oib.84.1426528047440;
 Mon, 16 Mar 2015 10:47:27 -0700 (PDT)
Received: by 10.76.10.170 with HTTP; Mon, 16 Mar 2015 10:47:27 -0700 (PDT)
In-Reply-To: <xmqq61a0sw48.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265581>

Yes, I have red what you wrote several times and tried your example.
I'm really sorry if I sound like I just ignored it. I just got a
little bit lost about which procedure needs patching. You're
absolutely right, queue_diff() is wrong place for it. So do you agree
that "append the name of the file at the end of the directory" logic
should be put to diff_no_index() which will also include calling
get_mode() for each path[] member? Sorry again for asking so much
questions

2015-03-16 19:14 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> Yurii Shevtsov <ungetch@gmail.com> writes:
>
>>> ...  As it stands now, even before we think about dwimming
>>> "diff D/ F" into "diff D/F F", a simple formulation like this will
>>> error out.
>>>
>>>     $ mkdir -p a/sub b
>>>     $ touch a/file b/file b/sub a/sub/file
>>>     $ git diff --no-index a b
>>>     error: file/directory conflict: a/sub, b/sub
>>>
>>> Admittedly, that is how ordinary "diff -r" works, but I am not sure
>>> if we want to emulate that aspect of GNU diff.  If the old tree a
>>> has a directory 'sub' with 'file' under it (i.e. a/sub/file) where
>>> the new tree has a file at 'sub', then the recursive diff can show
>>> the removal of sub/file and creation of sub, no?  That is what we
>>> show for normal "git diff".
>>>
>>> But I _think_ fixing that is way outside the scope of GSoC Micro.
>>
>> So you want me to convert args ("diff D/ F" into "diff D/F F") before
>> calling queue_diff()? But why?
>
> Because it is wrong to do this inside queue_diff()?
>
> Have you actually read what I wrote, tried the above sample
> scenario, and thought what is happening in the codepath?
>
> When the user asks to compare directory a/ and b/, the top-level
> diff_no_index() would have paths[0]=="a" and paths[1]=="b", and
> queue_diff() is called with these in name1 and name2.  Once it
> learns that both of these are directories, it _recurses_ into itself
> by appending the paths in these directories after these two names.
> It finds that both of these directories have "sub" underneath, so it
> makes a recursive call to itself to compare "a/sub" and "b/sub".
>
> That call would notice that one is a directory and the other is
> not.  That is where you are getting the "f/d conflict" error.
>
> At that point, do you think it is sensible to rewrite that recursed
> part of the diff into a comparison between "a/sub/sub" (which does
> not exist, and which the user did not mean to compare with b/sub)
> and "b/sub" (which is a file)?  I hope not.
>
>> queue_diff() already check args' types and decides which
>> comparison to do.
>
> Yes, and I already hinted that that is an independent issue we may
> want to fix, which I suspect is larger than GSoC Micro.  Also the
> fix would be different.  Right now, it checks the types of paths and
> then refuses to compare a directory and a file.  If we wanted to
> change it to closer to what the rest of Git does, we would want it
> to report that the directory and everything under it are removed and
> then a new file is created (if the directory is on the left hand
> side of the comparision and the file is on the right hand side) or
> the other way around.  That will not involve "append the name of the
> file at the end of the directory".
>
> In short, "append the name of the file at the end of the directory"
> logic has no place to live inside queue_diff() which handles the
> recursion part of the operation.
