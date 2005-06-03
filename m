From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Use correct U*MAX.
Date: Sat, 4 Jun 2005 01:02:37 +0200
Message-ID: <20050603230234.GC13093@pasky.ji.cz>
References: <7vy89ums2l.fsf@assigned-by-dhcp.cox.net> <7vis0xkjn4.fsf@assigned-by-dhcp.cox.net> <7vwtpc7lju.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 04 01:00:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeL8U-0005Cq-SW
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 00:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVFCXCp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 19:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVFCXCp
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 19:02:45 -0400
Received: from w241.dkm.cz ([62.24.88.241]:38636 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261152AbVFCXCl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 19:02:41 -0400
Received: (qmail 16815 invoked by uid 2001); 3 Jun 2005 23:02:37 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtpc7lju.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Jun 02, 2005 at 06:47:33PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> The largest "unsigned long" value is ULONG_MAX, not UINT_MAX.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> diff --git a/diff.c b/diff.c
> --- a/diff.c
> +++ b/diff.c
> @@ -256,7 +256,7 @@ static struct sha1_size_cache *locate_si
>  		first = next+1;
>  	}
>  	/* not found */
> -	if (size == UINT_MAX)
> +	if (size == ULONG_MAX)
>  		return NULL;
>  	/* insert to make it at "first" */
>  	if (sha1_size_cache_alloc <= sha1_size_cache_nr) {
> @@ -338,7 +338,7 @@ int diff_populate_filespec(struct diff_f
>  		struct sha1_size_cache *e;
>  
>  		if (size_only) {
> -			e = locate_size_cache(s->sha1, UINT_MAX);
> +			e = locate_size_cache(s->sha1, ULONG_MAX);
>  			if (e) {
>  				s->size = e->size;
>  				return 0;

This one still applies, but it might be better to get rid of it
altogether, like...

[PATCH] Kill UINT_MAX usage in locate_size_cache()

Use -1 instead of UINT_MAX to indicate that locate_size_cache() should
do only the lookup and not create new stuff in case the looked up hash
was not found.

Signed-off-by: Petr Baudis <pasky@ucw.cz>

diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -256,7 +256,7 @@ static struct sha1_size_cache *locate_si
 		first = next+1;
 	}
 	/* not found */
-	if (size == UINT_MAX)
+	if (size == -1)
 		return NULL;
 	/* insert to make it at "first" */
 	if (sha1_size_cache_alloc <= sha1_size_cache_nr) {
@@ -337,7 +337,7 @@ int diff_populate_filespec(struct diff_f
 		struct sha1_size_cache *e;
 
 		if (size_only) {
-			e = locate_size_cache(s->sha1, UINT_MAX);
+			e = locate_size_cache(s->sha1, -1);
 			if (e) {
 				s->size = e->size;
 				return 0;

|
-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
