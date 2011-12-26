From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add post-fetch hook
Date: Sun, 25 Dec 2011 23:59:46 -0800
Message-ID: <7vlipz930t.fsf@alter.siamese.dyndns.org>
References: <20111224234212.GA21533@gnu.kitenet.net>
 <7v4nwpbaxq.fsf@alter.siamese.dyndns.org>
 <20111225035059.GA29852@gnu.kitenet.net>
 <7vsjk99exw.fsf@alter.siamese.dyndns.org>
 <20111226023154.GA3243@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Mon Dec 26 09:00:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rf5Tk-0004Tk-GE
	for gcvg-git-2@lo.gmane.org; Mon, 26 Dec 2011 09:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753736Ab1LZH7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Dec 2011 02:59:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44686 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753200Ab1LZH7u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Dec 2011 02:59:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F0464324;
	Mon, 26 Dec 2011 02:59:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Gcxc/AQac6CEj8KHYhj+BWXcdqY=; b=xn7L/s
	dYcdQ2tcIOvJJbvK1zA8wPXt8HRHioCOjQiVaaICC0q8UcX06U10uF/2pOgYSpSb
	sk6LQL0BV6GH7XpxZDRCqK6FvJxK1ifb77/Tp2y+lDmxTd2BhB+/wecVaTuPOgXG
	MWhPtW/sdGaZVuHxJXz4DrtgzPOdVQH5qJJ2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FtzsrFR1gMyqzJbdLtHTVakuiOSzGiGM
	99sinHgttIU8UykUSWaALlgVCanSSa/+UEak6ijj4dqNs4BZQtYmihnjPHN/wQkC
	Dq+2vjoaHDh3fLPOBejXyw67RjOdXEIyRTaSYqOQFfS4MGqlftt7abacKci1rGSt
	LxD2fh8UlTk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BEB64323;
	Mon, 26 Dec 2011 02:59:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4CB134322; Mon, 26 Dec 2011
 02:59:48 -0500 (EST)
In-Reply-To: <20111226023154.GA3243@gnu.kitenet.net> (Joey Hess's message of
 "Sun, 25 Dec 2011 22:31:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94F17DA2-2F97-11E1-B8D4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187692>

Joey Hess <joey@kitenet.net> writes:

> The post-fetch hook is fed lines on stdin for all refs that were fetched, and
> outputs on stdout possibly modified lines. Its output is parsed and used
> when git fetch updates the remote tracking refs, records the entries in
> FETCH_HEAD, and produces its report.
>
> ---
>
> Not quite ready to sign off on this yet, but it does work.
> Comments and code review appreciated.

Thanks. I do have a few comments.

This hook is no longer a "post" fetch hook. The mechanism lets the object
transfer phase does its work and then rewrites/tweaks the result before
fetch completes. To an outside observer, what the hook does is an integral
part of what "fetch" does, and not something that happens _after_ fetch
completes. I am bad at naming things, but something along the lines of
"tweak-fetch" that makes it clear that what happens in the hook is still
part of the fetching may be a more appropriate name, methinks.

I very much on purpose said that the hook "must read everything from its
standard input, *and* *then* return..." in my response. Your "Demo" hook
emits output as it reads its input with sed, but your main process invokes
the hook, drains everything with write_in_full() before starting to read a
single line, so I suspect that your hook will deadlock when its output
pipe buffer fills up without being read by the main process. Of course,
for this deadlock to actually happen, you need to be fetching quite a lot
of refs.

To make the life of hook writers easier, however, it would be good to
support a hook written in the style of your "Demo" hook, instead of
requiring it to read everything before emiting any output. I think you
could solve this by having a select(2) loop to avoid the deadlock on our
end (lets call the code that spawns a hook with run_command() and
interacts with it a "hook driver" in the rest of this message), but before
going in that direction, I would like to see us stepping back and bit and
think about the way hooks are called in the current code.

We seem to already have too many hook drivers, each of which hand-roll
similar logic using run-command API. At some point, we would want to have
a single "run_hook" helper function that takes:

 - the name of a hook;
 - the command line arguments to be fed;
 - a callback "generator" function to feed the standard input stream of
   the hook process;
 - a callback "consumer" function to receive the standard output stream of
   the hook process; and
 - set of environment tweaks while running the hook (e.g. run the hook
   while setting GIT_INDEX_FILE to a temporary file).

and hides away the complexity from hook drivers.  The command line
arguments, input and output callback functions are all optional depending
on the API between the hook driver and the hook (e.g. the "post-update"
hook takes arguments from its command line but does not interact with the
standard I/O stream, while the "post-receive" hook takes its input from
the standard input stream). Tweaking of the environment is also optional;
not many hooks need it.

By formalizing the hook driver API that way, any hook driver that drives a
tricky hook that may need a select(2) loop to avoid a deadlock in a way
similar to your patch do would not have to worry about the issue, as the
run_hook() helper would take care of it by reading from the hook's output
pipe and drain the pipe by calling the "consumer" callback before calling
the "generator" callback and feed more input to the hook to cause a
deadlock. We also could in the future do many other things if and when we
wanted to that the current code structure makes difficult. A few examples
that readily come to my mind are:

 - relocate where the hook scripts live, by limiting the hook driver API
   to take just the "name" of the hook. The current hook callsites know
   that the hooks live in git_path("hooks/$name") and call run_command()
   on their own, but the run_hook() helper could redirect it away to
   somewhere else, e.g. "/etc/git-core/hooks/$name".

 - run a set of hooks on the same triggering condition. You may want to
   have two "post-receive" hooks, one to feed an e-mail based notification
   system and another to drive an autobuilder, for example. For this to
   work, the "generator" and "consumer" callbacks need to have a way for
   us to tell "beginning of a new session" and "end of a new session", so
   that they can produce/consume the same set of values more than once.

 - perhaps ignore SIGPIPE if the hook chooses not to read any information
   the hook driver provides with it.

I have been wondering when would be the good time to refactor the hook
driver API.  We can add your patch, after polishing it enough to make it
ready for inclusion, independent of the hook API refactoring. But that
would mean that it would require more work when refactoring the hook API,
as we would have one more hand-rolled hook caller that is based on
run_command().
