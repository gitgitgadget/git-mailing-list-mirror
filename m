From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 08/19] fsck: Make fsck_commit() warn-friendly
Date: Fri, 19 Jun 2015 16:43:38 -0700
Message-ID: <xmqqfv5n5knp.fsf@gitster.dls.corp.google.com>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
	<cover.1434720655.git.johannes.schindelin@gmx.de>
	<1ce6b2b32cb94d9697056d1181bb1fe396c64a5b.1434720655.git.johannes.schindelin@gmx.de>
	<xmqqmvzv78z9.fsf@gitster.dls.corp.google.com>
	<ba0cb32edf26639a8a00ad9d17b49e32@www.dscho.org>
	<xmqqk2uz5s6b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 20 01:43:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z65wn-0003TR-Tk
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jun 2015 01:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837AbbFSXnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 19:43:41 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33677 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060AbbFSXnk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 19:43:40 -0400
Received: by igbqq3 with SMTP id qq3so27269078igb.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 16:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=CeBsV+OHdti39rm2Pmr8CSQkA26j0Xh2uXMPbtdt7xE=;
        b=ozkFqZf+GDOB9JICq9sQ8xlftNjDEyF2anhI5xbm73S3OtekQm1Mw1lFizoXRjt2qI
         XUKHlvGIAab8ksRMAdA88ljdQCXOlaLPBa9gPj/G1qrQz0r0V4LcBeQUGTALXOkNP8tE
         zoWQHsyZVB3hJwPmiMr1NjaOg3Z8MnrGwxy4TnzfDRWdYdyD61uvlW6qv5/rkNTWnnVK
         DIez0ok0LNsBbhXKUEDFUCGDV5KXZ7t2FPUVYwoqL5XOzZT/Sff/DUVvY2qoUAtIohhx
         Mbq3jjwkvsmr1VuI+JtX8tJqQvpkSqMPBQIhysd2HwpMXhaqVMIWjXkVle8jq8NabFkQ
         7k/w==
X-Received: by 10.107.47.26 with SMTP id j26mr25973606ioo.17.1434757419941;
        Fri, 19 Jun 2015 16:43:39 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id z15sm2709771igp.12.2015.06.19.16.43.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 16:43:39 -0700 (PDT)
In-Reply-To: <xmqqk2uz5s6b.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 19 Jun 2015 14:01:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272217>

Junio C Hamano <gitster@pobox.com> writes:

> What would be the end-user experience if you stopped at the first
> error?  You see an error, add an "fsck.<msg-id> = ignore" and rerun,
> only to find another error and rinse and repeat?  Wouldn't you
> rather see all of them and add the "ignore" to cover them in one go?
>
>> I actually see a really good reason to *keep* the current behavior:
>> one of the most prominent users of this code path is `git receive-pack
>> --strict`. It is used heavily by GitHub to ensure at least a certain
>> level of validity of pushed objects. Now, for this use case it is easy
>> to see that you want to stop *as soon as an error was
>> encountered*. And as GitHub sponsors my work on this patch series, my
>> main aim is to support their use case.
>
> While I understand that use case, I do not think stopping after
> showing three more errors in a single commit would make much
> difference in the bigger picture.

I actually changed my mind.  The above talks about the value given
to the end user by noticing as many errors in a single object, but
I'd think fsck.<msg-id> is pretty much useless as a tool to keep
using a repository with malformed object in its history.  When you
are told object d6602ec is bad (that's the v0.99 tag that does not
have tagger field), you would never want to say "in this repository,
any tag without tagger is allowed", because you would still want to
catch and prevent future breakages of the same kind in new tags.

And the way to do so is to say "I know the object d6602ec is bad, so
do not report breakage you find to me" by using the skip-list.  For
that use case, showing _all_ errors (or warnings for that matter)
does not add any value.

So let's stop at the first error as your patch did.
