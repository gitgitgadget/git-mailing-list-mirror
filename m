From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git tag --contains : avoid stack overflow
Date: Wed, 23 Apr 2014 12:12:14 -0700
Message-ID: <xmqqeh0nzwq9.fsf@gitster.dls.corp.google.com>
References: <20140416141519.GA9684@camelia.ucw.cz>
	<20140416154653.GB4691@sigill.intra.peff.net>
	<alpine.DEB.1.00.1404171902010.14982@s15462909.onlinehome-server.info>
	<20140417213238.GA14792@sigill.intra.peff.net>
	<alpine.DEB.1.00.1404172347440.14982@s15462909.onlinehome-server.info>
	<20140417215817.GA822@sigill.intra.peff.net>
	<20140423075325.GA7268@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Apr 23 21:12:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd2au-0003g5-MQ
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 21:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757441AbaDWTMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 15:12:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47077 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757305AbaDWTMS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 15:12:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3D697EF6C;
	Wed, 23 Apr 2014 15:12:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1jAnXYdP1Zqm7chLvNvuYsgIR98=; b=m0yt4N
	MNbLtCelVV3YmyXuFMb4xNQCET2zSa9HkrSXyZHGO9Cf9h6XzLGQTlsU0eioQzf9
	1fy2t0q7Soy8dNFG4xPsYj52ly7g4xd9h7ZqH3DRf0cbEDB2MAbbySWaX/hfDBz7
	nistk5hnK6SmOH7TF+jiJAjTrdtPjdN62b/DQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GtZMyxyPeMjJckZ6lMgOHZulmgBNNrmk
	+ixlfjhdWiim5Wb1lEAlbs189G/pVlbfX+0B7yspzTNp4RhL6QAqg5C4p1Vb0Y/j
	7n4u3wn+YJ0HpbmLcMMW5vieR4asH3tJ8NfO8Xi1M+rL8DPECGUlHVuV+txTU30T
	hBsciVMyh9c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C653B7EF6A;
	Wed, 23 Apr 2014 15:12:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1BB4E7EF68;
	Wed, 23 Apr 2014 15:12:16 -0400 (EDT)
In-Reply-To: <20140423075325.GA7268@camelia.ucw.cz> (Stepan Kasal's message of
	"Wed, 23 Apr 2014 09:53:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2EDA7FB0-CB1B-11E3-A310-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246867>

Stepan Kasal <kasal@ucw.cz> writes:

[Administrivia: please refrain from using Mail-Followup-To to
deflect an attempt to directly respond to you; it will waste time of
other people while it may be saving your time].

> From: Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
>
> In large repos, the recursion implementation of contains(commit,
> commit_list) may result in a stack overflow. Replace the recursion with
> a loop to fix it.
>
> This problem is more apparent on Windows than on Linux, where the stack
> is more limited by default.
>
> See also this thread on the msysGit list:
>
> 	https://groups.google.com/d/topic/msysgit/FqT6boJrb2g/discussion
>
> [jes: re-written to imitate the original recursion more closely]
>
> Thomas Braun pointed out several documentation shortcomings.
>
> Tests are run only if ulimit -s is available.  This means they cannot
> be run on Windows.
>
> Signed-off-by: Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Tested-by: Stepan Kasal <kasal@ucw.cz>

Thanks.

> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 143a8ea..db82f6d 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1423,4 +1423,27 @@ EOF
>  	test_cmp expect actual
>  '
>  
> +ulimit_stack="ulimit -s 64"
> +test_lazy_prereq ULIMIT 'bash -c "'"$ulimit_stack"'"'

With this implementaion, ULIMIT implies bash, and we use bash that
appears on user's PATH that may not be the one the user chose to run
git with.  Can't we fix both of them by using $SHELL_PATH?

> +>expect

Move this inside test_expect_success?

> +# we require bash and ulimit, this excludes Windows
> +test_expect_success ULIMIT '--contains works in a deep repo' '
> +	i=1 &&
> +	while test $i -lt 4000
> +	do
> +		echo "commit refs/heads/master
> +committer A U Thor <author@example.com> $((1000000000 + $i * 100)) +0200
> +data <<EOF
> +commit #$i
> +EOF"
> +		test $i = 1 && echo "from refs/heads/master^0"
> +		i=$(($i + 1))
> +	done | git fast-import &&
> +	git checkout master &&
> +	git tag far-far-away HEAD^ &&
> +	bash -c "'"$ulimit_stack"' && git tag --contains HEAD >actual" &&

So this runs a separate "bash", the only thing which does is to run
a small script that gives a small stack to itself and exit, and then
run "git tag" in the original shell?

Ahh, no, I am mis-pairing the quotes.

How about doing it along this line instead?

	run_with_limited_stack () {
		"$SHELL_PATH" -c "ulimit -s 64 && $*"
	}

	test_lazy_prereq ULIMIT "run_with_limited_stack true"

	test_expect_success ULIMIT '...' '
        	>expect &&
		i=1 &&
                ...
                done | git-fast-import &&
                git tag far-far-away HEAD^ &&
                run_with_limited_stack "git tag --contains HEAD" >actual &&
		test_cmp expect actual
	'
