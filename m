From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 4/4] fast-export: make sure refs are updated properly
Date: Tue, 30 Oct 2012 17:37:21 -0700
Message-ID: <20121031003721.GV15167@elie.Belkin>
References: <1351623987-21012-1-git-send-email-felipe.contreras@gmail.com>
 <1351623987-21012-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 01:37:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTMJb-0008MK-OD
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 01:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759656Ab2JaAh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 20:37:29 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33155 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759020Ab2JaAh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 20:37:27 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so552718pad.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 17:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Vtf+oFDN83+Kv+jH4Q90XD1ZpeDUS2XsytwqXb8Ntac=;
        b=PhlJ7FlMt5S6RsYF/b60ICpYZ6t9xe03qV5ovJXueke5p+9Lz2roILSv9zRH7ZI+BN
         0kQrvY9EIVJz7TP8LoKbRrPg75mCg7MF3O/Dk9ZAn0fU8CYJPQQXR+kw7pSZj/0l6pVf
         WT0/Rg7aol9dcN8Om2vCN6JG1Xijx+LAh512glE/je4Ztj2Olt52xreSENgCBoclgO1W
         UbwUqrLQbfX7rjsoOnV3rx4nTy6VLnQihp4nMgOKC9LoKfWpbDm2MLY5i82augQt3zlQ
         mKG3IKGrE+2ubSAQTNXc1FJXCVbis65CnVtIQ+WLsxNzKFQ3dUY+8uuLc6Y/2PUghF5x
         19bA==
Received: by 10.66.74.40 with SMTP id q8mr97134844pav.29.1351643846842;
        Tue, 30 Oct 2012 17:37:26 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id vk5sm1962pbc.34.2012.10.30.17.37.24
        (version=SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 17:37:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1351623987-21012-5-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208773>

Felipe Contreras wrote:

> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -523,11 +523,16 @@ static void get_tags_and_duplicates(struct object_array *pending,
>  				typename(e->item->type));
>  			continue;
>  		}
> -		if (commit->util) {
> -			/* more than one name for the same object */
> +
> +		/*
> +		 * This ref will not be updated through a commit, lets make
> +		 * sure it gets properly upddated eventually.
> +		 */
> +		if (commit->util || commit->object.flags & SHOWN) {
>  			if (!(commit->object.flags & UNINTERESTING))
>  				string_list_append(extra_refs, full_name)->util = commit;
> -		} else
> +		}
> +		if (!commit->util)
>  			commit->util = full_name;

Here's an explanation of why the above makes sense to me.

get_tags_and_duplicates() gets called after the marks import and
before the revision walk.  It walks through the revs from the
commandline and for each one:

 - peels it to a refname, and then to a commit
 - stores the refname so fast-export knows what arg to pass to
   the "commit" command during the revision walk
 - if it already had a refname stored, instead adds the
   (refname, commit) pair to the extra_refs list, so fast-export
   knows to add a "reset" command later.

If the commit already has the SHOWN flag set because it was pointed to
by a mark, it is not going to come up in the revision walk, so it will
not be mentioned in the output stream unless it is added to
extra_refs.  That's what this patch does.

Incidentally, the change from "else" to "if (!commit->util)" is
unnecessary because if a commit is already SHOWN then it will not be
encountered in the revision walk so commit->util does not need to be
set.

If the commit does not have the SHOWN or UNINTERESTING flag set but it
is going to get the UNINTERESTING flag set during the walk because of
a negative commit listed on the command line, this patch won't help.

Jonathan
