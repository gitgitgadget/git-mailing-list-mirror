From: Junio C Hamano <gitster@pobox.com>
Subject: Re: `ab | (cd cd && git apply -)' fails with v2.0.0
Date: Thu, 24 Jul 2014 10:19:36 -0700
Message-ID: <xmqqegxaad3r.fsf@gitster.dls.corp.google.com>
References: <20140724142945.iERQ798d%sdaoden@yandex.com>
	<53D116B9.3050809@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Nurpmeso <sdaoden@yandex.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jul 24 19:19:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAMgK-0007Nk-Kp
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 19:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934078AbaGXRTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 13:19:46 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62217 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933903AbaGXRTp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 13:19:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E159A2B0F3;
	Thu, 24 Jul 2014 13:19:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ps0mjR0FZbERCs5P3jK8IpfDBK4=; b=JZh2jM
	RcOE/7oJ+TGJB0WyqmbmaPyWoqm4uJQKs69rmP2x+cJyPFjScXEi0YO2iKNzV+vA
	LGxCr6IxC56M48dgzTfwjpNkNXUYFjztsZvvIqJDo5IE4h7TK+0mBLCNq7l9zgfd
	rq6fED91AFj5bDPBHZpNiZLxEehMPhq7muuGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SW7nq5p6miHgj+SDA62bKQron3IV9B9p
	Z/7yrHbLjvMi7d2E2SH8WqyU9TOmrYyXsa+DHl8sja4YllApO15lM/DJpd2phh1J
	aX8LGBns5Hdc9ssAWdXLu2DPP1e5fDhMEyDPS6x6vkkq9geQ0/o/fu2RVmxMv2Na
	YOV9bO8pSiA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D6BB42B0F1;
	Thu, 24 Jul 2014 13:19:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A66882B0ED;
	Thu, 24 Jul 2014 13:19:38 -0400 (EDT)
In-Reply-To: <53D116B9.3050809@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Thu, 24 Jul 2014 16:22:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B1139B82-1356-11E4-B5C3-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254170>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Steffen Nurpmeso venit, vidit, dixit 24.07.2014 15:29:
>> Hello (again, psssssst, after a long time),
>> 
>> it happened yesterday that i needed to do
>> 
>>   $ git diff HEAD:FILE COMMIT:SAME-FILE |
>>   > (cd src && git apply -) 
>> ...
>
> Ah little more context would help. Are you diffing files in the subdir
> src, or a file at the root which happens to be present in the subdir src
> as well?

As the <treeish>:<path> form is not meant to produce "git apply"
applicable patch in the first place, I am not sure what the OP is
trying to achieve in the first place.  Not just "how many leading
levels to strip?" but "which file is being modified?" does not
appear in a usable form.  For example, here is what you would see:

    $ git diff HEAD:GIT-VERSION-GEN maint:GIT-VERSION-GEN
    diff --git a/HEAD:GIT-VERSION-GEN b/maint:GIT-VERSION-GEN
    index 40adbf7..0d1a86c 100755
    --- a/HEAD:GIT-VERSION-GEN
    +++ b/maint:GIT-VERSION-GEN
    @@ -1,7 +1,7 @@
    ...

and neither "HEAD:GIT-VERSION-GEN" nor "maint:GIT-VERSION-GEN" is
the file being modified ("GIT-VERSION-GEN" is).

I would understand if the upstream of the pipe were

    $ git diff HEAD maint -- GIT-VERSION-GEN | ...

though.

Needless to say, if the place "cd" goes is not a worktree controlled
by git, then "git apply" would not know where the top-level of the
target tree is, so even though the input with the corrected command
on the upstream side of the pipe tells it which file is being
modified, it needs to be told with the proper -p<n> parameter how
many leading levels to strip.
