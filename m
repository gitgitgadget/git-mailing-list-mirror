From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git loses commits on git pull --rebase with Dictator and Lieutenants Workflow
Date: Thu, 29 Jan 2015 11:31:14 -0800
Message-ID: <xmqqlhkle64d.fsf@gitster.dls.corp.google.com>
References: <loom.20150128T203924-608@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dick <dick@mrns.nl>
X-From: git-owner@vger.kernel.org Thu Jan 29 20:31:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGuoE-0003CM-RL
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 20:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756920AbbA2TbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2015 14:31:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52034 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755716AbbA2TbS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2015 14:31:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B7A333CAE;
	Thu, 29 Jan 2015 14:31:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zh1PNp0s/wxo/Yfn6U/ThWNZNaE=; b=gSEc5t
	qiK3/iW+rFUiDtu9M/W7q69L7I3V/1ZCce5nWMk8uUJPpwZBvXEIlWOoHEfzDx9h
	w6CQ61/2EvHXkjOQirqi6j0Fg/F/5GQC8eyuFHvT9XSHlyzbcaG5/DqfqfMAGPlb
	TaNrHNdN0d4sEiAYwAIG+/LByQ7w0t1eeULI8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oVo8Zsks/hS59Ytt8yWU8AawcFIo7Rsl
	9/FtwqFOaCWpmLxc76wPiFGwqv2GhKjhvuJoDXrfLaX83xVHcke7riQoQ7cn546n
	pHXX3QeKfoL2X7v1SF80b4MI25FcLqgoBgdTGB5wmc7B+TB3107uWZHJZx9fM62p
	KWIsG7l090o=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 52BE233CAC;
	Thu, 29 Jan 2015 14:31:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C1E0C33CAA;
	Thu, 29 Jan 2015 14:31:16 -0500 (EST)
In-Reply-To: <loom.20150128T203924-608@post.gmane.org> (dick@mrns.nl's message
	of "Wed, 28 Jan 2015 19:49:02 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 64CA79B8-A7ED-11E4-80A1-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263158>

Dick <dick@mrns.nl> writes:

> rm -rf left/ right/ right.git/
> git init left
> cd left/
> echo "hello world" > test.txt
> git add test.txt 
> git commit -m .
> cd ..
> git clone --bare left right.git
> git clone right.git/ right
> cd right
> git remote set-url origin ../left
> git remote set-url origin --push ../right.git

This is not using "origin" and set-url correctly.  Even though you
can use physically different URLs for fetching from and pushing
into, the named repository 'origin' is still conceptually the same
repository.  You use this mechanism when you want to fetch over the
public git:// protocol (which is lighter-weight) while pushing into
the same repository over ssh:// protocol (which may be heavier and
requires authentication).  The important part of the equation is
that the data should go to and come from the same place.  What you
pushed to 'origin', if you fetch from 'origin' again, should come
back to you.

And that is not what your two calls to set-url are doing.

In a triangular workflow to fetch from somewhere while pushing into
somewhere else, you are using _two_ different repositories: your
upstream's repository you fetch from, and your own repository you
push to publish your result.  So you would use _two_ remotes, not a
single 'origin'.
	
The 'right' person, who follows the 'left' developer who publishes
the more authoritative work in 'left.git' for you and others to
fetch from, and publishes his work to 'right.git' to ask 'left' to
pull, would do something like:

	git init --bare right.git
	git clone left right
	cd right
        git remote add mine ../right.git
        git config remote.pushDefault mine
        git push --all;# to publish to ../right.git

to set things up.  Then

	edit && git commit && git other-commands && ...
	git push ;# updates ../right.git

to publish his work.  Updating from 'left' would go like this:

	# pretend 'left' did something
	( cd ../left && git commit --allow-empty -m empty )

	git pull ;# or 'git pull --rebase'
