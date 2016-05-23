From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git reset --hard with staged changes
Date: Mon, 23 May 2016 10:05:20 -0700
Message-ID: <xmqqr3csaenj.fsf@gitster.mtv.corp.google.com>
References: <loom.20160523T023140-975@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Yotam Gingold <yotam@yotamgingold.com>
X-From: git-owner@vger.kernel.org Mon May 23 19:05:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4tII-0001Sq-Eu
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 19:05:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754148AbcEWRFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 13:05:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55931 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752834AbcEWRFY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 13:05:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 95E4F1B9DE;
	Mon, 23 May 2016 13:05:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0cQNfzb7iM07pK9Bh/6eAjY5lR4=; b=YDkhew
	/9HfvMpQ0LroEeTyr4nlAkgXgwY9g3ZwCJCEUNb6BzMuJquh6nnoVJDGkOXBA3RY
	FJDMSJNvKgcQF85kySAwO/zPWzPGEgPPVrL52NdQkF46fxS+VW0yIcYbuMPF3++3
	wOt0Pcj8l/eDJCE+DfuaowG0s3Ctn4gYsLVvE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v8bLepZs+oXBcYExLGw1bJV6Kj4hB5Yt
	Ywimz8YIqd0gefF8WA7a2BkUHkx4cA5zl632aToN/clgMA+hvzsH6Cn0nhqrtXr8
	dV2qFIEGn64c7H2jsV+TlCxHItVV7xTkGqivMX0UXF8IRmOB4ToM0z/Qy7TyuAkh
	wOcxJy08VdQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8DFE11B9DD;
	Mon, 23 May 2016 13:05:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1BB491B9DC;
	Mon, 23 May 2016 13:05:23 -0400 (EDT)
In-Reply-To: <loom.20160523T023140-975@post.gmane.org> (Yotam Gingold's
	message of "Mon, 23 May 2016 00:55:55 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8979247C-2108-11E6-90ED-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295338>

Yotam Gingold <yotam@yotamgingold.com> writes:

> --hard Resets the index and working tree. Any changes to tracked files in the
> working tree since <commit> are discarded.
>
> This should be clarified to define what a tracked file is.

A "tracked file" in that sentence is a file that is not untracked, I
think.

There are only four cases, so let's enumerate:

 * A path that is in HEAD but not in the index.  "reset --hard"
   wants to make the resulting index match what is in HEAD, so
   the path is added back to the index.  "reset --hard" also wants
   to make the resulting working tree match what is in the index, so
   the path in the working tree will be overwritten (or created, if
   you removed it earlier) with the contents taken from HEAD.

 * A path that is in HEAD and also in the index.  "reset --hard"
   wants to make the resulting index match what is in HEAD, and it
   also wants to make the resulting working tree match what is in
   the index, so any changes to the index and the working tree will
   be overwritten by the contents taken from HEAD.

 * A path that is not in HEAD but in the index.  The path is removed
   from the index and from the working tree, due to the same logic
   as the previous two.

 * A path that is neither in HEAD nor in the index.  Nothing
   happens.  This is the "untracked files" case.

The third case may smell that Git is discarding more than it needs
to, and if we were designing Git without any existing users from
scratch today, we might have chosen to remove it from the index and
make the working tree copy simply "untracked", but we already have
more than a dozen users that rely on the current behaviour, so such
a change is not likely to happen.

The biggest use of the third case is to abort a failed merge and to
restart it from scratch.  A path that is not in your branch that the
other branch created since the two branches forked will be added to
the index and to the working tree.  You see conflicts in other paths
(where both branches made changes in different and incompatible
ways), and after looking at it trying to resolve them, realize that
you made a mess and you want to start from scratch, i.e. you run
"reset --hard" followed by the same "git merge".

If "reset --hard" does not remove the "new" file from the index and
the working tree, the next "git merge" will think that the untracked
file is something you may have created, and would refuse to run, so
that it won't lose information.

As "reset --hard" is an operation that is run by the user to discard
the changes, it is understood to deliberately lose information, so
making the third one to remove the path from the working tree
(instead of making it untracked) is a better solution than forcing
the user in the "reset --hard && merge" scenario to see a merge that
does not even start (as opposed to "an attempted merge that resulted
in conflicts) and to manually remove these untracked files that the
user did not even create herself.
