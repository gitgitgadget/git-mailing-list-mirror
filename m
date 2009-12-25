From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC PATCH 1/2] Report exec errors from run-command
Date: Fri, 25 Dec 2009 11:51:48 +0200
Message-ID: <20091225095147.GB8319@Knoppix>
References: <1261676971-3285-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1261676971-3285-2-git-send-email-ilari.liusvaara@elisanet.fi>
 <7vr5qjecbb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 25 10:52:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NO6q2-0002O4-Ai
	for gcvg-git-2@lo.gmane.org; Fri, 25 Dec 2009 10:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbZLYJvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Dec 2009 04:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752388AbZLYJvy
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Dec 2009 04:51:54 -0500
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:57176 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024AbZLYJvx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Dec 2009 04:51:53 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id D452A8BEA7;
	Fri, 25 Dec 2009 11:51:51 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A0054CD0FF5; Fri, 25 Dec 2009 11:51:51 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id B007C4042;
	Fri, 25 Dec 2009 11:51:49 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <7vr5qjecbb.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135670>

On Thu, Dec 24, 2009 at 11:35:04PM -0800, Junio C Hamano wrote:
> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:
> 
> Thanks; I think overall this is a good idea, even though I have no clue
> if WIN32 side wants a similar support.

It would. But I have no clue about WIN32. But there are other people
on this list who have. :-)
 
>  - At first reading, the "while (close(fd) < 0 && errno != EBADF);"
>    pattern was a bit of eyesore.  It might be worth factoring that out to
>    a small static helper function that a smart compiler would
>    automatically inline (or mark it as a static inline).

Done (with bit of reformatting to add space, line break and comment.

>  - Is it guaranteed that a failed pipe(2) never touches its int fildes[2]
>    parameter, or the values are undefined when it fails?  The approach
>    would save one extra variable, compared to an alternative approach to
>    keep an explicit variable to record a pipe failure, but It feels iffy
>    that the code relies on them being left as their initial -1 values.

I added explicit set to -1 on failure case (I think failed pipe doesn't touch
those, but you never know about what some oddball OS is going to do).

>  - Should we worry about partial write as well (you seem to warn when you
>    get a partial read)?  Is it worth using xread() and friends found in
>    wrapper.c instead of goto read/write_again?

That's hairy code. One really can't print any errors in write path, as those
errors would go to who knows where due to redirections (I took the error
warning out).

That partial read warning is more for detecting 'can't happen' situations
since pipe should be large enough to atomically transfer integer.

>  - Shouldn't any of these warning() be die() instead?

If error reporting failures are fatal, all of them.

-Ilari
