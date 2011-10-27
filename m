From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP 02/11] notes-merge: use opendir/readdir instead of
 using read_directory()
Date: Thu, 27 Oct 2011 10:23:15 -0700
Message-ID: <7vzkgmz6v0.fsf@alter.siamese.dyndns.org>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
 <1319438176-7304-3-git-send-email-pclouds@gmail.com>
 <7vzkgo3m9b.fsf@alter.siamese.dyndns.org>
 <CACsJy8CocoAiVx_PeaaX1oRZvmzfj9-z9JLJkE5unSRVtpGkNA@mail.gmail.com>
 <7vmxcn3b8w.fsf@alter.siamese.dyndns.org>
 <CACsJy8C4iHffr4UYP9SvCU0OPC-LocUORwAQ492LqaV_tyvFQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 27 19:23:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJTfq-000371-Do
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 19:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746Ab1J0RXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 13:23:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44992 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752101Ab1J0RXT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 13:23:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8D924A14;
	Thu, 27 Oct 2011 13:23:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HCzCPt9fiG5Ea/hCfKKuwWz8hHU=; b=TVjBfE
	RK8URifxpJjAGMXw5EQ6BV1n0y7QppTu/654OcL4BgUUivJRLsyuYd6Zy0DSRvSv
	Jbr1SE3Axeq4ft/mBg9r3vR6kI+AEkkmT/LkZPkBcU2fDdmd+I3tmm0CggUnjlqq
	dddCDn9DSoqLOPTPeMRI5W7MV3jZ5G4ivFFIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FZ5eawAuj05n3HospWOZy80FVrJfUlnW
	8Z7+cHiQ6Riu4VxUjqW1Iumiq6AhIs0a0/IVEqLQaGvl8o2Zu1YwOQz/1eAnNcMH
	cwiHdxxWjYB8xboaYpCsPBDvEsOgFuLBdkJQ63i9jcwqNBUugGu1XrDCApHhawNl
	3NL5RbsbL94=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AEC384A13;
	Thu, 27 Oct 2011 13:23:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 11A4B4A12; Thu, 27 Oct 2011
 13:23:16 -0400 (EDT)
In-Reply-To: <CACsJy8C4iHffr4UYP9SvCU0OPC-LocUORwAQ492LqaV_tyvFQA@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Thu, 27 Oct 2011 18:51:38 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5BBFE826-00C0-11E1-AFB5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184300>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> When read_directory("where/ever") is called, what kind of paths does it
>> collect? Do the paths the function collects share "where/ever" as their
>> common prefix? I thought it collects the paths relative to whatever
>> top-level directory given to the function, so that "where/ever" could be
>> anything.
>
> Correct. But read_directory() takes pathspec now so naturally it does
> not treat "where/ever" a common prefix anymore.  So it has to open(".")
> and starts from there.

That is a puzzling statement. The read_directory() function takes:

 - dir: use this struct to pass traversal status and collected paths;

 - path, len: this is the directory (not a pathspec) we start traversal
   from; and

 - pathspec: these are the patterns that specify which parts of the
   directory hierarchy under <path,len> are traversed.

I do not see any good reason for <path,len> to become a match pattern. Are
you trying to get it prepended to elements in pathspec[] and match the path
collected including the <path> part?

Why?

I could see that "open . and start from there, treating as if <path,len>
is also pathspec" could be made to work, but I do not see why that is
desirable.

In other words, are there existing callers that abuse read_directory()
to feed a pattern in <path,len>? Maybe they should be the one that needs
fixing instead?
