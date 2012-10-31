From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 4/4] fast-export: make sure refs are updated properly
Date: Wed, 31 Oct 2012 03:13:20 +0100
Message-ID: <CAMP44s26chrdESPmQGRYBN4dy-C-fGjbgWbR7fBs71bViRYa-w@mail.gmail.com>
References: <1351623987-21012-1-git-send-email-felipe.contreras@gmail.com>
	<1351623987-21012-5-git-send-email-felipe.contreras@gmail.com>
	<20121031003721.GV15167@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 03:13:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTNoF-0003iV-7V
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 03:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933101Ab2JaCNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 22:13:22 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:49129 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932069Ab2JaCNW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 22:13:22 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so973710oag.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 19:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NFx1ZQaxLplxMqpqlQ260KCHYLk1BJyqVlJPXdfgTc0=;
        b=x81v7GSQx8A680eczWe1dVw4AinvafGTwELq34gDhiBLQV/VK8m2HcfPk+iMW1qwyw
         q4TUvFSXODBqF6IFWJRV1Fq2POyBcoCsgEv0XnFGRbpSmCvAAdhQn1r65MBgQMCyjP/3
         lHEnB2p1NLLUcwzQxZ4bMa6/kS8h0dV7bNfNmPkodC2m0Fbf8T72iN5CUkLriTYyn8HJ
         VIctdF3HOY6NdvMRwzce8VqKRUiLuwVdDLE2cgtWq9+ycMB+INg8dO+sFLQTct3u2AbF
         p3H7NJX0DreZgaQ/qxzqTVrGoRtA4qphYNRui59Py+vAlZqsQPrw2WxP//FNBrGoOT1L
         cR4w==
Received: by 10.60.1.164 with SMTP id 4mr13145434oen.96.1351649600502; Tue, 30
 Oct 2012 19:13:20 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Tue, 30 Oct 2012 19:13:20 -0700 (PDT)
In-Reply-To: <20121031003721.GV15167@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208785>

On Wed, Oct 31, 2012 at 1:37 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Felipe Contreras wrote:
>
>> --- a/builtin/fast-export.c
>> +++ b/builtin/fast-export.c
>> @@ -523,11 +523,16 @@ static void get_tags_and_duplicates(struct object_array *pending,
>>                               typename(e->item->type));
>>                       continue;
>>               }
>> -             if (commit->util) {
>> -                     /* more than one name for the same object */
>> +
>> +             /*
>> +              * This ref will not be updated through a commit, lets make
>> +              * sure it gets properly upddated eventually.
>> +              */
>> +             if (commit->util || commit->object.flags & SHOWN) {
>>                       if (!(commit->object.flags & UNINTERESTING))
>>                               string_list_append(extra_refs, full_name)->util = commit;
>> -             } else
>> +             }
>> +             if (!commit->util)
>>                       commit->util = full_name;
>
> Here's an explanation of why the above makes sense to me.
>
> get_tags_and_duplicates() gets called after the marks import and
> before the revision walk.  It walks through the revs from the
> commandline and for each one:
>
>  - peels it to a refname, and then to a commit
>  - stores the refname so fast-export knows what arg to pass to
>    the "commit" command during the revision walk
>  - if it already had a refname stored, instead adds the
>    (refname, commit) pair to the extra_refs list, so fast-export
>    knows to add a "reset" command later.
>
> If the commit already has the SHOWN flag set because it was pointed to
> by a mark, it is not going to come up in the revision walk, so it will
> not be mentioned in the output stream unless it is added to
> extra_refs.  That's what this patch does.

That is correct.

> Incidentally, the change from "else" to "if (!commit->util)" is
> unnecessary because if a commit is already SHOWN then it will not be
> encountered in the revision walk so commit->util does not need to be
> set.

Maybe, but that's yet another change, and with more changes come more
possibilities of regressions. I haven't verified this is the case.

If this makes sense, I would do it in another, separate patch.

> If the commit does not have the SHOWN or UNINTERESTING flag set but it
> is going to get the UNINTERESTING flag set during the walk because of
> a negative commit listed on the command line, this patch won't help.

I don't know what that means in practice.

Cheers.

-- 
Felipe Contreras
