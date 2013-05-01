From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] git-svn: fix bottleneck in stash_placeholder_list()
Date: Wed, 01 May 2013 10:09:59 -0700
Message-ID: <7vhaim8w48.fsf@alter.siamese.dyndns.org>
References: <1438528085.20130501090926@gmail.com>
	<1409591910.20130501123153@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>,
	Ray Chen <rchen@cs.umd.edu>, Eric Wong <normalperson@yhbt.net>
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 19:10:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXaXo-0002bU-T4
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 19:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754354Ab3EARKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 13:10:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53426 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753844Ab3EARKD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 13:10:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E99DA1B964;
	Wed,  1 May 2013 17:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YCqMCV3raU17MYEhbbFLMa1eKA4=; b=GNiVa4
	kcaweV9zDcLAmlu8I0B2e9stC89FwPSesSWV+61QfrYaGHhRoyNTEfSD4FdBoqM8
	s+8QMJOG9AqD2x3q2eclEj7j4dNGq1EIJ79zwHlVKTKuhiIzqGZE7RCvzusB1O65
	dqCBGFkjCECp9chdN0tsa1w/Ll3jH4JWe0tOU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J1RVomeMaPZtdMfiolg0PSqmGb6C2Ubm
	4ilNzKTnvQADFWhXmcbL2wW1mHZbYflemI8Xa4F26HiLuk7BUfSzi1x6iBUROAy4
	DA2X+1aU/vTrZwzjhQSDGW0MeiO+DJfUlRYYA2YuvMP6nF7sz8IPu9PlOHrXu9I3
	Ww6cURG8tTU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0CC01B963;
	Wed,  1 May 2013 17:10:01 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B5881B95F;
	Wed,  1 May 2013 17:10:01 +0000 (UTC)
In-Reply-To: <1409591910.20130501123153@gmail.com> (Ilya Basin's message of
	"Wed, 1 May 2013 12:31:53 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F5753736-B281-11E2-A3D9-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223101>

Ilya Basin <basinilya@gmail.com> writes:

> IB> In my repo the placeholders change too often (in 1/4 commits). I'm
> IB> thinking of using:
> IB> 'git config --unset "svn-remote.$repo_id.added-placeholder" path_regex'
> IB> instead of full rewrite.
>
> I need your help. There are still problems:
>
>     $ grep "define MAX_MATCHES" ~/builds/git/git-git/config.c
>     #define MAX_MATCHES 8192
>
>     $ grep added-placeholder .git/config | wc -l
>     4430
>
> 1/4 commits change the list of placeholders, usually 1 folder changes.
> Clearing and re-adding the entries to the config takes ~1 minute.

While I agree both "git config"'s external interface and internal
implementation are not suited for bulk update, I have a suspicion
that the config mechanism is not the right place to store this
information in the first place.  The config is a per-Git-repository
state that is not versioned, which means it is applicable regardless
of individual commits or trees (also it means it is designed not to
be shared across repositories).  But "You may see a file here that
otherwise should not be there only to mark that there should be an
empty directory" is an attribute to a particular tree, isn't it?

If you have a branch that git-svn adds a placeholder file (hence you
want to annotate that tree with "This directory is there only to
hold the placeholder file") and you want to perform a merge on the
Git side of that branch with another Git branch that does have real
contents in that directory, you would want the result to say "This
directory no longer is just for a placeholder", but you cannot say
that globally by updating the config file, as the config mechanism
is also applied to the original branch that came from git-svn, in
which the directory in question is still only to hold the placeholder
file.

A Subversion-only history does not have a reason to have .gitignore
file tracked in it; wouldn't a cleaner implementation to consider a
directory that has .gitignore and nothing else marked with "added
placeholder", without (ab)using the config mechanism?  If you are
worried about a corner case where the Subversion side adds the file,
even though it is not used there, probably you can add a single
comment line "# added by git-svn only to keep the directory" and
consider a directory that has nothing but .gitignore that consists
of only that exact comment line an "added placeholder" directory to
work it around.  Either approach would tie the information to the
tree state, which sounds like a much more correct approach to the
"keep empty directory" problem to me.
