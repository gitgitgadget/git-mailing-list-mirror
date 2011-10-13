From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Bug] git pull doesn't recognize --work-tree parameter
Date: Thu, 13 Oct 2011 11:01:13 -0700
Message-ID: <7vbotk6aae.fsf@alter.siamese.dyndns.org>
References: <E95C75ED-99F2-463C-A1AB-0F8152696739@jetbrains.com>
 <20111013155923.GA13134@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 13 20:01:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REPas-0002cV-E9
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 20:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369Ab1JMSBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 14:01:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43600 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932224Ab1JMSBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 14:01:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C640B461C;
	Thu, 13 Oct 2011 14:01:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5KJzGHEyx/DH1wrrNZkNHGT0iVU=; b=ELAOOR
	3kiJ60CM6cGCmVFu4gX2kcw4JB9i9zstSjc0ihy+LoxvQ51nmJE89YfP3uY1FMdf
	WL0kmr5lRYUogljIoSJzQvcujEIgEofLIJSERXQguIMFq4pleRx0lkYKKAkttJ2z
	YQWV35uuZyn3OZ+ua6MT11MZqImj7z+DhBpOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NWzKwXrU5m3MgL80/lefQuEMTkMknoKk
	7fbhQL+lhx20zXdKM6YaYCsvTbiKkYcGmio7prEZkBkSX7M84ZbRFtJzLToi85UX
	0BmE/xycUQYKLATWUiznfiOwvYgrJ8G1xj2qI4qUJNZ7ge0Mb62muP9fd/YAWqAq
	8qD35WnYqWk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC3CA461B;
	Thu, 13 Oct 2011 14:01:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E604461A; Thu, 13 Oct 2011
 14:01:15 -0400 (EDT)
In-Reply-To: <20111013155923.GA13134@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 13 Oct 2011 11:59:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 57DE674C-F5C5-11E0-900A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183502>

Jeff King <peff@peff.net> writes:

> Changing these scripts to use require_work_tree_exists is
> easy to verify. We immediately call cd_to_toplevel, anyway.
> Therefore no matter which function we use, the state
> afterwards is one of:
>
>   1. We have a work tree, and we are at the top level.
>
>   2. We don't have a work tree, and we have died.
>
> The only catch is that we must also make sure no code that
> ran before the cd_to_toplevel assumed that we were already
> in the working tree.
>
> In this case, we will only have included shell libraries and
> called set_reflog_action, neither of which care about the
> current working directory at all.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This is the low-hanging, obviously correct fruit.

I am not absolutely sure about "obviously correct", given that you assume
that cd_to_toplevel does what its name makes you think it does.  I've been
wondering if we want to do give a bit more sanity to "cd_to_toplevel" and
"rev-parse --show-toplevel".

    $ pwd
    /srv/project/git/git.git
    $ (cd Documentation/howto && git rev-parse --show-toplevel); echo $?
    /srv/project/git/git.git
    0

So far so good, however:

    $ (cd .git/refs/heads && git rev-parse --show-toplevel); echo $?
    0

I do not think this is quite right.

We would probably want to add "rev-parse --show-work-tree", but we would
need to audit the users of cd_to_toplevel before starting to use it.  I
wouldn't be surprised if there is a script that creates a temporary work
tree in .git/some/where and runs the scripted Porcelains without setting
GIT_WORK_TREE, relying on the historical behaviour of cd_to_toplevel that
does not really go to the top level.
