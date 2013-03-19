From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] add -u: only show pathless 'add -u' warning when
 changes exist outside cwd
Date: Mon, 18 Mar 2013 21:25:33 -0700
Message-ID: <7vli9kkoci.fsf@alter.siamese.dyndns.org>
References: <20130313040845.GA5057@sigill.intra.peff.net>
 <20130313041037.GB5378@sigill.intra.peff.net>
 <20130319034415.GI5062@elie.Belkin> <20130319034822.GL5062@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 05:26:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHo7f-0008El-IS
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 05:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755139Ab3CSEZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 00:25:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54343 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755106Ab3CSEZg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 00:25:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85FE58E2F;
	Tue, 19 Mar 2013 00:25:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nVlmTJ2Q/hv4m7wbopwoO+CVdfI=; b=sg05bV
	poPc9RH/2yNcXVlUKgRVqFBX5MjTpAkojBuyaTu3TYldj8CQTz5JqEBcMS2rxiqZ
	halkdO6adFQMOTtT1lo/Zst1I2+UlltuvctNmb5ueu52wIJv6hDuih88zPS+Qefe
	BLZJMBdhnR0GjR+zViNYcc5rkkwC9kq+160yw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BnKALFZTckBbPZFOTNgI0yOAUas/El2G
	YlPDVwS76fQ1FRjo4aqwYnb5/TKB7ZLx+tDmA+n2JTbQ/Iv7W/p77pRJEOl3CA2y
	FbScMbNyMipLGqnvb6GUhnkzhBsfmYcY7j3+zclpjas+Yhs3TdGgCilSxPgx8mHd
	FKJvIzLgm+g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A5688E2E;
	Tue, 19 Mar 2013 00:25:35 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EF4B08E2C; Tue, 19 Mar 2013
 00:25:34 -0400 (EDT)
In-Reply-To: <20130319034822.GL5062@elie.Belkin> (Jonathan Nieder's message
 of "Mon, 18 Mar 2013 20:48:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0B3BE058-904D-11E2-AE1F-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218480>

Jonathan Nieder <jrnieder@gmail.com> writes:

> A common workflow in large projects is to chdir into a subdirectory of
> interest and only do work there:
>
> 	cd src
> 	vi foo.c
> 	make test
> 	git add -u
> 	git commit
>
> The upcoming change to 'git add -u' behavior would not affect such a
> workflow: when the only changes present are in the current directory,
> 'git add -u' will add all changes, and whether that happens via an
> implicit "." or implicit ":/" parameter is an unimportant
> implementation detail.
>
> The warning about use of 'git add -u' with no pathspec is annoying
> because it serves no purpose in this case.  So suppress the warning
> unless there are changes outside the cwd that are not being added.

That is a logical extension of the reason why we do not emit
warnings when run at the top level.  A user who has known about and
is very much accustomed to the "current directory only" behaviour
may run "git add -u/-A" always from the top in the current project
she happens to be working on until Git 2.0 happens, and will not get
any warnings.  We are already robbing the chance to learn about and
prepare for the upcoming change from her.  And this patch makes it
even more so.  It does not make things fundamentally worse, but it
makes it more likely to hurt such a user.

The implemenation appears to run an extra diff_files() in addition
to the one we already have to run in order to implement the "add -u"
to collect modified/deleted paths.  Is that the best we can do?  

I am wondering if we can special case the no-pathspec case to have
add_files_to_cache() call underlying run_diff_files() without any
pathspec, inspect the paths that are modified and/or deleted in the
update_callback, add ones that are under the $prefix while noticing
the ones outside as warning worthy events.
