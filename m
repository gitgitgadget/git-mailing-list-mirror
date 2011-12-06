From: Junio C Hamano <gitster@pobox.com>
Subject: Re: hooks that do not consume stdin sometimes crash git with SIGPIPE
Date: Mon, 05 Dec 2011 17:39:19 -0800
Message-ID: <7vmxb6iim0.fsf@alter.siamese.dyndns.org>
References: <20110829203107.GA4946@gnu.kitenet.net>
 <20111205192930.GA32463@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Lars Wirzenius <liw@liw.fi>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Tue Dec 06 02:39:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXk0G-0001r2-0J
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 02:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932827Ab1LFBjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Dec 2011 20:39:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50290 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932809Ab1LFBjW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2011 20:39:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5C0169E1;
	Mon,  5 Dec 2011 20:39:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kGaBqPsEri9xg2cvsG5Ryb1RRPg=; b=QtUbxC
	bm5L1DP/dBOUnJwMYEbMPBJ11BYhfjK3ViifSgNfnWdrYW4SxgZmgHMwQ/6bamyx
	Wl1MXK+LW+bOqW477CUuRJT9BC+2vTmNiTkVJtkptP+Zusop/+CymIqotWgvwNbx
	SOjTIWkORGrngAqqbFt4nQtwg7hks3lzmMNZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZxrYHIbTtn6HhNzfn/nIxJSgpg1UyO9V
	6QYDckO88EHRzVJrgij5iRyP4svM5nbHVzl9YnMVCROcK9mNvP3RmeClvSM92beT
	nqprXgFDdso9NGxitqaWf8DIXyAnwEzo24jKSlPjXU31yNMa3HITscoZMRQ030Ns
	qbdftlygqaE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD2FF69E0;
	Mon,  5 Dec 2011 20:39:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 579A669D6; Mon,  5 Dec 2011
 20:39:21 -0500 (EST)
In-Reply-To: <20111205192930.GA32463@gnu.kitenet.net> (Joey Hess's message of
 "Mon, 5 Dec 2011 15:29:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1EC17FD4-1FAB-11E1-8B36-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186306>

Joey Hess <joey@kitenet.net> writes:

> We had a weird problem where, after moving to a new, faster server,
> "git push" would sometimes fail like this:
>
> Unpacking objects: 100% (3/3), done.
> fatal: The remote end hung up unexpectedly
> fatal: The remote end hung up unexpectedly
>
> Turns out that git-receive-pack was dying due to an uncaught SIGPIPE.

Why do you have a hook that is expected to read from receive-pack that
does _not_ read anything from it in the first place? If you do not care
about the update status given to pre-receive, shouldn't you be using the
update hook and ignoring the command line parameters instead?

I am not saying this is a user configuration error and there is nothing to
fix---Git shouldn't get killed merely because of configuration error.

I am wondering if we would want to have a uniform way to tell run_*_hook()
functions that the hook writer explicitly declines to get any input. E.g.
"hooks/pre-receive-noinput" is called instead of "hooks/pre-receive" and
we do not send any input to it, or something like that.
