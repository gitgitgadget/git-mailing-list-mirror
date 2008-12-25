From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rev-list with --name-status?
Date: Wed, 24 Dec 2008 19:24:32 -0800
Message-ID: <7vhc4tc4y7.fsf@gitster.siamese.dyndns.org>
References: <2729632a0812241453x4ae50362g4bcd3317e5be0429@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Thu Dec 25 04:29:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFgv5-0007Ao-Gp
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 04:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbYLYDYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2008 22:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbYLYDYm
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 22:24:42 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56368 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbYLYDYl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 22:24:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A6A608A1D1;
	Wed, 24 Dec 2008 22:24:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A64298A1CF; Wed,
 24 Dec 2008 22:24:34 -0500 (EST)
In-Reply-To: <2729632a0812241453x4ae50362g4bcd3317e5be0429@mail.gmail.com>
 (skillzero@gmail.com's message of "Wed, 24 Dec 2008 14:53:00 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8F14FC5C-D233-11DD-BCCE-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103890>

skillzero@gmail.com writes:

> I'd like to also include the output of --name-status so the email
> shows which files were changed by each commit (rather than just a
> summary at the end since our pushes sometimes have a lot of commits in
> them).
>
> git rev-list doesn't seem to support --name-status and git log doesn't
> seem to support --stdin. Is there a better way to do what I want?

The plumbing rev-list never runs diff internally.

Depending on what you want, "git log --stat" or "git log --name-only" or
even "git log --name-status -B -C" may serve you nicely.

"Depending on what you want" is the key phrase that indicates that what
you are asking for would be most likely found in Porcelains, not plumbing.

Even though there is not much reason to _avoid_ using "log" these days,
you could do your own scripting for whatever reason; perhaps you feel like
it would be a more macho thing to do (which isn't), perhaps you want more
customization than options supported by the stock "log" Porcelain gives
you.

In olden days, people scripted around plumbing, partly because the
Porcelains were implemented that way, and partly because the choices the
Porcelains back then gave you was limited than what we have now.  Your
script may look like this:

    git-rev-list --parents $range |
    while read commit parents
    do
            ... do whatever you want with them ...
    done

or

    git-rev-list --pretty --parents $range |
    perl -e '
    	while (<>) {
        	if (/^commit /../^$/) {
			if (/^commit (\S+)(.*)?/) {
				... we have a new commit; flush what
                                ... you accumulated for the previous one.
				... and prepare for this commit.
				... $1 is the commit, $2 has parents you
                                ... can further split
                        }
			... do "header" things here ...
                        next;
                }
                s/^    //;
                ... do "log" things here ...
	}
        ... flush what you accumulated for the last commit.
    '                
