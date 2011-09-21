From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to use git attributes to configure server-side checks?
Date: Wed, 21 Sep 2011 13:17:05 -0700
Message-ID: <7vy5xh1whq.fsf@alter.siamese.dyndns.org>
References: <4E7A3BDE.3040301@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Sep 21 22:17:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6TEM-0004PE-81
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 22:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084Ab1IUURN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 16:17:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51438 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752258Ab1IUURL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 16:17:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EAC4647A;
	Wed, 21 Sep 2011 16:17:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ur+1Qs+d7hLsrk8j52T6gRfzalc=; b=kR8C+N
	ky20ghjTelkdspnx+aSx590uGEva/1+LGNR4rvIvtkt6NTwpHDI/cjKG2bwYZaBc
	yrNzGEh8liEUqJZ32z7zvLymnbf0ilutOQjUoAfA4w/wMIrOD9M06Dq+XcP6nh5j
	wmJDmUmzxbxOQnBbiGbG5efjEgQ7s3Dg4vZV8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aZOVwHH+IkikY/K7giXKvKmnjFJDBVeL
	H9shy0VtGGsskR9NoeOdMFFEJV7YSoudm878mL8/vSLdXr7Tx+fkVdNqBhS0SHMt
	Yg46fmsC22ZArXZkkUR2WHDBewrxeqwpEK1gUUGOkDyYhWmkCKlYFmXGpIdEQxPX
	x3iaPPfBlcw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3ED0C6479;
	Wed, 21 Sep 2011 16:17:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC13F6478; Wed, 21 Sep 2011
 16:17:06 -0400 (EDT)
In-Reply-To: <4E7A3BDE.3040301@alum.mit.edu> (Michael Haggerty's message of
 "Wed, 21 Sep 2011 21:32:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AD762804-E48E-11E0-B0CD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181860>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I was thinking of using git attributes to configure a server-side
> "update" hook that does some basic sanity checking before accepting a
> push.  I thought I could do something like
>
> ~/.gitattributes:
>     *.c whitespace
>
> ~/crappy-vendor-code/.gitattributes:
>     # This code doesn't conform to our standards; disable check:
>     *.c -whitespace
>
> This would allow fine-grained specification of which checks are applied
> to which files, and ensure that the hook configuration is kept
> synchronized with changes to the content.
>
> What I can't figure out is how a server-side update hook can inquire
> about the gitattributes that were associated with a file *in a
> particular commit*, as opposed to in the current working tree.  I would
> like to ask questions like "was the "whitespace" attribute set on file F
> in commit C?"
>
> I see that there is an (undocumented) API involving
> git_attr_set_direction() that seems to let gitattributes to be read out
> of the index instead of the working tree.  But I am still confused:

The words "server side" automatically mean that there should be no working
tree, and where there is no working tree there should be no index, so the
direction should not make any difference.  The attributes that are used to
help whitespace checks should come from project.git/info/attributes in
such a case [*1*].

As to the actual checking of the pushed contents, your pre-receive hook is
called after all the objects received are placed in the object store, but
before the refs are updated to conclude the push, and you can veto the
push by exiting with non-zero status from the hook. Your hook will get
which ref is being updated from what old commit to what new commit, so you
can either

 (1) grab the new commits introduced to the project using rev-list, and
     invoke "git show --check" on each and every one of them; or

 (2) check only the endpoints, by running "git diff --check" between the
     old and new commits. A pushed series may introduce a breakage early
     in the series which is corrected later in the series and you would
     not catch such a case if you used this method.

[Footnote]

*1* granted, that there are people who make a checkout from their post
update hook, perhaps so that a build robot can be told to work on it or
the web server can deliver individual files. But that is merely a crude
substitute of having a proper "install" procedure. As far as the
"server-side" Git that accepts "git push" is concerned, such a working
tree does not exist.
