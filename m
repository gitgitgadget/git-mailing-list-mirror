From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: git ls-files and ignored directories
Date: Fri, 01 Jun 2012 09:03:23 -0700
Message-ID: <7vr4tz3tpw.fsf@alter.siamese.dyndns.org>
References: <20120530102218.0625CFC006A@dd24126.kasserver.com>
 <20120531101451.C35C5B4C00D@dd24126.kasserver.com>
 <20120601093757.GE32340@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christoph Buchner <bilderbuchi@phononoia.at>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 01 18:03:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaUK3-000739-JJ
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 18:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965186Ab2FAQD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 12:03:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61899 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965020Ab2FAQD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 12:03:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 093738671;
	Fri,  1 Jun 2012 12:03:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DElWslt3PxASbElNwcNQM/KUsgY=; b=E5sFOg
	JNXC820oosLZ7lv4WUicSrXrijhKNYCDP5Qx05tVuN9YKY4UnSPcFf2z68gJasVj
	LF66CLU16Ljwji8Mic1eKuny4xRjg4GBrhbhVsuAo9cQVPGziCy3UjbyKXA+to6d
	ySB4UHd1725Au1MtZwSS3ssrJ+97BDRv25qAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bztqtjhp+ACqC+tcnMJuhYcWQnPEgETZ
	ZAgQEhP0xr//nvayroCyMbE2/lPQXtUpEfPRrswvmFL9C6dvZYN4Vt6ZIEZtX02b
	Nd4B4bK7Opj9TqTs7+irPeaei4uguT8AHoOFt4yTqeM/y09Wfr9nRPjAVUNuLZTT
	k2YtFuCT2rU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 007F6866F;
	Fri,  1 Jun 2012 12:03:26 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B8FA866E; Fri,  1 Jun 2012
 12:03:25 -0400 (EDT)
In-Reply-To: <20120601093757.GE32340@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 1 Jun 2012 05:37:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 51BA1D94-AC03-11E1-9FD1-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198997>

Jeff King <peff@peff.net> writes:

> No, I don't think anybody is working on it at the moment (at least I
> do not see anything near the time of that old discussion, nor do I
> recall it being discussed since).
>
> +cc Clemens, in case he had any work-in-progress as a result that did
> not end up getting published.

I think the way the codepath for -i feeds path to excluded() is wrong.

The excluded() interface relies on the fact that the caller has
already checked foo/ before calling it for foo/bar; when asked to
see if "foo/bar" is excluded, it does not consider if "foo/" is
excluded---the caller should have already checked it.

The loop for cached/stage case in builtin/ls-files.c::show_files()
needs to learn to be more careful when DIR_SHOW_IGNORED is set in
dir->flags.  It needs to call a new helper function that notices
that the check is walking into a different directory from the path
it checked last, and feed leading directories to excluded(), or
something like that, instead of directly calling !excluded().
