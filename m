From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] git p4 test: wait longer for p4d to start
Date: Mon, 25 Jun 2012 20:46:20 -0700
Message-ID: <7vbok6enw3.fsf@alter.siamese.dyndns.org>
References: <1340673505-10551-1-git-send-email-pw@padd.com>
 <1340673505-10551-2-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 05:47:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjMjz-0005GR-ER
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 05:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471Ab2FZDqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 23:46:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63128 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865Ab2FZDqX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 23:46:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA5E597E6;
	Mon, 25 Jun 2012 23:46:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dE4QiHVxe43yiWjp4PQc12ewUpI=; b=nGYDEo
	o1kiZ0dD3Aw43wmRFf0jN3IxaMpYWbUNbPmlN6hb7CCDPoAMkKwiXHI4EHT8XP1N
	xLK70bS0Xm9xn/tS0cGXhqNFGP+nPP/9GwsKOKS3+guikcNEodUA6xiH1WG9IzF4
	j/zdoFOUjS0W7pQZQDoAvg90Zo9qlMyIBl2Z0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EM/ElVS9LwNPVO/nu+f+DX8s5UyQcFV8
	eT56yr+0+pzErFljKBmpsM57mjNXPJzMkxVY4K2dReRdR6Bu7Ap7XQVhzM3fTKSl
	jmtPH2Zj9qEXrcFpDQMtXpNU1LzTRu6nv0No+uJHPbFQqqTs+ti4/cj5cqrR26nH
	hXTPqAvRipQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C18C697E5;
	Mon, 25 Jun 2012 23:46:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 56E7497E4; Mon, 25 Jun 2012
 23:46:22 -0400 (EDT)
In-Reply-To: <1340673505-10551-2-git-send-email-pw@padd.com> (Pete Wyckoff's
 message of "Mon, 25 Jun 2012 21:18:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7F149AD4-BF41-11E1-93E6-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200623>

Pete Wyckoff <pw@padd.com> writes:

> Running tests at high parallelism on a slow machine, 5 sec is
> not enough to wait for p4d to start.  Change it to 10 sec.
>
> Signed-off-by: Pete Wyckoff <pw@padd.com>

I'd rather not to see this kind of incremental micro-tweaks.  The
next person who runs on an even slower box or with more excessive
parallelism compared to his machine size may complain and send a
patch to raise this to 20.

Who are we trying to help, and if you raised this to "forever", whom
would such a change be hurting?  If there is something wrong with
the p4 installation, it may never come up, but an interactive user
will eventually end up seeing "waiting for p4d to start" and nothing
else in such a case, and will know to kill it with ^C. An automated
test spawned from a cron job would definitely be hurt with a timeout
of "forever", but to them, 10 seconds or 10 minutes would not make
much of practical differences (as long as you do not run such a cron
job too often).

My preference would probably be a very long default that can be
shortened (or lengthened) with an environment variable, so that a
frequent auto-builder that runs the tests every five minutes can
tune it down to 30 seconds, or something like that.

>  t/lib-git-p4.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
> index 121e380..0080eae 100644
> --- a/t/lib-git-p4.sh
> +++ b/t/lib-git-p4.sh
> @@ -37,7 +37,7 @@ start_p4d() {
>  		p4d -q -r "$db" -p $P4DPORT &
>  		echo $! >"$pidfile"
>  	) &&
> -	for i in 1 2 3 4 5 ; do
> +	for i in 1 2 3 4 5 6 7 8 9 10 ; do
>  		p4 info >/dev/null 2>&1 && break || true &&
>  		echo waiting for p4d to start &&
>  		sleep 1
