From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] hooks: Add function to check if a hook exists
Date: Fri, 28 Dec 2012 18:08:01 -0800
Message-ID: <7vwqw1fw5a.fsf@alter.siamese.dyndns.org>
References: <1356735452-21667-1-git-send-email-aaron@schrab.com>
 <1356735452-21667-2-git-send-email-aaron@schrab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Aaron Schrab <aaron@schrab.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 03:09:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TolrI-0003oD-M7
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 03:09:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755201Ab2L2CIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 21:08:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58029 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755191Ab2L2CIE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 21:08:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEA6FAA3E;
	Fri, 28 Dec 2012 21:08:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z6yWoRDQX6adgwUm2iL9quV1OuE=; b=KglGxp
	R1H3OsY0qM//miUNGaoKZJWwK8DaXOnsCUNlf9tlmoShqy2Gt37LHEAwFqZkmk0h
	IjDWtwgabs5UuwhNZsiflREN5pMVZtNZVTx/RAu9JdH94i9C3gS7HYAlMP59Qsif
	PrxpRHokxmnTyFYSXwU7bHxCnRgwFQnScCpn4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s3D+QDkx5w9c+kcdZXyVzJLlBQxq1ZDO
	07q6xJtoVhvZO0jf1aVzJ1+RZZFeMpGjxclfe7Nfzift0vxczuHX5jXCN0fRq/jy
	rDmCV/VZU9d0uuLKX8nUgDf7HHV/LJQkVEJl7stUUaQCv+KmrDbMJYNK5FfY0YpK
	AnylDrpiXts=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D928EAA3D;
	Fri, 28 Dec 2012 21:08:03 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2DD46AA3A; Fri, 28 Dec 2012
 21:08:03 -0500 (EST)
In-Reply-To: <1356735452-21667-2-git-send-email-aaron@schrab.com> (Aaron
 Schrab's message of "Fri, 28 Dec 2012 17:57:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 93BC36E2-515C-11E2-9A1B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212284>

Aaron Schrab <aaron@schrab.com> writes:

> Create find_hook() function to determine if a given hook exists and is
> executable.  If it is the path to the script will be returned, otherwise
> NULL is returned.

Sounds like a sensible thing to do.  To make sure the API is also
sensible, all the existing hooks should be updated to use this API,
no?

> This is in support for an upcoming run_hook_argv() function which will
> expect the full path to the hook script as the first element in the
> argv_array.  

There is currently a public function called run_hook() that squats
on the good name with a kludgy API that is too specific to using
separate index file.  Back when it was a private helper in the
implementation of "git commit", it was perfectly fine, but it was
exported without giving much thought on the API.

If you are introducing a new run_hook_* function, give it a generic
enough API that lets all the existing hook callers to use it.  I
would imagine that the API requirement may be modelled after
run_command() API so that we can pass argv[] and tweak the hook's
environ[], as well as feeding its stdin and possibly reading from
its stdout.  That would be very useful.
