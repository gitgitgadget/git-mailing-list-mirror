From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/5] attr.c: respect core.ignorecase when matching
 attribute patterns
Date: Mon, 10 Oct 2011 17:00:10 -0700
Message-ID: <7vmxd8ieid.fsf@alter.siamese.dyndns.org>
References: <VYN8m1JCy102-eaWWa-bsunEvt3zeXLJkVg7FZKZCtXT-Ww0vg7a8xA7NTvrZTiovKTnJ9Hlom0@cipher.nrlssc.navy.mil> <U4wiHVyDLLG1PhI-8iY3YhHT7CEcTMEfg9MCDSaeuwAkg0N1a5wRE5NXaKAVQx8kpEYt75REVpRavoc-HiKe6rLk2AUepzHWptkevo08MRbGyWxqBHT_rySLemcbi66NKLRXwFGtaRQ@cipher.nrlssc.navy.mil> <4E91BAC8.9060606@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	peff@peff.net, j.sixt@viscovery.net,
	Brandon Casey <drafnel@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 11 02:00:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDPlc-0004rR-GP
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 02:00:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942Ab1JKAAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 20:00:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59391 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061Ab1JKAAN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 20:00:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F74355F4;
	Mon, 10 Oct 2011 20:00:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=cjXHrHHSjc/WJVIYKDcVaKlsYwY=; b=aGoqt8CnRMlSR0+/nYEk
	3fCShqutG2YmWbJkfqZxQJl/YCHQJNHT1vrFU3fjxa+i3iHYG/JMnZ3mq6DzI/g2
	J2LIhb0hzJHGbx+qGX8GaF7XukjZIOii87YOHvDDp/06DqasDGF4UxbNfsbhXeaw
	3ry/NgHJ0r2NSgkTHUbAhAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=X4RSqozh7Rv2RNBEJ4cc4aL6nAolzYxkAKoku2t6tRdbRB
	uF0aAUsBXFh0byry1rZpT2qF9Z6E6rj12f14CdPDPqfI8kLQOmY3SeiBfUKtQlxh
	5ZS1zWUo3r63U/8vQPQS6QP2vI6r0ma5c30eHolQziKl883nVS5U4aQEeFfPs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 354F955EB;
	Mon, 10 Oct 2011 20:00:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A40855EA; Mon, 10 Oct 2011
 20:00:12 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FDC010EC-F39B-11E0-A267-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183272>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 10/06/2011 08:22 PM, Brandon Casey wrote:
>> The last set of tests is performed only on a case-insensitive filesystem.
>> Those tests make sure that git handles the case where the .gitignore file
>> resides in a subdirectory and the user supplies a path that does not match
>> the case in the filesystem.  In that case^H^H^H^Hsituation, part of the
>> path supplied by the user is effectively interpreted case-insensitively,
>> and part of it is dependent on the setting of core.ignorecase.  git should
>> only match the portion of the path below the directory holding the
>> .gitignore file according to the setting of core.ignorecase.
>
> ... It is hard to imagine that
> anybody *wants* part of a single filename to be matched
> case-insensitively and another part to be matched case-sensitively.

That is not necessarily coming from the user's wish. When a command that
takes a pathspec from the user is run from a subdirectory, almost always
the output from $(git rev-parse --show-prefix) is prefixed to them. This
value is read from the filesystem, and unless on a system whose readdir()
may lie to us, we do not _have_ to ignore the case of this part of the
substring of a resulting pathspec element to get a successful match, even
though we _do_ want to match the user-supplied part case insensitively
if/when the user says he wants us to with core.ignorecase.

Having said that, it may not hurt in practice if we matched the prefix
part case insensitvely, because prefix=foobar/ obtained on a filesystem
where core.ignorecase is true would mean there won't be FooBar/ and other
case-permuted names on the filesystem at the same time.

But of course I may be missing something...
