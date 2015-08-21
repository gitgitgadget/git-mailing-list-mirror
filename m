From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Which branch(es) contain certain commits? (was Re: (unknown))
Date: Fri, 21 Aug 2015 15:39:46 -0700
Message-ID: <xmqqio88466l.fsf@gitster.dls.corp.google.com>
References: <349031438778845@web22j.yandex.ru>
	<CACsJy8Be-kY49CxAJTx2R2XG-c_WeuU=yLFT8-XSoaDkTScPGg@mail.gmail.com>
	<xmqqh9nxerfv.fsf@gitster.dls.corp.google.com>
	<5570041440192599@web21j.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ivan Chernyavsky <camposer@yandex.ru>
X-From: git-owner@vger.kernel.org Sat Aug 22 00:40:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSuye-0002Zc-Tm
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 00:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbbHUWjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 18:39:49 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34809 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbbHUWjs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 18:39:48 -0400
Received: by padfo6 with SMTP id fo6so15914781pad.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 15:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=85mPwbR7TQlbRl/R7aN0odRHGTegz12/tZ10R+7yc4I=;
        b=TUDTjWI3XiMrSgLmbLwLqZzh9GG4KyB7IEdhKRfacn5TbPLIS9VVcL3YVsfgDfFNXS
         4pp1zgDyOVeL7OgJ7yjLuXLd2HLxp4oT2Znx0dfobYDShIVLbR/ZYbF9Ozhm7TwWhke5
         /D07pp/4Ex2XYbH9fTLvikN6fSGS/CGCF7I8z9uooqRcMbOuWLjM4XSHNhn+ZElHOXKe
         KQPaiRnoa7NiUVSsGQmDZH0BNXR0pfOfhF0T6PcOXsD8RlNWhECyFs8IuR+eeb7esM8M
         dwjcuJhoLTn/dS3Qk934dGdXM7/SVPcVfL9i6hSUoXJywW6InwAyCJuNrJGUnPFsULDA
         jXIA==
X-Received: by 10.66.175.7 with SMTP id bw7mr21960495pac.155.1440196788181;
        Fri, 21 Aug 2015 15:39:48 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c7d:6904:6af7:82e1])
        by smtp.gmail.com with ESMTPSA id s17sm8981603pdl.2.2015.08.21.15.39.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 21 Aug 2015 15:39:47 -0700 (PDT)
In-Reply-To: <5570041440192599@web21j.yandex.ru> (Ivan Chernyavsky's message
	of "Sat, 22 Aug 2015 00:29:59 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276339>

Ivan Chernyavsky <camposer@yandex.ru> writes:

> But now I had a look on the source and I can see that builtin/branch.c
> builds the list of references and prints them in a single place
> (print_ref_list()) so I will have to split that function into two in
> order to reuse existing functionality.
>
> Another problem is that builtin/branch.c currently does not use
> setup_revisions(), so I'll have to hook it there as well.
>
> Then, I assume, I'll need to use the initial ref_list (filled the same
> as for the current "list" case) to configure the rev_info structure
> after setup_revisions(), and start revision traversal.
>
> I'm not sure I've got it all right from the source in those few days,
> so I apologize in advance if it's stupid in some part or as a whole.

Heh, you say "problem" above, but I do not think it is a "problem"
per-se.  If you want to teach branch some preprocessing based on the
revision traversal API, you naturally need to call setup_revisions().

The outlined steps above all feel sensible; one thing you did not
mention is that you may probably have to clear object flags after
you are done with the initial "--grep" revision traversal, as some
features of branch may want to use the object flags (e.g. --merged
would use in_merge_bases()).  Other than that, all of it sounds
easily implementable.

Note that "branch --list", "tag --list" and "for-each-ref" are being
revamped to share more internal code.  If you want to pursue this,
you probably would want to build on top of that effort once it is
done.  That way, you may get "tag --grep=FIX123" for free.

> That said, do you think the goal is worth such changes?

That is a dangerous question.  As Duy already said,

> Probably because nobody is interested and steps up to do it. The lack
> of response to you mail is a sign.

apparently not many people thought it is worth; otherwise we would
already have such a feature.

If you are asking me personally, I'm sorry but I have to say no.

The reason why I personally do not think your "branch --grep=FIX123"
would be very useful to me is because I would imagine that I would
be interested in learning the exact commit that mentions FIX123 as
well as which branches contain it, if I had a need for such a
feature.

That is, it would inherently be two step process for me anyway, i.e.

 (1) I'd run "log -p --grep" to find which commits are about FIX123
     and check that what they did indeed make sense; and

 (2) I'd then run "branch --contains" to learn which ones are
     already up to date with respect to the fix.

Your "branch --grep=FIX123" that only tells me the names of branches
would have no use in that workflow, as it would not even give me an
indication that the request --grep=FIX123 found the right commit in
the first place.
