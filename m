From: Eric Wong <e@80x24.org>
Subject: Re: [WIP-PATCH 0/2] send-email: refactor the email parser loop
Date: Fri, 27 May 2016 20:14:36 +0000
Message-ID: <20160527201436.GA16547@dcvr.yhbt.net>
References: <20160527140104.11192-1-samuel.groot@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org, matthieu.moy@grenoble-inp.fr,
	gitster@pobox.com, aaron@schrab.com
To: Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Fri May 27 22:14:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6O9B-0003ol-TX
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 22:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756519AbcE0UON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 16:14:13 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:52158 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751575AbcE0UON (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 16:14:13 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5204A1FCC6;
	Fri, 27 May 2016 20:14:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160527140104.11192-1-samuel.groot@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295792>

Samuel GROOT <samuel.groot@grenoble-inp.org> wrote:
> While working on the new option `quote-email`, we needed to parse an
> email file. Since the work is already done, but the parsing and data
> processing are in the same loop, we wanted to refactor the parser, to
> make the code more maintainable.

Thank you for doing this work :)

> This is still WIP, and one of the main issue (and we need your
> advice on that), is that around 30 tests will fail, and most of them
> are false-negatives: to pass, they rely on the format of what is
> displayed by `git send-email`, not only data.
> 
> 
> For example, several tests will fail because they do a strict compare
> between `git send-email`'s output and:
> 
>    (mbox) Adding cc: A<author@example.com>  from line 'Cc: A<author@example.com>, One<one@example.com>'
>    (mbox) Adding cc: One<one@example.com>  from line 'Cc: A<author@example.com>, One<one@example.com>'
> 
> Though `git send-email` now outputs something like:
> 
>    (mbox) Adding cc: A<author@example.com>  from line 'Cc: A<author@example.com>'
>    (mbox) Adding cc: One<one@example.com>  from line 'Cc: One<one@example.com>'
I actually like neither, and would prefer something shorter:

    (mbox) Adding cc: A <author@example.com> from Cc: header
    (mbox) Adding cc: One <one@example.com> from Cc: header
    (mbox) Adding cc: SoB <SoB@example.com> from Signed-off-by: trailer

That way, there's no redundant addresses in each line and less
likely to wrap.

But I actually never noticed these lines in the past since they
scrolled off my terminal :x

Since the headers are already shown after those lines, it's
redundant to have the entire line.  And we could add
trailers after the headers (with a blank line to delimit):

    # existing header output:
    From: F <F@example.com>
    Cc: A <author@example.com>, One <one@example.com>
    Subject: foo

    # new trailer output
    Signed-off-by: SoB <SoB@example.com>
    Acked-by: ack <ack@example.com>

> We can think of several solutions:
> 
>    1. Modify the parser, to give the script the knowledge of the exact
>       line the data came from.
> 
>    2. Hack the tests: modify the script using the parser to artificially
>       recreate the supposedly parsed line.
>       (e.g. with a list.join(', ')-like function)
> 
>    3. Modify the tests to replace exact cmp by greps.
> 
> 
> IMHO, we should consider option 3, since the tests should rely on data
> rather than exact outputs. It also makes the tests more maintainable,
> in the sense that they will be more resilient to future output
> modifications.

Agreed on 3.

I am not sure if anybody outside of tests parses the stdout of
send-email.  It's certainly a porcelain and I don't think
stdout needs to be stable, and maybe the output in
question should go to stderr since it could be considered
debug output.

But I could be wrong...
