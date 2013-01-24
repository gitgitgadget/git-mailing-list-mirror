From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parse_object: clear "parsed" when freeing buffers
Date: Wed, 23 Jan 2013 16:25:01 -0800
Message-ID: <7vfw1rfmw2.fsf@alter.siamese.dyndns.org>
References: <8988071A-1DF3-463E-8AF9-AE4EA200D786@me.com>
 <7vsj5rfspy.fsf@alter.siamese.dyndns.org>
 <1C90CE32-F559-4E76-915E-93642F614552@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jonathon Mah <jmah@me.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 01:25:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyAdD-0008JR-KO
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 01:25:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391Ab3AXAZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 19:25:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38625 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752008Ab3AXAZE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 19:25:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 707B8C938;
	Wed, 23 Jan 2013 19:25:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XRcn6ilondhm6rKBpf4Ws7m6Vps=; b=kV+NQj
	s+hiTXPHScs4FlUnM31N/5KDzmoyrvHopaLVfxQjGeDO37vpKF4rEEGcK0pIqAVN
	MFzu1LFI0DMZAf/yd4PCi7twEVP6lM//6kGGglps/j/Q7pb2d6L+DbEbWw8DS+fF
	Vo2JDIjQCdNWE04TZdo5GT/soWjZVw62Ci0Rc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hWuw5eY0sBjo+NlZ0mLbF8jj3+2gho7s
	MVbOLIOCfFvfK6b9TEveGcuZDOGx6069/mgu8TGfuXlzGs6abanpLPRxpr4HI4qb
	OyacWpUwUi3K/YtPOcAF+tnR4qzqSe0XFGwvzckwx8XMjTjnn4d/DoAXHcqzb+4e
	gpbqwd81SDY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 656FEC937;
	Wed, 23 Jan 2013 19:25:03 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB9AEC936; Wed, 23 Jan 2013
 19:25:02 -0500 (EST)
In-Reply-To: <1C90CE32-F559-4E76-915E-93642F614552@me.com> (Jonathon Mah's
 message of "Wed, 23 Jan 2013 15:36:51 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7EB28C6E-65BC-11E2-A213-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214380>

Jonathon Mah <jmah@me.com> writes:

> No, I haven't audited the code paths (I have only the loosest
> familiarity with the source). Indeed, I found that clearing the
> 'parsed' flag in fsck.c (traverse_one_object()) is incorrect and
> causes test failures.
>
> With the object cache, isn't modifying the object unsafe in
> general? Instead of auditing code paths, it's now necessary to
> audit _all_ code that uses "struct object", which seems
> infeasible.

The object layer was designed with "run one thing and one thing
well, and then let the _exit(2) take care of the clean-up" model in
mind; modifying the object, e.g. updating commit->parents list,
in-core by revision traversal machinery is very much within the
scope of its intended uses.

> I'm just trying to fix the segfault demonstrated in the test
> attached to the patch.

Can offending readers that dereference NULL without checking if
buffer has been freed be updated so that they read_sha1_file(), read
the contents from the result returned from the function (instead of
reading from .buffer), and free the memory when they are done?

That would be a fix that would be very much isolated and easy to
audit.
