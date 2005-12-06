From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Clean up compatibility definitions.
Date: Tue, 06 Dec 2005 00:11:57 -0800
Message-ID: <7vu0dm4pbm.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0512050519k5ed80035x9eb4907f569e0a4b@mail.gmail.com>
	<81b0412b0512050524w7b632651n93c836fda41a39d@mail.gmail.com>
	<7vfyp7cuii.fsf@assigned-by-dhcp.cox.net>
	<7voe3vb8fh.fsf@assigned-by-dhcp.cox.net>
	<20051205215059.GC4443@steel.home>
	<7vr78r9pg0.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0512052315p1917a04ek264c14abf41a1027@mail.gmail.com>
	<7vk6ei65r6.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0512060007s589e1d0dr4f47da68a7f3567a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Dec 06 09:13:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjXvl-0008JT-D3
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 09:12:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbVLFIMA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 03:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbVLFIL7
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 03:11:59 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:10727 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750737AbVLFIL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2005 03:11:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051206081125.WQNQ3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Dec 2005 03:11:25 -0500
To: git@vger.kernel.org
In-Reply-To: <81b0412b0512060007s589e1d0dr4f47da68a7f3567a@mail.gmail.com>
	(Alex Riesen's message of "Tue, 6 Dec 2005 09:07:04 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13267>

Alex Riesen <raa.lkml@gmail.com> writes:

> On 12/6/05, Junio C Hamano <junkio@cox.net> wrote:
>> > ... return MAP_FAILED if error, do not
>> > exit process, do no output.
>> Ah, that is what you meant.  I agree.
>
> now, while we agree, how about the patch removing "user interface"
> from gitfakemmap altogether?

> 311da12b7aaca9b7329a07807e1ce4afba4bff77
> diff --git a/compat/mmap.c b/compat/mmap.c
> index 55cb120..32d7a30 100644
> --- a/compat/mmap.c
> +++ b/compat/mmap.c
> @@ -8,15 +8,17 @@ void *gitfakemmap(void *start, size_t le
>  {
>  	int n = 0;
>  
> -	if (start != NULL || !(flags & MAP_PRIVATE))
> -		die("Invalid usage of gitfakemmap.");
> +	if (start != NULL || !(flags & MAP_PRIVATE)) {
> +		errno = ENOTSUP;
> +		return MAP_FAILED;
> +	}

I've considered this one after hearing what you meant by your
previous comment, but I am slightly in favor of keeping this
die(); what would trigger this is a programmer error, and the
extra error message from die() makes it obvious, although I
agree that it is unclean from purist point of view.

On the other hand,

> -	start = xmalloc(length);
> +	start = malloc(length);

This one I'd agree with 100%.
