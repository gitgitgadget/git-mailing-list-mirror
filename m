From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Git add <device file> silently fails
Date: Sat, 17 Apr 2010 09:38:12 -0700
Message-ID: <7v4oja3uh7.fsf@alter.siamese.dyndns.org>
References: <201004171624.17797.agruen@suse.de>
 <u2s81b0412b1004170744u4cc3c0e1z6d7019fe405a67ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 18:38:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3B2J-0004kZ-8N
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 18:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403Ab0DQQiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 12:38:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48215 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310Ab0DQQiV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 12:38:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E9887AAC58;
	Sat, 17 Apr 2010 12:38:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+/MSBsariKh+0mPOvemJ2shIUR8=; b=PVYB7+
	4fNFK7fA7RDKItMs63yCPRzCpcITneC6aLBmWiFpvBSER6piQh8VgPQjF9zd60dN
	Q2qibAkKiiiatPRXjeHRaqPhctr8qChI1ENeB33vFIYogOdCvpw96zvFhExsRyaY
	3kwCwrZGGFnn/iMsASNjtyBNyWhN5ytUTdiF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mUJ5F+xliZtsovWqvc5dMopeA+NHnsMI
	TJkIfY8OOMXquumVtZhr9DDHylbYLmE48FYsO5UhumExOlAchX9P/Ld2YkNeAvij
	SMtEPQET6zqBXnVXmrbCSCZMDaSmZfuOjbYSW0RQFgyGiAwzzvXTIrWIerBQrPpE
	EZlxDM9Z2Jc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B5E2EAAC4F;
	Sat, 17 Apr 2010 12:38:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 13A51AAC4A; Sat, 17 Apr
 2010 12:38:13 -0400 (EDT)
In-Reply-To: <u2s81b0412b1004170744u4cc3c0e1z6d7019fe405a67ec@mail.gmail.com>
 (Alex Riesen's message of "Sat\, 17 Apr 2010 16\:44\:05 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A04C75CE-4A3F-11DF-A14E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145154>

Alex Riesen <raa.lkml@gmail.com> writes:

> I think something like this should make the accident more
> noticable:

The early skippage done in dir.c (read-directory-recursive) should treat
these as ignored just like paths that are ignored with .gitignore
mechanism, and if we do so, we shouldn't need this patch to add another
codepath to give notification to the user (we would however still need
to reword "'add -f' if you really want to add it", though).

> diff --git a/builtin/add.c b/builtin/add.c
> index 87d2980..9c4a5f2 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -347,6 +347,8 @@ static int add_files(struct dir_struct *dir, int flags)
>  		die("no files added");
>  	}
>
> +	if (!dir->nr)
> +		die("No files selected for addition");
>  	for (i = 0; i < dir->nr; i++)
>  		if (add_file_to_cache(dir->entries[i]->name, flags)) {
>  			if (!ignore_add_errors)
