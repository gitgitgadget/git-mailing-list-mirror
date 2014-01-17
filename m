From: Junio C Hamano <gitster@pobox.com>
Subject: Re: with git-next, git pull --rebase can print out "fatal: No such ref: ''" for branches without an upstream
Date: Fri, 17 Jan 2014 10:57:56 -0800
Message-ID: <xmqq8uuexwp7.fsf@gitster.dls.corp.google.com>
References: <52D8827E.3060007@fb.com>
	<20140117022152.GB12444@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Siddharth Agarwal <sid0@fb.com>, git@vger.kernel.org,
	john@keeping.me.uk
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 17 19:58:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4EcU-00083K-RA
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 19:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753123AbaAQS6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 13:58:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41700 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753115AbaAQS6K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 13:58:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C58B86239B;
	Fri, 17 Jan 2014 13:58:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PfYSwKqRMhJ1n5roXz+n852hPTo=; b=G/rLIt
	D4C3YqYcf/pXRjW+Cy+xPYBdnDKsJCtWvNaPfIPmHj+xu7p5mo1uNLouDUohYU5d
	wq8VAosvhDOBpw8utQ8eNuchry9Ft6K6nFguqkr6twbfFkUU+hWwRnhv1btEwAjX
	Sv+PT14QDJheI2+BT10js5NhR8fr8hs0AIMdU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KExrAQxzl0dFdSDe6tVo7SO9+vw99o+9
	hct9Y7mAseWPszFO21B7GUq7CURVEUmvbXypo/DJHRiUanSeuSeNphBNH9wOZSTg
	mV4H27g1ea0qISv7VW0cHelHxpASsc7fv6O6eZ+D2iVLKdspqrhT6pC6aau5E2+5
	4cL/2iGbS3s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABB4D6239A;
	Fri, 17 Jan 2014 13:58:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC6A262395;
	Fri, 17 Jan 2014 13:58:03 -0500 (EST)
In-Reply-To: <20140117022152.GB12444@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 16 Jan 2014 21:21:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4B360516-7FA9-11E3-9D2E-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240608>

Jeff King <peff@peff.net> writes:

> On Thu, Jan 16, 2014 at 05:08:14PM -0800, Siddharth Agarwal wrote:
>
>> With git-next, where git pull --rebase can print out "fatal: No such
>> ref: ''" if git pull --rebase is run on branches without an upstream.
>
> This is already fixed in bb3f458 (rebase: fix fork-point with zero
> arguments, 2014-01-09), I think.

Doesn't the call to get_remote_merge_branch in this part

        test -n "$curr_branch" &&
        . git-parse-remote &&
        remoteref="$(get_remote_merge_branch "$@" 2>/dev/null)" &&
        oldremoteref=$(git merge-base --fork-point "$remoteref" $curr_branch)

yield an empty string, feeding it to "merge-base --fork-point" as
its first parameter?

Perhaps something like this is needed?

 git-pull.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-pull.sh b/git-pull.sh
index 605e957..467c66c 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -229,6 +229,7 @@ test true = "$rebase" && {
 	test -n "$curr_branch" &&
 	. git-parse-remote &&
 	remoteref="$(get_remote_merge_branch "$@" 2>/dev/null)" &&
+	test -n "$remoteref" &&
 	oldremoteref=$(git merge-base --fork-point "$remoteref" $curr_branch)
 }
 orig_head=$(git rev-parse -q --verify HEAD)
