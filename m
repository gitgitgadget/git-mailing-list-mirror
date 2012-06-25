From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] revision: Show friendlier message.
Date: Sun, 24 Jun 2012 22:28:25 -0700
Message-ID: <7vobo8hsee.fsf@alter.siamese.dyndns.org>
References: <1340478681-58476-1-git-send-email-muhtasib@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Leila Muhtasib <muhtasib@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 07:28:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj1qj-00082C-7Y
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 07:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339Ab2FYF23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 01:28:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51112 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752176Ab2FYF22 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 01:28:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A2423CF7;
	Mon, 25 Jun 2012 01:28:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qEA6PCOLadaNXCqvYR9BGFA2nw8=; b=TMgjG1
	mTXTFm8aKq/zenvXGulBBRjFMB29tBS7QnEh9BDwJ2EMOOAwim8L67jqmQYfr2aI
	Oxigf7TYPmkgl9fm0CA7SSTUlotpOCanHXV+m4vRz/EjwEu52gTpZB4pC5pXoeOg
	sjz56XyigII2Sp4mNC7Np9eoKcwNeRKk8ziyA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JnWWgmgIbmG3kE6haUOYb3mpAEFh2GS7
	1WSWaB0FdqB3vlzUCvoP7hDxQIGpfzRhaVo+k2bUfi5Az2YGgMcjXfVBvTZimrgc
	9EuXfnbbDnWPQWVJaVOjO53LrCDv8/GC2usR6c+9NNqXMalDouNZgUJzolZ+0vNi
	NWjfVWPiSGI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FD253CF6;
	Mon, 25 Jun 2012 01:28:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 248E43CF5; Mon, 25 Jun 2012
 01:28:27 -0400 (EDT)
In-Reply-To: <1340478681-58476-1-git-send-email-muhtasib@gmail.com> (Leila
 Muhtasib's message of "Sat, 23 Jun 2012 15:11:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 97542CEC-BE86-11E1-8DB7-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200544>

Leila Muhtasib <muhtasib@gmail.com> writes:

> % mkdir test
> % cd test
> % git init
> Initialized empty Git repository in .git/
> % git log
> fatal: bad default revision 'HEAD'

I agree that the message, while it is technically correct and does
not deserve to be called a bug, can be made more friendly.

But setup_revisions() is a very low level routine that is used by
many plumbing commands, and it is a horrible layering violation to
tweak its behaviour based on argv[0] and also it is too inflexible
hack as a solution.  For example, don't you want to give a different
error message for "git log HEAD" with an explicit "HEAD" from the
command line?  Would you add a similar support for a command that is
not "log" by adding yet another strcmp() here?

Wouldn't it be a more reasonable alternative solution if you do this:

 1. Check if HEAD points at a commit _before_ setting opt->def to it
    in "git log" (and other end-user facing programs in the "log"
    family, possibly in cmd_log_init_finish() if that function is
    not called by a program where the current message should not
    change), and do _NOT_ set opt->def to it;

 2. Make setup_revisions() expose got_rev_arg to its callers
    (e.g. move it to struct rev_info);

 3. If you did not pass HEAD in opt->def and setup_revisions() said
    it did not "got_rev_arg", give whatever error message that you
    think is more user friendly.

That way, if HEAD points at a commit, or if HEAD doesn't point at a
commit but the user gave some existing commit from the command line,
you wouldn't see "bad default revision" at all.

And the most important part of this alternative is that the lower
level machinery does not have to _care_ about the reason why the
higher level passed a bad HEAD to it.

Personally, I tend to think that not saying anything and reporting
success, instead of any error message, would be the right thing to
do if you are changing the behaviour of this case anyway.

Hrm?
