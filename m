From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git commit --amend safety check?
Date: Tue, 10 Mar 2015 22:11:43 -0700
Message-ID: <xmqq8uf46ru8.fsf@gitster.dls.corp.google.com>
References: <CAJo=hJuwdOzNZSVBRAPDz97Gdoi6JWvYxE0ufY+Hd9K8jjCqfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 11 06:12:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVYw1-0006Zr-Dj
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 06:11:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbbCKFLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 01:11:46 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61000 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750770AbbCKFLq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 01:11:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0EFBF37B99;
	Wed, 11 Mar 2015 01:11:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RrU8zXLjQlgZWMAVAlvW02pUDuM=; b=u55gZr
	iTZW+jdSd+1vBOa7opo3lga/T4l//kNdjAgLMu9qpW5Y3eMRjpmwlz1tTFwOBZtr
	nL5E5wh/NkR9s4VScFssjI+6X+g3mQiMsaPuozCjNf4QwJUdbxfolg+sPkKUq0Ps
	aOnZegtYU8dEvEyA0H9vWmyq5B+B/OiuSXWUM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VqAFqHLw1KiL6QYMOC3w8rf0vSkmiAlt
	Tu5tRi2jbZkQ2OhJFIeRexcFBdTIK7JfQGkOsy6yPRJdv1Dnn+543ly90wzrHV77
	SS7Jr3qW1ASN2IwQX4Rz0dj0xG/gbKeJ9jywvljAq/Puieg340W378GTHuO7APF5
	Qprvlkf0eSw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 079BB37B97;
	Wed, 11 Mar 2015 01:11:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 820C937B96;
	Wed, 11 Mar 2015 01:11:44 -0400 (EDT)
In-Reply-To: <CAJo=hJuwdOzNZSVBRAPDz97Gdoi6JWvYxE0ufY+Hd9K8jjCqfA@mail.gmail.com>
	(Shawn Pearce's message of "Tue, 10 Mar 2015 21:31:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1C446156-C7AD-11E4-A7DA-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265300>

Shawn Pearce <spearce@spearce.org> writes:

> We keep seeing reports of Gerrit Code Review users who incorrectly do
> something like:
>
>   git clone URL foo
>   cd foo
>   git commit --amend -m "My first change!" -a
>   git push URL HEAD:refs/for/master
>
> Step #3 is where they get into trouble. They just amended the
> published tip commit and pushed it back to the server. That is... lets
> just say not good.
>
> Hg is known to be more user friendly. One way its user friendly is it
> by default refuses to let you amend a change set that the client has
> reasonable assertion to believe was already published through a remote
> repository.

Well, it is not Git that is less user friendly, but Gerrit is the
problem.  More specifically, the last line:

>   git push URL HEAD:refs/for/master

is what catches this non-fast-forward in usual workflow with Git.
Wouldn't the real problem that the refs/for/master magic accepts
anything, even a non-fast-forward?

Having said that, disabling --amend and forcing to use --force or
something when it is clear that the user is attempting something
unusual is a good idea.  But I am not sure what the definition of
unusual should be.  In a non-Gerrit central repository workflow, the
rule might be "HEAD must not be reachable from @{upstream}"
(otherwise you are rewriting what you got from elsewhere), or it may
be "HEAD must not be reachable from @{publish}'s remote tracking
branch", or perhaps both, as these two could be different in
triangular workflow.

But I am not sure what the sensible rules are when the user prepares
the commit, planning to push it to a ref like refs/for/master that
does not have a counterpart on our side.
