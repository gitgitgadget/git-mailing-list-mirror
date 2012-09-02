From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH 9/9] Add git-check-ignores
Date: Sun, 2 Sep 2012 15:50:29 +0100
Message-ID: <CAOkDyE9wPUOwJpeKQ5wSCoufqyqE9zwRuBuNvDGEZ-z8452DwA@mail.gmail.com>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
	<1346544731-938-10-git-send-email-git@adamspiers.org>
	<CACsJy8CLzTddPOCzGhNkOGYjTvEtgWFoD+6DLhAew4Rf1aw5WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 16:50:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8BVW-0007IO-BI
	for gcvg-git-2@plane.gmane.org; Sun, 02 Sep 2012 16:50:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753718Ab2IBOub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Sep 2012 10:50:31 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45397 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441Ab2IBOua (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2012 10:50:30 -0400
Received: by pbbrr13 with SMTP id rr13so7000853pbb.19
        for <git@vger.kernel.org>; Sun, 02 Sep 2012 07:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=k+R1dAQMeq7JUfStB2eZWbtQi+KHVw/0p/Zk85gIe7E=;
        b=VD5PoB+mSwXi47K4DNNmxTo6SXsr7LlAxOnw0ZoMyMcQRuh4U2artffqH9ancavoC2
         ml1M9zfHxZNeIGPLpqLhm2uo1znyiejeNfnoHUaVLui3/yvsFVU5pdjxUu1dGuOSpvjV
         +hqXd9FmYsBHEm3iBAaP0sA9LCj3NyzaldXzivIGgGy083tDAaxHYSoPDeB7g3HqTirC
         Wb8gybk5oKzustX8r3UZBFd8We+hU+ZGr9X21cN1CB7hrdwQ81kwDdUlV5IylnNiGdCD
         mz4cNc98fod54mbz4Prn3dhxO1a2rcVoXs32Xwn5ckc+qcEwc7Bh9m+kb2fwO18ZVonV
         h9gw==
Received: by 10.66.82.103 with SMTP id h7mr27811495pay.61.1346597429884; Sun,
 02 Sep 2012 07:50:29 -0700 (PDT)
Received: by 10.68.134.201 with HTTP; Sun, 2 Sep 2012 07:50:29 -0700 (PDT)
In-Reply-To: <CACsJy8CLzTddPOCzGhNkOGYjTvEtgWFoD+6DLhAew4Rf1aw5WA@mail.gmail.com>
X-Google-Sender-Auth: ZgpKr5Xd7QZk463O7RmaapA5hSI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204666>

Hi there,

Firstly, thanks for the quick feedback!

On Sun, Sep 2, 2012 at 11:41 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Sun, Sep 2, 2012 at 7:12 AM, Adam Spiers <git@adamspiers.org> wrote:
>> This works in a similar manner to git-check-attr.  Some code
>> was reused from add.c by refactoring out into pathspec.c.
>
> Thanks, comments from a quick glance. First of all, can we make it
> work (or share code) with .gitattributes? We may need to debug
> .gitattributes as well as .gitignore. A common command would be nice.

I'm no expert on .gitattributes and check-attr, but AFAICS, all the
opportunities to share code in the plumbing and front-end seem to be
taken already, e.g. the directory traversal and path handling.  The
CLI argument parsing is necessarily different because check-attr
requires a list of attributes as well as a list of files, and of
course the output routines have to be different too.

The only opportunity for code reuse which I saw but /didn't/ take was
around the --stdin line parsing code which is duplicated between:

    check_attr_stdin_paths
    check_ignore_stdin_paths
    cmd_checkout_index
    cmd_update_index
    hash_stdin_paths

I attempted to refactor these, but quickly realised that due to the
lack of proper closures in C, the overheads and complexity incurred by
performing such a refactoring probably outweighed the benefits, so I
gave up on the idea.

Having said that, I'm totally open to suggestions if you can spot
other places where code could be reused :)

>> +SYNOPSIS
>> +--------
>> +[verse]
>> +'git check-ignore' pathname...
>> +'git check-ignore' --stdin [-z] < <list-of-paths>
>
> Also --quiet option, where check-ignore returns 0 if the given path is
> ignored, 1 otherwise?

I considered that, but couldn't think of appropriate behaviour when
multiple paths are given, so in the end I decided to remain consistent
with check-attr, which always returns 0.  But I'm happy to change it
if you can think of a more useful behaviour.  For example we could
have a --count option which produces no output but has an exit status
corresponding to the number of ignored files.

>  - If many paths are given, then perhaps we could print ignored paths
> (no extra info).

How is this different to git ls-files -i -o ?

>  - Going to the next level, we could print path and the the location
> of the final exclude/include rule (file and line number).

That's the current behaviour, and I believe it covers the most common
use case.

>  - For debugging, given one path, we print all the rules that are
> applied to it, which may help understand how/why it goes wrong.

That would be nice, but I'm not sure it's a tremendously common use
case.  Could you think of a scenario in which it would be useful?  I
guess it could be done by adding a new DIR_DEBUG_IGNORED flag to
dir_struct which would make the exclude matcher functions collect all
matching patterns, rather than just returning the first one.  This in
turn would require another field for collecting all matched patterns.

>> @@ -338,6 +338,7 @@ static void handle_internal_command(int argc, const char **argv)
>>                 { "bundle", cmd_bundle, RUN_SETUP_GENTLY },
>>                 { "cat-file", cmd_cat_file, RUN_SETUP },
>>                 { "check-attr", cmd_check_attr, RUN_SETUP },
>> +               { "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
>>                 { "check-ref-format", cmd_check_ref_format },
>>                 { "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
>>                 { "checkout-index", cmd_checkout_index,
>
> I don't think we really need NEED_WORK_TREE here. .gitignore can be
> read from index only.

I thought about that, but in the end I decided it probably didn't make
sense, because none of the exclude matching routines match against the
index - they all match against the working tree and core.excludesfile.
This would also require changing the matching logic to honor the index,
but I didn't see the benefit in doing that, since all operations which
involve excludes (add, status, etc.) relate to a work tree.

But as with all of the above, please don't hesitate to point out if
I've missed something.  You guys are the experts, not me ;-)

Thanks again,
Adam
