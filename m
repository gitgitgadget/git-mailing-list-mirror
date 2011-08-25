From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clean --exclude broken?
Date: Wed, 24 Aug 2011 18:38:22 -0700
Message-ID: <7vfwkqmfsh.fsf@alter.siamese.dyndns.org>
References: <A04A4D84-16CC-438C-8828-0D11BE9DE2DA@cpanel.net>
 <7vliuio65w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Todd Rinaldo <toddr@cpanel.net>
X-From: git-owner@vger.kernel.org Thu Aug 25 03:38:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwOts-0003rg-Qd
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 03:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494Ab1HYBi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 21:38:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53504 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752366Ab1HYBi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 21:38:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFB1E5112;
	Wed, 24 Aug 2011 21:38:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IYpSfbiYbuaqvwMJarjvNUckuIA=; b=eTFaAF
	dUC0ngkVslwr9Ib2bhCqWILmZMZwhOQRJ9jq3AYOGT6hLKYChv5nPCvMU4Zyww0v
	RJqcirlsHPHNu4t1mVxcaOLDgr+Fc2Myp9K6PyeYWlMb0OClItX4QDkDa3fYS/FM
	mNQ0njzGknG+pjiJnnUx7UdhkG0s8HUcpRvJU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a4G97KcIB/TASWl1I2Dnjqwj1445sBKn
	zm9k2nn8tzQuAjnlXT2vmjpKwEx7UrNlO0WQkMrSz34bR2F/PwI4teiWJKmxELvA
	Ybebd6BXcLO1fGkszZw4yHMtROZOjVKTP3uL5sEe4reMwEtGBTnBuEG/VTIdJFip
	HDol8qPJoyo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E794E5110;
	Wed, 24 Aug 2011 21:38:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 47D0A510F; Wed, 24 Aug 2011
 21:38:24 -0400 (EDT)
In-Reply-To: <7vliuio65w.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 24 Aug 2011 14:23:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EC31DC8A-CEBA-11E0-B3D5-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180056>

Junio C Hamano <gitster@pobox.com> writes:

> Todd Rinaldo <toddr@cpanel.net> writes:
>
>> I think I have found a new bug in 1.7.5:
>
> My quick check indicates 1.7.3 behaves the same way, and 1.7.2.5 didn't
> have --exclude option, so this does not seem to be anything particularly
> new in the 1.7.5 release.
>
>> # The problem (Why is foo/ removed?)
>> $>git clean -dXf --exclude=/foo
>> Removing bar/
>> Removing foo/
>
> Why is this command line giving -X that tells us not to use the ignore
> rules, and --exclude option at the same time?

The documentation and the implementation of "git clean" is quite confused.
Here is what is said about "-e":

    -e <pattern>::
    --exclude=<pattern>::
            Specify special exceptions to not be cleaned.  Each <pattern> is
            the same form as in $GIT_DIR/info/excludes and this option can be
            given multiple times.

But in reality, it is not about "not be cleaned" at all. A better
description to reflect what the implementation actually does is probably
this:

	In addition to what are found in usual places like .gitignore (per
	directory) and $GIT_DIR/info/exclude, consider these patterns to
	be in the ignore rules.

This mirrors what --exclude parameter to "ls-files" does [*1*].

I can however see a use case where the user wants to say something like
this which is quite different:

	I know "git clean" (or "git clean -x" or "git clean -X") will try
	to remove paths A, B and C. I want it remove them except for this
	particular path C by adding --except=C option to the command line.

And the current documentation does look like it is describing such an
option. But that is not what --exclude option is about.

One solution might be to say "I know the usual rules stored in .gitignore
and the like tell us to that 'foo' is ignored (and to be cleaned), but for
this invocation only, please treat 'foo' is _not_ ignored.", and there
indeed is a way to do so:

    $ git clean -d -X -e \!foo

(the backslash before '!' is to avoid history substitution in some shells).


[Footnote]

*1* This part in builtin/clean.c looks a bit distasteful:

	for (i = 0; i < exclude_list.nr; i++)
		add_exclude(exclude_list.items[i].string, "", 0, dir.exclude_list);

The last parameter should be &dir.exclude_list[EXC_CMDL] because we are
adding exclude patterns from the command line.  It works by accident
only because EXC_CMDL happens to be defined as 0.
