From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] fast-export: add new --refspec option
Date: Thu, 09 May 2013 15:32:53 -0700
Message-ID: <7vvc6r7pii.fsf@alter.siamese.dyndns.org>
References: <1368063095-22861-1-git-send-email-felipe.contreras@gmail.com>
	<1368063095-22861-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 00:56:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaZle-0001c8-CO
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 00:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575Ab3EIW4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 18:56:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59098 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757714Ab3EIWc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 18:32:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F4091D56B;
	Thu,  9 May 2013 22:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6x0gCW8ryHV//kppAc6RTqFcj6E=; b=v1PZBt
	NQ70Ji8ccgFA835DdvETT062sKW9kKsVNaArCv9Wr8YZRchKfi9wvCfCFqEatS4E
	HLYATBNOrBwnCYlJhgjmCpAAgl7WOTJYsqneN3/yJBVyv8xXLKNhyvzbW+SSbzKQ
	nKuvtDo6oTmtIEUE/85FAFl4vUB9/z09hL+Gk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iwbWwIkkWkLBmdHGfjMnh4395ySY/vKJ
	n9CPQy11q0qfZzvyMbkjqzBnQPSjDzxLdNQKfdhr2lUW7sVXn9cRnna7z4NOnyD+
	5XPw1IWMcVhq2vKZVmYjAyAvhB/W9TbXCeTxOoAaxnhJgqV8lxLvYiVBpzjq9uE6
	Ylp1oL9ct6U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16DC01D56A;
	Thu,  9 May 2013 22:32:55 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 750E91D569;
	Thu,  9 May 2013 22:32:54 +0000 (UTC)
In-Reply-To: <1368063095-22861-3-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Wed, 8 May 2013 20:31:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6412F76A-B8F8-11E2-BE59-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223794>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> +test_expect_success 'use refspec' '
> +	git fast-export --refspec refs/heads/master:refs/heads/foobar master | \
> +		grep "^commit " | sort | uniq > actual &&

You do not need backslash after the pipe symbol at the end of line;
the shell knows you haven't finished speaking at that point.

The usual "pipe hides the error status of upstream commands" applies
here.  The command may die after writing enough to fill the pipe
buffer and showing the lines that begin with "commit".

Also it makes it harder to debug the test when something goes wrong.

By the way, don't you find that something does not feel quite right
with this command line?

    git fast-export --refspec=refs/heads/master:refs/heads/foobar master 

Why do we even have to say "master" at the end, when the other
option makes it clear that we are shipping "master" out?

Without thinking ramifications through, my gut feeling is that it
would feel more natural if we took:

    git fast-export master:foobar

to mean the same thing (which is what happens to the users of "git
push").  Is there a case where you have some ref on the left hand
side of the --refspec but you do not push out the history leading to
it?

With such an update, this part of the test would of course look
like:

	git fast-export master:foobar >actual.dump &&
        grep "^commit " actual.dump |
        sort -u >actual &&
        ...

and we do not need a new option.  Just a new extension to express
what gets pushed out.

But of course I may be missing some cases why there need to be a
separate option.
