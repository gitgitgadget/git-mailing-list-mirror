From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD/PATCH 3/5] checkout: Use remote refspecs when DWIMming tracking branches
Date: Fri, 19 Apr 2013 12:44:00 -0700
Message-ID: <7vzjwuz4ov.fsf@alter.siamese.dyndns.org>
References: <1366352442-501-1-git-send-email-johan@herland.net>
	<1366352442-501-4-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Apr 19 21:44:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTHE9-0005o1-Hm
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 21:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950Ab3DSToF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 15:44:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44959 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753715Ab3DSToD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 15:44:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E661170BD;
	Fri, 19 Apr 2013 19:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HXbk5AwUoJFP6qroVW0hPcOcp7Q=; b=weNw8j
	+cubeUmatJbO8YtWRtTRYZwXB75rIKBTuXvXZFfA29SMESbEtuqkc1/Z97KyVO8a
	IQla4Q902TNsEOBrBGGhqjteYn1ISeKJ3INP22UisjtR2UUpGQ85Nn8O1TOzyycU
	08dJKg49eudsT7mXt5di3BD3s0PCYtMBiymKc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IziKXxsJZRaoyOr97TymWvD90dDOTO9l
	nkPhdTNQVWKr7+1iQnU9ZJIXWSifZ+OqbsABQogVenu8cB2HNYFlO2qKB/4jfdzo
	5gF4VLNZ6OMKW4MXn1IxpMn4nxYVwIOLv8HHsTxrUD8C4E9x9lTz0ZvnF3R5q1Vh
	G7ao3c9gt1U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46B37170BC;
	Fri, 19 Apr 2013 19:44:02 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AB7BD170B7;
	Fri, 19 Apr 2013 19:44:01 +0000 (UTC)
In-Reply-To: <1366352442-501-4-git-send-email-johan@herland.net> (Johan
	Herland's message of "Fri, 19 Apr 2013 08:20:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7C346D6C-A929-11E2-B867-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221811>

Johan Herland <johan@herland.net> writes:

> The DWIM mode of checkout allows you to run "git checkout foo" when there is
> no existing local ref or path called "foo", and there is exactly one remote
> with a remote-tracking branch called "foo". Git will then automatically
> create a new local branch called "foo" using the remote-tracking "foo" as
> its starting point and configured upstream.
>
> However, the current code hardcodes the assumption that all remote-tracking
> branches are located at refs/remotes/$remote/*, and that "git checkout foo"
> must find exactly one ref matching "refs/remotes/*/foo" to succeed.
> This approach fails if a user has customized the refspec of a given remote to
> place remote-tracking branches elsewhere.
>
> The better way to find a tracking branch is to use the fetch refspecs for the
> configured remotes to deduce the available candidate remote-tracking branches
> corresponding to a remote branch of the requested name, and if exactly one of
> these exists (and points to a valid SHA1), then that is the remote-tracking
> branch we will use.
>
> For example, in the case of "git checkout foo", we map "refs/heads/foo"
> through each remote's refspec to find the available candidate remote-tracking
> branches, and if exactly one of these candidates exist in our local repo, then
> we have found the upstream for the new local branch "foo".

Once you introduce a concrete "foo" as a name in the example, it
would be far easier to understand if you spelled all the other
assumptions in the example out.

I am _guessing_ that you mean a case like this:

	[remote "origin"]
		fetch = refs/heads/*:refs/remotes/origin/*
	[remote "xyzzy"]
		fetch = refs/heads/*:refs/remotes/xyzzy/nitfol/*
	[remote "frotz"]
		fetch = refs/heads/*:refs/remotes/frotz/nitfol/*

and refs/remotes/origin/foo or refs/remotes/frotz/nitfol/foo do not
exist but refs/remotes/xyzzy/nitfol/foo does.  And the user says
"git checkout foo".  Instead of finding a remote ref that matches
"refs/remotes/*/foo" pattern (and assuming the part that matched *
is the name of the remote), you can iterate the RHS of the refspecs
to see if there is a unique match.

Then the new branch can unambiguously find that its upstream is
xyzzy's foo.

I think it makes sense to update the semantics like that.

Wouldn't the traditional case (i.e. without "nitfol/" in the
xyzzy/frotz remotes above) be a mere special case for this new
logic?  You mentioned there is a regression caught by existing tests
if you go this route, but I do not see how that happens.
