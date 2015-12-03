From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision.c: fix possible null pointer access
Date: Thu, 03 Dec 2015 12:06:52 -0800
Message-ID: <xmqqlh9bthyb.fsf@gitster.mtv.corp.google.com>
References: <1449171136-31566-1-git-send-email-stefan.naewe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Naewe <stefan.naewe@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 21:07:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4a9c-0001rv-Mx
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 21:07:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbbLCUG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2015 15:06:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58942 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753428AbbLCUGz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2015 15:06:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 999AD2F020;
	Thu,  3 Dec 2015 15:06:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oSul8n/jlkgec/2S9QdJ3JX6JLg=; b=IH9foZ
	pbUtZx03NxS4TXn8yrwBaI+yPfHCRpAEj+M6Fcyduq0PsfCbhNNuSPmrNcWUgmW6
	cspWa5rogKTe+ZyF4e5mYIIarubRcjBC9LosQhXKd4F0n76A1obxHgQRK+fo9Z/7
	MDkbczeWSnQr0P2FRfCjoSR69dMRK5Mo0HWgM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xo6bNDwDTSowTI+1D9QHObzFvaf6ab/d
	DoW2/EKihUTm9NwyoB58HLSCIdyMlN8Hl3TzDKDsJAyAdQabb1P5pc5HqRDUHyXK
	Y4Jnz0Cap78a/5W8jpn5EzLfDr9I8QmivyChsxloNPy2iwKX7cjO+M6M9dVKWCgO
	FKQF4SW/N38=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 925982F01F;
	Thu,  3 Dec 2015 15:06:54 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1BE722F01E;
	Thu,  3 Dec 2015 15:06:54 -0500 (EST)
In-Reply-To: <1449171136-31566-1-git-send-email-stefan.naewe@gmail.com>
	(Stefan Naewe's message of "Thu, 3 Dec 2015 20:32:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 65F6CCDE-99F9-11E5-BD1E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281966>

Stefan Naewe <stefan.naewe@gmail.com> writes:

> Two functions dereference a tree pointer before checking

Reading them a bit carefully, a reader would notice that they
actually do not dereference the pointer at all.  It just computes
another pointer and that is done by adding the offset of object
member in the tree struct.

> if the pointer is valid. Fix that by doing the check first.
>
> Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>
> ---
> This has been reported through the CppHints newsletter (http://cpphints.com/hints/40)
> but doesn't seem to have made its way to the ones who care (the git list
> that is...)

Nobody would be surprised, unless the newsletter was sent to this
list, which I do not think it was (but if it was sent while I was
away, then it is very possible that I didn't see it).

>  revision.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index 0fbb684..bb40179 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -104,7 +104,12 @@ static void mark_tree_contents_uninteresting(struct tree *tree)
>  {
>  	struct tree_desc desc;
>  	struct name_entry entry;
> -	struct object *obj = &tree->object;
> +	struct object *obj;
> +
> +	if (!tree)
> +		return;
> +
> +	obj = &tree->object;

This is questionable; if you check all the callers of this function
(there are two of them, I think), you would notice that they both
know that tree cannot be NULL here.

>  
>  	if (!has_sha1_file(obj->sha1))
>  		return;
> @@ -135,10 +140,13 @@ static void mark_tree_contents_uninteresting(struct tree *tree)
>  
>  void mark_tree_uninteresting(struct tree *tree)
>  {
> -	struct object *obj = &tree->object;
> +	struct object *obj;
>  
>  	if (!tree)
>  		return;
> +
> +	obj = &tree->object;
> +
>  	if (obj->flags & UNINTERESTING)
>  		return;

This one is not wrong per-se, but an unnecessary change, because no
deferencing is involved.  At least, please lose the blank line after
the new assignment.

>  	obj->flags |= UNINTERESTING;

Thanks.
