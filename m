From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't use the pager when running "git diff --check"
Date: Thu, 13 Dec 2007 21:11:45 -0800
Message-ID: <7vmysdx3la.fsf@gitster.siamese.dyndns.org>
References: <1197552751-53480-2-git-send-email-win@wincent.com>
	<1197575138-58070-1-git-send-email-win@wincent.com>
	<20071214045127.GC10169@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 14 06:12:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J32qU-00048W-68
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 06:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbXLNFL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 00:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbXLNFL7
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 00:11:59 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56286 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbXLNFL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 00:11:58 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0096486E2;
	Fri, 14 Dec 2007 00:11:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2831B86DC;
	Fri, 14 Dec 2007 00:11:49 -0500 (EST)
In-Reply-To: <20071214045127.GC10169@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 13 Dec 2007 23:51:27 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68222>

Jeff King <peff@peff.net> writes:

> On Thu, Dec 13, 2007 at 08:45:38PM +0100, Wincent Colaiuta wrote:
>
>> In 89d07f75 "git diff" learnt to not run the pager if the user passes
>> the --exit-code switch. This commit does the same for the --check
>> switch for the same reason: we want the user to get the exit status
>> from "git diff", not the pager.
>
> But --check is also producing useful output, which might need paged. So
> you are sacrificing existing interactive use of --check for scriptable
> exit-code uses. If you really want the exit code, why not "git diff
> --check --exit-code"?
>
> OTOH, I am not too sad to lose the paging behavior; it would take quite
> a few whitespace errors to scroll off the screen.

You are right.  While I do not personally miss paging output, it is a
regression not to page --check output by default.

By the way, there is no reason to make --check and --exit-code mutually
exclusive either.  You could say with --exit-code the command will exit
with status 01 or'ed in if trees are not identical, and with --check the
command will exit with status 02 or'ed in.  Loosely written scripted
callers can continue doing:

	if git --no-pager diff --exit-code
        then
        	they are different
        fi

	if git --no-pager diff --check
	then
        	there are funky blanks
	fi

while the ones that are aware of the new behaviour of --check can:

	git --no-pager diff --check --exit-code
        case $? in
        0)	all is well ;;
        1)	clean difference there ;;
        3)	dirty difference there ;;
        2)	cannot happen ;;
	*)	bombed out, as die exits with 128 ;;
	esac
