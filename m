From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/21] git p4: generate better error message for bad
 depot path
Date: Fri, 28 Sep 2012 11:58:01 -0700
Message-ID: <7vlifuklbz.fsf@alter.siamese.dyndns.org>
References: <1348833865-6093-1-git-send-email-pw@padd.com>
 <1348833865-6093-4-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 21:19:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THg5q-0007tg-VX
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 21:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031050Ab2I1TS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 15:18:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32787 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030809Ab2I1TS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 15:18:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 703258152;
	Fri, 28 Sep 2012 15:18:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=ykKh7oM58ZeD165Op+tj6WJzCpQ=; b=kTRL8o4AS7wSTDUwq8p5
	sj8DLjwHQYrSZfTVf2ZU/7Zd1SK1PZlwHvklLPlYbQnQegIFesMxUPFRFjiO+0Mr
	O3ZkWqJDr70dnaPAM4vGK5dXuc61Xn9D8mzIHJ1Z8EW1KGd9Pbzq80p95WOnIV4p
	LQtsEujj6tcvgsjKQNy57VQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Dn0WbO7a74u+CXEuKzUgRrjQvWBs8YJi2RPkpg/ZE1Nkvr
	3IcSm8Ac4bI9GLMDwh8bvcsarX/f/HoDy9O5hBOItXy9HsLxygEnn1zvyCYFV6HZ
	QGvQCvBilZ76/xM6OaNOHV3Lmy6MulXUahvIEc5wF3RO79ZGQDGu2jiH0pUYU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E60C8151;
	Fri, 28 Sep 2012 15:18:26 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CCFCD8150; Fri, 28 Sep 2012
 15:18:25 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 46E7085E-09A1-11E2-8B30-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206599>

Pete Wyckoff <pw@padd.com> writes:

> Depot paths must start with //.  Exit with a better explanation
> when a bad depot path is supplied.
>
> Signed-off-by: Pete Wyckoff <pw@padd.com>
> ---
>  git-p4.py               | 1 +
>  t/t9800-git-p4-basic.sh | 5 +++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/git-p4.py b/git-p4.py
> index 97699ef..eef5c94 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -3035,6 +3035,7 @@ class P4Clone(P4Sync):
>          self.cloneExclude = ["/"+p for p in self.cloneExclude]
>          for p in depotPaths:
>              if not p.startswith("//"):
> +                sys.stderr.write('Depot paths must start with "//": %s\n' % p)
>                  return False
>  
>          if not self.cloneDestination:
> diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
> index b7ad716..c5f4c88 100755
> --- a/t/t9800-git-p4-basic.sh
> +++ b/t/t9800-git-p4-basic.sh
> @@ -30,6 +30,11 @@ test_expect_success 'basic git p4 clone' '
>  	)
>  '
>  
> +test_expect_success 'depot typo error' '
> +	test_must_fail git p4 clone --dest="$git" /depot 2>errs &&
> +	grep -q "Depot paths must start with" errs
> +'

Use of "grep -q" does not help ordinary testers, as the output will
not be shown when the tests are run normally.

>  test_expect_success 'git p4 clone @all' '
>  	git p4 clone --dest="$git" //depot@all &&
>  	test_when_finished cleanup_git &&
