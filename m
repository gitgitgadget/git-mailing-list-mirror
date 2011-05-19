From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] unpack-trees: add check_worktree flag to enable
 dry-run functionality
Date: Thu, 19 May 2011 11:14:42 -0700
Message-ID: <7vei3u7e25.fsf@alter.siamese.dyndns.org>
References: <7vd3jm74gv.fsf@alter.siamese.dyndns.org>
 <4DD0043D.1050101@web.de> <7vfwofpvai.fsf@alter.siamese.dyndns.org>
 <4DD2CFD4.7060508@web.de> <7vpqnheygi.fsf@alter.siamese.dyndns.org>
 <4DD557AF.4030700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu May 19 20:15:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN7kj-00025p-F0
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 20:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934118Ab1ESSPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 14:15:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38496 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934030Ab1ESSOu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 14:14:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D3AB75B50;
	Thu, 19 May 2011 14:16:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jJgaRfhOC4cYeKss2GmLwvn66as=; b=A5nvUK
	B9x2B9WOmXgeMtO7hoEeBRWLmXdTfr0xRNvR+0K5i28awyKeAHWHlTKowA4DNq6y
	N6ZNjAXlmgAoDaj/pBeK110Pi0nJh+jOP7KaV5Xd3u0vMU9RD8FdEwemWUHWJcbE
	Bjhk1+DNg7dTLNAMm0cORvnGCbyEwXUJ/e9d0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eGQKR86ACBkaG94XT60VMNIZ7tZvf0VA
	2JW8sWGZtFoG9ADKpLNJx6js37vsKMZyV7dHngS9Z4wamocrZTIz0y3AbaFQ8iVH
	o+TMlEdI9SYvPFI/AzF2Eb/efEz0qRbzecij3Z0FSyYKkpVvOsNPYWb2eKhKTKXG
	nqVvTwR0Clw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B20615B4F;
	Thu, 19 May 2011 14:16:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 82F685B4E; Thu, 19 May 2011
 14:16:50 -0400 (EDT)
In-Reply-To: <4DD557AF.4030700@web.de> (Jens Lehmann's message of "Thu, 19
 May 2011 19:47:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2C768D68-8244-11E0-8FC6-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173986>

Jens Lehmann <Jens.Lehmann@web.de> writes:

>>> +	if (opts.update && dry_run)
>>> +		opts.update = 0;
>> 
>> ... this hunk must go, right?
>
> But this is the "don't update the work tree when -n is used together
> with -u" part, so it is needed, no? With this patch applied first and
> opts.check_worktree set to 1 inside that if() added there all tests
> succeed.

I would say the natural way to do your "dry-run" would be to change the
inner guts of unpack_trees() codepath that currently does

	if (opts.update) {
		if (do something to the work tree and get non-zero on failure)
			die("... cannot update '%s'", path);
	}

with your "-n" work to

	if (opts.update) {
        	if (opts.dry_run) {
			if (would the work tree operation fail?)
				say("... update would fail because ... '%s'", path);
		} else {
			if (do something to the work tree and get non-zero on failure)
				die("... cannot update '%s'", path);
		}
	}

and that was why I thought you would want to keep the original value of
opts.update. I wouldn't think of a good way to make the code that kicks
in when both update and dry_run are set if you clear update that early in
the codepath.

Of course you could implement a roundabout logic that says something like

	if (!update && !pretending_to_update)
        	return 0; /* we are not updating */

	if (update)
        	do work tree operations;
	else if (pretending_to_update)
        	check if work tree operations would fail;
	else
		do nothing;

But I think that is going backwards. The point of "-n" == dry-run is to
cover all cases, and your initial round was only covering "no -u" case and
in this round we are trying to also cover "-u" case. With the approach to
add "check-worktree", if we have the third mode of operation (the first
two being the existing "without -u" and "with -u"), would you add yet
another "check-distim"?

Wouldn't the interaction with these true "operation modes" and "dry run"
be a lot simpler to read and implement that way?  In other words, which
one do you find easier between these two to follow?

	if (opts.update) {
		if (opts.dry-run)
                	check if we can update but do not update in real;
		else
                	do update and die if we can't;
	} else if (opts.distim) {
		if (opts.dry-run)
                	check if we can distim but do not actually distim it;
		else
                	do distim and die if we cannot;
	} ...

vs

	if (!opts.update && !opts.distim && !opts.check_worktree && !opts.check_distim)
		return;

	if (opts.update || opts.check_worktree) {
		if (opts.check_worktree)
                	check if we can update but do not update in real;
		else
                	do update and die if we can't;
	} else if (opts.distim || opts.check_distim) {
		if (opts.check_distim)
                	check if we can distim but do not distim in real;
		else
                	do distim and die if we can't;
        }
