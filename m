From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv4 06/21] notes.h/c: Propagate combine_notes_fn return
 value to add_note() and beyond
Date: Thu, 21 Oct 2010 00:21:00 -0500
Message-ID: <20101021052100.GB2413@burratino>
References: <1287626936-32232-1-git-send-email-johan@herland.net>
 <1287626936-32232-7-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bebarino@gmail.com, avarab@gmail.com,
	gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 21 07:24:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8ndx-0001dC-Du
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 07:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795Ab0JUFYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 01:24:44 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:58228 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403Ab0JUFYn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 01:24:43 -0400
Received: by gwaa12 with SMTP id a12so253149gwa.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 22:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=gOLBZtnT2ZxwB/k+hRUsox8+thsiNfnXYoJO46KxmmE=;
        b=G/lD234aKj153rDpg5GcBK1P8TgQRck38Xy0UHUhPnXS29zq8MFuFWWcs6qdoWFNI9
         FAB+Q1fIkDybskL2dxPla1WZ/CfOwt1LVLJjUTij6VxUPQ6hw13F/5mRomdPhpq3YuBa
         yc/rfxEi2/WAQpNO+GbaVTGhAU32jvIbbrn+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BWHK3bYlukH9DZmE/KkGd/BWRbD4tyOghnIvCfDsBFAO15HwcnfXrAjnAEfZ1P8jSZ
         GpKZMYBzZ01PFSAnf9KVARmbFWiZQ64IPN3sREXmuJ/b7U5cNn38Dfy8k2L3ohFYSWJz
         xvWzHk7nV1AdIxLfGfHT6mvUzVIFZRtjXJZ80=
Received: by 10.151.51.9 with SMTP id d9mr2904853ybk.89.1287638683247;
        Wed, 20 Oct 2010 22:24:43 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id v9sm7648795ybe.21.2010.10.20.22.24.41
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 22:24:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287626936-32232-7-git-send-email-johan@herland.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159485>

Johan Herland wrote:

> --- a/notes.c
> +++ b/notes.c
> @@ -303,13 +298,17 @@ static void note_tree_insert(struct notes_tree *t, struct int_node *tree,
>  	       GET_PTR_TYPE(*p) == PTR_TYPE_SUBTREE);
>  	if (is_null_sha1(entry->val_sha1)) { /* skip insertion of empty note */
>  		free(entry);
> -		return;
> +		return 0;
>  	}
>  	new_node = (struct int_node *) xcalloc(sizeof(struct int_node), 1);
> -	note_tree_insert(t, new_node, n + 1, l, GET_PTR_TYPE(*p),
> -			 combine_notes);
> -	*p = SET_PTR_TYPE(new_node, PTR_TYPE_INTERNAL);
> -	note_tree_insert(t, new_node, n + 1, entry, type, combine_notes);
> +	ret = note_tree_insert(t, new_node, n + 1, l, GET_PTR_TYPE(*p),
> +			       combine_notes);
> +	if (!ret) {
> +		*p = SET_PTR_TYPE(new_node, PTR_TYPE_INTERNAL);
> +		ret = note_tree_insert(t, new_node, n + 1, entry, type,
> +				       combine_notes);
> +	}
> +	return ret;

Micronit: it would probably be clearer to write

	if (ret)
		return ret;
	*p = SET_PTR_TYPE(...
	return note_tree_insert(...

to avoid a little nesting.

The patch still looks good to me.
