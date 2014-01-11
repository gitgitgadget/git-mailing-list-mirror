From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] merge: make prepare_to_commit responsible for write_merge_state
Date: Fri, 10 Jan 2014 16:20:39 -0800
Message-ID: <xmqqha9b74iw.fsf@gitster.dls.corp.google.com>
References: <6B177FFA-1797-45FE-9EF1-2C9E6EE8A234@yaauie.com>
	<1389228344-38813-1-git-send-email-ryan@yaauie.com>
	<1389228344-38813-4-git-send-email-ryan@yaauie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Ryan Biesemeyer <ryan@yaauie.com>
X-From: git-owner@vger.kernel.org Sat Jan 11 01:20:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1mJi-0000L6-E8
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jan 2014 01:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758311AbaAKAUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jan 2014 19:20:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62513 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758307AbaAKAUm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jan 2014 19:20:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C964B62FB4;
	Fri, 10 Jan 2014 19:20:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fwfmYNqGGHF+4CPyIMivHmHDoEs=; b=NUdAmM
	NRAKaZyd4+PCN5JTp5//GK3RORs3dMnWauP889l7/MofU3DQJlSF2FSE6ELRVQu2
	bBR//TLoKsxt7xLwrvuio+Ssgz2fgJFDB78ZAnhAZbb8fUJqc2EcsoXPpN0NX7nX
	jQ/61SgM7faxLInOhknZVIDe3OXsib1S1DAh0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GOBV3AcHVJCjvhvWSbuhrRzSCtuZ7knK
	qYfM+hh+xvAIKMWnpBjcDztKtQGSOQ9WjJB6CUJOomWgBDnyYjpt1jy+el9xIiq4
	SzMXy2OzTg+GYLWITlZcrnJMFG0uCknnAZ8TNJIURRztLN7EAF3M+j/q2v9U6A1j
	j+cH8hy/g04=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9CBC62FB2;
	Fri, 10 Jan 2014 19:20:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1066062FB1;
	Fri, 10 Jan 2014 19:20:40 -0500 (EST)
In-Reply-To: <1389228344-38813-4-git-send-email-ryan@yaauie.com> (Ryan
	Biesemeyer's message of "Thu, 9 Jan 2014 00:45:43 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 34144B16-7A56-11E3-A15A-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240324>

Ryan Biesemeyer <ryan@yaauie.com> writes:

> +	write_script "$HOOK" <<-EOF &&
> +	if [ -s "$(git rev-parse --git-dir)/MERGE_HEAD" ]; then
> +		exit 0
> +	else
> +		exit 1
> +	fi
> +	EOF

The script can be a one-liner

	write_scirpt "$HOOK" <<-\EOF &&
        test -s "$(git rev-parse --git-dir)/MERGE_HEAD"
	EOF

can't it?  I also do not think you want to have the rev-parse run
while writing the script (rather, you would want it run inside the
script, no?)

> +	git merge other &&
> +	test "`git log -1 --pretty=format:%s`" = "Merge branch '"'"'other'"'"'" &&
> +	test ! -s "$(git rev-parse --git-dir)/MERGE_HEAD"
> +
> +'
> +
>  test_done
