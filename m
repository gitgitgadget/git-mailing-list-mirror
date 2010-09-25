From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: what should git rev-parse --flags HEAD do?
Date: Sat, 25 Sep 2010 10:54:32 -0700
Message-ID: <7vfwwxogiv.fsf@alter.siamese.dyndns.org>
References: <AANLkTimEToibgpUS1KTSruFRdggi3kbAJU5tfk9r6d2U@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Brandon Casey <drafnel@gmail.com>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 19:55:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzYxZ-0002kr-8C
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 19:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755919Ab0IYRys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 13:54:48 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59380 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021Ab0IYRyr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 13:54:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CE5DD9E6F;
	Sat, 25 Sep 2010 13:54:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nv3IXuVDz6jIzSKvn5KnmKPRwkU=; b=mta3hj
	oAyECuYVIEc6WFz0Eyym/BdVIMCDRoJjP5L/6vpef1tUyP+3GMC2aqJvpCK37V66
	9p1/GBXfTv8oYUeeDg3q1Waq5+7AXVEpgWTR05CTv8K56dPhXgYLawQZw/pF60+f
	rJ4+uHAYsYI6SzU+R/Ev45q2vNIAKH5R7LFhg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lJiQS9z3fNqCRbzZy8oWz1ksm/tKAmRG
	w3zgmj2PpM0sbqbRYXTDmwyyyfQXqsC3xVzkt0w93bR7LizSmA/3D7elet2RC22Z
	ohGAMH4/Q9pYR8pY8FbgpN7Mr5JbmkQdjH4HrCkyysB6zzMIcMGEbe9/7ziFC1s7
	OASELLbexJM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B692D9E6E;
	Sat, 25 Sep 2010 13:54:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5514AD9E6D; Sat, 25 Sep
 2010 13:54:34 -0400 (EDT)
In-Reply-To: <AANLkTimEToibgpUS1KTSruFRdggi3kbAJU5tfk9r6d2U@mail.gmail.com>
 (Jon Seymour's message of "Sat\, 25 Sep 2010 20\:11\:19 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F78D8FA0-C8CD-11DF-891C-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157171>

Jon Seymour <jon.seymour@gmail.com> writes:

> The documentation for git rev-parse --flags currently states:
>
>     Do not output non-flag parameters.
>
> Therefore, one might expect:
>   $ git rev-parse --flags HEAD
>
> to produce no output.
>
> In fact, it outputs the sha1 hash of HEAD.

Perhaps you are missing --no-revs.

Linus wrote rev-parse to implement this in a shell script:

    git log [other-options-and-args] [revision-traversal-options-and-args]

which needs to be transformed to:

    git rev-list [revision-traversal-options-and-args] |
    git diff-tree --stdin [other-options-and-args]

so that it can parse "-p HEAD" with and without "--no-revs" to produce
"HEAD" and "-p" respectively.  It does so by knowing options that are
relevant to rev-list invocation (shown by default, or --revs-only) and 
everything else (hidden when --no-revs is given).

"--flags" is an afterthought that filters out non-flags in other parts; I
do not think it applied to the "rev" part (i.e. giving --no-revs at the
same time would be a valid workaround if you know you do not want HEAD or
any revision traversal argument) in any released version of git.
