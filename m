From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3306,t5304: avoid clock skew issues
Date: Fri, 08 Apr 2011 13:20:42 -0700
Message-ID: <7vipuo336t.fsf@alter.siamese.dyndns.org>
References: <b384c3adae96498eafb2a1faddeaabe85a0f7225.1302285490.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 08 22:21:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8IAr-0007Lb-7C
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 22:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757783Ab1DHUUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 16:20:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62814 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757777Ab1DHUUv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 16:20:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4AEDE514D;
	Fri,  8 Apr 2011 16:22:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e+S59FZe2Jwj1fbVS0kIjTdw2ek=; b=HasmPd
	ombv7K8xKm7osgcBzeAJB/4NVkmbvcEltDbbXH2jLOvVk7GlHvOzizEr1U54Zoih
	YPSEruNIUuaNr1RJe6zVhpeuPdOXXUuvP9eE0IZ/niIk6QBDYBWcEmNVPikeIdbU
	v81qUIwS/y+axYTY4/EtOhThQftezgqT2/on8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KPpN715Zwgi13/nw3XP7G91eBLxkNZOw
	Tf/ZY3wiInlB++7dPub2n2AiWqdmZ8oPiiX/vu5DCqglwEIm5DE2qXaqyQxWU6X7
	kZfV1cUpESWd1vvBkxd5LgrQ/t8loGYWKplstzl3n63GVcwydPq/8E6Km9to1xc2
	b5Zp1VJntpw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 26A82514B;
	Fri,  8 Apr 2011 16:22:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 23BEE5148; Fri,  8 Apr 2011
 16:22:39 -0400 (EDT)
In-Reply-To: <b384c3adae96498eafb2a1faddeaabe85a0f7225.1302285490.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri, 8 Apr 2011 19:58:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F5553FFA-621D-11E0-B55C-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171157>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> On systems where the local time and file modification time may be out of
> sync (e.g. test directory on NFS) t3306 and t5305 can fail because prune
> compares times such as "now" (client time) with file modification times
> (server times for remote file systems). I.e., these are spurious test
> failures.
>
> Avoid this by setting the relevant modification times to the local time.
>
> Noticed on a system with as little as 2s time skew.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> I don't think we can safeguard prune itself properly. A filesystem may be out
> of time sync sporadically (and produce incorrect time stamps) but then be in
> sync when "git prune" is run so that we can't detect it.
>
>  t/t3306-notes-prune.sh |    4 ++++
>  t/t5304-prune.sh       |    3 ++-
>  2 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/t/t3306-notes-prune.sh b/t/t3306-notes-prune.sh
> index c428217..3114972 100755
> --- a/t/t3306-notes-prune.sh
> +++ b/t/t3306-notes-prune.sh
> @@ -20,6 +20,10 @@ test_expect_success 'setup: create a few commits with notes' '
>  	git add file3 &&
>  	test_tick &&
>  	git commit -m 3rd &&
> +	COMMIT=$(git rev-parse HEAD) &&
> +	COMMIT_FILE=.git/objects/$(echo $COMMIT | sed "s/^../&\//") &&

Hmm, the remainder of the test script seems to know this commit is 5ee1c35
all over the place.  Do the above two lines worth it?
