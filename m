From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] test: set the realpath of CWD as TRASH_DIRECTORY
Date: Wed, 29 Aug 2012 09:33:07 -0700
Message-ID: <7vy5kxwtdo.fsf@alter.siamese.dyndns.org>
References: <5030F0BF.2090500@alum.mit.edu>
 <f58965733e604a9fe6ed72384d0307062403b478.1346043214.git.worldhello.net@gmail.com> <7vk3wktiph.fsf@alter.siamese.dyndns.org> <503D973D.8040402@alum.mit.edu> <7vmx1exmde.fsf@alter.siamese.dyndns.org> <503DCFAE.6060307@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Lea Wiemann <lewiemann@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Aug 29 18:33:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6lCg-0000cq-3g
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 18:33:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439Ab2H2QdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 12:33:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46632 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753438Ab2H2QdK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 12:33:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C56D69B04;
	Wed, 29 Aug 2012 12:33:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dpuGRb+ecOrLN8/btx/F9xCne+U=; b=ZUY9Es
	joKE9BhR9nEGxAoekkAciWWG+zQO6+es5xMBF+3j8nyXXkBXdMZ4Qe0ObfAEj0jc
	6TnegDzdKLtJzy0rI3VMRAcCV11H92BrfbShRLW03OqbKNiRMcWMmqDmI6h3uASf
	/bQ8TuWxI0wIfErwcuBtNYA1pE+zoR4oPVILw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LjGR43/0s/PrYBmBR4A68HkWVW3KnTx2
	KF51xQEoaM9oBN56uqoIArqUMULwiFO2jZnRHK5WPf0rC3S7CbOKO4Q2j32oy9Cz
	3c64HDWU0RFCEFBWlReuDZk3f4wApPZfQ7xTF5Zzjp3QDo2z5Yzpwv23yyLRv5OG
	a5OPW30Y1Go=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B138E9B03;
	Wed, 29 Aug 2012 12:33:09 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 171409B02; Wed, 29 Aug 2012
 12:33:08 -0400 (EDT)
In-Reply-To: <503DCFAE.6060307@alum.mit.edu> (Michael Haggerty's message of
 "Wed, 29 Aug 2012 10:15:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 37AB7D1E-F1F7-11E1-8047-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204484>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 08/29/2012 08:06 AM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
> It is in fact the whole approach that I object to.
> ...
>> What exactly is broken in CEILING?
>
> CEILING is used in setup_git_directory_gently_1() when trying to find
> the GIT_DIR appropriate for the current directory.  The entries in
> CEILING are compared textually to getcwd(), looking for the entry that
> is the longest proper prefix of PWD.  This is then used to limit a loop
> that is vaguely
>
>     while (!is_git_directory())
>             chdir("..");
>
> The problem, as I understand it, is that when the tests are run with
> root set to a path that includes a symlink, then test and
> TRASH_DIRECTORY are set to the textual value of "$root/trash
> directory.tXXXX", but then a little bit later test-lib.sh chdirs into
> the trash directory using "cd -P $test" (thereby resolving symlinks).
> So, taking my concrete example "--root=/dev/shm" where /dev/shm is a
> symlink to /run/shm, we have
>
>     test="/dev/shm/trash directory.tXXXX"
>     TRASH_DIRECTORY="$test"
>     ...
>     cd -P "$test"
>
> which results in PWD being "/run/shm/trash directory.tXXXX".

The components of CEILING should be adjusted to strip the symlink so
that it begins with "/run/shm/" before it is used; otherwise it
would not work.  As the current code does not do that at runtime (I
am describing the situation, not justifying), it won't match if
CEILING is built out of $TRASH_DIRECTORY.  In the above, setting of
$test and $TRASH is wrong; it does not match the realpath.

So "I somehow thought that Jiang's patch was to make sure any
variables that contain pathnames (and make sure future paths we
might grab out of $(pwd)) are realpath without symlinks early in the
test set-up," in my previous message was not correct.  The patch is
not doing that, and that is what breaks your setup.

My preference is to set things up in such a way that most of the
tests do not have to worry about these symlink aliases.  I know you
said you do not like the "whole approach", but I'd like to see our
tests run in a stable and reproducible testing environment.

We should have specific tests (on symlink enabled platforms) that
creates a directory and an alias to it via a symlink, goes into it
and checks the CEILING (and whatever else) behaviour.  We know that
the current code does not account for the alias introduced by
symlinks, and setup_git_directory_gently() may want to be patched to
fix _that_ specific test.
