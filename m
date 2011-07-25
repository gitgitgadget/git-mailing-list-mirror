From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 39/48] merge-recursive: Fix rename/rename(1to2)
 resolution for virtual merge base
Date: Mon, 25 Jul 2011 13:55:04 -0700
Message-ID: <7vhb6aqdw7.fsf@alter.siamese.dyndns.org>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
 <1307518278-23814-40-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 25 22:55:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlSBF-0006zk-T6
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 22:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647Ab1GYUzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 16:55:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39607 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751453Ab1GYUzH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 16:55:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 97CEB4250;
	Mon, 25 Jul 2011 16:55:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ddzvYJJsFbFndzqMSt5BXJrkYuw=; b=ZLUr9f
	2Gd7xg+ha/pQ//v5lN0VnRQ/lgNb7+omjYy4mhS41Pa4uJHmYzlEVv/iuiDZyGmS
	YZAgroLwEQD99j2hGn6RB+zx7YsdDv1TWkeOYa9caKOrxwye8zrJYT/ysOGGO1lL
	lFnM9KBH6VcEzRgaILA2DV8RdglDJfkBevZdw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C2cLPnfkh29NCbdWAneC8LvbUl9UgQjl
	S5pva+3IWpFeN6Besw2TsezShf7tXeuobEGa3vPnPBIZ7gG+tJvqKXGtbcc8RFfT
	4owhGgTt2MKEox8Ds2tEpVgp8OC4tavI7lcnmsEpkj5YEWAUpQ0uCchVFEO7WyMP
	o78YkIPnA6c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F1F6424F;
	Mon, 25 Jul 2011 16:55:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19C68424E; Mon, 25 Jul 2011
 16:55:06 -0400 (EDT)
In-Reply-To: <1307518278-23814-40-git-send-email-newren@gmail.com> (Elijah
 Newren's message of "Wed, 8 Jun 2011 01:31:09 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6017B886-B700-11E0-8891-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177816>

Elijah Newren <newren@gmail.com> writes:

> When renaming one file to two files, we really should be doing a content
> merge.  Also, in the recursive case, undoing the renames and recording the
> merged file in the index with the source of the rename (while deleting
> both destinations) allows the renames to be re-detected in the
> non-recursive merge and will result in fewer spurious conflicts.

In other words,...

> +		 * FIXME: For rename/add-source conflicts (if we could detect
> +		 * such), this is wrong.  We should instead find a unique
> +		 * pathname and then either rename the add-source file to that
> +		 * unique path, or use that unique path instead of src here.
>  		 */
> +		update_file(o, 0, mfi.sha, mfi.mode, src);
> +		remove_file_from_cache(ren1_dst);
> +		remove_file_from_cache(ren2_dst);

... the use of "src" here is taking a "middle ground" and punting on
resolving the conflicting opinions of both branches for the outer merge to
resolve. I think that is a sensible thing to do.

The rename destinations of both branches are removed. What happens if
ren1_dst (the path one branch wanted to rename src to) were added by the
other branch (which wanted to rename src to ren2_dst), causing rename/add
conflict between branches (i.e. not the one you worry about in the above
FIXME which is about one branch renaming src to ren1_dst while adding an
unrelated content to src)?
