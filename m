From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP PATCH] Teach read-tree the -n|--dry-run option
Date: Tue, 17 May 2011 15:47:41 -0700
Message-ID: <7vpqnheygi.fsf@alter.siamese.dyndns.org>
References: <7vd3jm74gv.fsf@alter.siamese.dyndns.org>
 <4DD0043D.1050101@web.de> <7vfwofpvai.fsf@alter.siamese.dyndns.org>
 <4DD2CFD4.7060508@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed May 18 00:47:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMT3T-00020Q-92
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 00:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500Ab1EQWru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 18:47:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51360 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932456Ab1EQWrt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 18:47:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 203AA5442;
	Tue, 17 May 2011 18:49:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MZ0xRn/mq/oOZcFZZotWjOQG/aE=; b=BuC6mV
	dVJZhx+OQJ5bruIrT0M3z9heeQRTnCe7mtQvI6+zqkx+ph4Tng2WlfnJi9iq+Y0w
	dPP52QOTkadRBgSgUEeO3u61yD8IqOCrh01eq/r1C9u5Q03gX5Hc500Cf4Z6uXB7
	3j6T4TOBXWqkbzCYMZv2US2SDwwmYtZG/QKxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KH5lEI4I2+Sn38Phbfftfozew285lYZh
	GnBExamgIyiXLT0r/ndV2sRaJw8FcCDS0LxnZYr9Bu8wkYZldRWLBfNW51wp7KPr
	L++RQj5pSYNJkfDJNK7VhB/oXsAsyWTwtxGyeK1rexKe1jxJNZGaWDAiqa9rprop
	/M5hi6gM3jo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F125C5440;
	Tue, 17 May 2011 18:49:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 00E84543F; Tue, 17 May 2011
 18:49:49 -0400 (EDT)
In-Reply-To: <4DD2CFD4.7060508@web.de> (Jens Lehmann's message of "Tue, 17
 May 2011 21:43:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA6F5F6A-80D7-11E0-B00A-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173829>

Jens Lehmann <Jens.Lehmann@web.de> writes:

>> I think the change to the implementation would be trivial, but you would
>> probably want to update the tests in 1002 (remove the one at the end that
>> checks -u/-n incompatibility, and perhaps make sure "-n -u" combination
>> does not touch anything as advertised).
>
> I added two convenience functions read_tree_u_must_[succeed|fail]() which
> work pretty much the way read_tree_must_[succeed|fail]() do but with the
> added functionality that they check git diff-files before and after the
> read-tree -n too.

Sounds sensible.

> The only exceptions where I could not make that replacement without
> breaking a test were:
>
> * t1001:381 (#25) new file conflicts with untracked directory
>   This should have been detected by verify_absent_1(), but that function
>   is left early when opts->update is 0. Will look into that.

Thanks. This is the kind of corner case I was worried about when I said
"we might have a case where read-tree -m succeeds but read-tree -m -u
doesn't". Fixing it would mean that ...

> @@ -183,6 +184,8 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
>  		die("--exclude-per-directory is meaningless unless -u");
>  	if (opts.merge && !opts.index_only)
>  		setup_work_tree();
> +	if (opts.update && dry_run)
> +		opts.update = 0;
>
>  	if (opts.merge) {
>  		if (stage < 2)

... this hunk must go, right?

> diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
> index 680d992..54e69ce 100755
> --- a/t/t1001-read-tree-m-2way.sh
> +++ b/t/t1001-read-tree-m-2way.sh
> @@ -48,6 +48,25 @@ check_cache_at () {
>  	esac
>  }
>
> +read_tree_must_succeed () {
> +...
> +}
> +
> +read_tree_u_must_succeed () {
> +...
> +}

Now at this point wouldn't it make more sense to move these helpers to
lib-read-tree.sh or something and .-source it from all nine tests?
