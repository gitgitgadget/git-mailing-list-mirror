From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: pruning recipe for destructive
 filter-branch
Date: Fri, 13 Feb 2009 17:07:30 -0800
Message-ID: <7vr6214yi5.fsf@gitster.siamese.dyndns.org>
References: <1234545279-23153-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Feb 14 02:09:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY91n-00061x-6B
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 02:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762471AbZBNBHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 20:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762728AbZBNBHj
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 20:07:39 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57686 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762729AbZBNBHi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 20:07:38 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8990B999EF;
	Fri, 13 Feb 2009 20:07:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1C648999EE; Fri,
 13 Feb 2009 20:07:31 -0500 (EST)
In-Reply-To: <1234545279-23153-1-git-send-email-trast@student.ethz.ch>
 (Thomas Rast's message of "Fri, 13 Feb 2009 18:14:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DDF9E440-FA33-11DD-981B-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109795>

Thomas Rast <trast@student.ethz.ch> writes:

> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
> index 1fbbbb4..737c555 100644
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -339,6 +339,42 @@ git filter-branch --index-filter \
>  ---------------------------------------------------------------
>  
>  
> +
> +Checklist for Shrinking a Repository
> +------------------------------------
> +
> +git-filter-branch is often used to get rid of a subset of files,
> +usually with some combination of `\--index-filter` and
> +`\--subdirectory-filter`.  If you want to physically shrink the
> +repository afterwards, you have some choices:
> +
> +* Clone it with `git clone file:///path/to/repo`.  The clone will not
> +  have the removed objects.  See linkgit:git-clone[1].  (Note that
> +  cloning with a plain path just hardlinks everything!)
> +
> +If you really don't want to clone it, for whatever reasons, check the
> +following points (in this order).  This is a very destructive
> +approach, so *make a backup* or go back to cloning it.  You have been
> +warned.

Sounds sane so far and even somewhat amusing.

> +* Make sure you really removed all variants of a filename, if a blob
> +  was moved over its lifetime.  `git log \--follow \--all \-- foo` can
> +  help you find renames.
> +
> +* Make sure you really filtered all refs: use `\--tag-name-filter cat
> +  \-- \--all` when calling git-filter-branch.

Don't these two apply equally to "git clone" approach?  Only the remaining
four are specific to in-place pruning, if I am reading this correctly.

> +* Make sure you remove the original refs backed up by
> +  git-filter-branch: say `git for-each-ref \--format="%(refname)"
> +  refs/original/ | xargs -n 1 git update-ref -d`.
> +
> +* Expire all reflogs with `git reflog expire \--expire=now \--all`.
> +
> +* Repack to remove packed objects with `git repack -ad`.
> +
> +* Prune unpacked unreferenced objects with `git prune \--expire=now`.
> +
> +
>  Author
>  ------
>  Written by Petr "Pasky" Baudis <pasky@suse.cz>,
> -- 
> 1.6.2.rc0.274.g97213
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
