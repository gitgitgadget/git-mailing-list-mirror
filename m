From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff --no-index: allow pathspec after --
Date: Sat, 20 Sep 2014 23:19:19 -0700
Message-ID: <xmqq38blmr6g.fsf@gitster.dls.corp.google.com>
References: <1410256584-19562-1-git-send-email-pclouds@gmail.com>
	<xmqqha04o8k7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 08:19:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVaUm-0002ce-Rb
	for gcvg-git-2@plane.gmane.org; Sun, 21 Sep 2014 08:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbaIUGT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2014 02:19:27 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54445 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751115AbaIUGT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2014 02:19:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DF7F033469;
	Sun, 21 Sep 2014 02:19:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=86UCUdOjZ4GcJrweOoZlO8pmJcU=; b=KZundk
	XZV2d/1Xc6aEr6bs5cyqo9WKd5nysGlJgARAWV9XRq4eI3cZbZ4bD6wAKqHwFRHG
	N5Ho0JkHRYCXlWldPAtZD3HXatJPT1g+yt464O6o4UomoTOvB9BuVzQBx2OF1xu3
	7yu1S18Zj9D42a0J1maMQ2ptw6XuXybgWhojA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PwZ8n6IeCM5eR4ZSyANbEdLhz4WMkGi7
	69Uf4uCE9mmALKivWE4bAsPIwQEgquuFMQeoR6vJWCdeob5ieuQEJGKH0btnWISF
	1RF6G+VsVnHcGrVdzl4lqy5JUckwbwsu620pW31SyMFrghFjKMcsxwEjaZrwgCI0
	4/S4CoV5VRU=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D713F33468;
	Sun, 21 Sep 2014 02:19:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5B18333466;
	Sun, 21 Sep 2014 02:19:20 -0400 (EDT)
In-Reply-To: <xmqqha04o8k7.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 18 Sep 2014 15:41:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 39183DF2-4157-11E4-9106-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257341>

Junio C Hamano <gitster@pobox.com> writes:

> Coming back to the command line syntax for the new feature, if I had
> to choose, I would say
>
> 	git diff --no-index [-<options>] [--] <path> <path> <pathspec>
>
> perhaps?  As we never compare anything other than two things,...

Actually, I am not so sure about this anymore.

It is not entirely fair to say that

	git diff --no-index [--options] A B C D

as comparing A and B while using C and D as pathspec and declare a
person who expects otherwise a moron.  To a person whose brain is
not rotten by years of use of Git, "we never compare anything other
than two things with --no-index" is not a given, I am afraid.

It is equally plausible that the same command line may be asking to
compare A with B and C with D, i.e. producing

	diff --no-git a/A b/B
        ...
        diff --no-git a/C b/D
        ...

It also equally plausible (taking a cue from "mv A B C Dir/") that
it is comparing A, B and C with D/A, D/B and D/C, respectively,
producing

	diff --no-git a/A b/D/A
        ...
        diff --no-git a/B b/D/B
        ...
        diff --no-git a/C b/D/C
        ...

The only unambiguous syntax I can think of that avoids such
alternative interpretations is something ugly like

    git diff --no-index [-<options>] --src=<path> --dst=<path> [--] <pathspec>

where "src" and "dst" are in line with the existing src/dst-prefix
options.

Perhaps we could declare that this is the "canonical" way to spell
pathspec-filtered no-index comparison of two directories, but we
allow the syntax suggested in the message I am responding to as a
short-hand, but I am not sure if that would fly well.

This --src/--dst thing could lead to even uglier tangent.  We could
use these options to specify what is compared with what else

    --{src,dst}-path=<directory in the working tree>
    --{src,dst}-index
    --{src,dst}-worktree
    --{src,dst}-tree=<tree object>

which allows us to express funky combinations like

	git diff --src-index --dst-worktree [--] <pathspec>
	git diff --src-tree=HEAD --dst-index [--] <pathspec>
	git diff --src-tree=maint --dst-tree=master [--] <pathspec>

The above three would be ugly ways to spell the traditional "short
hands", e.g.

	git diff [--] <pathspec>
        git diff --cached [--] <pathspec>
        git diff maint master [--] <pathspec>

respectively.  And an obvious fallout of the above is this command
line:

	git diff --src-path=A --dst-path=B [--] <pathspec>

Because this does not involve any index, tree or worktree, it cannot
be a Git operation, so we know that is --no-index mode; the command
line does not need to say --no-index anywhere if we go that route.
