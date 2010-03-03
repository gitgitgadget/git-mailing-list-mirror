From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Latest master failing t7401 submodule tests
Date: Wed, 03 Mar 2010 12:52:46 -0800
Message-ID: <7vbpf5m8kh.fsf@alter.siamese.dyndns.org>
References: <4B8E5450.3040702@gmail.com>
 <7vhboxqje8.fsf@alter.siamese.dyndns.org>
 <20100303200239.GA28904@coredump.intra.peff.net>
 <7vhboxno38.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: A Large Angry SCM <gitzilla@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 03 21:53:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmvZ4-00042h-P0
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 21:53:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766Ab0CCUw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 15:52:59 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47062 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967Ab0CCUw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 15:52:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F9CA9EEF3;
	Wed,  3 Mar 2010 15:52:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=51IGGzxLCl2Vqe51aJrBIbwH1JA=; b=FIsm0v
	7TLmv1uuIZoJZRf225piqYG/WYFSnD360DMTdiF2DAnIlR7yWQMB68ooLJyVEjoo
	8sEOrms6WToXIs/fqz3SBWGjmYMB+DmwPonz+AczBOgVWR0j2gE/LjBoW6dwqoUU
	0D7/Xwy7lxy8D7RJ+A9c3ijLJSZiCIv7r0pbY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a7cwAON5ZvMrf5z0ae1jyy4a9AvkyF5a
	8mCQns2p4O0Jity3rhbq2cf4Lv1fwYLyBdVHbdjUMoFmQJnWt+4oSfHF2Nqj0rHg
	GSqCls8/p16e2nefw5rfhsw6IEANIdbdFxtuA/htpiDuwqQnxC/xgOP+9uTGBzZF
	TT6vFYfSNwg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DDFD99EEF2;
	Wed,  3 Mar 2010 15:52:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 107C79EEF1; Wed,  3 Mar
 2010 15:52:47 -0500 (EST)
In-Reply-To: <7vhboxno38.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 03 Mar 2010 12\:32\:11 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BBD19376-2706-11DF-A47B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141478>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I did see it on my debian unstable box with with dash as /bin/sh (though
>
> 3deea89 (submodule summary: Don't barf when invoked in an empty repo,
> 2010-02-16) looks broken.  It shifts $1 unconditionally when:
>
>  - "git submodule summary", no arguments given and defaults to HEAD which
>    is _not_ unborn (we shouldn't shift in this case);
>
>  - "git submodule summary HEAD path...", which is not unborn (we should shift);
>
>  - "git submodule summary path...", defaults to HEAD which is _not_ unborn
>    (we shouldn't shift).

IOW, shouldn't the code look more like this?

	if test $# != 0 && head=$(git rev-parse -q --verify "$1")
	then
		shift
	else
		git rev-parse -q --verify HEAD >/dev/null || return 0
		head=HEAD
	fi

That is, if a specific version might be there, we see if it is a version
and shift it out only if that is the case.  Otherwise we default to HEAD
but special case for an unborn HEAD (and report success).


 git-submodule.sh |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 5869c00..bd3a8d4 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -553,15 +553,12 @@ cmd_summary() {
 
 	test $summary_limit = 0 && return
 
-	if rev=$(git rev-parse -q --verify --default HEAD ${1+"$1"})
+	if test $# != 0 && head=$(git rev-parse -q --verify "$1")
 	then
-		head=$rev
 		shift
-	elif test -z "$1" -o "$1" = "HEAD"
-	then
-		return
 	else
-		head="HEAD"
+		git rev-parse -q --verify HEAD >/dev/null || return 0
+		head=HEAD
 	fi
 
 	if [ -n "$files" ]
