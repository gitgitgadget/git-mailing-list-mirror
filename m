From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] git-p4: handle utf16 filetype properly
Date: Sun, 16 Oct 2011 11:08:33 -0700
Message-ID: <7vaa90reqm.fsf@alter.siamese.dyndns.org>
References: <20111016144215.GC22144@arf.padd.com>
 <20111016144435.GE22144@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
	Chris Li <git@chrisli.org>,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Oct 16 20:08:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFV8b-0000xt-Ce
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 20:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755050Ab1JPSIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 14:08:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57408 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754965Ab1JPSIg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 14:08:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A10514EE2;
	Sun, 16 Oct 2011 14:08:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Iu7FY9YrhE5tFwGfTLb5TQ5gcjk=; b=OWZuP5
	6T2+Sytj3Hn/sm4F98nrnIoH9pG02KYz8l9iCDi8jl/1KucnND2CruGukV1N7GqZ
	hqVXZTPRu+b4aU9Jum1RFiYnSBj27EzH0Q4XIyEw3sBrvYfq2tru5WUdVFbO4Z/i
	p4ifEkn1eD7RCQoVoXVruFj6Kg4gB/xV3gVcE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EgJIn5lu7xneVM9CuOXnuQ+8RTmlwajK
	7StCAujU598DB6prPkA/Gr8nafzkHetNYW5LrVmjp0s69V8eVun4YzEChA5qQb87
	k3s7vJpZ/svQcvCASKo5sccSA0tM0VWXkZruPBBmrF19rsdQ8Zpto2huLu/troj6
	G0hcfvm8Inw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9819F4EE0;
	Sun, 16 Oct 2011 14:08:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19CF84EDF; Sun, 16 Oct 2011
 14:08:35 -0400 (EDT)
In-Reply-To: <20111016144435.GE22144@arf.padd.com> (Pete Wyckoff's message of
 "Sun, 16 Oct 2011 10:44:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DD4776E0-F821-11E0-B212-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183730>

Pete Wyckoff <pw@padd.com> writes:

> +build_smush() {
> +	cat >k_smush.py <<-\EOF &&
> +	import re, sys
> +	sys.stdout.write(re.sub(r'(?i)\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$]*\$', r'$\1$', sys.stdin.read()))
> +	EOF
> +	cat >ko_smush.py <<-\EOF
> +	import re, sys
> +	sys.stdout.write(re.sub(r'(?i)\$(Id|Header):[^$]*\$', r'$\1$', sys.stdin.read()))
> +	EOF
> +}
> +
> +test_expect_success 'keyword file test' '
> +	build_smush &&
> +	test_when_finished rm -f k_smush.py ko_smush.py &&
> +	test_when_finished cleanup_git &&
> +	"$GITP4" clone --dest="$git" //depot@all &&
> +	(
> +		cd "$git" &&
> +
> +		# text, ensure unexpanded
> +		python "$TRASH_DIRECTORY/k_smush.py" <"$cli/k-text-k" >cli-k-text-k-smush &&
> +		test_cmp cli-k-text-k-smush k-text-k &&
> +		python "$TRASH_DIRECTORY/ko_smush.py" <"$cli/k-text-ko" >cli-k-text-ko-smush &&
> +		test_cmp cli-k-text-ko-smush k-text-ko &&
> +
> +		# utf16, even though p4 expands keywords, git-p4 does not
> +		# try to undo that
> +		test_cmp "$cli/k-utf16-k" k-utf16-k &&
> +		test_cmp "$cli/k-utf16-ko" k-utf16-ko
> +	)
> +'

Shouldn't this pay attention to PYTHON_PATH in any way?
