From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git grep doesn't follow symbolic link
Date: Tue, 10 Jan 2012 10:22:13 -0800
Message-ID: <7vwr8za04q.fsf@alter.siamese.dyndns.org>
References: <CAPRVejc7xND_8Y=Pb5rYGEcaKYUaX7_WkSro-_EL8tTGxkfY3Q@mail.gmail.com>
 <CALkWK0=-LZH4MYhX50v-RWpGA2r+6q50YxsKaOxc0mJ__yuK7g@mail.gmail.com>
 <877h0zlvwd.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Bertrand BENOIT <projettwk@users.sourceforge.net>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 10 19:22:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkgL0-0000wa-6i
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 19:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932784Ab2AJSWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 13:22:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36558 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932311Ab2AJSWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 13:22:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3796660B;
	Tue, 10 Jan 2012 13:22:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d31lGN6w4X0mFiKY2XqjzW5xvaI=; b=WsmK05
	hQwMp6ra1bdw9A1y9u2u09o1zYMfVgkEU+yVR5zLWOczdCCfKVIfQFyplthW2W+E
	Qp/XRK+Me3e1STI3U0wbKDwzSv+Sj+Lj1D3y5326wuSD4e14gKJZumibEqYnIymR
	BqEeqalq5yYc5K7M+5FmaLImQn5EKsINWWuKM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vkxLzqgdDqjQkJSbHHfNcSvUSSSDv6bE
	m+x/C8p2/lpMpwWW783ZzQxC/lw3LBFb4Bvf+YmmF+c0qS5PFaUMg+YYM7aG/Jo2
	6+63KWZoiU+2N0iFhJcjyb1g2vO+RBAmIsunzHEMYzu2WbEhTK/53ZUkOH6GUFla
	F1Rq3+PmPGI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA4CD660A;
	Tue, 10 Jan 2012 13:22:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4036C6609; Tue, 10 Jan 2012
 13:22:15 -0500 (EST)
In-Reply-To: <877h0zlvwd.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Tue, 10 Jan 2012 11:00:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 05A7FC8E-3BB8-11E1-89BE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188275>

Thomas Rast <trast@student.ethz.ch> writes:

>> I'd imagine so: symbolic links are not portable across different file
>> systems; Git's internal representation of a symbolic link is a file
>> containing the path of the file to be linked to.
>
> I'd actually welcome a fix to this general area,...

Even though some platforms may lack symbolic links, where they are
supported, they have a clear and defined meaning and that is what Git
tracks as contents: where the link points at.

So we would want our "git diff" to tell us, even if you moved without
content modification the symbolic link target that lives somewhere on your
filesystem but is outside the control of Git, and updated a symbolic link
that is tracked by Git to point to a new location, that you updated the
link. On the other hand, if you did not update a tracked symbolic link,
even if the location the link points at that may or may not be under the
control of Git, we do not want "git diff" to show anything. As far as that
link is concerned, nothing has changed.

Changing this would not be a fix; it would be butchering.

Having said that...

> But I lose all the cute features of git-diff.  I *could* say
>
>   git diff --no-index <(ls) <(cd elsewhere && ls)

... "--no-index" is specifically _not_ about tracked contents of Git, but
was bolted on as a poor-man's substitute for GNU diff (think of it as
somebody wanted to have the nifty "git diff" features like renames and
coloring, but did not want to bother to port them to GNU diff codebase,
but instead hacked Git codebase to work outside Git tracked contents).  In
that context, I would agree that it _might_ make sense to treat special
files and symbolic links in a way that is different from how tracked
contents are handled.
