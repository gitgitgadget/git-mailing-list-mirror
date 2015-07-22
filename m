From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 2/2] refs: loosen restriction on wildcard "*" refspecs
Date: Wed, 22 Jul 2015 16:24:48 -0700
Message-ID: <CA+P7+xo4xYVsoitBk7SJhQtHU9_dXFiOpWefUr_8M96GqX8W1w@mail.gmail.com>
References: <1437599133-13012-1-git-send-email-jacob.e.keller@intel.com>
 <1437599133-13012-3-git-send-email-jacob.e.keller@intel.com> <xmqqio9brgrj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 01:25:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZI3O0-00005W-Mx
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 01:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100AbbGVXZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2015 19:25:09 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35950 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbbGVXZI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 19:25:08 -0400
Received: by igbij6 with SMTP id ij6so149024620igb.1
        for <git@vger.kernel.org>; Wed, 22 Jul 2015 16:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aa1BK3K+qe4+U9ov6K1DzydmAVh0XHi5bQLJNyBHYTM=;
        b=OHp6F8RebqRma+BA5ftPAU30y2jKrb2VdSqLn42BS0MeR/Na7Iy8c50gNBJvetXIEx
         jvRjwDM1vtcydRnRL/sQ2lSxuvJWXzhmXRQnI9WNbgR5L8DbmdXgVbw5uIeqiPu94omW
         PDzC+zTv9ZAygO6lQTBSvsIhm3i6CM85UDs2cPTdSvKZdVqHKrZuWeurrthGB7QYXhgQ
         DINebf/0ZghNMz24pqhhpiyF+YxCdaRCTd7K0QwAuaaN2KilG5L6dZCuI87dPaBqlgVp
         dHx20ZBPuAHLVI2GqgxE1G0poYXKfHTx/JZKJZnjOJsyNpt+Xz6X4PKsjX9qPCKoefDH
         uM1A==
X-Received: by 10.107.6.231 with SMTP id f100mr7887793ioi.61.1437607507826;
 Wed, 22 Jul 2015 16:25:07 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Wed, 22 Jul 2015 16:24:48 -0700 (PDT)
In-Reply-To: <xmqqio9brgrj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274474>

On Wed, Jul 22, 2015 at 3:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Modify logic of check_refname_component and add a new disposition
>> regarding "*". Allow refspecs that contain a single "*" if
>> REFNAME_REFSPEC_PATTERN is set. Change the function to pass the flags as
>> a pointer, and clear REFNAME_REFSPEC_PATTERN after the first "*" so that
>> only a single "*" is accepted.
>>
>> This loosens restrictions on refspecs by allowing patterns that have
>> a "*" within a component instead of only as the whole component. Also
>> remove the code that hangled refspec patterns in check_refname_format
>> since it is now handled via the check_refname_component logic.
>>
>> Now refs such as `for/bar*:foo/bar*` and even `foo/bar*:foo/baz*` will
>> be accepted. This allows users more control over what is fetched where.
>> Since users must modify the default by hand to make use of this
>> functionality it is not considered a large risk. Any refspec which
>> functioned before shall continue functioning with the new logic.
>
>
> Thanks.  Now I can read the changes to the code in these two commits
> and see that they both make sense ;-)
>
> The above description seem to use "ref" and "refspec" rather
> liberally, so I'll rewrite some parts of it to clarify while
> queuing.
>
> By the way, have you run test suite before sending this (or any
> previous round of this) patch?  This seems to break t5511-refspec.sh
> for me.
>
>
>

Looks like another location I forgot to update. I can send a re-spin
if you need with the following diff. Basically looks like the tests
just didn't get updated to count the new behavior is valid.

diff --git i/t/t5511-refspec.sh w/t/t5511-refspec.sh
index de6db86ccff0..7bfca7962d41 100755
--- i/t/t5511-refspec.sh
+++ w/t/t5511-refspec.sh
@@ -71,11 +71,11 @@ test_refspec fetch ':refs/remotes/frotz/HEAD-to-me'
 test_refspec push ':refs/remotes/frotz/delete me'              invalid
 test_refspec fetch ':refs/remotes/frotz/HEAD to me'            invalid

-test_refspec fetch 'refs/heads/*/for-linus:refs/remotes/mine/*-blah' invalid
-test_refspec push 'refs/heads/*/for-linus:refs/remotes/mine/*-blah' invalid
+test_refspec fetch 'refs/heads/*/for-linus:refs/remotes/mine/*-blah'
+test_refspec push 'refs/heads/*/for-linus:refs/remotes/mine/*-blah'

-test_refspec fetch 'refs/heads*/for-linus:refs/remotes/mine/*' invalid
-test_refspec push 'refs/heads*/for-linus:refs/remotes/mine/*' invalid
+test_refspec fetch 'refs/heads*/for-linus:refs/remotes/mine/*'
+test_refspec push 'refs/heads*/for-linus:refs/remotes/mine/*'

 test_refspec fetch 'refs/heads/*/*/for-linus:refs/remotes/mine/*' invalid
 test_refspec push 'refs/heads/*/*/for-linus:refs/remotes/mine/*' invalid




Regards,
Jake
