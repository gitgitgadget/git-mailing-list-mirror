From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] Fix some bugs in abspath.c
Date: Tue, 04 Sep 2012 11:08:47 -0700
Message-ID: <7va9x5bqz4.fsf@alter.siamese.dyndns.org>
References: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Sep 04 20:08:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8xYX-0008Vr-T1
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 20:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450Ab2IDSIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 14:08:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50197 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757487Ab2IDSIu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 14:08:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A71CD8D83;
	Tue,  4 Sep 2012 14:08:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8DK4M5JPLRoGFJ5nSAjdLg+tqQM=; b=ZveuBW
	Mh3nBIyHpSVliOrCsW5Ay7MT1DwoQDE+01Hz8QrzRnXkLXnEzP4Z+UCE9MBnz1lm
	NmOKNdBeZl2+d9MdLA9O6t3FPRDwZsv+KcS+9uWVzNJAP5YaO6vNLzZ0gHtPh11L
	QE7p70xDwcj/nEI4V0e5TcksVRAlihqQ0HOek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lUWvU64rBsdUMHHErID+hnm6liTYi3YA
	Ix4ZMTnGPa3M1BbpFmD/drTZPOk0H7057SvpCchMj9vD+sbyIiRsaWYE1xWOki7c
	2xKItmc+/gMrK/+II5M5H9DOQt0WW2RYq7Ygvez0S3dw/ndryMaVNBX+m6ENwI6w
	jBZZ1s/PtQQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 942DA8D82;
	Tue,  4 Sep 2012 14:08:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E619F8D80; Tue,  4 Sep 2012
 14:08:48 -0400 (EDT)
In-Reply-To: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu>
 (mhagger@alum.mit.edu's message of "Tue, 4 Sep 2012 10:14:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 935D3C88-F6BB-11E1-976C-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204759>

mhagger@alum.mit.edu writes:

> From: Michael Haggerty <mhagger@alum.mit.edu>
>
> I really just wanted to tidy up filter_refs(), but I've been sucked
> into a cascade of recursive yak shaving.  This is my first attempt to
> pop the yak stack.

Thanks.

> Please note that both absolute_path("") and real_path("") used to
> return the current directory followed by a slash.  I believe that this
> was a bug, and that it is more appropriate for both functions to
> reject the empty string.  The evidence is as follows:
>
> * If this were intended behavior, presumably the return value would
>   *not* have a trailing slash.

That is weak.  The only thing you can infer from that observation is
that the presense or absense of trailing '/' would not make any
difference to the caller who wanted a path to the cwd (and is more
convenient if the call is made so that a path relative to the cwd is
tucked after it).

> * I couldn't find any callers that appeared to depend on the old
>   behavior.

That is a very good argument (especially if the audit were
thorough).

I would be tempted to say that we should die() on "" for now, cook
the result outside "master" for a few weeks while auditing the
callchains, and see if any of them complains.
