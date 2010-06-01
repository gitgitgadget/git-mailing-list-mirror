From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/8] revert: allow cherry-picking more than one commit
Date: Tue, 1 Jun 2010 04:03:17 -0500
Message-ID: <20100601090317.GB32320@progeny.tock>
References: <20100531193359.28729.55562.chriscool@tuxfamily.org>
 <20100531194240.28729.9164.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jun 01 11:03:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJNNe-00071C-3N
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 11:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045Ab0FAJDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 05:03:20 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51564 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328Ab0FAJDT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 05:03:19 -0400
Received: by iwn6 with SMTP id 6so708413iwn.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 02:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=JhfyiJx/4sbw1Vck+M0or09r/+2ZyBO5sp0QgWYlcg0=;
        b=ArP5Emtf3rbWyy6pp7Qi/wiRVnLUQyFW+zTQw6fDYEXM3sFSlPyYLkr5tklqsebQo8
         //igYnGjSsbI7u0ZWCjgelGKX/sJUeQD9uNXLF491kEpB/L2X6gq7U5XulQBIYvdgU5o
         7LxkOQAWA/woPY8uf/cg2vxuOTqw3lxg6XNPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wgHCs8nHO7dExY8KIzOwPDkMHP3RZI8A5RvPJ/k7o9nTd0hHdvmdIb8he1etwv8Dh1
         kwRJQu3mDD9KXZ6vbZXdiJQdJ5yPlq2tm+uFDOLhlmahk7a3FebGc7JfoHZNBdhPvsjB
         FwU2/0Z3BbDrgA02K+Kc1tpS5hseyTl64/uDQ=
Received: by 10.231.183.19 with SMTP id ce19mr7431823ibb.35.1275382998624;
        Tue, 01 Jun 2010 02:03:18 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r12sm30425474ibi.8.2010.06.01.02.03.17
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 02:03:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100531194240.28729.9164.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148094>

Christian Couder wrote:

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -520,8 +516,33 @@ static int do_pick_commit()
>  	return 0;
>  }
>  
> +static void prepare_revs(struct rev_info *revs)
> +{
> +	int argc = 0;
> +	int i;
> +	const char **argv = xmalloc((commit_argc + 4) * sizeof(*argv));
> +
> +	argv[argc++] = NULL;
> +	argv[argc++] = "--no-walk";
> +	if (action != REVERT)
> +		argv[argc++] = "--reverse";
> +	for (i = 0; i < commit_argc; i++)
> +		argv[argc++] = commit_argv[i];
> +	argv[argc++] = NULL;
> +
> +	init_revisions(revs, NULL);
> +	setup_revisions(argc - 1, argv, revs, NULL);
> +	if (prepare_revision_walk(revs))
> +		die("revision walk setup failed");
> +
> +	if (!revs->commits)
> +		die("empty commit set passed");
> +}

Tiny one-time leak.  Maybe avoiding it will make debugging tools
happier.

The rest of the patch of course looks good.  Thanks.

diff --git a/builtin/revert.c b/builtin/revert.c
index b90955f..a73f66b 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -532,6 +532,7 @@ static void prepare_revs(struct rev_info *revs)
 
 	init_revisions(revs, NULL);
 	setup_revisions(argc - 1, argv, revs, NULL);
+	free(argv);
 	if (prepare_revision_walk(revs))
 		die("revision walk setup failed");
 
