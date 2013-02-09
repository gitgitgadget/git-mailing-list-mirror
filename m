From: Junio C Hamano <gitster@pobox.com>
Subject: Re: inotify to minimize stat() calls
Date: Fri, 08 Feb 2013 18:56:30 -0800
Message-ID: <7vsj56w5y9.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 <7vehgqzc2p.fsf@alter.siamese.dyndns.org>
 <7va9rezaoy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 03:57:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U40ch-0005eM-4v
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 03:57:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315Ab3BIC4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 21:56:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39823 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760552Ab3BIC4d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 21:56:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0354BD84;
	Fri,  8 Feb 2013 21:56:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ll1ggna6cyROKyd4XOjFjPckxtQ=; b=FrCuEX
	aVofig2CFDUgXWK1ZhhrM2/QdCNbwXE94jOmIGAq9dS2NJJTNjXUl3HuKxzBw3sT
	TrCmF8XHJ3/ltJcWabQDHl7njmYFxXK70P10Mwb+/wSAycN+tBk3wVhJq2JXUTlr
	mh5rE3pb7qGhhVTmVCNqA7hPXCBEciq7QlnaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CWUuccGE206zTxs3aWm/MoGqc1QVu4o8
	mGFMwaEoTIp8tnQsVoSYC3cP2SVHkCIHcy0aPtXVpobQ28BoZrQW+i2sWLhuOpvl
	26RYO7spyWx1Zx5sMu1XqoCjiTXYkwp/1ntHj9JmRc/z9QO5dw5mvEJS+N9/G9WW
	o4rmJzgkCes=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5940BD83;
	Fri,  8 Feb 2013 21:56:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4133FBD81; Fri,  8 Feb 2013
 21:56:32 -0500 (EST)
In-Reply-To: <7va9rezaoy.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 08 Feb 2013 14:45:49 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4F07E8BA-7264-11E2-BAC7-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215848>

Junio C Hamano <gitster@pobox.com> writes:

> I checked read-cache.c and preload-index.c code.  To get the
> discussion rolling, I think something like the outline below may be
> a good starting point and a feasible weekend hack for somebody
> competent:
>
>  * At the beginning of preload_index(), instead of spawning the
>    worker thread and doing the lstat() check ourselves, we open a
>    socket to our daemon (see below) that watches this repository and
>    make a request for lstat update.  The request will contain:
>
>     - The SHA1 checksum of the index file we just read (to ensure
>       that we and our daemon share the same baseline to
>       communicate); and
>
>     - the pathspec data.
>
>    Our daemon, if it already has a fresh data available, will give
>    us a list of <path, lstat result>.  Our main process runs a loop
>    that is equivalent to what preload_thread() runs but uses the
>    lstat() data we obtained from the daemon.  If our daemon says it
>    does not have a fresh data (or somehow our daemon is dead), we do
>    the work ourselves.
>
>  * Our daemon watches the index file and the working tree, and
>    waits for the above consumer.  First it reads the index (and
>    remembers what it read), and whenever an inotify event comes,
>    does the lstat() and remembers the result.  It never writes
>    to the index, and does not hold the index lock.  Whenever the
>    index file changes, it needs to reload the index, and discard
>    lstat() data it already has for paths that are lost from the
>    updated index.

I left the details unsaid in thee above because I thought it was
fairly obvious from the nature of the "outline", but let me spend a
few more lines to avoid confusion.

 - The way the daemon "watches" the changes to the working tree and
   the index may well be very platform dependent.  I said "inotify"
   above, but the mechanism does not have to be inotify.

 - The channel the daemon and the client communicates would also be
   system dependent.  UNIX domain socket in $GIT_DIR/ with a
   well-known name would be one possibility but it does not have to
   be the only option.

 - The data given from the daemon to the client does not have to
   include full lstat() information.  They start from the same index
   info, and the only thing preload_index() wants to know is for
   which paths it should call ce_mark_uptodate(ce), so the answer
   given by our daemon can be a list of paths.
