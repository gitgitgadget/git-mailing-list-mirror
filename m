From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git mergetool broken when rerere active
Date: Thu, 06 Jan 2011 10:56:29 -0800
Message-ID: <7vbp3tc142.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.1.10.1101052119530.26654@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Magnus Baeck <magnus.back@sonyericsson.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	David Aguilar <davvid@gmail.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 19:57:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pav1E-0007p4-R5
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 19:57:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753523Ab1AFS4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 13:56:49 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46975 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496Ab1AFS4r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 13:56:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B5AE83776;
	Thu,  6 Jan 2011 13:57:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0KHSSezmg7tYNQurXJ/+5DUmvpE=; b=Bjr2g6
	7glvf6jeSd1/X8S8BtCSAbUAUSdDQ81lSfqToSgfuVvxsXWmaX92sFuZUM2nOk7J
	HCqJAjpXL+6KcfMUUZse0PxJU3kUljtYxVvnvdWaSYwAzlsA6ltWvik7JWyTc0R0
	5/xXmNZt504e5tkxKtD321Ov5kdgmtKx+O7ys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jnn/XVmB1zboQl09MjziQx3Nv8q9EL/7
	wFFULtVb1dzWoZGbj6Iw53q40phtxgXm0L606gFeHkA9kUWtajgSshzMzJ7RzqcA
	4p/nxnIAxnJiubzrW5N9dn7NnOrYZg/runNinmz8MSE3BrEJhlIzN0UbVuMNq41b
	MsZ6SlcEJ60=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 49D353770;
	Thu,  6 Jan 2011 13:57:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 68E06376D; Thu,  6 Jan 2011
 13:57:09 -0500 (EST)
In-Reply-To: <alpine.DEB.1.10.1101052119530.26654@debian> (Martin von
 Zweigbergk's message of "Wed\, 5 Jan 2011 22\:39\:07 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C81B49FC-19C6-11E0-9479-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164654>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> When rerere is enabled, git mergetool uses 'git rerere status' to find
> out which files to run the merge tool on. This was introduced in
> bb0a484 (mergetool: Skip autoresolved paths, 2010-08-17). Before that,
> 'git ls-files -u' was used, whether or not rerere was active.
>
> This change caused two problems:
>
>  (1) Before this change, it used to be that case that all conflicts
>      would be resolved and added to the index after running 'git
>      mergetool' without arguments, i.e. on all files. After the
>      change, conflicts of type 'deleted by them' or 'deleted by us'
>      would be ignored, since they are not listed shown by 'git rerere
>      status'.

Good point.  We used to say "everything that had conflict after a mergy
operation", now we say "everything that rerere attempted resolution but
didn't succeed".  Missing are paths that rerere didn't even attempt to
apply previous resolution at all.

Probably we would need a "git rerere remaining" sobcommand that is similar
to status but also includes the "punted" paths.
