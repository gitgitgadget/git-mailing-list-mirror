From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] Add a config option for remotes to specify a foreign
 vcs
Date: Mon, 10 Aug 2009 01:47:00 -0700
Message-ID: <7v63cw3vjv.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.0908091526060.27553@iabervon.org>
 <7v1vnk79lt.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.0908092153520.27553@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brian Gernhardt <benji@silverinsanity.com>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Aug 10 10:47:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaQXH-0004ep-DQ
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 10:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327AbZHJIrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 04:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752119AbZHJIrL
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 04:47:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36509 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbZHJIrK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 04:47:10 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B62202462F;
	Mon, 10 Aug 2009 04:47:09 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AA2A12462E; Mon, 10 Aug 2009
 04:47:02 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 63FC1054-858A-11DE-BB49-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125410>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I think that users should never need to know the names of the helpers. I 
> mean, the native protocol uses helpers that most users are completely 
> unaware of. The users do need to know what the 

... heck ;-)?

But seriously, why not?

> The problem is not that foreign systems don't have "urls" in particular. 
> The problem is that there are foreign systems, like perforce, where the 
> lines between different repositories in the git sense are drawn in very 
> different ways. In perforce, for example, there is a single namespace for 
> all branches of all projects hosted on the same server. It's like... 
> ...
> (and hundreds more, mixing all the branches of all of the repositories 
> for all of the projects, without any conventions beyond what the 
> community on the particular server made up)

That looks similar to a subversion server with multiple projects with
multiple branches, and they seem to be able to use

    "svn://<whatever svn uses as its own convention>"

just fine.

Why p4 cannot do what svn can?  Doesn't p4 ever "name" a repository/branch
inside that "single namespace" with a simple string that is easy to
remember for users?  And if there is one, I do not see what prevents you
from using "p4://<whatever information p4 users use>"?

> You really need a different sort of configuration option to specify what 
> we think of as "the git.git repository", which includes certain branches 
> and doesn't include other projects hosted on kernel.org. And in order to 
> find the server, it uses an arbitrary shell command line that acts like 
> rsh (and often consists of "ssh" as the command and a bunch of complicated 
> options to connect to the right port of the right host to get the right 
> restricted shell with the right preset environment). So there's nothing 
> you can put in the <whatever string the helper understands> part, because 
> the helper really has to figure out what it's doing from a bunch of 
> options.
>
> Furthermore, I don't want to just use "p4:" as what people should use in 
> remote.*.url in order to select the right helper, because then people are 
> going to have different remotes with the same url option value in order to 
> access entirely different data.

Maybe it is the _primary_ itch you would want to scratch, but this does
sound like a very special case that wants to have multiple pieces of
pre-parsed information to identify a "repository".

Perhaps in such a case it would be equally valid if you said "p4:hello"
and "p4:goodbye" to identify two "repositories", with p4-helper specific
configuration option that is keyed off of of p4.hello.* and p4.goodbye.*
namespace, e.g. (without knowing p4 at all)

	[remote "origin"]
        	url = p4:hello
	[p4 "hello"]
        	find-server-command = ssh bunch of complicated options
		random-p4-option = ...
		random-other-p4-option = ...

Of course it does not have to be called "url", and you could do the same
thing with:

	[remote "origin"]
        	vcs = p4
	[p4 "origin"]
        	find-server-command = ssh bunch of complicated options
		random-p4-option = ...
		random-other-p4-option = ...

And probably there aren't much difference either way between these two
appraoches.  The former gives an extra name ("hello") that may simply be
redundant, or perhaps adds value by descriptive, depending on your
viewpoint.
