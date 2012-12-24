From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Find the starting point of a local branch
Date: Mon, 24 Dec 2012 18:21:15 +0700
Message-ID: <CACsJy8DMGrHqgY7himfJA-6f5beZ83Pje+-ex62LQOAARWh=Nw@mail.gmail.com>
References: <20121224035825.GA17203@zuhnb712> <201212240409.qBO49wkV020768@no.baka.org>
 <CACsJy8CNd3W_WUMbZ1QZ4ReZ5ziX90QejK9mh1TMs0ig33kGMw@mail.gmail.com>
 <1356327291-ner-6552@calvin> <CACsJy8DkA-J+ds1eHBqrRyiZrOigORTtxVeEQpZjGHrBR+QjCQ@mail.gmail.com>
 <7vmwx4newy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tomas Carnecky <tomas.carnecky@gmail.com>,
	Seth Robertson <in-gitvger@baka.org>,
	Woody Wu <narkewoody@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 24 12:22:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tn66f-00059D-4U
	for gcvg-git-2@plane.gmane.org; Mon, 24 Dec 2012 12:22:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373Ab2LXLVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2012 06:21:47 -0500
Received: from mail-oa0-f54.google.com ([209.85.219.54]:41128 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156Ab2LXLVq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2012 06:21:46 -0500
Received: by mail-oa0-f54.google.com with SMTP id n9so6657295oag.27
        for <git@vger.kernel.org>; Mon, 24 Dec 2012 03:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5kjqvKhXgMm9YVypISbm13YncYYUby8k7L8WViK07so=;
        b=vegrlnamRSpVLIeN2qpeyucXz4zW2ECMTasJ0rsKI99Q5qof5TjZiO5Z/nDaeYJ3nK
         WZJ2WSGbz789KpUQd8PubH6ZAQO4HNqSPnMngl++EAg/zkxYkuGrk7IjzIIBxnQCWon7
         S022KM83JLfCXWDwK7Wb+x67gsu+mcv8P6vU4lY6h+lXqaI1XfsNWZVB7HOAE+2yR404
         Lu9Ue0ydU0N+IbwhLb0SO1LOWGTIAeG9NF2ofsxUjkoDyvKVuAuhYsXaPzFH6zHHaTFy
         PXCbKpFmxRAYOX03Ck9AQolSfSW4gLEfS0WBtocwASkwqKiWCpue6jHCclXmo8xwaUbN
         Lfmg==
Received: by 10.182.141.103 with SMTP id rn7mr17545953obb.5.1356348105453;
 Mon, 24 Dec 2012 03:21:45 -0800 (PST)
Received: by 10.182.27.168 with HTTP; Mon, 24 Dec 2012 03:21:15 -0800 (PST)
In-Reply-To: <7vmwx4newy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212107>

On Mon, Dec 24, 2012 at 1:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Mon, Dec 24, 2012 at 12:34 PM, Tomas Carnecky
>> <tomas.carnecky@gmail.com> wrote:
>>>> Maybe we should store this information. reflog is a perfect place for
>>>> this, I think. If this information is reliably available, git rebase
>>>> can be told to "rebase my whole branch" instead of my choosing the
>>>> base commit for it.
>>>
>>> What's the starting point of the branch if I type: git branch foo <commit-ish>?
>>
>> You start working off <commit-ish> so I think the starting point would
>> be <commit-ish>.
>
> Yeah, that sounds sensible.  Don't we already have it in the reflog,
> though?

I looked briefly at reflog before writing my previous mail and noticed
that when I create a new branch (usually using "git checkout -b branch
ref") it does not record the base commit.

> What is trickier is when you later transplant it to some other base
> (perhaps prepare a topic on 'master', realize it should better apply
> to 'maint' and move it there).  If the user did the transplanting by
> hand, reflog would probably not have enough information, e.g. after
>
>     $ git checkout maint^0
>     $ git log --oneline master..topic
>     $ git cherry-pick $one_of_the_commit_names_you_see_in_the_above
>     $ git cherry-pick $another_commit_name_you_see_in_the_above
>       ...
>     $ git branch -f topic
>
> no reflog other than HEAD@{} will tell you that you were at maint^0,
> so the reflog of topic wouldn't know it "forked" from there, either.

We could at least invalidate the recorded base in reflog and let user
define a new one (I hope).
-- 
Duy
