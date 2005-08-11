From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Trapping exit in tests, using return for errors
Date: Wed, 10 Aug 2005 23:06:43 -0700
Message-ID: <7virydnh1o.fsf@assigned-by-dhcp.cox.net>
References: <1123732581.18644.37.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 08:07:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E36DJ-0000Ld-Ua
	for gcvg-git@gmane.org; Thu, 11 Aug 2005 08:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbVHKGGq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 02:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbVHKGGq
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 02:06:46 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:18079 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932075AbVHKGGp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2005 02:06:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050811060642.XPVH19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 11 Aug 2005 02:06:42 -0400
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1123732581.18644.37.camel@dv> (Pavel Roskin's message of "Wed,
	10 Aug 2005 23:56:21 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Pavel Roskin <proski@gnu.org> writes:

> This patch does following:
>
> All instances of "exit", "exit 1" and "(exit 1)" in tests have been
> replaced with "return 1".  In fact, "(exit 1)" had no effect.

Are you sure about all of the above?

You are right about "... || exit" in the expect_success tests;
they are broken.  But '(exit 1)' or just saying 'false' at the
end should have done the right thing.  Worse yet, return does
not seem to really work as expected, except if all you want to
do was to tell the test driver "I failed", in which case
"bloopl" would work just as well.

prompt$ cat k.sh
what="$1"
eval '
        echo foo
        case '$what' in
        false)
                (exit 1) ;;
        exit)
                exit 1 ;;
        return)
                return 1 ;;
        esac
'
echo "status $?"
prompt$ bash k.sh exit
foo
prompt$ bash k.sh false
foo
status 1
prompt$ bash k.sh return
foo
k.sh: line 20: return: can only `return' from a function or sourced script
status 1
prompt$ 
