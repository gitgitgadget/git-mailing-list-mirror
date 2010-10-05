From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/18] notes.h/c: Clarify the handling of notes objects
 that are == null_sha1
Date: Tue, 5 Oct 2010 10:21:20 -0500
Message-ID: <20101005152120.GE12797@burratino>
References: <1285719811-10871-1-git-send-email-johan@herland.net>
 <1285719811-10871-4-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bebarino@gmail.com, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Oct 05 17:24:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P39Nw-0000QR-Q2
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 17:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754286Ab0JEPYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 11:24:41 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:62473 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753603Ab0JEPYk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 11:24:40 -0400
Received: by gwj17 with SMTP id 17so2022222gwj.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 08:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=WcZtPJrAsR1ruVsqhLE70XDE9GD5MQecvEy8SRIk/vM=;
        b=yBTFQMq/a0IPvJ6HwYRTL03/8LVZjd5dxvxI5hzA2G0QEOY4dUmeN4fnCXix0pkW64
         aeOf+VRj0pL0jAQHWYrYa7MQkqD0hlyJChOr7cT22o/jq4u8hp03hvv/sTvD/eOM1e6h
         jBUNfxPqtMafAEkMz9AYIo/Cklev/e1vrz1G8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HHzIbQACHhgUt0QKCBKMvndI2oYdylWUmE5vf2qYTRUNFV7Q5Ix+qzUC3i/BeLaUM5
         mZqPPowAPGvaDE053x21q7Lw3N4n9hdsq82rjXAZ/L0yO2qD6cp1XhZB1fmWf2OiSTIX
         MhzDQe1/XJd3CLE8Vt8ZtWY1RlctAGJZ7NauQ=
Received: by 10.101.58.10 with SMTP id l10mr8216454ank.258.1286292279155;
        Tue, 05 Oct 2010 08:24:39 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id f29sm11955439anh.31.2010.10.05.08.24.37
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 05 Oct 2010 08:24:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1285719811-10871-4-git-send-email-johan@herland.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158203>

Johan Herland wrote:

> The only functional changes in this patch concern the handling of null_sha1
> in notes_tree_insert(). Otherwise the patch consists solely of reordering
> functions in notes.c to avoid use-before-declaration

Would it makes sense to split off that no-op as a separate patch?

> --- a/notes.c
> +++ b/notes.c
> @@ -175,7 +248,10 @@ static void note_tree_insert(struct notes_tree *t, struct int_node *tree,
>  	switch (GET_PTR_TYPE(*p)) {
>  	case PTR_TYPE_NULL:
>  		assert(!*p);
> -		*p = SET_PTR_TYPE(entry, type);
> +		if (is_null_sha1(entry->val_sha1))
> +			free(entry);
> +		else
> +			*p = SET_PTR_TYPE(entry, type);
>  		return;
>  	case PTR_TYPE_NOTE:
>  		switch (type) {

No note present, but the node for one is.  This skips insertion of
empty notes, for consistency with:

> @@ -191,6 +267,9 @@ static void note_tree_insert(struct notes_tree *t, struct int_node *tree,
>  					    sha1_to_hex(l->val_sha1),
>  					    sha1_to_hex(entry->val_sha1),
>  					    sha1_to_hex(l->key_sha1));
> +
> +				if (is_null_sha1(l->val_sha1))
> +					note_tree_remove(t, tree, n, entry);

The note-present case, where the combine_notes() function can
return a null sha1 to request that a note be removed.

>  				free(entry);
>  				return;
>  			}
> @@ -222,6 +301,10 @@ static void note_tree_insert(struct notes_tree *t, struct int_node *tree,
>  	/* non-matching leaf_node */
>  	assert(GET_PTR_TYPE(*p) == PTR_TYPE_NOTE ||
>  	       GET_PTR_TYPE(*p) == PTR_TYPE_SUBTREE);
> +	if (is_null_sha1(entry->val_sha1)) { /* skip insertion of empty note */
> +		free(entry);
> +		return;
> +	}

The more usual no-note-present case.  Again, this skips insertion
of empty notes.

Do I understand correctly that the point of the main point of
this patch is to allow combine_notes() functions to request
that a note be deleted?  If so, it would be nice if the commit
message said so.

Regardless, for what it's worth,
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
