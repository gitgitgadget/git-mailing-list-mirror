From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Git add <device file> silently fails
Date: Sun, 18 Apr 2010 22:15:31 -0700
Message-ID: <7vbpdgt43w.fsf@alter.siamese.dyndns.org>
References: <201004171624.17797.agruen@suse.de>
 <u2s81b0412b1004170744u4cc3c0e1z6d7019fe405a67ec@mail.gmail.com>
 <7v4oja3uh7.fsf@alter.siamese.dyndns.org> <201004171957.00944.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Mon Apr 19 07:16:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3jKx-00072D-0t
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 07:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484Ab0DSFPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 01:15:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39833 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919Ab0DSFPl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 01:15:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C83F8AAD67;
	Mon, 19 Apr 2010 01:15:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3PhDfxJtI/VrPqecap0C+qRklf4=; b=DFzvip
	qXfMc1zW1KLp05fLhVxQkUdYGrKmguQnd18hot3TkyWh0I55gwG/IULFNksnUueB
	LCLfQbFv9aN4ich7XZ3ZlpOIBCNopGOMJFeKPx4f1TiP2sZ6h14R/6eVf0wy5J+P
	CSVBsSA4Idc0aNyO8F5Q5881b2XHl1L+S5MHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=datsHhkG7Xp7e/Q5/IM/bdvMya3HbZdK
	FeDUGOxTwjEhelXkY3Uv8HnvBQazaG9nfeNdMS2rePs3ZnFN70oHwnZtDkA0qUJm
	I1RNF4T6OPY1SrTf745txCqNHRpYRXCRkn6BjbEeWwh5KnVtEustAcEEWiAA0jPo
	fWEEKEvex4Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 96544AAD65;
	Mon, 19 Apr 2010 01:15:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB998AAD5C; Mon, 19 Apr
 2010 01:15:32 -0400 (EDT)
In-Reply-To: <201004171957.00944.agruen@suse.de> (Andreas Gruenbacher's
 message of "Sat\, 17 Apr 2010 19\:57\:00 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9663A116-4B72-11DF-A967-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145263>

Andreas Gruenbacher <agruen@suse.de> writes:

> @@ -720,7 +723,8 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
>  
>  	switch (dtype) {
>  	default:
> -		return path_ignored;
> +		dir_add_ignored(dir, path, *len, DIR_IGNORED_FILETYPE);
> +		break;

Hmm, do we want to break and return path_handled here, to cause
the calling read_directory_recursive() to call dir_add_name()?

Also I suspect that (dir->flags & DIR_COLLECT_IGNORED) needs to be checked
before making this call.

> +struct dir_vector {
> +	int nr, alloc;
> +	struct dir_entry **entries;
> +};

We would probably call a structure of this shape "dir_array", as I haven't
seen us calling anything "vector" for naming consistency.

Instead of introducing two dir-arrays for different kinds of ignoredness,
it may be cleaner to add one bit (or more for later expansion) to dir_entry
and mark the ones in ignored dir-array with the ignore reason.
