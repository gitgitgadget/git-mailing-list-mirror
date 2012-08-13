From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help: correct behavior for is_executable on Windows
Date: Mon, 13 Aug 2012 10:48:14 -0700
Message-ID: <7vmx1yel9d.fsf@alter.siamese.dyndns.org>
References: <20120811070030.GA83665@book.hvoigt.net>
 <7vd32whgvl.fsf@alter.siamese.dyndns.org>
 <20120813170221.GB6418@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Aug 13 19:48:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0ykZ-0005tx-Rq
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 19:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910Ab2HMRsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 13:48:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36126 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861Ab2HMRsR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 13:48:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B24B94B3;
	Mon, 13 Aug 2012 13:48:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7tRW6xG6Y2bwHymJNemDur2gzJY=; b=qWDVQ8
	gw3QOWJ5gY0bB7Ce1QhMULRoOlY/ljzb7rQKF+/WflAY4m9vXOa5WzstvR21WW2y
	GCc+LervCThAEVyScd0sr2FlWrFFhSug59305pMQm79i7Cqm2VlhWp4YBBkSOrA9
	ayY1dgD/1BeTSo8YHUHLLRksMmlmp7IVPEsVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b9nrBWGirw3eoaUXixK2zgMWCT7xA7fV
	F2V6TMFIkTYrcWSwsSt+bNlmcnBblsFueDlrinisYtQNqYD+x4ePOdvliv9vi4L/
	wzH1FtsElWpq/5+IH7AJfAG59K3WSDYsPRRre35ABCLHIKcdsNj4cUOb7BHGh1yi
	9ko85CDV8WU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB5BD94B2;
	Mon, 13 Aug 2012 13:48:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 500C794B0; Mon, 13 Aug 2012
 13:48:16 -0400 (EDT)
In-Reply-To: <20120813170221.GB6418@book.hvoigt.net> (Heiko Voigt's message
 of "Mon, 13 Aug 2012 19:02:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F94A510-E56F-11E1-A818-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203349>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> Since the code for cygwin and windows in general is almost the same I would
> extract one function for them where I leave in one ifdef for cygwin.
>
> E.g. like this:
>
>
> 	static int is_executable(const char *name)
> 	{
> 	        struct stat st;
>
> 	        if (stat(name, &st) || /* stat, not lstat */
> 	            !S_ISREG(st.st_mode))
> 	                return 0;
>
> 		fill_platform_stat(name, &st);
>
> 	        return st.st_mode & S_IXUSR;
> 	}
>
> which I could then define to a no op on posix. That way we avoid code
> duplication in the platform specific functions.
>
> What do you think?

Does having the "stat()" help on Windows in any way?  Does it ever
return an executable bit by itself?

If not, Windows compat/ implementation may want to skip issuing a
useless stat() and write it as

	if (has_extension(".exe"))
        	return 1;
	if (contents_begins_with("MZ") || contents_begins_with("#!"))
        	return 1;
	return 0;

without ever talking about stat() which is POSIXism compat/
implementation for Windows does not have to worry about.

And that was the reason I suggested making the whole implementation
of path_is_executable() overridable by compat/ layer.

But if having "stat()" helps on Windows, then your counterproposal
is good enough for me.

Thanks.
