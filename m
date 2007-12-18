From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] Authentication support for pserver
Date: Tue, 18 Dec 2007 22:41:03 +1300
Message-ID: <46a038f90712180141x2f27e6cei5ef53339fd3f90dc@mail.gmail.com>
References: <87wsrhex4c.fsf@cpan.org>
	 <7vd4t9x2lw.fsf@gitster.siamese.dyndns.org> <87mysdepeh.fsf@cpan.org>
	 <7vir31u210.fsf@gitster.siamese.dyndns.org> <877ijhm1b5.fsf@cpan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	martyn@catalyst.net.nz, martin@catalyst.net.nz
To: "=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?=" <avar@cpan.org>
X-From: git-owner@vger.kernel.org Tue Dec 18 10:41:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4YxA-0003N7-Fm
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 10:41:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311AbXLRJlJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Dec 2007 04:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752178AbXLRJlI
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 04:41:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:21682 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbXLRJlF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Dec 2007 04:41:05 -0500
Received: by ug-out-1314.google.com with SMTP id z38so72462ugc.16
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 01:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=LmtKdzMVOxZtGmVmeicLumzk9ajMV15BjWaVxE5RkXU=;
        b=IueoStQwmibUEGhylLjWoW788gmwN93IsPMVo7cO7jkwAv5V4vBlR2k8XmKrU0ByvBgzI5Hf0BI16xhlwMxzZ66IvacRf0A5uuz+0Px0RJ9kC86vF1oNGvkkKI0YsS26XDw6afZDggecjfpIYlrSJF+Z7bQu4P8pJU5FiCTrgHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FUugrbhIl5z57c4fgHMf0Oqa8pDj5h4muPPJ9S4fIj9+eFYKs0bMzC1sC1s0eHyhRCa7SvxW/+ytBu61wYzjXr9nWwTb6co2mdZQcbf6XEYsqD7H7kkK4isGJI6CVpw2AlggjkzHHeXZqWBsyV1NJH3NztIK5pIrGbwm3r48+uI=
Received: by 10.67.116.15 with SMTP id t15mr617359ugm.21.1197970863314;
        Tue, 18 Dec 2007 01:41:03 -0800 (PST)
Received: by 10.66.252.2 with HTTP; Tue, 18 Dec 2007 01:41:03 -0800 (PST)
In-Reply-To: <877ijhm1b5.fsf@cpan.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68719>

On Dec 15, 2007 10:08 AM, =C6var Arnfj=F6r=F0 Bjarmason <avar@cpan.org>=
 wrote:
> > Looks good.  I'll queue only so that I won't lose it and wait for A=
cks
> > from Mart[iy]ns.  Please sign off your patch.

I have been mulling a bit about this change. Seems correct from a code
flow POV. But anon pserver support was added with a lot of
trepidation. Authenticated, write-enabled pserver support fills me
with dread ;-)

A few things that come to mind

 - git/config is very likely to be readable if the site is served via
other means, like dumb http protocol, or git+ssh. So even if the
password scrambling is mickey-mouse. it might make sense to force the
password data to live elsewhere.

 - umasks/file permissions will probably be handled by the underlying
git tools and core.sharedrepository, since we no longer update refs
"manually". So after a bit of thinking, this should not be an issue.

 - I still worry about running cvsserver with an acct that has write
privileges. With anon, all we need write access is the sqlite db, and
that's not even based on user input. And it can be relocated elsewhere
via git/config.

So, wondering about input validation and related matters re-read most
of cvsserver. The only suspicious bit I find is a caller to
transmitfile @ lines 1117, where the 2nd parameter doesn't come from
tempfile() - if a nasty filename sneaked in, we could (perhaps) be in
for a surprise. We do that for diff header prettyness - we could use
--label / -L instead. Will try and prep a patch for that tomorrow if
noone beats me to it (bedtime in nz!).

Hmmm. Does "worried ACK" count as an ACK? Can we add big fat warnings
along the lines of "run this in a locked down environment, pretty
please"?

cheers,



m
