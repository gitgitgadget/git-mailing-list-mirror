From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/3] fast-import: do not write null_sha1 as a merge
 parent
Date: Wed, 27 Jun 2012 16:25:31 -0500
Message-ID: <20120627212531.GN12774@burratino>
References: <1340818825-13754-1-git-send-email-divanorama@gmail.com>
 <1340818825-13754-2-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 23:25:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjzk4-0007VL-Io
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 23:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757040Ab2F0VZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 17:25:37 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57806 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756135Ab2F0VZg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 17:25:36 -0400
Received: by yenl2 with SMTP id l2so1333751yen.19
        for <git@vger.kernel.org>; Wed, 27 Jun 2012 14:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Gnd3bkjzuWEw1IvJ0jFTsIXpQw29Osn6X6x2b11y6PQ=;
        b=rCfhIL2HgWZhqzQAZynHntmWsCOcStUSFU6dcTsuPSXXNlhPTSq3pnQGIWgMzaFI1l
         ej1QHUueuU6CODJcBviT3og2Wa8UYLDnOIQtRHa/uyGCFMLGFc7QdcihuEWIjrZgcrD/
         B77y5Z0eK5vUGyM2sCF0q4KdCPgcqwIWNzCUfHgkPDcmyBbvDa1VAHHZzUlAxInGpYlN
         1cfVlM7j65/yNrOj/l9gvKEnCCiDm6CjkHTHukmLa+JiAEiVT/QMOkOERkQDBGSBQeYi
         3Ojzx+5djDxys15d32FpXHi7kmlTYf1NPgVnrYvnYpnjVGvn6WAPSu184T64N8UFKEt8
         GkKA==
Received: by 10.236.181.199 with SMTP id l47mr24948782yhm.85.1340832335735;
        Wed, 27 Jun 2012 14:25:35 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id f68sm81693056yhh.22.2012.06.27.14.25.34
        (version=SSLv3 cipher=OTHER);
        Wed, 27 Jun 2012 14:25:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1340818825-13754-2-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200758>

Dmitry Ivankov wrote:

> null_sha1 is used in fast-import to indicate "empty" branches and
> should never be actually written out as a commit parent. 'merge'
> command lacks is_null_sha1 checks and must be fixed.

Yeah.

> It looks like using null_sha1 or empty branches in 'from' command
> is legal and/or an intended option (it has been here from the very
> beginning and survived). So leave it allowed for 'merge' command too,
> and just like with 'from' command silently skip null_sha1 parents.

Ok, fair enough.  Are there any tests in the test script for the
"create new branch from unborn branch" trick?  Is this worth
documenting so other backend authors know what they need to do to
support frontends that work with git fast-import?

[...]
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -2734,7 +2734,8 @@ static void parse_new_commit(void)
>  		strbuf_addf(&new_data, "parent %s\n", sha1_to_hex(b->sha1));
>  	while (merge_list) {
>  		struct hash_list *next = merge_list->next;
> -		strbuf_addf(&new_data, "parent %s\n", sha1_to_hex(merge_list->sha1));
> +		if (!is_null_sha1(merge_list->sha1))
> +			strbuf_addf(&new_data, "parent %s\n", sha1_to_hex(merge_list->sha1));

Acked-by: Jonathan Nieder <jrnieder@gmail.com>
