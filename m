From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Sharing merge conflict resolution between multiple developers
Date: Mon, 11 Aug 2014 18:57:44 -0700
Message-ID: <CAPc5daW1A9OVSBPe-br-x9OeQPqj816NgMKztWMyp6gN==ojHw@mail.gmail.com>
References: <CAFOYHZCiKC4TR4jFVUB=W5qbDG8XvB2Obx1ZfTH8OF3E_c5BnA@mail.gmail.com>
 <xmqqd2c67tok.fsf@gitster.dls.corp.google.com> <CAFOYHZAaF+Dve1DwUUd-k6Nh3+nOZzNVUQAD0quN4crRAjfCLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 03:58:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XH1Lw-0003kq-Bx
	for gcvg-git-2@plane.gmane.org; Tue, 12 Aug 2014 03:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbaHLB6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2014 21:58:07 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:45661 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbaHLB6G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2014 21:58:06 -0400
Received: by mail-la0-f48.google.com with SMTP id gl10so7235109lab.7
        for <git@vger.kernel.org>; Mon, 11 Aug 2014 18:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Nx0m8tTYEP8MzUxeiUrzXxbyF8HhDB7vXV/LYAcE3go=;
        b=q4Zu0ciaLGD+0pRChinQlzSq6+3p4XYwjpZDglNiio/cmVaapfEd1G3i7vL84BWg5a
         m4XeB6Skv4YqA/tRor6xuh/dXUsaSUPrN6i29y+oNh3CAB35vX3YJSb3nvSPYTSZJVza
         ugNr5w+Idlu+fbj0LB/QYUq7PaaAE+LsciuTdIsL7C4L9xpswowxc1mallb9a/lmFzrK
         VcdLRSeUhAJtaJ1cLqHlFk1hjnrYOnVZLbDeZOl9xw0qr+v1tZ+v5WrCidcgNvA1Utr/
         hhw2qguT/gBKk9T5vo3frya04LaysMSJaUnrxuGfRDUKgmrTnyP/sY8mlX2NKjTlXkBe
         cX2w==
X-Received: by 10.112.16.6 with SMTP id b6mr104252lbd.74.1407808684164; Mon,
 11 Aug 2014 18:58:04 -0700 (PDT)
Received: by 10.112.199.74 with HTTP; Mon, 11 Aug 2014 18:57:44 -0700 (PDT)
In-Reply-To: <CAFOYHZAaF+Dve1DwUUd-k6Nh3+nOZzNVUQAD0quN4crRAjfCLQ@mail.gmail.com>
X-Google-Sender-Auth: 1YIaTOR0uAXbH4yqohIzBUMwv-U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255144>

On Mon, Aug 11, 2014 at 4:29 PM, Chris Packham <judge.packham@gmail.com> wrote:

>> So, the "recording" phase may go something like this:
>> ...
>>     git checkout merge-fix/$this-$that
>>     git read-tree -m -u HEAD $this
>>     git commit -a -m 'merge-fix/$this-$that postimage'
>>
>> The rough idea is "git show merge-fix/$this-$that" will show the
>> "patch" you can apply on top of the conflicted state other people
>> would get by running "git merge $that" while on "$this" branch.
>
> So how would someone else pickup that postimage and use it?
>
>   git checkout $this
>   git merge $that
>   git fetch $remote ':/merge-fix/$this-$that postimage'
>   git show ':/merge-fix/$this-$that postimage' | git apply (or patch -p1)

For a simpler case that would work, but because we are not saving
just a patch but two full trees to compare (i.e. merge-fix/$this-$that
is the postimage, its ^1 is the preimage), you should be able to use
the three-way merge in a similar way cherry-pick works. In fact, that
is how rerere replays the recorded resolution, not with a "patch -p1".
