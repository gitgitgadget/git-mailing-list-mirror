From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Teach git-apply about '-R'
Date: Fri, 28 Jul 2006 08:14:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607280809550.4168@g5.osdl.org>
References: <Pine.LNX.4.63.0607261940090.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <200607262039.25155.Josef.Weidendorfer@gmx.de> <20060728013038.GH13776@pasky.or.cz>
 <Pine.LNX.4.63.0607281213250.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Fri Jul 28 17:15:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6U3H-0000oB-Dd
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 17:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbWG1POs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 11:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbWG1POs
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 11:14:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10430 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752009AbWG1POs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jul 2006 11:14:48 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6SFEanW013653
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 28 Jul 2006 08:14:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6SFEZH5007903;
	Fri, 28 Jul 2006 08:14:35 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607281213250.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-2.541 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24390>



On Fri, 28 Jul 2006, Johannes Schindelin wrote:
>
> +/* a and b may not overlap! */
> +static void memswap(void *a, void *b, unsigned int len)

This is disgusting.

Especially since it's also slow as hell.

> +		memswap(p->new_name, p->old_name, sizeof(char *));
> +		memswap(&p->new_mode, &p->old_mode, sizeof(unsigned int));
> +		memswap(&p->is_new, &p->is_delete, sizeof(int));
> +		memswap(&p->lines_added, &p->lines_deleted, sizeof(int));
> +		memswap(p->old_sha1_prefix, p->new_sha1_prefix, 41);
> +
> +		for (; frag; frag = frag->next) {
> +			memswap(&frag->newpos, &frag->oldpos, sizeof(int));
> +			memswap(&frag->newlines, &frag->oldlines, sizeof(int));

All but one of those are register sizes, so doing a horribly ugly 
"memswap()"to do them is truly nasty, when you could have done

	#define swap(a,b) myswap((a),(b),sizeof(a))

	#define myswap(a,b,size) do {		\
		unsigned char mytmp[size];	\
		memcpy(tmp, &a, size);		\
		memcpy(&a, &b, size);		\
		memcpy(&b, mytmp, size);	\
	} while (0)

and it would have worked MUCH more efficiently, since any sane compiler 
would immediately have noticed that you're doing word-sized copies, and 
optimized the hell out of it.

(Untested, of course).

		Linus
