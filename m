From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] fetch --all: pass --tags/--no-tags through to each
 remote
Date: Fri, 07 Sep 2012 10:07:01 -0700
Message-ID: <7v1uidzrre.fsf@alter.siamese.dyndns.org>
References: <20120901112251.GA11445@sigill.intra.peff.net>
 <1346880139-2281-1-git-send-email-ComputerDruid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Oswald Buddenhagen <ossi@kde.org>
To: Dan Johnson <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 19:07:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA21S-00070L-25
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 19:07:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778Ab2IGRHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 13:07:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33438 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751217Ab2IGRHE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 13:07:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA5DD78FA;
	Fri,  7 Sep 2012 13:07:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t5qdkQB+mVdki317aqB0VpR5yC8=; b=IerddU
	LhdYsbBQl56WdTMrskeMNIHGrF9ojlKQUd+ht1ktvG4HwOy3tDBoFuKBH2RYOYd+
	IQOsEtuCHpjRuOvsZjhXgvUP/CHqAGJ6RisOaY9dSe36LOULR0KmLOKyI3l67Fkm
	zDUTA2/jDYlXSi9YvgGpOCjgdcXkoCjS1mxwY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DRgMdzq7vDl75x6rXUxeVYaWsgfJRaZL
	QrTvQzQfrn4rmonYiiMLKT0bwRp7gcas2s7TsjVcoUpuSvDwbPxSP8w90fYLwHQz
	N08mWGbklMhkTMu6bBfI3ynH4N4jRGeTYoswnt5u0qdlcKnkPqHpdfZ0F9TASUe+
	lRqYkN1orkk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C828E78F9;
	Fri,  7 Sep 2012 13:07:03 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 39E0A78F8; Fri,  7 Sep 2012
 13:07:03 -0400 (EDT)
In-Reply-To: <1346880139-2281-1-git-send-email-ComputerDruid@gmail.com> (Dan
 Johnson's message of "Wed, 5 Sep 2012 17:22:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 71D4B41A-F90E-11E1-B6B3-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204977>

Dan Johnson <computerdruid@gmail.com> writes:

> When fetch is invoked with --all, we need to pass the tag-following
> preference to each individual fetch; without this, we will always
> auto-follow tags, preventing us from fetching the remote tags into a
> remote-specific namespace, for example.
>
> Reported-by: Oswald Buddenhagen <ossi@kde.org>
> Signed-off-by: Dan Johnson <ComputerDruid@gmail.com>
> ---
> On Sat, Sep 1, 2012 at 7:22 AM, Jeff King <peff@peff.net> wrote:
>>Hmm. We allocate argv in fetch_multiple like this:
>>
>>  const char *argv[12] = { "fetch", "--append" };
>>
>>and then add a bunch of options to it, along with the name of the
>>remote. By my count, the current code can hit exactly 12 (including the
>>terminating NULL) if all options are set. Your patch would make it
>>possible to overflow. Of course, I may be miscounting since it is
>>extremely error-prone to figure out the right number by tracing each
>>possible conditional.
>>
>>Maybe we should switch it to a dynamic argv_array? Like this:
>>
>>  [1/2]: argv-array: add pop function
>>  [2/2]: fetch: use argv_array instead of hand-building arrays
>
> This version is re-rolled to be on top of jk/argv-array, avoiding the issue of
> the fixed-size array entirely. If needed, we could of course use the old
> version of this patch and bump the number, but I figure this is preferable.

Thanks.  Queued.
