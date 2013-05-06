From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] remove the impression of unexpectedness when access is denied
Date: Mon, 06 May 2013 07:02:41 -0700
Message-ID: <7vr4hktddq.fsf@alter.siamese.dyndns.org>
References: <20120610182310.GB2427@book.hvoigt.net>
	<20120611190207.GA20889@sigill.intra.peff.net>
	<20120614071259.GA51076@book.hvoigt.net>
	<7v395xg6oh.fsf@alter.siamese.dyndns.org>
	<20120614203712.GA51783@book.hvoigt.net>
	<20120619182449.GA99957@book.hvoigt.net>
	<20130504031001.GA3734@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 06 16:02:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZM0C-00075v-CW
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 16:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079Ab3EFOCp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 10:02:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34166 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751923Ab3EFOCo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 10:02:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFC3F1B631;
	Mon,  6 May 2013 14:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ao87sF6LxM2QuQNiFnzBvgxU/ss=; b=SDRobS
	JvZu/v3cyXMsPNqc8MVl61Lgzfn+0umpyU9QVLInEojmzuFo//PR9FMDYihgph9C
	3vQ/MdlQepx9MNJVwAmrX/JP0wGQmUOmVePmeS37eVgVcHJwJUpDwDez4vZE62PA
	9alv1L1EZAJLXvA6licH8FKHceVej/6OT1Wvw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VGR/XwhN6AAmIADvsoM8i8HnyIpWJ8Bz
	Po7QvVSzl2WH+Y9Vqpxb1r/ZQDoFjFIxKdT0zCePRBaa0dERsSfisje9C+msgsQ7
	BHDNRjBKCVZKBzPYF7B5+xDhb7wlVrSlIkw2jAMRWsvolKdK5f2OWGDrPi4OrH9D
	G615l7V7C88=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C40EB1B630;
	Mon,  6 May 2013 14:02:43 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 466241B62F;
	Mon,  6 May 2013 14:02:43 +0000 (UTC)
In-Reply-To: <20130504031001.GA3734@elie.Belkin> (Jonathan Nieder's message of
	"Fri, 3 May 2013 20:10:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9F24F934-B655-11E2-9FF3-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223450>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I ran into this message for the first time today.
>
>  $ git fetch --all
>  Fetching origin
>  remote: Counting objects: 368, done.
> [...]
>  Fetching gitk
>  fatal: Could not read from remote repository.
>
>  Please make sure you have the correct access rights
>  and the repository exists.
>  error: Could not fetch gitk
>  Fetching debian
>  Fetching pape
> [...]
>
> The "gitk" remote refers to git://git.kernel.org/pub/scm/gitk/gitk.
> Using ls-remote to contact it produces the same result.  The message
> is correct: the repository does not exist.
>
> Impressions:
>
>  * Looking at "Could not read", it is not clear what could not read
>    and why.  GIT_TRACE_PACKET tells me the interaction was
>
> 	me> git-upload-pack /pub/scm/gitk/gitk\0host=git.kernel.org\0
> 	them> (hangup)
>
>    Would it make sense for the server to send an "ERR" packet to give
>    a more helpful diagnosis?

I think git-daemon does so (or at least attempts to do so);
path_ok() uses enter_repo() to check if the given path is a
repository, returns NULL to run_service(), whichh in turn calls
daemon_error() that does the ERR thing.

>  * The spacing and capitalization is odd and makes it not flow well
>    with the rest of the output.  I suspect it would be easier to read
>    with the error separated from hints:
>
> 	Fetching gitk
> 	fatal: the remote server sent an empty response
> 	hint: does the repository exist?
> 	hint: do you have the correct access rights?
> 	error: Could not fetch gitk
> 	Fetching debian
>
>    If a server is misconfigured and just decides to send an empty
>    response for no good reason, the output would still be true.

It does sound better. Also s/Could not fetch/could not fetch/.

>  * The error message is the same whether the server returned no
>    response or an incomplete pkt-line.  Maybe in the latter case it
>    should print the "hung up unexpectedly" thing.

OK.
