From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fixed Cygwin CR-munging problem in mailsplit
Date: Sat, 27 May 2006 11:21:31 -0700
Message-ID: <7vfyivfhw4.fsf@assigned-by-dhcp.cox.net>
References: <4477262A.5000301@Intel.com>
	<7virnsk6fe.fsf@assigned-by-dhcp.cox.net> <44789309.1030002@Intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat May 27 20:21:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fk3Pt-0007v3-Hn
	for gcvg-git@gmane.org; Sat, 27 May 2006 20:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbWE0SVe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 14:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbWE0SVe
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 14:21:34 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:25016 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S964916AbWE0SVd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 May 2006 14:21:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060527182132.FUDZ24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 27 May 2006 14:21:32 -0400
To: Salikh Zakirov <Salikh.Zakirov@Intel.com>
In-Reply-To: <44789309.1030002@Intel.com> (Salikh Zakirov's message of "Sat,
	27 May 2006 21:57:29 +0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20866>

Salikh Zakirov <Salikh.Zakirov@Intel.com> writes:

> Do not open mailbox file as fopen(..., "rt")
> as this strips CR characters from the diff,
> thus breaking the patch context for changes 
> in CRLF files.
>
> Signed-off-by: Salikh Zakirov <Salikh.Zakirov@Intel.com>
>
> ---
> fd405a0843f3efd474bc7897b06d813d6498fbf4
> diff --git mailsplit.c mailsplit.c
> index c529e2d..70a569c 100644
> --- mailsplit.c
> +++ mailsplit.c
> @@ -162,7 +162,7 @@ int main(int argc, const char **argv)
>  
>  	while (*argp) {
>  		const char *file = *argp++;
> -		FILE *f = !strcmp(file, "-") ? stdin : fopen(file, "rt");
> +		FILE *f = !strcmp(file, "-") ? stdin : fopen(file, "r");
>  		int file_done = 0;
>  
>  		if ( !f )

I personally think this is a right change.  Provided if MTAs on
the path between patch originator and you are not broken and
your MUA saved the message with CR/LF distinction in the
contents intact, this should do more right thing.

I see broken patches every once in a while, but when they are
mangled by the mailpath, CRLF is the least of the problem; they
have other whitespace breakage that makes them unapplicable
anyway.

Having said that, however, that historically used to be a big IF
with capital letters.


I have a feeling that Linus did this on purpose.  For the
projects we originally cared about, a patch to introduce CRLF
in the tracked content was a broken patch 100% of the time (not
99%), and most likely caused by a breakage somewhere on the
mailpath.  At least in the original git context, protecting
UNIX/POSIX people from broken MTA/MUA counted far more than
catering to people who deals with DOSsy contents.

So I am slightly in favor of the change, but just barely.
