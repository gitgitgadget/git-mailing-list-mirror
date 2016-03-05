From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Making git apply always work relative to current directory
Date: Sat, 05 Mar 2016 11:31:53 -0800
Message-ID: <xmqq4mckvhzq.fsf@gitster.mtv.corp.google.com>
References: <20160305181125.GA48536@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sat Mar 05 20:32:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acHvm-0004Tv-U0
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 20:32:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbcCETb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 14:31:57 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52195 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750724AbcCETb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 14:31:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C02AB4A966;
	Sat,  5 Mar 2016 14:31:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I+eEiPsBwG+jcy/IJ/n5zWcTfBY=; b=qr/GP4
	5be1xpffHnVP7v3GNYXZZFuSTTwmGC2CsbfyVTrD8hjtDAaP/JL/QHo/HrLFPsnp
	RaMMdLwqq41YMz50zlljzNUdYhQhbRmUw608pfC3zCjBLFkl0/psde1n0xNtqV1R
	Gzvjl4F+0kcCLfZ3G28CQt3bEx+ZavC9iZlfE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hot2ONkLMn9FbJ4iKUMsgTnK7ENF6Yqa
	tiCZFc06IEjO85uXDeLhLDWAmDgVdeK/Qg2QHVsAzmx/UqfcY/+gpPmNUnWHQ3Hq
	H7SshWCH0LaqzbAmxaAOEHeJnkKus14GV13Wu0ysabPiqlW3uHNRHjap44z1a5s/
	TOve+ZV/ORg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B73714A965;
	Sat,  5 Mar 2016 14:31:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1F0BD4A964;
	Sat,  5 Mar 2016 14:31:55 -0500 (EST)
In-Reply-To: <20160305181125.GA48536@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Sat, 5 Mar 2016 18:11:25 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EB49DF86-E308-11E5-AFB3-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288321>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> If I run git apply --no-index --verbose <patch>, it succeeds in both
> cases, but when I'm in the git repository, it *silently does nothing*.

That originally sounded peculiar to me and I suspected it to be a
bug, but it looks like a designed-in feature and with us since

commit edf2e37002eeb30a2ccad5db3b3e1fe41cdc7eb0
Author: Junio C Hamano <junkio@cox.net>
Date:   Fri Nov 25 23:14:15 2005 -0800

    git-apply: work from subdirectory.
    
    When applying a patch to index file, we need to know where GIT_DIR is;
    use setup_git_directory() to find it out.  This also allows us to work
    from a subdirectory if we wanted to.
    
    When git-apply is run from a subdirectory, it applies the given patch
    only to the files under the current directory and below.
    
    Signed-off-by: Junio C Hamano <junkio@cox.net>

So exclusion by use_patch() for paths outside the current directory
seems to be a feature; the log message does not say "why", but if I
have to guess, the reasoning was probably "The old world order was
that the command has to always be run from the top level.  A user
who wants to run it from a subdirectory must be doing so for a
reason, e.g. 'I am currently working in this directory, do not touch
outside this area'".  In any case, I suspect that the existing tooling
people built over the past 10 years around "git apply" already depends
on this behaviour, so we cannot lightly change it.

Is it so hard to temporarily go up to the root, run "git apply", and
come back?  You can use "--no-index --directory=trash" for both
cases that way.
