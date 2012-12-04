From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Add basic syntax check on shell scripts
Date: Tue, 04 Dec 2012 11:39:19 -0800
Message-ID: <7vobi9mwt4.fsf@alter.siamese.dyndns.org>
References: <201212021417.25525.tboegi@web.de>
 <7vzk1vrs63.fsf@alter.siamese.dyndns.org>
 <CACsJy8BxviWRHqGvptsJVmkFM6HQa9HnLWsh5V6Ec6Fqv52sGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 20:39:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfyLE-0006F1-TN
	for gcvg-git-2@plane.gmane.org; Tue, 04 Dec 2012 20:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047Ab2LDTjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2012 14:39:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60049 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005Ab2LDTjX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2012 14:39:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D5959D0D;
	Tue,  4 Dec 2012 14:39:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1vto7em8LFQfg+yn/AdZufXrtt4=; b=N9HjxE
	qokpctZRgFP6J9Ai+mWINc1Rou3IIRZip4FjPBEDH0Yjdel9Bui+/OUVUiliLRh1
	8YvTzmNG8CpAUZLGoobfrm25ugiOgSMwEFQQsPsan+N3rq/CMuNdMDiMRYk0Fcr/
	AuyPeF2TQcXV4KB5PEjTfpbMxuIkrrLcsOLHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JBpSwqB1Oyf3P//S42otr8ukBfMY6TJg
	VpoeJJ0NZ0eK5o/hVDfpphF8/x6SB5KsmBPzlQ+kHMYATWTnooz8EAu7aQljE+my
	CXbTQoaVMWzFZtNnc8LUaxzQhk1dtCXn8wInpywFqWhcelj0cnQq8IaUzqQbWRVy
	GaBKhTPy9mc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECD359D0C;
	Tue,  4 Dec 2012 14:39:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E3A89D08; Tue,  4 Dec 2012
 14:39:21 -0500 (EST)
In-Reply-To: <CACsJy8BxviWRHqGvptsJVmkFM6HQa9HnLWsh5V6Ec6Fqv52sGA@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 4 Dec 2012 14:20:20 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4CF1A3B6-3E4A-11E2-B796-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211092>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> This (once it gets cleaned up to reduce false positives) belongs to
>> "cd t && make test-lint".
>
> Or a project commit hook?

Surely.  It is OK to have "cd t && make test-lint" in your
pre-commit hook.

A few more things in addition to what Torsten's script attempts to
catch that we would want to catch are:

 * Do not spell string equality with "test $a == $b"; that is
   bash-ism and you only need "=" (which works in bash, too);

 * Do not capture output from "wc -l" in a variable and string
   compare with a constant, e.g. 

	lnum=$(wc -l <...) && test "$lnum" = 9

   as some wc implementations place extra SP in its output;

 * Do not use "test_must_fail" to run non-git command and require it
   to fail (instead, just write "! cmd").

 * Do not write ERE with backslashes and expect "grep" to grok them;
   that's GNUism.  e.g.

	grep "^\(author\|committer\) "

   is bad.  Use egrep (or "grep -E") if you want to use ERE.
