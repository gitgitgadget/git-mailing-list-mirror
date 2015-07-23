From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] refs: loosen restriction on wildcard "*" refspecs
Date: Thu, 23 Jul 2015 10:13:45 -0700
Message-ID: <xmqq1tfyre46.fsf@gitster.dls.corp.google.com>
References: <1437599133-13012-1-git-send-email-jacob.e.keller@intel.com>
	<1437599133-13012-3-git-send-email-jacob.e.keller@intel.com>
	<xmqqio9brgrj.fsf@gitster.dls.corp.google.com>
	<CA+P7+xo4xYVsoitBk7SJhQtHU9_dXFiOpWefUr_8M96GqX8W1w@mail.gmail.com>
	<xmqqa8umrfge.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.iabervon.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 19:13:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIK4A-0002D0-5q
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 19:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864AbbGWRNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 13:13:49 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36769 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448AbbGWRNs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 13:13:48 -0400
Received: by pachj5 with SMTP id hj5so160652987pac.3
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 10:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=eUHp3sabqqDoA7z6d21AqNQMkoEbBwqVI5m/pWe9AsI=;
        b=OkZwDjWBZ/B8w4XZJ3EAo78xrPmS1BoHwGOoOoS6MiCLLcvp/90nelpXu2Afxl5b6z
         lG7414LmmPONsy9f3V0YVqCCOtVmfcDOmKC2uBazAG/SdPN1ZH/ptExVy0DnGfDJEoNe
         HRyoEkC/ZjoRokbRqSAm4Eq5hFHf/fBirGa37P7/MO6GZ2+nz5RLBUC5Y5pMdHPdiD6d
         Xj2KQJzeOQQ+SLcp+10s5C2IjE0WNJjqO+eDkUOjRyK1znfWV2Zcj6SN6+DKIfl8aOWK
         vgl5h3Ca7RsTtQGUhXKd4Yo9DgMEpX5umMxjkOUEloAfCHm7HtpOU7owpWENmxKR4qPA
         n/Ag==
X-Received: by 10.66.138.40 with SMTP id qn8mr20614790pab.19.1437671628135;
        Thu, 23 Jul 2015 10:13:48 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:156f:a37c:e915:d6df])
        by smtp.gmail.com with ESMTPSA id ex1sm6523966pdb.57.2015.07.23.10.13.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jul 2015 10:13:47 -0700 (PDT)
In-Reply-To: <xmqqa8umrfge.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 23 Jul 2015 09:44:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274507>

Junio C Hamano <gitster@pobox.com> writes:

> Will squash the changes; no need to resend (unless people discover
> other issues; let's hope that I wouldn't be the one to do so ;-).
>
> Thanks.
>
>> diff --git i/t/t5511-refspec.sh w/t/t5511-refspec.sh
>> index de6db86ccff0..7bfca7962d41 100755
>> --- i/t/t5511-refspec.sh
>> +++ w/t/t5511-refspec.sh
>> @@ -71,11 +71,11 @@ test_refspec fetch ':refs/remotes/frotz/HEAD-to-me'

That was whitespace damaged, so I had to hand-tweak the file in
place.  While at it, I noticed that we do not check a case where
multiple asterisks appear in a single component (which is rejected
for a reason different from having multiple components with an
asterisk in them), which also deserves its own test.

I'll squash in the following instead.

There is a slightly related tangent I noticed while doing so.

I wonder if there is an obvious and unambiguous interpretation of
what this command line wants to do:

    $ git fetch origin refs/heads/*g*/for-linus:refs/remotes/i-*/mine

We _might_ want to allow one (and only one) component with more than
one asterisk on the LHS of a refspec, while requiring only one
asterisk on the RHS to allow "this '*g*' is just like '*' but
excluding things that do not have 'g' in it".

Or it may not be worth the additional complexity.


 t/t5511-refspec.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/t5511-refspec.sh b/t/t5511-refspec.sh
index de6db86..f541f30 100755
--- a/t/t5511-refspec.sh
+++ b/t/t5511-refspec.sh
@@ -71,15 +71,18 @@ test_refspec fetch ':refs/remotes/frotz/HEAD-to-me'
 test_refspec push ':refs/remotes/frotz/delete me'		invalid
 test_refspec fetch ':refs/remotes/frotz/HEAD to me'		invalid
 
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
 
+test_refspec fetch 'refs/heads/*g*/for-linus:refs/remotes/mine/*' invalid
+test_refspec push 'refs/heads/*g*/for-linus:refs/remotes/mine/*' invalid
+
 test_refspec fetch 'refs/heads/*/for-linus:refs/remotes/mine/*'
 test_refspec push 'refs/heads/*/for-linus:refs/remotes/mine/*'
 
