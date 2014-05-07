From: Pasha Bolokhov <pasha.bolokhov@gmail.com>
Subject: Re: Problem: staging of an alternative repository
Date: Wed, 7 May 2014 13:51:57 -0700
Message-ID: <CAKpPgvcvOeneqpidNAbp-8gkS3dpLfMEdTjb-L7o-VSadKHP9A@mail.gmail.com>
References: <CAKpPgveXqraM4bXb499mJm5Ls+EinihfEJ6VgOFikC0_Qp8iTA@mail.gmail.com>
 <20140430213545.GV9218@google.com> <CACsJy8C4bO_ZB-DMOkbJc9cJd_LmR6z0RZ1UZB3wKPEX005xmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 22:52:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi8pF-0005gx-8A
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 22:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbaEGUwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 16:52:20 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:60058 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbaEGUwS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 16:52:18 -0400
Received: by mail-oa0-f45.google.com with SMTP id l6so1978808oag.32
        for <git@vger.kernel.org>; Wed, 07 May 2014 13:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RZgCVEiKrRp1pqpLS+CUewW1BGetYMhcI9nfYo0kGk0=;
        b=lYVjMx/sW5xgL3r7JwnLLfIqxXYAHuqT0QcG73AcEVi6QkSBRS5TCt8BaeA+1u486m
         mn+cymT8BKi7hMWKcYPjj7vrZ4J/KVlYSAET+sQBSnRmbzAZF3rBfP4PM+zX9jpQBjKm
         bnTvXzcTHmOhwKacqdqzX5fONvOIr3A0e0Rwa7WVN1U1oDg067sjJzgVeVqVMdM5RoJt
         ef8oTYwWqCRSYzr7D5ZDdQzoOfAjHo8vIhQO6EUeM9Ye0OaS0pd9Xw0lpb2nMctQLW2w
         RAMVZtuT280tcYDeM4LaG8PDViJs/ZxeGopNdWE7yp9Q4iviQ1QfAWgn1HI//+OM2FA+
         EPEw==
X-Received: by 10.182.78.100 with SMTP id a4mr18980765obx.56.1399495937764;
 Wed, 07 May 2014 13:52:17 -0700 (PDT)
Received: by 10.60.16.8 with HTTP; Wed, 7 May 2014 13:51:57 -0700 (PDT)
In-Reply-To: <CACsJy8C4bO_ZB-DMOkbJc9cJd_LmR6z0RZ1UZB3wKPEX005xmA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248372>

    Hi,

I've looked more attentively, here are my observations and the
resulting suggestions:

- Suggest only to check *string-wise* the given "path" against
$GIT_DIR. Both or one of them may be relative paths (but comparison
best be performed when converted to absolute paths). That's the only
solution which will give predictable results, but does not handle
symlinks: if you have symlinks (so that both differing paths actually
point to the same location) the comparison will return failure. Only
if you have an exact string-wise match do we ignore the "path"

- With this way of comparison, only the root ".git_new" will be
ignored. Submodules will likely contain the usual ".git". Since the
code normally ignores ".git" anyway, and I do not intend to change
that, I don't see how submodule detection can be affected

- The problem of resolving symlinks is in a very general case
insolvable (e.g. imagine one of the symlinks points to another
filesystem which may be up or down depending on the day of week - it's
easy to plot a scenario where symlinks will resolve (or even fail to
resolve) differently at different runs)

- Even if it was solvable, the current implementation of handling
".git" certainly does not check any symlinks:
        $  mv -i   .git   .metadata
        $  ln -s .metadata .git
  Then certainly "git add -A" will grab all ".metadata" and store into itself

  Please let me know what you think. Again, I can try to carefully do
this suggestion

Pavel


On Thu, May 1, 2014 at 11:20 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, May 1, 2014 at 4:35 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>>     Now I know, the '--git-dir' option may usually be meant to use
>>> when the repository is somewhere outside of the work tree, and such a
>>> problem would not arise. And even if it is inside, sure enough, you
>>> can add this '.git_new' to the ignores or excludes. But is this really
>>> what you expect?
>>
>> I think it's more that it never came up.  Excluding the current
>> $GIT_DIR from what "git add" can add (on top of the current rule of
>> excluding all instances of ".git") seems like a sensible change,
>> assuming it can be done without hurting the code too much. ;-)
>
> I think it came up before. Changes could be very messy (but I did not
> check carefully) because right now we just compare $(basename $path)
> with ".git", one path component, simple and easy. Checking against
> $GIT_DIR means all path components. You also have to deal with
> relative and absolute paths and symlinks in some path components. You
> may also need to think if submodule detection code (checking ".git"
> again) is impacted. On top of that, read_directory() code is already
> messy (or at least scary to me) with all kinds of shortcuts we have
> added over the years. A simpler solution may be ignoring all
> directories whose last component is  "$GIT_DIR_NAME" (e.g.
> GIT_DIR_NAME=.git_new).
> --
> Duy
