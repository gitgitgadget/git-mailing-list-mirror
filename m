From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] add: refuse to add paths beyond repository
 boundaries
Date: Tue, 09 Apr 2013 10:09:56 -0700
Message-ID: <7v4nfftyu3.fsf@alter.siamese.dyndns.org>
References: <CALkWK0m_82ThYKxcr=YHGBnOaHr9yBpYFHxx2KrnQkWD_zjp1A@mail.gmail.com>
 <1365499297-8667-1-git-send-email-artagnon@gmail.com>
 <1365499297-8667-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 19:10:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPc3i-0004k2-FS
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 19:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935041Ab3DIRKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 13:10:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59850 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758507Ab3DIRJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 13:09:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1145715FC3;
	Tue,  9 Apr 2013 17:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XBaHOXxPuOEcXytuKEotl5kM86k=; b=FHhoiJ
	4CY9AXx/rq3xniOZbGeHiOEV8qpT9K4XEy2yfeDBYRrelpW9ckP7+MPNjhN0gdaO
	NEyh7HBRVvNSja2mr8fSOyEGZCxfjrcA+K6KMc7ldcsG8Ext/mr7kjsdV7KW6pLZ
	/MyIOR5lZrkwBcaYcZDlCutuxwoPX4YurU/ug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M1e8XFcUzkv1FhFB6oxnih1+tay3CsM8
	2RX2cNF0o+Kv8YSrxZTkvdGrcpf4PU4aYYqotspShN6SxSWbGbvg62MCiowBj2+I
	fNePH9lxXbxoZ9l2EtLgSxCQF0HnEN0Cvw0FQalLwir+bkKKTZLl4+8uDcwkF4Ma
	npLi6Mtz/QM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0764615FC2;
	Tue,  9 Apr 2013 17:09:59 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E08315FBE; Tue,  9 Apr
 2013 17:09:57 +0000 (UTC)
In-Reply-To: <1365499297-8667-3-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Tue, 9 Apr 2013 14:51:37 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4E6EC7A4-A138-11E2-8BFF-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220588>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Currently, git add has the logic for refusing to add gitlinks using
> treat_path(), which in turn calls check_path_for_gitlink().  However,
> this only checks for an in-index submodule (or gitlink cache_entry).
> A path inside a git repository in the worktree still adds fine, and
> this is a bug.  The logic for denying it is very similar to denying
> adding paths beyond symbolic links: die_if_path_beyond_symlink().
> Follow its example and write a die_if_path_beyond_gitrepo() to fix
> this bug.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---

> @@ -166,6 +166,7 @@ static const char **validate_pathspec(const char **argv, const char *prefix)
>  		const char **p;
>  		for (p = pathspec; *p; p++) {
>  			die_if_path_beyond_symlink(*p, prefix);
> +			die_if_path_beyond_gitrepo(*p, prefix);
>  		}
>  	}
> diff --git a/cache.h b/cache.h
> index e1e8ce8..987d7f3 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -962,6 +962,8 @@ struct cache_def {
>  
>  extern int has_symlink_leading_path(const char *name, int len);
> +extern int has_gitrepo_leading_path(const char *name, int len);

I looked at the output from "grep has_symlink_leading_path" and also
for "die_if_path_beyond"; all of these places are checking "I have
this multi-level path; I want to know if the path does not (should
not) be part of the current project", I think.  Certainly the one in
the "update-index" is about the same operation as "git add" you are
patching.

Isn't it a better approach to _rename_ the existing function not to
single out "symlink"-ness of the path first ?  A symlink in the
middle of such a multi-level path that leads to a place outside the
project is _not_ the only way to step out of our project boundary.  A
directory in the middle of a multi-level path that is the top-level
of the working tree of a foreign project is another way to step out
of our project boundary.  Perhaps

	die_if_path_outside_our_project()
        path_outside_our_project()

And then update the implementation of path_outside_our_project(),
which only took "symlink in the middle" into account so far, and
teach it that such a "top-level of the working tree of a foreign
project" is also stepping out of our project?

That way, you do not have to settle on fixing the bug only in "git
add" and keep the bug in "git update-index", I think.

I think the hit in builtin/apply.c deals with the same "beyond
symlink is outside our project" check and can be updated like so.  I
didn't look at the ones in diff-lib.c and dir.c so you may want to
double check on what they use it for.
