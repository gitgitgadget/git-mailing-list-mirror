From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-send-email: Don't set author_not_sender from Cc: lines
Date: Tue, 22 Aug 2006 18:34:16 -0700
Message-ID: <7vd5asjkvb.fsf@assigned-by-dhcp.cox.net>
References: <1156253919761-git-send-email-hskinnemoen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 23 03:34:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFhdT-0005xC-6p
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 03:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWHWBeV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 21:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWHWBeV
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 21:34:21 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:1408 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932173AbWHWBeU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 21:34:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060823013417.PYDN6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Aug 2006 21:34:17 -0400
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25886>

Haavard Skinnemoen <hskinnemoen@atmel.com> writes:

> When an mbox-style patch contains a Cc: line in the header,
> git-send-email will check the address against the sender specified
> on the command line. If they don't match, sender_not_author will
> be set to the address obtained from the Cc line.

> @@ -506,7 +506,7 @@ foreach my $t (@files) {
>  				if (/^Subject:\s+(.*)$/) {
>  					$subject = $1;
>  
> -				} elsif (/^(Cc|From):\s+(.*)$/) {
> +				} elsif (/^(From):\s+(.*)$/) {
>  					if ($2 eq $from) {
>  						next if ($suppress_from);
>  					}
> @@ -516,8 +516,11 @@ foreach my $t (@files) {
>  					printf("(mbox) Adding cc: %s from line '%s'\n",
>  						$2, $_) unless $quiet;
>  					push @cc, $2;
> +				} elsif (/^(Cc):\s+(.*)$/) {
> +					printf("(mbox) Adding cc: %s from line '%s'\n",
> +						$2, $_) unless $quiet;
> +					push @cc, $2;
>  				}
> -
>  			} else {
>  				# In the traditional
>  				# "send lots of email" format,

The patch looks wrong.  If your name is on CC: and you want to
suppress sending to yourself what happens?

How about doing something like this instead?

diff --git a/git-send-email.perl b/git-send-email.perl
index a83c7e9..8adb6b9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -510,7 +510,7 @@ foreach my $t (@files) {
 					if ($2 eq $from) {
 						next if ($suppress_from);
 					}
-					else {
+					elsif ($1 eq 'From') {
 						$author_not_sender = $2;
 					}
 					printf("(mbox) Adding cc: %s from line '%s'\n",
