From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: RFC "grep '...\{m,n\}"?
Date: Fri, 23 Jan 2015 07:39:37 +0700
Message-ID: <CACsJy8Boo4tBNDJjSP5Kv_e6WaE=Fg_dGzOHFDjd5HcX3D3r7A@mail.gmail.com>
References: <CAPig+cQcYXzRwHMRcKQJf-mWq7d9Kgp7KndnEhFs4_mwgLpiiA@mail.gmail.com>
 <1421927415-114643-1-git-send-email-kirill.shutemov@linux.intel.com> <xmqqvbjysh4o.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 01:40:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YESII-0002Zg-GW
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 01:40:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906AbbAWAkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 19:40:10 -0500
Received: from mail-qc0-f172.google.com ([209.85.216.172]:36003 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527AbbAWAkI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 19:40:08 -0500
Received: by mail-qc0-f172.google.com with SMTP id i8so4182160qcq.3
        for <git@vger.kernel.org>; Thu, 22 Jan 2015 16:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1erBEHEVumvNzv7EHyJcMEn18VJnF/Ren7TNrlCzBZA=;
        b=jdOuUtQv7oSQtATwsqJjbi4IlwjabuDulgDB4TlNxb7qmUGbodaUeCtvfroMxccly8
         +XFmsH5Nx+7C4w7f6hE+fi4U7xO5c3zp7+oEnV48GeIwkFglKAjc14o1s3+9VtVbZspj
         VN4OOarSuBxHx52ycqIssyky1AP4hKBFd9whP9Ufw9xqkxLsatsCQYV3b9YqQLvjWe4T
         qg9mjDVFtxVreoK5XV7CCmGsGErNeN4a2DgThoJtLy9dGt7B20iVM2ubygeXsKUBby/Y
         SDJyU+Z4GdhAkyyqAm4GWR9BEik89fwQIrFtzaGlEDwoV8f1pVDzhPeJGjh8JLBHLovU
         xrmw==
X-Received: by 10.140.22.233 with SMTP id 96mr8094271qgn.86.1421973607715;
 Thu, 22 Jan 2015 16:40:07 -0800 (PST)
Received: by 10.96.137.73 with HTTP; Thu, 22 Jan 2015 16:39:37 -0800 (PST)
In-Reply-To: <xmqqvbjysh4o.fsf_-_@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262897>

On Fri, Jan 23, 2015 at 3:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> writes:
>
>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>> index 8197ed29a9ec..a31f7e0430e1 100755
>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>> @@ -1039,4 +1039,11 @@ test_expect_success 'short SHA-1 collide' '
>>       )
>>  '
>>
>> +test_expect_success 'respect core.abbrev' '
>> +     git config core.abbrev 12 &&
>> +     set_cat_todo_editor &&
>> +     test_must_fail git rebase -i HEAD~4 >todo-list &&
>> +     test 4 = $(grep -c "pick [0-9a-f]\{12,\}" todo-list)
>> +'
>
> Documentation/CodingGuidelines says
>
>  - As to use of grep, stick to a subset of BRE (namely, no \{m,n\},
>    [::], [==], or [..]) for portability.
>
>    - We do not use \{m,n\};
>
>    - We do not use -E;
>
>    - We do not use ? or + (which are \{0,1\} and \{1,\}
>      respectively in BRE) but that goes without saying as these
>      are ERE elements not BRE (note that \? and \+ are not even part
>      of BRE -- making them accessible from BRE is a GNU extension).
>
> but I see we have multiple hits from "git grep 'grep .*\\{'" (all in
> the t/ directory).  I wonder
>
>  - if everybody's system is now OK with \{m,n\} these days, or
>
>  - there are people who are grateful that we stayed away from using
>    \{m,n\} but they are not running the tests because their system
>    is too exotic to pass other parts of the test suite.

Can we switch to using git-grep in the test suite and avoid these
platform issues? Or maybe switch to test-grep.c that is a wrapper of
compat regex to make sure the same feature set is used across
platforms.
-- 
Duy
