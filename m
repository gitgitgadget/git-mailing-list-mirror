From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH v2] Re: mailinfo: allow individual e-mail files as input
Date: Thu, 06 Aug 2009 21:30:30 -0500
Message-ID: <kRgAbadymu_kXO_N6eQZL3RZpkCM95QJxM7bDH84bRuxk2kjGYKwjA@cipher.nrlssc.navy.mil>
References: <COrzR9ThNBy5SQ7chsXyUB30jVGIijxZQ3LI9L_y7Ab5vWcDcy_HolvjjuHTC7DHI9ntV-eR_v0@cipher.nrlssc.navy.mil> <fmF7fF0TYh9QnFuUzmi-Zw9fKRhYn2-S-kCVb2e-d84D87BPqjfwrwFursOoLGkB99qKJmb_oRs@cipher.nrlssc.navy.mil> <20090807015238.GF12924@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, giuseppe.bilotta@gmail.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Fri Aug 07 04:30:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZFEA-0000Tk-4x
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 04:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756496AbZHGCae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 22:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756486AbZHGCae
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 22:30:34 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:39145 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756411AbZHGCae (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 22:30:34 -0400
Received: by mail.nrlssc.navy.mil id n772UV3r012796; Thu, 6 Aug 2009 21:30:31 -0500
In-Reply-To: <20090807015238.GF12924@vidovic>
X-OriginalArrivalTime: 07 Aug 2009 02:30:31.0126 (UTC) FILETIME=[08AD3760:01CA1707]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125163>

Nicolas Sebrecht wrote:
> The 06/08/09, Brandon Casey wrote:
> 
>> diff --git a/git-am.sh b/git-am.sh
>> index d64d997..49f2be4 100755
>> --- a/git-am.sh
>> +++ b/git-am.sh
> 
> <...>
> 
>> +			{
>> +				echo "$l1"
>> +				echo "$l2"
>> +				echo "$l3"
>> +				cat
> 
> UUOC, I guess.

I needed to use google to figure out that UUOC means Useless Use Of Cat,
but I think you are mistaken.  Rather than trying to explain it, try this
with and without 'cat' commented out:

#!/bin/sh

{
    {
        echo "line one"
        echo "line two"
        cat
    } | sed -e 's/$/Q/'
} <<-EOF
This is a line of text
Here is another line of text.
And another
EOF

Hopefully you'll see the parallels to the sequence in git-am.sh and understand
that cat was used to send the rest of the email through sed along with the first
three lines that were read explicitly.  git-am.sh looks more like this:

   {
      read l1
      ...
      {
         echo "$l1"
         ...
         cat
      } | sed ...
   } << "$1"

At least, I thought that is how it looked until I read your other email where
you pointed out that "$1" is an argument to sed.

>> +			} | sed -n -e '/^$/q' -e '/^[ 	]/d' -e p "$1" |
>                                                    ^^
> 
> Is it still needed?

Yes.  The '/^[ 	]/d' portion of the sed statement deletes any lines with
leading space or tab.  This avoids passing continuation fields to the
grep statement which is not designed for them, and so would fail (or
match, depending on how you look at it.  We used -v with grep).

-brandon
