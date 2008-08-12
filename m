From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH v2] tg-create.sh: Support for multiple {to,cc,bcc} options
Date: Tue, 12 Aug 2008 07:14:51 +0200
Message-ID: <36ca99e90808112214hb8f01f0j30cff74e4f6c1ead@mail.gmail.com>
References: <1218307736-24891-1-git-send-email-bert.wesarg@googlemail.com>
	 <20080811204723.GF10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Aug 12 07:15:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSmEd-0005Aa-Kp
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 07:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbYHLFOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 01:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbYHLFOx
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 01:14:53 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:51279 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbYHLFOw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 01:14:52 -0400
Received: by yw-out-2324.google.com with SMTP id 9so760556ywe.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2008 22:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=QYuKkHBL+Vejt4hkgITbmpW9bFNm6goUzGq2vNRocBo=;
        b=KjDkgaQeF6Nkyt1+I4Nc5fJSOSpoCCKBJPWt4oo435nLYEvBws8DbI+4r5LKOq0/0H
         BSSydvuOtpHZshurGZbUNQbdcvjOWcadyEBjykhe66k0lbtUvPiAibc/AD08OWCeTqBF
         l1RD0LFt3dIu6EEq+0bxFI0DmeZY6OT5RxIJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=kUFP45AIgYrk1N+O0r0lGpLu8opBnE76wKoPQGEvaCJNHlEG/r4KLITQUHTaEGjiX0
         m47McY4uwwLAp9OsAntlqoNkGWkSddpmzpSghva0oPZSuD9y/MZcCPSNREm8B9Isk9G8
         XFCLVTEpSbfClkjIkmw+nN1Tac44ShGrrJmp4=
Received: by 10.151.150.20 with SMTP id c20mr13672390ybo.6.1218518091315;
        Mon, 11 Aug 2008 22:14:51 -0700 (PDT)
Received: by 10.70.49.12 with HTTP; Mon, 11 Aug 2008 22:14:51 -0700 (PDT)
In-Reply-To: <20080811204723.GF10151@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92067>

On Mon, Aug 11, 2008 at 22:47, Petr Baudis <pasky@suse.cz> wrote:
>  Hi,
>
> On Sat, Aug 09, 2008 at 08:48:56PM +0200, Bert Wesarg wrote:
>> Git config supports multiple values for the same config key, so support it
>> for these TopGit config options, too.
>>
>> New in v2:
>> Print a RFC2822 compliant header.
>>
>> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>
>  oops, I'm really sorry! I thought I already commented on this while
> apparently, I forgot to.
>
>> ---
>>  tg-create.sh |   35 ++++++++++++++++++++++++++++++++---
>>  1 files changed, 32 insertions(+), 3 deletions(-)
>>
>> diff --git a/tg-create.sh b/tg-create.sh
>> index 6cce7ed..d7ee1d2 100644
>> --- a/tg-create.sh
>> +++ b/tg-create.sh
>> @@ -100,13 +100,42 @@ git checkout -b "$name"
>>  echo "$deps" | sed 's/ /\n/g' >"$root_dir/.topdeps"
>>  git add "$root_dir/.topdeps"
>>
>> +# Print a RFC2822 compliant header ($2) with values from the config option
>> +# ($1 without the topgit. prefix)
>> +get_multi_config()
>> +{
>> +     # Do we need to escape it for awk double quotes?
>> +     prefix="$2"
>> +     prefix_align="$(printf "%*s  " "${#2}" "")"
>> +
>> +     git config --get-all topgit.$1 |
>> +             awk '
>> +                     BEGIN {
>> +                             line = ""
>> +                             prefix = "'"$prefix"': "
>> +                     }
>> +                             {
>> +                                     if (line != "") {
>> +                                             print prefix line ","
>> +                                             prefix = "'"$prefix_align"'"
>> +                                     }
>> +                                     line = $0
>> +                             }
>> +                     END {
>> +                             if (line != "") {
>> +                                     print prefix line
>> +                             }
>> +                     }
>> +             '
>> +}
>> +
>
> I'm not too happy about this, for several reasons:
>
>        (i) This code is so awfully complicated.
For my first awk script, its very clean and not that complicated. I think ;-)

>
>        (ii) It would be simpler to just prefix all the further lines
> with a tab; wouldn't something like
>
>                sed '2,$s/^/\t/'
No objections with this.

>
> actually work?
>
>        (iii) This is troublesome because now header values can span
> multiple lines. Until now, we were just blisfully ignorant about this
> possibility. At least tg export needs to be adjusted to account for this
> now, and I fear dealing with this will be pretty annoying when
> prototyping new features.
Than we should go back to v1. As I asked in a previous line: "But do
we generate a valid mail with tg patch, or just a patch file with some
special looking lines?"

Bert
> --
>                                Petr "Pasky" Baudis
