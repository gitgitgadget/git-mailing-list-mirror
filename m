From: Junio C Hamano <gitster@pobox.com>
Subject: On --depth=funny value
Date: Tue, 08 Jan 2013 18:53:49 -0800
Message-ID: <7vy5g383sy.fsf_-_@alter.siamese.dyndns.org>
References: <1357632422-5686-1-git-send-email-stefanbeller@googlemail.com>
 <CACsJy8BLLTWd+cTBj1jNW=ODPy7=Kg4-TPUdZ82YCE-0RQpMZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 03:54:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tslnx-0005QL-Nw
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 03:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756251Ab3AICxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 21:53:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61659 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755306Ab3AICxw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 21:53:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C340A10B;
	Tue,  8 Jan 2013 21:53:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DvZupofO9akcHio9lyJqBr4aJAs=; b=Lp4yMe
	mvbygu/nz0mjDHiDeDNGwXWWNB7Pt9VbfPVQPNQLaa8g/VcbCJoF3KiWFKb7Cocm
	Mlw+uucCMwvj1lK3Nq3xvgpEFgFSZtk12CJ/1QBBGqT8wt7N6lg206+l6TfGb5Wm
	/0ZLnd8UbkRDHy7BuEWzjR7AK/RnR+L6OeKmA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c+ZJhBchb3KSH73jMoUrDizzDInK2IKI
	LRQpXxmQshfMlVRz1LgrmdoSDDfzK7ROBr7zbYSdBu0xo4af5d2tvWgpbqQh2jF7
	nBKX0DdXwL/uiP++sft4TTrEh5J4q4sPfL43m2zCPE16XJNamgw6thlhGUgaamzc
	uV4M5dsX4e0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 805E9A108;
	Tue,  8 Jan 2013 21:53:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5D09A106; Tue,  8 Jan 2013
 21:53:50 -0500 (EST)
In-Reply-To: <CACsJy8BLLTWd+cTBj1jNW=ODPy7=Kg4-TPUdZ82YCE-0RQpMZA@mail.gmail.com> (Duy
 Nguyen's message of "Wed, 9 Jan 2013 07:57:43 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC09EFAE-5A07-11E2-BF1A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213023>

Here to outline my current thinking.  Note that this is unrelated to
the "git clone --bottom=v1.2.3" to say "I do not care about anything
that happened before that version".

 * First, let's *not* do "git fetch --depth=inf"; if you want to
   unplug the bottom of your shallow clone, be more explicit and
   introduce a new option, e.g. "git fetch --unshallow", or
   something.

 * Make "git fetch" and "git clone" die() when zero or negative
   number is given with --depth=$N, for the following reasons:

   - The --depth option is describe as:

         ("git clone") ... a 'shallow' clone with a history
         truncated to the specified number of revisions.

         ("git fetch") Limit fetching to ancestor-chains not longer
         than n.

     It is fairly clear from the above that negative $N does not
     make any sense.

     Technically, fetching the commits that were explicitly asked
     for and not there parents is the only possible ancestor-chain
     that is not longer than -4, so "git fetch --depth=-4" ought to
     behave just like "git fetch --depth=0", but you have to be very
     sick to read the documentation and expect things to work that
     way.  Also there is no way to misread the "git clone"
     documentation and expect "git clone --depth=-4" to create a
     history truncated to negative number of revisions.

     Which means that it is the right thing to do to die() when a
     negative number is given to --depth for these commands.

   - As people count from one, the natural way to ask for the tip
     commit without any history ought to be "--depth=1".  Let's
     declare the current behaviour of "--depth=1" that gives the tip
     and one commit behind it a bug.

     Which means that these commands should be updated to die() when
     zero is given to their --depth option.  "Do not give me any
     history" is inherenty incompatibe with "clone" or "fetch".

     Because there is no configuration variable "fetch.depth" (or
     "clone.depth") that forces all your cloned repositories to be
     shallow, "git clone --depth=0" or "git fetch --depth=0"
     couldn't have been ways for existing users to ask to defeat any
     funny configured depth value and clone or fetch everything.
     When they wanted to clone or fetch everything, they would have
     just used the command without any "--depth" option instead.

     Which means that nobody gets hurt if we change these commands
     to die() when zero is given to their --depth option.

 * We would like to update "clone --depth=1" to end up with a tip
   only repository, but let's not to touch "git fetch" (and "git
   clone") and make them send 0 over the wire when the command line
   tells them to use "--depth=1" (i.e. let's not do the "off-by-one"
   thing).

   Instead, fix "upload-pack" (the bug is in get_shallow_commits()
   in shallow.c, I think), so that it counts correctly.  When the
   other end asks for a history with 1-commit deep, it should return
   a history that is 1-commit deep, and tell the other end about the
   parents of the returned history, instead of returning a history
   that is 2 commmits deep.  So when talking with a newer server,
   clients will get correct number of commits; when talkng with an
   older server, clients will get a bit more than they asked, but
   nothing will break.

Can people sanity check the reasoning outlined here?  Anything I
missed?

The above outline identifies three concrete tasks that different
people can tackle more or less independently, each with updated
code, documentation and test:

 1. "git fetch --unshallow" that gives a pretty surface on Duy's
    "--depth=inf";

 2. Making "git fetch" and "git clone" die on "--depth=0" or
    "--depth=-4";

 3 Updating "upload-pack" to count correctly.

I'll refrain from saying "Any takers?" for now.
