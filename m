From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] diff --no-index: allow pathspec after --
Date: Sun, 21 Sep 2014 11:08:17 +0700
Message-ID: <CACsJy8CTwk_o7SCFas7q8di_4jZu717znx-44Eg-fxCHZnCTuw@mail.gmail.com>
References: <1410256584-19562-1-git-send-email-pclouds@gmail.com> <xmqqha04o8k7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 06:08:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVYSC-0000fu-M5
	for gcvg-git-2@plane.gmane.org; Sun, 21 Sep 2014 06:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbaIUEIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2014 00:08:49 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:60798 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbaIUEIs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2014 00:08:48 -0400
Received: by mail-ie0-f175.google.com with SMTP id lx4so5743409iec.20
        for <git@vger.kernel.org>; Sat, 20 Sep 2014 21:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FVnL4/Jz0JWxDZbE7EhSazZMzWKP6pJ/V4FOzb5qJso=;
        b=q9ks5QmY8GGD/x11PKMteiV04uR8PH+4Upnu+wbTEW+++4yKh6V0A6BP7iMJLFLbC9
         2gR0v+uPxsw3+HmqcxtEZQyH60i21/315fWS3jnfdzEV/Aqo24ZFrhOqrrtFVJkJvmgt
         DIdhCuZmIykIo8KuZlNXHaXH1hnbDSbxu35sIdFNL1VFR7qs1WnJKfopyFris9pwVy/K
         YiKJBgCj1qqNQ5/n2OnfRo8b+V2tg786hRQLnDhLYujJS3OXcLAca4WpZYDBMXb4OU4j
         FRJJQO5c/y7XrOfiV3vxWZqxD/yFbnvwfBRodWS6sHy5RUZPds3mqW60Fk0qg/VrZ3t5
         dEng==
X-Received: by 10.50.61.145 with SMTP id p17mr6225720igr.41.1411272527531;
 Sat, 20 Sep 2014 21:08:47 -0700 (PDT)
Received: by 10.107.131.150 with HTTP; Sat, 20 Sep 2014 21:08:17 -0700 (PDT)
In-Reply-To: <xmqqha04o8k7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257340>

On Fri, Sep 19, 2014 at 5:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> @@ -194,19 +207,23 @@ void diff_no_index(struct rev_info *revs,
>>               int j;
>>               if (!strcmp(argv[i], "--no-index"))
>>                       i++;
>> -             else if (!strcmp(argv[i], "--"))
>> +             else if (!strcmp(argv[i], "--")) {
>>                       i++;
>> -             else {
>> +                     break;
>> +             } else {
>
> I think this part is a good bugfix regardless of your new feature.
>
> The general command line structure ought to be:
>
>    $ git diff [--no-index] [--<diff options>...] [--] <path> <path>
>
> but the existing code is too loose in that "--" is just ignored.
> The caller in builtin/diff.c makes sure "--no-index" comes before
> "--", the latter of which stops option processing, so it is not so
> grave a bug, though.

Yeah I pack everything in one patch because this is more of a design
question. Will make separate cleanup patches.

> Coming back to the command line syntax for the new feature, if I had
> to choose, I would say
>
>         git diff --no-index [-<options>] [--] <path> <path> <pathspec>
>
> perhaps?  As we never compare anything other than two things, we can
> do the following:
>
>  * Implicit --no-index heuristics will kick in _ONLY_ when we have
>    two things at the end after parsing options in builtin/diff.c, as
>    before;
>
>  * In diff_no_index() after parsing options at its beginning,
>
>   - if we have only two things left, they may be
>
>     . two files;
>     . a file and "-" or "-" and a file; or
>     . two directories (fully traversed without pathspecs)
>
>     just as before.
>
>   - if we have more than two things left, the first two of these
>     _MUST_ be directories, and the remainder is pathspec to filter
>     the result of directory traversal.
>
> Wluldn't that be cleaner and easier to understand?

Looks good.
-- 
Duy
