From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Fix branches file configuration
Date: Tue, 25 Mar 2008 16:50:27 -0700
Message-ID: <20080325165027.c23b6ebb.akpm@linux-foundation.org>
References: <alpine.LNX.1.00.0803251931500.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Mar 26 00:51:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeIvR-0008NA-BR
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 00:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757692AbYCYXus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 19:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757731AbYCYXus
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 19:50:48 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49402 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757692AbYCYXur (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Mar 2008 19:50:47 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2PNoSeK011218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 25 Mar 2008 16:50:29 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m2PNoReJ020022;
	Tue, 25 Mar 2008 16:50:27 -0700
In-Reply-To: <alpine.LNX.1.00.0803251931500.19665@iabervon.org>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
X-Spam-Status: No, hits=-4.774 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78233>

On Tue, 25 Mar 2008 19:35:28 -0400 (EDT) Daniel Barkalow <barkalow@iabervon.org> wrote:

> It turns out that .git/branches/foo should fetch into refs/heads/foo.
> 
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
> We still don't have a test for that bit of the behavior, so I could have 
> it still doing the wrong thing. But it at least should do what I think 
> people want.
> 
> Andrew, could you give this a try, on top of current master (or, for that 
> matter, any released version that doesn't work), and let me know if it 
> does the wrong thing?
> 

I tried it on 1.5.5-rc1.  It seems to dtrt from a quick test.

> diff --git a/remote.c b/remote.c
> index 40ed246..a027bca 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -232,7 +232,7 @@ static void read_branches_file(struct remote *remote)
>  {
>  	const char *slash = strchr(remote->name, '/');
>  	char *frag;
> -	char *branch;
> +	struct strbuf branch;
>  	int n = slash ? slash - remote->name : 1000;
>  	FILE *f = fopen(git_path("branches/%.*s", n, remote->name), "r");
>  	char *s, *p;
> @@ -258,17 +258,16 @@ static void read_branches_file(struct remote *remote)
>  	strcpy(p, s);
>  	if (slash)
>  		strcat(p, slash);
> +	strbuf_init(&branch, 0);
>  	frag = strchr(p, '#');
>  	if (frag) {
>  		*(frag++) = '\0';
> -		branch = xmalloc(strlen(frag) + 12);
> -		strcpy(branch, "refs/heads/");
> -		strcat(branch, frag);
> -	} else {
> -		branch = "refs/heads/master";
> -	}
> +		strbuf_addf(&branch, "refs/heads/%s", frag);
> +	} else
> +		strbuf_addstr(&branch, "refs/heads/master");
>  	add_url_alias(remote, p);
> -	add_fetch_refspec(remote, branch);
> +	strbuf_addf(&branch, ":refs/heads/%s", remote->name);
> +	add_fetch_refspec(remote, strbuf_detach(&branch, 0));
>  	remote->fetch_tags = 1; /* always auto-follow */
>  }
>  
> -- 
> 1.5.4.3.610.gea6cd
