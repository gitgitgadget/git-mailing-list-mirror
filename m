From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] rerere: Expose an API corresponding to 'clear'
 functionality
Date: Wed, 13 Apr 2011 15:38:43 -0500
Message-ID: <20110413203843.GC30630@elie>
References: <7vmxjwws8a.fsf@alter.siamese.dyndns.org>
 <1302700718-19093-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 22:39:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA6q7-0004tm-7N
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 22:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489Ab1DMUi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 16:38:58 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57826 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932094Ab1DMUi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 16:38:57 -0400
Received: by gyd10 with SMTP id 10so261077gyd.19
        for <git@vger.kernel.org>; Wed, 13 Apr 2011 13:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=nxquLeEszM8Ih77LkRdgca42aUE9ZXqJCludwPqdtsk=;
        b=TyYaFRK6v0YmJMGcFkuiVWuWipp1FHMiR4ZIRO6R5rzg7+HETga4ZsqLAPZfcQl/D2
         5iQYKhGBz29oa8oro1Tp/yawiudHgQZ5Wr5eHFkuU+sdiIMTFENrGeBlKWYSYPB9fdYt
         kH6EVFZIoW/az7JuK7kucf5Dz9t92cE776esc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=T653AerYLvugTqWvD7HSdNs6nyO7H2fKpigkd3FCTow7CKPetwiG2OpOY7W+W8aa05
         YAXV6XDknRwx0MDK5haq+Aytv7K+QKt8iGIWJ4v8FvKqUKve215kyTKKkPa2TZhNdbbp
         jBVmvqXJ5E24PROFnZfTcUlQSGYOk7SSGtf5k=
Received: by 10.150.161.2 with SMTP id j2mr1024569ybe.235.1302727136352;
        Wed, 13 Apr 2011 13:38:56 -0700 (PDT)
Received: from elie ([69.209.64.230])
        by mx.google.com with ESMTPS id q34sm2317213ybk.18.2011.04.13.13.38.51
        (version=SSLv3 cipher=OTHER);
        Wed, 13 Apr 2011 13:38:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1302700718-19093-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171486>

Hi,

Ramkumar Ramachandra wrote:

> Expose a new function called rerere_clear,

The commit message is a good chance to quickly explain the API.  What
does the function do?  When would one call it?  Is it equivalent to
running "git rerere clear"?  Any gotchas?

> and make 'builtin/rerere.c'
> use this when the corresponding command-line argument is passed.

Didn't "git rerere" already use the functionality of this function?
I'm not sure what this part means.

> As a
> side-effect, also expose unlink_rr_item as unlink_rerere_item.

This is not a side-effect; you did it directly.

I think the reason for this is that rerere_gc is not being exposed at
the same time, right?  I suppose if I were doing it, I would have
moved that to rerere.c, too and kept unlink_rr_item static, but there
is also appeal in a minimal patch.  It would be clearer to say
something to the effect that we

	Also export unlink_rr_item as unlink_rerere_item so
	rerere_clear and the un-libified "git rerere gc" can
	both use it.

[...]
> +++ b/builtin/rerere.c
> @@ -142,19 +134,14 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
>  		pathspec = get_pathspec(prefix, argv + 1);
>  		return rerere_forget(pathspec);
>  	}
> +	if (!strcmp(argv[0], "clear"))
> +		return rerere_clear();
>  
>  	fd = setup_rerere(&merge_rr, flags);
[...]
> +++ b/rerere.c
> @@ -671,3 +679,22 @@ int rerere_clear(void)
[...]
> +	fd = setup_rerere(&merge_rr, RERERE_NOAUTOUPDATE);
> +	if (fd < 0)
> +		return 0;

Why RERERE_NOAUTOUPDATE instead of 0?  (Of course it doesn't matter in
practice.   Maybe "0" would convey that more clearly?)

> +
> +	for (i = 0; i < merge_rr.nr; i++) {
> +		const char *name = (const char *)merge_rr.items[i].util;
> +		if (!has_rerere_resolution(name))
> +			unlink_rerere_item(name);
> +	}
> +	string_list_clear(&merge_rr, 1);
> +	unlink_or_warn(git_path("MERGE_RR"));
> +	return 0;
> +}

The write_lock is never rolled back.  "git rerere" won't care since it
exits moments later and the atexit handler is called, but others might
mind that they can't perform any more rerere operations afterwards. :)

Thanks and hope that helps.
Jonathan
