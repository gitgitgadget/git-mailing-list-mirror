From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Do not ignore errors during make check
Date: Wed, 14 Dec 2005 13:30:16 -0800
Message-ID: <7v1x0fxt7b.fsf@assigned-by-dhcp.cox.net>
References: <20051214210932.GA2642@kvasir.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 22:33:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmeCc-0004by-IS
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 22:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbVLNVaT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 16:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbVLNVaS
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 16:30:18 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:34808 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932356AbVLNVaR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2005 16:30:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051214212936.DUHO15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Dec 2005 16:29:36 -0500
To: Amos Waterland <apw@us.ibm.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13645>

Amos Waterland <apw@us.ibm.com> writes:

> Do not let errors pass by unnoticed when running `make check'.
> ...
>  check:
> -	for i in *.c; do sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i; done
> +	for i in *.c; do sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i || break; done

Good point but "|| exit" would be more appropriate.  With the
above patch, I suspect "make check" merely stops at the first
error but resulting return code would still be zero, wouldn't
it?

$ cat Makefile
check1:
	for i in 1 2 3 4; do echo testing $$i; test $$i -le 2 || break; done

check2:
	for i in 1 2 3 4; do echo testing $$i; test $$i -le 2 || exit; done
$ make check1
for i in 1 2 3 4; do echo testing $i; test $i -le 2 || break; done
testing 1
testing 2
testing 3
$ make check2
for i in 1 2 3 4; do echo testing $i; test $i -le 2 || exit; done
testing 1
testing 2
testing 3
make: *** [check2] Error 1
$ exit
