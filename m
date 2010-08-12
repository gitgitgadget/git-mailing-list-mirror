From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git-add: Don't exclude explicitly-specified tracked 
 files
Date: Wed, 11 Aug 2010 19:59:58 -0700
Message-ID: <7vaaosv8lt.fsf@alter.siamese.dyndns.org>
References: <1281510236-8103-1-git-send-email-gdb@mit.edu>
 <7vmxstypot.fsf@alter.siamese.dyndns.org>
 <AANLkTinbMHDa6P8N4Mne34rMkmzzbrpm0osd2LRbr-Jv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de
To: Greg Brockman <gdb@MIT.EDU>
X-From: git-owner@vger.kernel.org Thu Aug 12 05:00:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjO1e-0002I3-3u
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 05:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759452Ab0HLDAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 23:00:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33155 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759233Ab0HLDAH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 23:00:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EAB0DCC7C7;
	Wed, 11 Aug 2010 23:00:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/7fzV/+lkOfMyyVz9OXIcVwzKf4=; b=jEDNQb
	bdmT0jpeLTHP4+9AJ4/oq49jA8r9BF/Vr1DmMzAiy7K1oe1cSZZQSdc8Z67j7NnC
	LewO0f3/hJ7KfhowpmKabug5rMmn6QqoJOGbIq50oiXcxRQIiivwns3CxHoktWgd
	+KmI6B2fac6mzGcoMLNtCHRSNQqXEdYXveNeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gb2uEJeNBDKyRXA/7be8/h8QlquKZamh
	m/afKfXLJ7dDGc/o0A5019ivI8d1si91F/jWmL+1zt3FpaTNWaotO6U3rS3Xkiz+
	LGPw///SbJZm+M+08PgQBB1CCkJWxWt2CD5Dxtlz8FRJIoVisTR8BEV6unPb69+5
	aIEqe3Wn0tc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AFA2ACC797;
	Wed, 11 Aug 2010 23:00:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0499CC795; Wed, 11 Aug
 2010 22:59:59 -0400 (EDT)
In-Reply-To: <AANLkTinbMHDa6P8N4Mne34rMkmzzbrpm0osd2LRbr-Jv@mail.gmail.com>
 (Greg Brockman's message of "Wed\, 11 Aug 2010 14\:36\:13 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B44F9568-A5BD-11DF-95D7-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153329>

Greg Brockman <gdb@MIT.EDU> writes:

>> What should happen if the user did these instead, after adding "dir" as an
>> ignored entry, and adding dir/file but not dir/untracked to the index?
>>
>>  (1)    git add dir/file dir/untracked    ; explicitly named
>>  (2)    git add dir/*                     ; have shell glob--same as (1)
>>  (3)    git add "dir/*"                   ; have git glob
>>  (4)    git add dir                       ; have git recurse
>
> In all four cases, the output I get is:
> """
> The following paths are ignored by one of your .gitignore files:
> dir
> Use -f if you really want to add them.
> fatal: no files added
> """
>
> Note that this is also the output if you run
>
> (5) rm dir/untracked && git add "dir/*"

Here is the one that troubles me the most:

 (6) git add dir/f*

This _looks_ like very explicitly named from git's point of view, but from
the end user's point of view it is not.  Depending on presense (or absense)
of another file whose name begins with 'f' in the directory, the add will
be either prevented or silently accepted.

I am not sure what the best solution would be; I tend to think the current
behaviour is slightly saner in the face of shell globbing.
