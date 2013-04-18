From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] submodule: drop the top-level requirement
Date: Thu, 18 Apr 2013 15:40:41 -0700
Message-ID: <7vfvyn4g46.fsf@alter.siamese.dyndns.org>
References: <cover.1365539059.git.john@keeping.me.uk>
	<cover.1366314439.git.john@keeping.me.uk>
	<cover.1366314439.git.john@keeping.me.uk>
	<6e4122f3eedec3f520028b5598b78e0d59e5d12b.1366314439.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Apr 19 00:41:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USxVk-0007gO-Lw
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 00:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936709Ab3DRWks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 18:40:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54056 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936708Ab3DRWkp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 18:40:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A311E17FC4;
	Thu, 18 Apr 2013 22:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=09ElH2VWdO40oYjGO1ALv6NMgb0=; b=rqTpAO
	XfQH96MVWnsSR/XnYFGZN3aUGdgVse/B1r02nqfSfNa4UEw83Ru8K3IdUhEOLKWX
	1tsmNG/23IM2vhfTr/udDKTcwnXC3DB+Q8g0AbmOU2ELcuXLxfM0fwsVsv9ymjQD
	vxDwfNxI+1OApFpwHhvcQ7aZ2JFo2gbb+zL84=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ySmA4GNRqiXQmL+d/Ppm3nmiP6ZvypMn
	6uODUPtOhD+UTmleRUNRNpTHZyyev4wipA3yFvz0NWidSwFZfKjsCzbDOqs9Oze8
	MrVjOvLp6vr5i9THuQKLG2QriSZa/RFeOJa50baCZVbptuFacVx3OA+3yNA28qbW
	iMOJ9e3zT64=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A6DA17FC3;
	Thu, 18 Apr 2013 22:40:43 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 17C3117FC1;
	Thu, 18 Apr 2013 22:40:43 +0000 (UTC)
In-Reply-To: <6e4122f3eedec3f520028b5598b78e0d59e5d12b.1366314439.git.john@keeping.me.uk>
	(John Keeping's message of "Thu, 18 Apr 2013 20:50:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 00B7EE8A-A879-11E2-8909-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221699>

John Keeping <john@keeping.me.uk> writes:

> +relative_path ()
> +{
> +	local target curdir result
> +	target=$1
> +	curdir=${2-$wt_prefix}
> +	curdir=${curdir%/}
> +	result=
> +
> +	while test -n "$curdir"
> +	do
> +		case "$target" in
> +		"$curdir/"*)
> +			target=${target#$curdir/}
> +			break
> +			;;
> +		esac

Could $curdir have glob wildcard to throw this part of the logic
off?  It is OK to have limitations like "you cannot have a glob
characters in your path to submodule working tree" (at least until
we start rewriting these in C or Perl or Python), but we need to be
aware of them.

>  module_list()
>  {
> +	eval "set $(git rev-parse --sq --prefix "$wt_prefix" -- "$@")"

An efficient reuse of "--" ;-)

> +test_expect_success 'run summary from subdir' '
> +	mkdir sub &&
> +	(
> +		cd sub &&
> +		git submodule summary >../actual
> +	) &&
> +	cat >expected <<-EOF &&
> +* ../sm1 0000000...$head1 (2):
> +  > Add foo2
> +
> +EOF

It somewhat looks strange to start with "<<-EOF" and then not to
indent the body nor EOF.
