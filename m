From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] push: change `simple` to accommodate triangular workflows
Date: Mon, 24 Jun 2013 00:43:31 -0700
Message-ID: <7v38s8dkd8.fsf@alter.siamese.dyndns.org>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
	<1372048388-16742-4-git-send-email-gitster@pobox.com>
	<CALKQrgfAT9GhD-_tZHr9wRA6R6g7ttDWTsmUQXdWUhG-gwNBqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jun 24 09:43:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur1R4-0004ZK-SS
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 09:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752959Ab3FXHnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 03:43:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64428 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752952Ab3FXHne (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 03:43:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1022D27077;
	Mon, 24 Jun 2013 07:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Khs5776zNew72JenFWXcMfFAU7c=; b=Rp4LAG
	KGZQ265mSXwrRdS31qCTpe+I/wSWsXUE2cGucyCNfSQ6Agn/w5FnTl8iYc8/uV4m
	u/AlZxiiTZ3vhxk5OUJ80Cl1wnA+X3hAvIhwdy8+B9ZY904FJTkYKv8PF+lMNfqS
	J0jj5Omjgg9zUjcrE4CR+4ITZxe9zCyFmBYPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ABukozgckqODLoFVaFn5sSfxvL6BBgi7
	STyIky1bg/4NFvVqyVklSkdCM/iN7r0JrjVvnsbcnS/E8DsogjYit4mQOxIlSK8z
	bowswTGEZ9GzoXJMWsT87ILd3s7PoQsM3cOANVKLTt/qkEL75I24F5oEaBZ/d0kG
	yJrMghLMDME=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D13BB27076;
	Mon, 24 Jun 2013 07:43:33 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2628F27075;
	Mon, 24 Jun 2013 07:43:33 +0000 (UTC)
In-Reply-To: <CALKQrgfAT9GhD-_tZHr9wRA6R6g7ttDWTsmUQXdWUhG-gwNBqQ@mail.gmail.com>
	(Johan Herland's message of "Mon, 24 Jun 2013 08:58:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C53FBBD2-DCA1-11E2-9D21-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228784>

Johan Herland <johan@herland.net> writes:

>> +static void setup_push_current(struct remote *remote, struct branch *branch)
>> +{
>> +       if (!branch)
>> +               die(_(message_detached_head_die), remote->name);
>> +       add_refspec(branch->name);
>
> Here (and above) we add a refspec to tell Git exactly what to push
> from the local end, and into what on the remote end.

Correct.

> Is it possible to end up with multiple simultaneous refspecs
> matching the same local ref, but mapping to different remote refs?

Sorry, I don't follow.  If you say "push.default = current" and you
do not give any other stronger clue (e.g. "git push origin master"
on the command line, or "git push [origin]" with remote.origin.push
configured), the above function is called and sets up your current
branch to be pushed to the same.

It is a bit more interesting for "push.default = upstream", which is
for centralized workflow.  If you forked frotz and nitfol branches
both from their master, e.g.

	$ git checkout -t -b frotz origin/master
	$ git checkout -t -b nitfol origin/master

after having worked on one of the branches, when you want to push it
back, the result of working on the topic branch goes back to master,
but I think that is what you want in the centralized workflow.  If
it fast-forwards, you are fine, and if it does not, you will fetch
your upstream, i.e. their master, integrate your work with it, and
then push it back.  At that point, you are playing the role of the
integrator of the shared master branch, because what you do on your
topic branch when you integrate others' work from master is exactly
that---you are not perfecting the theme you wanted to achieve on
your topic branch, but are integrating that result into shared
master to advance the overall state of the project.  So pushing the
result back to 'master' makes perfect sense.  After that, when you
have to restart your work on the other branch, you may first "pull
--rebase" before continuing, or you may just keep going with your
work based on a tad old origin/master.  But when you finish working
on that topic and are about to push it out, you would be doing the
same "tentatively don the central integrator's hat", and again it
makes sense to push the result to 'master'.

So in that sense, it is not "which one wins".  It is more like "you
can push only after you become up to date, so there isn't one branch
overwriting the other one."

That is how I view it, anyway.

 cf. http://git-blame.blogspot.com/2013/06/fun-with-various-workflows-1.html

>> +static int is_workflow_triagular(struct remote *remote)
>
> s/triagular/triangular/

Thanks.

>
>> +{
>> +       struct remote *fetch_remote = remote_get(NULL);
>> +       return (fetch_remote && fetch_remote != remote);
>
> This changed from a strcmp() to a pointer compare. That might be safe,
> depending on the sources of the two struct remote *, but I'm not sure.

Given the way remote_get() works, it should be correct, I think.
