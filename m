From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/3] Re: mailinfo: allow individual e-mail files as input
Date: Thu, 06 Aug 2009 20:59:05 -0500
Message-ID: <Bq46oDu9ypgY1WI5GDyfybM5nluSMTj7VLfPqQH2BjK-xQyDLXAh5Q@cipher.nrlssc.navy.mil>
References: <MEhvdM_GHnyaFj9ZU3lxKS47vmOk5BKslGm0FxkE_lg0SQT5Zx6KhA@cipher.nrlssc.navy.mil> <COrzR9ThNBy5SQ7chsXyUOUuBmX-VWMCz3MUVwvBOlIZzlIXRRMP6EMS7BRy_6uJvxt5H-FbtdY@cipher.nrlssc.navy.mil> <COrzR9ThNBy5SQ7chsXyUB30jVGIijxZQ3LI9L_y7Ab5vWcDcy_HolvjjuHTC7DHI9ntV-eR_v0@cipher.nrlssc.navy.mil> <20090807013650.GE12924@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, giuseppe.bilotta@gmail.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Fri Aug 07 03:59:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZEk4-00016C-JW
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 03:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755865AbZHGB70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 21:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755763AbZHGB70
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 21:59:26 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58047 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755639AbZHGB7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 21:59:25 -0400
Received: by mail.nrlssc.navy.mil id n771x6PU009691; Thu, 6 Aug 2009 20:59:06 -0500
In-Reply-To: <20090807013650.GE12924@vidovic>
X-OriginalArrivalTime: 07 Aug 2009 01:59:06.0585 (UTC) FILETIME=[A5671490:01CA1702]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125160>

Nicolas Sebrecht wrote:
> The 06/08/09, Brandon Casey wrote:
> 
>>  git-am.sh     |   14 ++++++++++++++
>>  t/t4150-am.sh |    2 +-
>>  2 files changed, 15 insertions(+), 1 deletions(-)
>>
>> diff --git a/git-am.sh b/git-am.sh
>> index d64d997..dd60f5d 100755
>> --- a/git-am.sh
>> +++ b/git-am.sh
>> @@ -191,6 +191,20 @@ check_patch_format () {
>>  			esac
>>  			;;
>>  		esac
>> +		if test -z "$patch_format" &&
>> +			test -n "$l1" &&
>> +			test -n "$l2" &&
>> +			test -n "$l3"
>> +		then
>> +			# This begins with three non-empty lines.  Is this a
>> +			# piece of e-mail a-la RFC2822?  Grab all the headers,
>> +			# discarding the indented remainder of folded lines,
>> +			# and see if it looks like that they all begin with the
>> +			# header field names...
>> +			sed -n -e '/^$/q' -e '/^[ 	]/d' -e p "$1" |
>> +			egrep -v '^[A-Za-z]+(-[A-Za-z]+)*:' >/dev/null ||
>> +			patch_format=mbox
>> +		fi
>>  	} < "$1" || clean_abort
>>  }
> 
> May I ask why you resurrect this "first three lines check for rfc2822"
> instead of dumbly falling back to the "mbox" patch_format? Performance?

This at least checks that the header has the correct form for an email.

The dumb fallback to mbox format would just blindly pass the patch to
mailsplit which (I think) would just dump out an improperly formatted
email.  git-am would then start the process of applying the malformed
patch and fail.  With this patch, we can catch the failure earlier
and hopefully provide a better complaint to the user.

-brandon
