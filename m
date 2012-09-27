From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/8] Fix GIT_CEILING_DIRECTORIES that contain symlinks
Date: Thu, 27 Sep 2012 12:42:16 -0700
Message-ID: <7vy5jvp813.fsf@alter.siamese.dyndns.org>
References: <50406C82.2070005@alum.mit.edu>
 <1348688090-13648-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Sep 27 21:42:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THJyf-0004TX-9x
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 21:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011Ab2I0TmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 15:42:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49510 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751704Ab2I0TmT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 15:42:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C4BC9B8E;
	Thu, 27 Sep 2012 15:42:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PldGN/LfV8DK7BmESkEK7cxfu6U=; b=MWMSJe
	joiPvHF2Kzy11qCx1e8zg7OhuWGm5UVgZL5/TO91XErYcT5+e3598VOA+Q6PlWwj
	4yC9la/pk4MSbct8EOmvhXUtoxot3FXvID+yRJ9KIn0SbGLDF6LJf8ctJrwWCFh1
	StbUETZLHUl8xASXf2FmidIwFYgWrYH2vowVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OE9YNw4O1SM4zZlcaPGKkOmToxA2XJR3
	8DjlZs7/rXmp9Gfud0B6wGL0oCzTzJAGBslIDXmu0wX9Q2Bcy46pom+ayPUJ+xxh
	dS3JQCcLSG+qxWrNPLr3WaUETxLl+h1AzalVHxd6xWZrpHB66Aq8tPV5ym4CnQiq
	s7X9/AAcotg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59E8D9B8D;
	Thu, 27 Sep 2012 15:42:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B013A9B8C; Thu, 27 Sep 2012
 15:42:17 -0400 (EDT)
In-Reply-To: <1348688090-13648-1-git-send-email-mhagger@alum.mit.edu>
 (Michael Haggerty's message of "Wed, 26 Sep 2012 21:34:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 71F5350A-08DB-11E2-B28D-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206512>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This series fixes longest_ancestor_length() so that it works even if
> prefix_list contains entries that involve symlinks.  The basic goal of
> the series is to call real_path() on each of the entries so that a
> textual comparison of the potential prefix to the front of path
> correctly decides whether the path is located inside of the entry.
> But along the way some other things had to be changed:
>
> * real_path() die()s if the path passed to it is invalid, whereas it
>   is allowed for GIT_CEILING_DIRECTORIES to contain invalid paths.  So
>   create a new function real_path_if_valid() that returns NULL for
>   invalid paths.
>
> * Changing longest_ancestor_length() to call real_path_if_valid()
>   would make the former very difficult to test (because the tests
>   would depend on the contents of the whole filesystem).  Therefore,
>   rewrite longest_ancestor_length() in terms of functions
>   string_list_split(), string_list_longest_prefix(), and
>   real_path_if_valid() which are tested individually.
>
> The net results of these changes are that:
>
> 1. t1504 used to have to canonicalize TRASH_DIRECTORY to make itself
>    work even if the --root directory contains symlinks.  This
>    canonicalization is no longer necessary (and has been removed).
>
> 2. t4035, which used to fail if the --root directory contained
>    symlinks, now works correctly in that situation.
>
> After this change, all tests pass if the --root directory does *not*
> contain symlinks, but t9903 still fails if the --root directory
> contains symlinks.  I haven't analyzed the cause of t9903's failure,
> but it does not appear to be related to the GIT_CEILING_DIRECTORIES
> feature.

I haven't read the actual patches yet, but the all of the above
sounds sensible.

> On the mailing list I suggested *purposely* inserting symlinks into
> the "trash directory.*" paths to test symlink handling more
> systematically.  This patch series does *NOT* make that change.

And that may be a sensible follow-up step once the dust settles.

Thanks.
