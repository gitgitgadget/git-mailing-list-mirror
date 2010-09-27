From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-stash: fix flag parsing
Date: Sun, 26 Sep 2010 21:36:14 -0700
Message-ID: <7vzkv3hkg1.fsf@alter.siamese.dyndns.org>
References: <953B8952-8928-43B3-A05D-6AEDC5D4B565@gernhardtsoftware.com>
 <1285366534-10490-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, jon.seymour@gmail.com,
	robbat2@gentoo.org, Brandon Casey <drafnel@gmail.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 06:36:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P05S5-0008A7-Ao
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 06:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474Ab0I0Eg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 00:36:28 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35761 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269Ab0I0Eg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 00:36:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D620D90C2;
	Mon, 27 Sep 2010 00:36:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BDQtZDkQMg6K/9dcjJEsFS29BhA=; b=edSDT+
	ofF3Zq2DmTRXWDvxfi9SAmatzlG3zX0TYJIqG0blv31V3DPHfb5KFmfggJKSYtOW
	eG1FMWTr2LPAAkLfM6zr8uD1+U9x4+soKzuIxvkUIx2mz7jZeLNrs5CpVMZneVlz
	M0Yd446uA8MAsed1RFFxCYfOlpogeRaskO3wI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bY3w1DBxWzxI3RwMeRii0qq1mOtyfL1m
	tW1mV4JXEvdB51kCnqca2wXDGKE110OQDz3mp8eeVeHKndKworQZaT4CQ9begE+h
	PPJxN2dwgwQOvzc+l7upwjU+KzGrtsB5N/Qw01gji0FbegOg9cuAgNvhu3btbug6
	81Bd07A9JT8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 06963D90C1;
	Mon, 27 Sep 2010 00:36:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E4F8DD90C0; Mon, 27 Sep
 2010 00:36:15 -0400 (EDT)
In-Reply-To: <1285366534-10490-1-git-send-email-brian@gernhardtsoftware.com>
 (Brian Gernhardt's message of "Fri\, 24 Sep 2010 18\:15\:34 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C773BFD2-C9F0-11DF-B212-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157295>

Brian Gernhardt <brian@gernhardtsoftware.com> writes:

> Currently git-stash uses `git rev-parse --no-revs -- "$@"` to set its
> FLAGS variable.  This is the same as `FLAGS="-- $@"`.  It should use
> `git rev-parse --no-revs --flags "$@"`, but that eats any "-q" or
> "--quiet" argument.  So move the check for quiet before rev-parse.
>
> Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
> ---
>
>  Not the most elegant solution, but it works.

Thanks.

rev-parse as a flag parser was useful hack when most of the log family was
"rev-list | diff-tree" with various options, but the recent push to make
flags consistent across commands inevitably has made it fundamentally
impossible for the function to function sensibly in all cases, as it
itself has to share some options, like "-q", with others.

After the push of rewriting everything as C builtin, combined with the
improvement of parse-options, I have to say that rev-parse flag parser
hack has outlived its usefulness.  The former means there is less reason
to script end-user commands as a "rev-list | diff-tree" pipeline (I am not
talking about special purpose statistics commands that use rev-list here),
and the latter means that it has become easier for a Porcelain script to
parse _its_ command line options and come up with a set of sensible
options to underlying rev-list and the command at the downstream of the
pipe, without following the original hacky pattern of "we let random
options and args and without interpreting them we guess which ones to
throw at rev-list and which ones to throw at diff-tree".
