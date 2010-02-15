From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-grep ignores untracked files
Date: Sun, 14 Feb 2010 17:45:12 -0800
Message-ID: <7vvddz5l1z.fsf@alter.siamese.dyndns.org>
References: <1266194137-25653-1-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 02:45:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngq1h-0005nE-4D
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 02:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487Ab0BOBpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 20:45:24 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61903 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274Ab0BOBpX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 20:45:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 255949AABF;
	Sun, 14 Feb 2010 20:45:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/SvLyCKp71wiopwb3KdX6uRALyU=; b=HY/eFl
	3IvQ9u9pfJlYdOjjDi9elAaSzcN04rRyH/7O0keipyNvI9THPfr0yVA7NHu2c/zI
	XIg8GNMDlnQjCb1cWQgy+M3efJWFJRT2Jo3Joo/SCvrbbQ2ens/aYRBMCjPDCFRP
	2b62Kp2F4rIjdqTJXeGxsAwsm6OtYw66ecrW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v2167Nwliwi8pwQsfZGEuQhjM49z7yNR
	/rT6Uvq7/yVFVpVWgDuxdZ5d7I2o1wX93cG6fyml0vyzbIxPxt4V+2gefVXQjHpD
	cDtYV0wSor9Q/7aml7P38+YwRUlTtwnT1CKceSob4tq5/w/N9nTADZZX2g8PhUE3
	AC0pYNg4Pwk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0342A9AABE;
	Sun, 14 Feb 2010 20:45:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 500F79AAB9; Sun, 14 Feb
 2010 20:45:14 -0500 (EST)
In-Reply-To: <1266194137-25653-1-git-send-email-lodatom@gmail.com> (Mark
 Lodato's message of "Sun\, 14 Feb 2010 19\:35\:37 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C47D636E-19D3-11DF-B546-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139956>

>  Look for specified patterns in the working tree files, blobs
> -registered in the index file, or given tree objects.
> +registered in the index file, or given tree objects.  Only tracked files in
> +the working tree are searched.  Paths that do not match are silently ignored,
> +including paths to untracked files.

Strictly speaking, because git commands are about tracked files unless
explicitly stated otherwise, the phrase "files in the work tree" already
means "tracked" ones.  It is understandable (but not excusable) that
people who wrote manual assumed the readers would have learned that from
the user manual without repeating.  Adding explicit description would be a
good thing to do.

I think rewording the paragraph to "... patterns in the tracked files in
the work tree, blobs registered in the index file, ... or given tree
objects."  would be a good balance to strike.  It gives enough information
without making it too verbose.

I doubt we want to have "Only tracked files blah blah".  Like all the
normal git commands, "grep" is about tracked contents, and I don't think
it would help to repeat the obvious like pathspec filter will act as a
filter.  "add <pathspec>" is an exception in that it _is_ about untracked
paths and that is why you get warnings for unmatched ones.

    Side note: there will be --no-index option to let you run "git grep"
    over files in a random directory.

> +<path>...::
> +	Only search files matching these wildcard patterns; see glob(7) for
> +	the format.  If not given, all tracked files in the tree are searched.

Please do *not* "see glob(7) for the format".  Pathspec used for "grep"
(and "ls-files") are "leading path match or glob(7)".  E.g. "git grep
frotz t/" looks for frotz in all files under "t/" recursively, and that
does not have much to do with glob(7).  If we do not have a description
already, we may want to add these basics to git(1) or the user manual.

Thanks.
