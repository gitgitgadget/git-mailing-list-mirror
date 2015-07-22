From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3] refs: loosen restrictions on wildcard '*' refspecs
Date: Wed, 22 Jul 2015 11:24:39 -0700
Message-ID: <CA+P7+xrnRTJZ1j1bPx=3CNtOiNLxHux5bR9b1gaJKeM2_LZ6Kw@mail.gmail.com>
References: <1437581180-26883-1-git-send-email-jacob.e.keller@intel.com> <1437589261.4520.2.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 20:32:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHyoD-0003Te-9G
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 20:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbbGVSb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2015 14:31:57 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37456 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbbGVSb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 14:31:56 -0400
Received: by igbpg9 with SMTP id pg9so139546193igb.0
        for <git@vger.kernel.org>; Wed, 22 Jul 2015 11:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vBSNUUNYY1Odflp1V/bFlBxz02/PZRq0o29112AFpm4=;
        b=HLkEmrgDdpWNbqLJT5TDwSydbX41dUDuDe6kRBLvUPRDgiyWd12n8SeRCZd+sqkp+4
         C58O6+jx19GxuA9ws4Rn3RzigyWiPHS29BcuADZ4/1P/F4pKpJ/od+9yvrtoB2xVrgxT
         TEQOefdUmJJB9IQvUQla9cHAAi6wibCvby00Ssp5JkBCb1i5LjQJHeMWmKMtNZTwcgIv
         VxPCHa9BoR2+DcaONS8Rx8X5zQxO6cvBHwWCdjVajAk13Mi+S47FOTf89d/qeUVzL7oL
         azvPOarFWmylhed5Ho4r3A6cpNCnml7TilK0XwJnrqhGCBP80zwivT9VZlZtK6RU/G7t
         dzmw==
X-Received: by 10.50.78.1 with SMTP id x1mr4451948igw.1.1437589499183; Wed, 22
 Jul 2015 11:24:59 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Wed, 22 Jul 2015 11:24:39 -0700 (PDT)
In-Reply-To: <1437589261.4520.2.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274449>

On Wed, Jul 22, 2015 at 11:21 AM, David Turner <dturner@twopensource.com> wrote:
> On Wed, 2015-07-22 at 09:06 -0700, Jacob Keller wrote:
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Update the check_refname_component logic in order to allow for a less
>> strict refspec format in regards to REFNAME_REFSPEC_PATTERN. Previously
>> the '*' could only replace a single full component, and could not
>> replace arbitrary text. Now, refs such as `foo/bar*:foo/bar*` will be
>> accepted. This allows for somewhat more flexibility in references and
>> does not break any current users. The ref matching code already allows
>> this but the check_refname_format did not. Note this does also allow
>> refs such as `foo/bar*:foe/baz*`, that is, arbitrary renames. This was
>> already possible with namespace sections before, but now is possible
>> even as part of the pattern section. Since users have to explicitly type
>> these into the configuration it does not seem an issue.
>>
>> Also streamline the code by making this new check part of
>> check_refname_component instead of checking after we error during
>> check_refname_format, which fits better with how other issues in refname
>> components are checked.
>>
>> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
>> Cc: Daniel Barkalow <barkalow@iabervon.iabervon.org>
>> Cc: Junio C Hamano <gitster@pobox.com>
>> ---
>>
>> I updated the patch description a bit. This is also re-based onto the
>> next/ branch in-case. This is mostly a resend so that anyone interested
>> in review has another chance to see the patch.
>>
>>  Documentation/git-check-ref-format.txt |  4 ++--
>>  refs.c                                 | 39 +++++++++++++++++++---------------
>>  refs.h                                 |  4 ++--
>>  t/t1402-check-ref-format.sh            |  8 ++++---
>>  4 files changed, 31 insertions(+), 24 deletions(-)
>>
>> diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
>> index fc02959ba4ab..9044dfaadae1 100644
>> --- a/Documentation/git-check-ref-format.txt
>> +++ b/Documentation/git-check-ref-format.txt
>> @@ -94,8 +94,8 @@ OPTIONS
>>       Interpret <refname> as a reference name pattern for a refspec
>>       (as used with remote repositories).  If this option is
>>       enabled, <refname> is allowed to contain a single `*`
>> -     in place of a one full pathname component (e.g.,
>> -     `foo/*/bar` but not `foo/bar*`).
>> +     in the refspec (e.g., `foo/bar*/baz` or `foo/bar*baz/`
>> +     but not `foo/bar*/baz*`).
>>
>>  --normalize::
>>       Normalize 'refname' by removing any leading slash (`/`)
>> diff --git a/refs.c b/refs.c
>> index ce8cd8d45001..3002015ff289 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -20,11 +20,12 @@ struct ref_lock {
>>   * 2: ., look for a preceding . to reject .. in refs
>>   * 3: {, look for a preceding @ to reject @{ in refs
>>   * 4: A bad character: ASCII control characters, "~", "^", ":" or SP
>> + * 5: check for patterns to reject unless REFNAME_REFSPEC_PATTERN is set
>
> How about this:
> + 5: *, reject unless REFNAME_REFSPEC_PATTERN is set
>
> (I guess it's possible that we would later allow other pattern chars,
> but we could change the message then).
>
>
>

Ok that makes sense

Regards,
Jake
