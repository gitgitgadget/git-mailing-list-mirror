From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 2/2] Resolve double chmod() in move_temp_to_file()
Date: Sat, 28 Mar 2009 12:01:35 +0100
Message-ID: <200903281201.35409.johan@herland.net>
References: <200903250105.05808.johan@herland.net>
 <200903261617.48362.johan@herland.net>
 <7viqlu1837.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 28 12:03:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnWJx-0004J6-Al
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 12:03:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754894AbZC1LBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 07:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753738AbZC1LBl
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 07:01:41 -0400
Received: from mx.getmail.no ([84.208.15.66]:45201 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754177AbZC1LBk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Mar 2009 07:01:40 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH700952QMPNGD0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 28 Mar 2009 12:01:37 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH700CL3QMNPS50@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 28 Mar 2009 12:01:37 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.3.28.104615
User-Agent: KMail/1.11.1 (Linux/2.6.28-ARCH; KDE/4.2.1; x86_64; ; )
In-reply-to: <7viqlu1837.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114950>

On Saturday 28 March 2009, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > -	if (chmod(filename, 0444) || adjust_shared_perm(filename))
> > +	if (chmod(filename, get_shared_perm(0444)))
>
> Your get_shared_perm() will end up feeding 0444 to S_ISDIR(), which would
> most likely say "no" and cause real harm, but there is no guarantee that
> we won't start checking S_ISREG() or other things in get_shared_perm()
> later.  I do not like this.

You are right.

> How about doing it this way instead?
>
> One thing to note is that we seem to have been passing what we read from
> st.st_mode, together with S_IFMT bits, to chmod(2); I do not think I've
> seen any breakage reports on exotic systems (glibc on Linux seems to
> ignore the higher bits), but from my reading of POSIX, I would not be
> surprised if somebody's chmod(2) returned EINVAL.

Agreed.

> -- >8 --
> set_shared_perm(): sometimes we know what the final mode bits should look
> like
>
> adjust_shared_perm() first obtains the mode bits from lstat(2), expecting
> to find what the result of applying user's umask is, and then tweaked it

s/tweaked/tweaks/

> as necessary.  When the file to be adjusted is created with mkstemp(3),
> however, the mode thusly obtained does not have anything to do with
> usre's umask, and we would need to start from 0444 in such a case and

s/usre/user/

> there is no point running lstat(2) for such a path.
>
> This introduces a new API set_shared_perm() to bypass the lstat(2) and
> instead force setting the mode bits to the desired value directly.
> adjust_shared_perm() becomes a thin wrapper to the function.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

[...]

> diff --git a/sha1_file.c b/sha1_file.c
> index 8869488..5bfc36c 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2263,7 +2263,7 @@ int move_temp_to_file(const char *tmpfile, const
> char *filename) *
>  	 * The same holds for FAT formatted media.
>  	 *
> -	 * When this succeeds, we just return 0. We have nothing
> +	 * When this succeeds, we just return; we have nothing

Small nit: This belongs in the previous patch, doesn't it?


All in all, this looks very good. Please drop my second patch, and use this 
instead.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
