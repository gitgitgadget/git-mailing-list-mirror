From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] "git add -A/--no-all" finishing touches
Date: Thu, 25 Apr 2013 16:44:39 -0700
Message-ID: <7vobd2yy3c.fsf@alter.siamese.dyndns.org>
References: <7vehe3qi5m.fsf@alter.siamese.dyndns.org>
	<1366663435-13598-1-git-send-email-gitster@pobox.com>
	<7vhaiu1a89.fsf@alter.siamese.dyndns.org>
	<7v4neu19mj.fsf@alter.siamese.dyndns.org>
	<20130425232410.GN29963@google.com>
	<7vvc7ayy84.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Thomas Rast <trast@inf.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 01:44:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVVqI-0001ek-KU
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 01:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758471Ab3DYXom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 19:44:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59658 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756119Ab3DYXom (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 19:44:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A392919E7E;
	Thu, 25 Apr 2013 23:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xYMq0p7K8lV/qwzt1oxeMizxlP4=; b=CHM/HU
	Sqb4sU6xVGTS03+rcM+Re77hn8qUpE+KjsO6OO/C7jZmN9vnPtYbDw0rY7VOdhlI
	GLKYJmtg7q2Ma2HNOh3nfusEENoF4E9DDYS2UDNYAMT3Fu4ukBsVcUPF1ydfF+Sj
	p9z0nAxjKgpwijxI3r/dmp+9cd3kAYxDny8Us=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qAQrkPAl7Ac+ez5nddul+ac4xmDQF2Cm
	H5Atz3oZ7TTrWyI60EnOpX1ADnvyRfoFnyF2DK74uiRXDQRCF/tykQuEw7QxvN3C
	H93CUIziU2betnefnvBsnlNdlEDWmTg6KHB5omKsBYhwWaGn3SSusxdS8FHBOY1r
	4ajTOXv1Z88=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 929A619E7D;
	Thu, 25 Apr 2013 23:44:41 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0195819E7C;
	Thu, 25 Apr 2013 23:44:40 +0000 (UTC)
In-Reply-To: <7vvc7ayy84.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 25 Apr 2013 16:41:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 192E25B8-AE02-11E2-8B04-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222467>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Junio C Hamano wrote:
>>
>>> At the point of calling warn_pathless_add(), it seems that we are
>>> triggering this for paths that are not necessarily modified when run
>>> with "add -n -u".
>>
>> Do you mean files that were touched but have no content change, or
>> something more subtle?
>
> I had the change (which by the way needs a fix for the "found a
> directory" codepath) on top of master, uncommitted, and no other
> change (I also have some cruft that is not ignored).
>
>     cd Documentation && ../git add -n -u
>
> reported GIT-VERSION-GEN which was not touched.  It does not
> reproduce, though...

Ahh, I haven't run anything under the debugger yet, but I think I
know what is going on.

Don't we limit our "update-index --refresh" equivalent to the
original pathspec, even though your "-u/-A sans pathspec" warning
detection relies on grabbing the changes from the entire tree?
