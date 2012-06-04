From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Help: Found odd git bug
Date: Mon, 04 Jun 2012 10:52:50 -0700
Message-ID: <7vd35ft159.fsf@alter.siamese.dyndns.org>
References: <4FCCE433.7090007@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 19:53:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbbSb-0006uM-Ax
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 19:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754885Ab2FDRwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 13:52:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50366 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754478Ab2FDRww (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 13:52:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6072E8E43;
	Mon,  4 Jun 2012 13:52:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FXYuwwYnglZoHwGZYMRcdBB5pgw=; b=reZJEf
	AxoFfYqVPOcqNkE0XSZNFlDaPHFSfYDfNGVPxQTSxE+ZXVIM937kQSjRw6XxzBYv
	Sm1jHOmQaz7ROkjpNWtie3aNfeP+VGbLnF0kGjyRpWpFvZPYCJX0HqKO/b2fIezV
	3e2fxOP7WwkOLgjBBmDdJjgz++IhlxAXXhFY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U9wU/UX5jN6Lrs802LxuKHy8LXCTvzE7
	jQ5Rwsg7cruqClhDx38AeZYCyUaXgdTIf9dY1VLS71o6i1gYrVR8ivKKDeat2DPQ
	L2/UyaNYq1N/68yDC5Gyy/JglFyUMGgGR2aR3KW0QjCzFml5YGhEqkgf6z66YxWt
	XzGI+sW50u0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 571E88E42;
	Mon,  4 Jun 2012 13:52:52 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DE6A48E41; Mon,  4 Jun 2012
 13:52:51 -0400 (EDT)
In-Reply-To: <4FCCE433.7090007@xiplink.com> (Marc Branchaud's message of
 "Mon, 04 Jun 2012 12:37:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1AED23DE-AE6E-11E1-9621-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199163>

Marc Branchaud <marcnarc@xiplink.com> writes:

> A commit claims to add a line to a file.  Indeed, "git diff" shows the line
> being added.
>
> However, when I check out the commit, the file contains a *different* line,
> with slightly modified contents.
>
> What's more, "git show SHA:path/to/file" shows that the blob contains the
> wrong line.
>
> I found this using git 1.7.9, but 1.7.11.rc1 also shows the problem.
>
> How can I narrow down what's causing this problem?

Without any information useful to diagnose, I would say it probably
is not a bug but is an operator error when either of the "git diff"
or "check out the commit" steps were done.  Even if you cannot share
the repository, at least a _complete_ command line with arguments is
needed.

For example, we can _reproduce_ your symptom description like this.

	$ echo this line was added >file
        $ git add file
        $ git commit -m 'added a line'
        
	$ echo another addition >file
        $ git diff
	 some context
        +another addition

	Ok, the "git diff" shows the line "another addition" being
	added.  Let's check:

	$ git show HEAD:file

	Huh? The output does not contain "another addition". What is
	going on?

What is going on in the above is an operator error, thinking the
"git diff" gave the change introduced by the commit, while it asked
the change to the working tree _since_ the commit.
