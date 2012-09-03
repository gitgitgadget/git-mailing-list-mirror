From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 9/9] Add git-check-ignores
Date: Mon, 3 Sep 2012 11:14:22 +0700
Message-ID: <CACsJy8BO9pOEK4GykTAR94TF7ff3Bkx4db8ifcYVP32FNigmRA@mail.gmail.com>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
 <1346544731-938-10-git-send-email-git@adamspiers.org> <CACsJy8CLzTddPOCzGhNkOGYjTvEtgWFoD+6DLhAew4Rf1aw5WA@mail.gmail.com>
 <CAOkDyE9wPUOwJpeKQ5wSCoufqyqE9zwRuBuNvDGEZ-z8452DwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Mon Sep 03 06:15:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8O4l-0002k3-2N
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 06:15:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731Ab2ICEOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Sep 2012 00:14:54 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:60835 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369Ab2ICEOx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2012 00:14:53 -0400
Received: by ieje11 with SMTP id e11so3156140iej.19
        for <git@vger.kernel.org>; Sun, 02 Sep 2012 21:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OTh8Mem6p6f6/aNcUlPHRoPLTRF05LagBDU0qqqcdZA=;
        b=RVz5M0uYiXCubFpfww13f/mqjoKpoB/SlPKUhe/QhrXTwZYK54B4E2rKi74u2/esWw
         ihtWxQyCNvGVOX2bTpyAIthqaelg5mU47BUMNOtspPt02CHvwLBy/kkd7/psPfDLq74P
         YEV4j25Z+bk8OgJGzFV0Wuao0PEhX88CNWQE6HBT9ZIf28ha4C5Ct9cqpyM3TdGkiU7o
         p8xqUFanWVaf390jjxKPTCMDZOOo2QuLcTn5qBMeLHzL0O16Q1kMgEF9/4wGdDjd0JpS
         Jyj0uXJaron/QqTu1EISzoOPOapJzosooEm6Ums+EzKHLhGjidRjg2NYlrHMPAUF7JOw
         5DGA==
Received: by 10.50.178.97 with SMTP id cx1mr9439783igc.48.1346645692816; Sun,
 02 Sep 2012 21:14:52 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Sun, 2 Sep 2012 21:14:22 -0700 (PDT)
In-Reply-To: <CAOkDyE9wPUOwJpeKQ5wSCoufqyqE9zwRuBuNvDGEZ-z8452DwA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204682>

On Sun, Sep 2, 2012 at 9:50 PM, Adam Spiers <git@adamspiers.org> wrote:
> I'm no expert on .gitattributes and check-attr, but AFAICS, all the
> opportunities to share code in the plumbing and front-end seem to be
> taken already, e.g. the directory traversal and path handling.  The
> CLI argument parsing is necessarily different because check-attr
> requires a list of attributes as well as a list of files, and of
> course the output routines have to be different too.
>
> The only opportunity for code reuse which I saw but /didn't/ take was
> around the --stdin line parsing code which is duplicated between:
>
>     check_attr_stdin_paths
>     check_ignore_stdin_paths
>     cmd_checkout_index
>     cmd_update_index
>     hash_stdin_paths
>
> I attempted to refactor these, but quickly realised that due to the
> lack of proper closures in C, the overheads and complexity incurred by
> performing such a refactoring probably outweighed the benefits, so I
> gave up on the idea.
>
> Having said that, I'm totally open to suggestions if you can spot
> other places where code could be reused :)

Yeah. That was my impression too. I just hoped a new set of eyes might
discover something ;) At lease we could prepare the output format that
can be reused (maybe with little changes) for check-attr debugging if
it comes later. Or make this command part of check-attr..

>> Also --quiet option, where check-ignore returns 0 if the given path is
>> ignored, 1 otherwise?
>
> I considered that, but couldn't think of appropriate behaviour when
> multiple paths are given, so in the end I decided to remain consistent
> with check-attr, which always returns 0.  But I'm happy to change it
> if you can think of a more useful behaviour.  For example we could
> have a --count option which produces no output but has an exit status
> corresponding to the number of ignored files.

We could take this opportunity to kill "add --ignore-missing", which
is basically .gitignore checking and it accepts multiple paths, I
think.

>>  - If many paths are given, then perhaps we could print ignored paths
>> (no extra info).
>
> How is this different to git ls-files -i -o ?

I think ls-files requires real files on working directory, but
check-ignore can deal with just non-existing paths.

>>  - For debugging, given one path, we print all the rules that are
>> applied to it, which may help understand how/why it goes wrong.
>
> That would be nice, but I'm not sure it's a tremendously common use
> case.  Could you think of a scenario in which it would be useful?  I
> guess it could be done by adding a new DIR_DEBUG_IGNORED flag to
> dir_struct which would make the exclude matcher functions collect all
> matching patterns, rather than just returning the first one.  This in
> turn would require another field for collecting all matched patterns.

Mixing include/exclude ignore rules multiple times could be hard to
figure out what goes wrong. But as we haven't seen an actual use case
yet, just leave it out.

>> I don't think we really need NEED_WORK_TREE here. .gitignore can be
>> read from index only.
>
> I thought about that, but in the end I decided it probably didn't make
> sense, because none of the exclude matching routines match against the
> index - they all match against the working tree and core.excludesfile.
> This would also require changing the matching logic to honor the index,
> but I didn't see the benefit in doing that, since all operations which
> involve excludes (add, status, etc.) relate to a work tree.
>
> But as with all of the above, please don't hesitate to point out if
> I've missed something.  You guys are the experts, not me ;-)

Again I was thinking that check-ignore could work with imaginary paths
and could be used by scripts. If a script just wants to check certain
paths are excluded, it should not need to move to working directory
(though it probably is in working directory most of the time).
-- 
Duy
