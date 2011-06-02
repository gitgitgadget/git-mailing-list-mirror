From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarified how "git submodule add" handles relative
 paths.
Date: Thu, 02 Jun 2011 10:14:04 -0700
Message-ID: <7v39jsdulf.fsf@alter.siamese.dyndns.org>
References: <7vaae2ihe1.fsf@alter.siamese.dyndns.org>
 <1306943792-1825-1-git-send-email-marcnarc@xiplink.com>
 <7vsjrth4iy.fsf@alter.siamese.dyndns.org> <4DE69945.1080601@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Jun 02 19:14:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSBTR-0006e8-QZ
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 19:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532Ab1FBROR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 13:14:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64890 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753076Ab1FBROQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 13:14:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2747F5AFB;
	Thu,  2 Jun 2011 13:16:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E+SCTIwrD8+Pb2AXJPMsRrqN90o=; b=Ewakzp
	zHm5nCBPQphpnmOnJGzvEaOd2znA7uL/CnOebmlJZ7A9V9X6+32aEEl0b1R5DaDK
	YOD8HeZpn+BX235ad2uI7BRjQBG0zYHFnQc3NFO/61PGh0QoOK9cXJ0/U+My5skb
	bPmjKDuYGnq/asPpJhHfNX8599iQNH/xfobpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EvEoJRvhcWK6wHAxZ9a11rPU7KPF660v
	NJkoBRdWYERzwtYSJ+HGD8HnE3hi6WptdqjJhOTiMNt7rUAp3oXxiQ1Q9gse/3yU
	SAZnPRuL2A0IVCuzKStnpm8XvXtQRvCDx2sXSz54A4usBX1pPV+A1Hcw8QKPeo4M
	gyjh7UKy/lI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D467F5AF9;
	Thu,  2 Jun 2011 13:16:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5CE895AF0; Thu,  2 Jun 2011
 13:16:14 -0400 (EDT)
In-Reply-To: <4DE69945.1080601@web.de> (Jens Lehmann's message of "Wed, 01
 Jun 2011 21:55:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 084B36FC-8D3C-11E0-8500-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174962>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> I often use a local filesystem location for shared code I'm using in some
> personal projects, mainly because I want to avoid the hassle of setting
> up a server location for it (and the git test suite uses that feature too
> for similar reasons). That doesn't make much sense when working together
> with others, but that is not an issue in these use cases.
>
> So I see three different location types supported by current submodule
> add:
>   1) a URL reachable by you and your coworkers
>   2) a path relative to the URL of the superproject's default remote
>   3) A local filesystem location which can only be shared locally
> And each of them has its merits and uses (and using two of them everyday
> might make it easy to overlook the third ;-)

I suspect that it would be a relatively easy fix if your toplevel
superproject is its own authoritative upstream.  Something along the line
of this patch, perhaps?  It is obviously untested, and we may want to
issue an "echo >&2 'info:...'" to tell the user what we are assuming in
this codepath.

 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index b010a67..6d27729 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -34,7 +34,7 @@ resolve_relative_url ()
 {
 	remote=$(get_default_remote)
 	remoteurl=$(git config "remote.$remote.url") ||
-		die "remote ($remote) does not have a url defined in .git/config"
+	remoteurl=$(pwd) # the repository is its own authoritative upstream
 	url="$1"
 	remoteurl=${remoteurl%/}
 	sep=/
