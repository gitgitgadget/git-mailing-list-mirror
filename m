From: Junio C Hamano <gitster@pobox.com>
Subject: Re: inotify to minimize stat() calls
Date: Fri, 08 Feb 2013 14:45:49 -0800
Message-ID: <7va9rezaoy.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 <7vehgqzc2p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 23:46:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3wi0-0007uZ-Ug
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 23:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947286Ab3BHWpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 17:45:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63136 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760366Ab3BHWpw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 17:45:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E67EC60E;
	Fri,  8 Feb 2013 17:45:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yJ1m276O3ohlgkf2N1B7kT3QK48=; b=eG33uG
	2wwpe8m+1farTOoPfA+eSAIEenh+Aur/SLeymHoExNNE7Jr5vQxbCUWOFq6uBtKb
	gWu3reqshKtRXMWgE6lK9TOtwuwEKXtO4x1sJa0GVefsNP+9z8f9PGa+CUGXlxZW
	BqTL9zHCD1bNfGX+f+bCTfQA6EUQ2xT3Isuqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rmTGlNGaHqMuWRR5jpEyHUoFufooxIml
	N/p+aYGay1s0acsmYmy7BUJ3EcZ7xccSV41F5fMpun2wojf8C1nAfWuFyiNniZVx
	G5+crS2WdnUWBZQHTxuK9uDF/PrXh2gWmu+H1XjigzrW4Lk2FkXYhjYmBS5Zmiva
	IhaPkrJrGzI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62750C60D;
	Fri,  8 Feb 2013 17:45:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0D08C60B; Fri,  8 Feb 2013
 17:45:51 -0500 (EST)
In-Reply-To: <7vehgqzc2p.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 08 Feb 2013 14:15:58 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4A353FB8-7241-11E2-A1FF-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215823>

Junio C Hamano <gitster@pobox.com> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> ...  Will Git ever
>> consider using inotify on Linux?  What is the downside?
>
> I think this has come up from time to time, but my understanding is
> that nobody thought things through to find a good layer in the
> codebase to interface to an external daemon that listens to inotify
> events yet.  It is not something like "somebody decreed that we
> would never consider because of such and such downsides."  We are
> not there yet.

I checked read-cache.c and preload-index.c code.  To get the
discussion rolling, I think something like the outline below may be
a good starting point and a feasible weekend hack for somebody
competent:

 * At the beginning of preload_index(), instead of spawning the
   worker thread and doing the lstat() check ourselves, we open a
   socket to our daemon (see below) that watches this repository and
   make a request for lstat update.  The request will contain:

    - The SHA1 checksum of the index file we just read (to ensure
      that we and our daemon share the same baseline to
      communicate); and

    - the pathspec data.

   Our daemon, if it already has a fresh data available, will give
   us a list of <path, lstat result>.  Our main process runs a loop
   that is equivalent to what preload_thread() runs but uses the
   lstat() data we obtained from the daemon.  If our daemon says it
   does not have a fresh data (or somehow our daemon is dead), we do
   the work ourselves.

 * Our daemon watches the index file and the working tree, and
   waits for the above consumer.  First it reads the index (and
   remembers what it read), and whenever an inotify event comes,
   does the lstat() and remembers the result.  It never writes
   to the index, and does not hold the index lock.  Whenever the
   index file changes, it needs to reload the index, and discard
   lstat() data it already has for paths that are lost from the
   updated index.
