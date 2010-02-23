From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git checkout -b: unparent the new branch with -o
Date: Tue, 23 Feb 2010 13:56:07 -0800
Message-ID: <7viq9nfwg8.fsf@alter.siamese.dyndns.org>
References: <1266960007-16127-1-git-send-email-erick.mattos@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:56:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk2js-0000Ty-Ia
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 22:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134Ab0BWV4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 16:56:15 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41351 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020Ab0BWV4O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 16:56:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D3DA9CF84;
	Tue, 23 Feb 2010 16:56:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lXISBBQASnFYaJY3l2LmmSZVe44=; b=NH1u1n
	e41YgyWpi3FpuOINV1jZ8vy3xZn9ukfwUHvuBX/IBXQolkn7aVtFvjt/knmUXEi4
	QOl7wKH4tWfgigToImA0HhH3vwXe3GEhx1z77CRnKWHwfajbgUbTRLbg2zQcbmYo
	sx2D/AjBWNzIMECqY4grkuNixSMCn/3jQrbEA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h2hTjptJR7SaCL4iSHpqi1zTzYxVT2WG
	q75Ba37E1GMZ2CnGFmWrajRW15SSO6aU8rfvdvDGRnmEwsNXZyHTLhr6/LUNQg4f
	C2le/7cmHvwz3LDbukHJ/zfXvOPpfF1CsCV1T6VuQYYtzlFCWzf/KRTuMfLWNvaD
	NnCyR8tkFWI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CB7079CF83;
	Tue, 23 Feb 2010 16:56:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 111A49CF82; Tue, 23 Feb
 2010 16:56:08 -0500 (EST)
In-Reply-To: <1266960007-16127-1-git-send-email-erick.mattos@gmail.com>
 (Erick Mattos's message of "Tue\, 23 Feb 2010 18\:20\:07 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 416DE81E-20C6-11DF-88A4-E038EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140848>

Erick Mattos <erick.mattos@gmail.com> writes:

> A good example to show the need of this option is a Debian folder of control
> files.  Whenever a maintainer needs to debianize a source code to build
> packages he needs to add a folder called Debian with a lot of files inside it.
> Those files are connected to the source code of the program but they are not
> really part of the program development.  On this situation using the new
> option, that maintainer would do:
>
> 	git checkout -ob debian
> 	git clean -df
> 	mkdir Debian
> 	add all control files
> 	...hack it enough...
> 	git add Debian
> 	git commit

I do not think that is a good example.

If you have an extract of an upstream tarball, say frotz-1.42.tar.gz, and
you are not porting anything older than that version, why not have two
branches, frotz and master, and do things this way?

 - frotz (or "vanilla" or "upstream") that keeps track of the "vendor
   drop" without debian/ directory;

 - master that forks from frotz and adds "debian/" and nothing else; and

 - any other topic branches that either fork from frotz if you are fixing
   upstream bug (or enhancing the vanilla version), or fork from master if
   you are fixing or enhancing the debianization.

When you receive frotz-1.43.tar.gz, you will advance 'frotz' branch with
it, and probably fork maint-1.42 branch from master so that you can keep
supporting older debianized frotz, while merging frotz into master so that
you can prepare a debianized version of newer package.

Your debianization will _never_ be totally independent of the vendor
version, so there is no good reason to have it as a rootless branch.
