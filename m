From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] rerere: let caller decide whether to renormalize
Date: Wed, 04 Aug 2010 11:12:31 -0700
Message-ID: <7vocdifdrk.fsf@alter.siamese.dyndns.org>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
 <20100804031935.GA19699@burratino> <20100804032338.GF19699@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git\@vger.kernel.org List" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 20:12:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgiSX-00051Q-9L
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 20:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757400Ab0HDSMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Aug 2010 14:12:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46770 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757312Ab0HDSMp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 14:12:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D69CCCAFB6;
	Wed,  4 Aug 2010 14:12:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=poZtl4oO0fUMc7hyy9x2mdidyK4=; b=rvFw08x2KrYceGQCgu5fj37
	vWnE7vZGfr9nj8ohXA6KYeBpkhTENmI0DtE4vCWLXW+Sge/gLJvvCMNitmCWzEjl
	IaW8GxWvjx5BtS84JsBlGEfeh7IJfDs17W19ItY1YQNKSJq1amUqOr3GOjuYAzNi
	+hy5QozKpl+cJb1WpoGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=TEUV+OCqpcxLsartThMRjxrOef54Hn3Lk6s0+ywnYimRqFmti
	bga/YiYc+ouFjmThzha1uootqdNcAZOJcwuchsAOYZ68YlmlM/jmOGyNx3ItPQ23
	LseP+1ty5rvRGnvrhVS6ZG+uA0czNlG8uu/j2j2m8bhuODRrYbJUOg++hQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 806D6CAFB3;
	Wed,  4 Aug 2010 14:12:39 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7AAB7CAFB1; Wed,  4 Aug
 2010 14:12:33 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DE0246A0-9FF3-11DF-B6D1-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152589>

Jonathan Nieder <jrnieder@gmail.com> writes:

> NEEDSWORK: this is a step in the wrong direction.  rerere needs
> an -s option to use an arbitrary merge strategy and a -X option to
> pass arbitrary options to that driver.

If you are talking about "rerere", I strongly disagree with that.

1. "-s"

   A "merge strategy" deals with the shape of the history (e.g. common
   ancestor selection or synthesis for the purpose of 3-way merge) and the
   shape of the trees (e.g. rename detection, subtree shifting).  Starting
   from two commits, it decides, based on the shape of the history, what
   three trees your tree-level 3-way merge would operate on, and then
   based on the shape of the trees, decides the pairing of blobs to run
   the 3-way merge at the file-content level.

   When "rerere" is invoked, a strategy already has dealt with all of the
   above, and "rerere" only works on the (half-completed) result of that.
   It is purely a three-way merge at the file-contents level and there is
   no room for a "strategy" to get involved.  It makes direct calls to
   ll_merge() exactly for this reason.

2. "-X"

   In the "merge -X<opt>" syntax, "-X" does not stand for "low level
   details"; it just means "eXternal callout".  It is there just to tell
   the "merge" front-end "You may not understand this yourself, but the
   program you call does, so just pass it along".

   IOW, we want to be able to pass --<opt> through the frontend to the
   backend, without having to tell all the options any possible backends
   may know to the frontend.  Just to make it easier to parse and tell
   which ones are the front-end options and which ones are not (for both
   machines and humans), we say -X<opt> to the frontend.  Then "merge"
   turns that -X<opt> into "--<opt>" and give it to the strategy.

   A command that natively knows about an option is correct to take an
   option as "--<option>", e.g. "merge--recursive --renormalize".  You
   trigger it by saying "merge -Xrenormalize" from the frontend.


To recap: it is absolutely the right thing to do to introduce a new
"rerere --renormalize" option, like your patch did.  Doing anything else
IS a step in the wrong direction.
