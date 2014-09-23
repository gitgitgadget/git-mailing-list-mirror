From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] archive: support filtering paths with glob
Date: Tue, 23 Sep 2014 09:57:35 -0700
Message-ID: <xmqqfvfijmv4.fsf@gitster.dls.corp.google.com>
References: <1433062.XhRCATRB3s@al>
	<1411271706-1151-1-git-send-email-pclouds@gmail.com>
	<xmqq4mvzlb5c.fsf@gitster.dls.corp.google.com>
	<CACsJy8CwwzOuiL1GMcK9OWZSdSqCpLzVJPyNkHocH10_1VmXSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Peter Wu <peter@lekensteyn.nl>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 18:57:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWTPK-0000qQ-5l
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 18:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbaIWQ5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 12:57:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64583 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753832AbaIWQ5h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 12:57:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 24CA73AFF6;
	Tue, 23 Sep 2014 12:57:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pokyggZBXa7gO6T26ley5XGppaY=; b=Mvg/6E
	WmeKdoG7kVu/oUbb0Nh27yEeQpFW4s/VvjyNmCLn2+mHv9+WBoo0w5Iv+QGL7yAh
	emVGLDloziHkG9G+Sxq8x364n9nBtYKjRVY/JkXV1gCvNnMeO20dBqohwY2qHpK6
	Yu3xDIMaAHubDjgrp5XHIAHiB5NzGmV410JwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HdzdH5XEPnE4oQ9lSUDpZypmkcALySpO
	D/a4E6wMi5H9pEUoaG+uNesak6uTGwclieshGAw7WEtcJdFXzvG9LLKdgg+BzrbP
	jdYdSpALkn9XSR+IsAJLvTFMYsq/jgMvPlVXfrqafx4PQ9SwBOC4wKJR5pZ5nJlk
	9KfaEbNPmgw=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 190B33AFF5;
	Tue, 23 Sep 2014 12:57:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 916DE3AFF2;
	Tue, 23 Sep 2014 12:57:36 -0400 (EDT)
In-Reply-To: <CACsJy8CwwzOuiL1GMcK9OWZSdSqCpLzVJPyNkHocH10_1VmXSA@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 23 Sep 2014 06:04:31 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B83FB9F6-4342-11E4-88FE-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257428>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Sep 23, 2014 at 2:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> When we have a/b/c and a/d/e to be written, the first round would
>> write a/ and then a/b/ with the above, and presumably elsewhere
>> somebody will write a/b/c; next time around we do need to write a/d/
>> but we wouldn't want to write a/ itself.  How is this code
>> preventing the recursion going all the way up every time to avoid
>> repeating a/?
>>
>> Puzzled...
>
> We never traverse 'a' (or any directory) twice and we only push a
> directory to the stack when we examine it. After a/b and a are written
> down and we examine 'd', 'a/d' is pushed to the stack. When we hit
> 'a/d/e', we only have 'a/d' in the stack, not 'a'.

So the traverser will feed you

	a/
        a/b/
        a/b/c
        a/d/
        a/d/e

in that order, and you keep a/ and a/b/ until you see a/b/c at which
time you flush the two queued ones and likewise for a/d/ and a/d/e.
When you queue a/d/ you do not decompose that to a/ and a/d/ because
you know that the caller of the callback would have made sure all
the leading path components have been given you by the time it gave
you a/d/, and it all works out fine.

Thanks for clarifying.
