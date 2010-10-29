From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Inconsistent behavior of the path disambiguator
Date: Fri, 29 Oct 2010 11:38:21 -0700
Message-ID: <7vbp6c7ski.fsf@alter.siamese.dyndns.org>
References: <AANLkTinM863uZfRxy_1BW1fnfEPsPo8A2m86=Wxh7XGd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 20:38:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBtqU-0003pR-Ms
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 20:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759050Ab0J2Sia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 14:38:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41873 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758459Ab0J2Si3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 14:38:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6905E2B30;
	Fri, 29 Oct 2010 14:38:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BuOi5/DJChJ0nGqhjd9SOGwz9mk=; b=NlURCw
	kVSwVv7PaoD1qJe1/fKFZUFuPsAZ6GubLaY26C4bJGelfPKyfvOtPQ3DgFACvEv4
	mbDk3Ts4QO5B03bHXUSLL3udvRKqSMgAZb1HDg/0Ylt+kKoCuN/Xg1ZjGNQ02O75
	1GPBP7TYHleLXYFxssT8gjbqGOc0VdSMhQUw8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b5DlJLDURxFwAwfYtv9zEjnJWN+cinm7
	fHMRTAR8htt+yQOJUKJjchp2Oy0DJRCGFn1vuz6ee0M7nMibDETArM6t7hBq25WW
	iUqwCZaOlOvh7KZsVyzGHfBhjarSAs9araXdR040ay6GkPy0FYwUQA88gUEZK1Ak
	YMEQ6LwEk8k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D22E2B29;
	Fri, 29 Oct 2010 14:38:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A0EF2B22; Fri, 29 Oct
 2010 14:38:23 -0400 (EDT)
In-Reply-To: <AANLkTinM863uZfRxy_1BW1fnfEPsPo8A2m86=Wxh7XGd@mail.gmail.com>
 (Dun Peal's message of "Fri\, 29 Oct 2010 19\:11\:03 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B77311D2-E38B-11DF-9A45-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160354>

Dun Peal <dunpealer@gmail.com> writes:

> When I clone a remote that has a branch `foo`, then `git checkout foo
> --`, the path disamgiuator makes the operation fail. `git checkout
> foo` without the disambiguator works. Following that, when branch
> `foo` already exists, `git checkout foo --` works even with the
> disambiguator that caused it to fail previously.

I do not think there is any bug.  You were being bitten by folks who tried
to be helpful for newbies by introducing a(n arguably confusing) special
case; I can see why this is confusing, though.

> $ git checkout foo --
> fatal: invalid reference: foo

Immediately after a clone you would have

    refs/heads/master
    refs/HEAD -> refs/heads/master
    refs/remotes/origin/foo
    refs/remotes/origin/whatever-else-you-have
    ...

and there is no commit that you can name with "foo" when asking git to
check out some paths out of, nor there is no branch that you can name with
"foo" when asking git to check out to work on it.

You can say 'origin/foo', though, in general.

> $ git checkout foo
> Branch foo set up to track remote branch foo from origin.

Asking to check out a branch "foo" in order to work on extending the
history of that branch, when there is _no_ "foo", has a special magic
invented by some folks to "help usability", if there is only one $remote
that has "foo" in it.  In this case, you have refs/remotes/origin/foo but
no other refs/remotes/$frotz/foo, and this special magic kicks in.

git behaves as if you meant "git checkout -t -b foo origin/foo" but were
too lazy to type that yourself in this case.

> Switched to a new branch 'foo'
> $ git checkout master
> Switched to branch 'master'
> $ git checkout foo --
> Switched to branch 'foo'

This is referring to local branch "foo", there is nothing magic.
