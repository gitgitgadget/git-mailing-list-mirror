From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] Add git-send-email-script - tool to send emails from git-format-patch-script
Date: Sun, 31 Jul 2005 17:40:18 -0700
Message-ID: <7vk6j6a3rh.fsf@assigned-by-dhcp.cox.net>
References: <11227978451100@foobar.com>
	<7vbr4jmhqe.fsf@assigned-by-dhcp.cox.net>
	<20050731235242.GH32263@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 01 02:43:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzOOs-0001fz-3o
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 02:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbVHAAmz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 20:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbVHAAkc
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 20:40:32 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:50304 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S262280AbVHAAkX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2005 20:40:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050801004018.ICDB15197.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 31 Jul 2005 20:40:18 -0400
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20050731235242.GH32263@mythryan2.michonline.com> (Ryan Anderson's message of "Sun, 31 Jul 2005 19:52:42 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ryan Anderson <ryan@michonline.com> writes:

> If I hope that nobody has done something like:
> 	GIT_AUTHOR="Ryan <> Anderson"
> 	GIT_AUTHOR_EMAIL="ryan@michonline.com"
>
> I get more confusing results.

The function git_author_info() would remove <> from the above
GIT_AUTHOR_* environment values by calling ident.c:copy(), so I
think you would get more-or-less what you _should_ expect without
getting confused.

    $ GIT_AUTHOR_NAME="Ryan <> Anderson" \
      GIT_AUTHOR_EMAIL="ryan@michonline.com" git-var -l
    GIT_COMMITTER_IDENT=Junio C Hamano <junkio@cox.net> 1122855849 -0700
    GIT_AUTHOR_IDENT=Ryan  Anderson <ryan@michonline.com> 1122855849 -0700

>> Is this the culprit that produced this mechanical-looking line?
>> 
>>     To: junkio@cox.net,git@vger.kernel.org
>
> No, that line was exactly what I put into the readline entry.

I was mostly talking about Email::Valid seeming to be stripping
out the display-name[*] part and keeping only addr-spec[*] part,
like this:

    $ cat j.perl
    #!/usr/bin/perl
    use Email::Valid;
    for ('Junio C Hamano <junkio@cox.net>',
         'Ryan Anderson <ryan@michonline.com>') {
        print $_, " => ", lc(Email::Valid->address($_)), "\n";
    }
    $ perl j.perl
    Junio C Hamano <junkio@cox.net> => junkio@cox.net
    Ryan Anderson <ryan@michonline.com> => ryan@michonline.com

Also, I wonder if running lc() to downcase the local-part[*] is
safe/allowed/correct; domain[*] part is case insensitive and
should be OK to downcase, though.

> ..., because of the way I pull in all the relevant emails
> from various places.  So I really needed a way to cull the duplicates.
> ...  I could do soemthing like this, instead, I suppose:

I understand your needs, and you can make it a "sub
filter_dups", which I think would make things a lot more
pleasant to read.


[Footnote]

Terms marked [*] are from RFC2822, section 3.4.
