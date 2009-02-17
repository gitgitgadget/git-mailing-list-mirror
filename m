From: Deskin Miller <deskinm@gmail.com>
Subject: Re: git-svn error: Unable to parse date
Date: Tue, 17 Feb 2009 09:26:29 -0500
Message-ID: <86d4c5e00902170626q7d460a30l168ecd227db69a46@mail.gmail.com>
References: <20090217094850.GQ7504@wouts.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Ward Wouts <ward@wouts.nl>
X-From: git-owner@vger.kernel.org Tue Feb 17 15:28:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZQvY-0006u3-AS
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 15:28:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbZBQO0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 09:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbZBQO0b
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 09:26:31 -0500
Received: from rv-out-0506.google.com ([209.85.198.235]:12554 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbZBQO0a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 09:26:30 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2032918rvb.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 06:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZFmAT//I81/gDZ9qqumnrP0h9SWb4+joFnwl2QfwY7E=;
        b=mH4hPhn1Fb74AaOCm6AVA+oboVkUUJtTC29AoxGMCT2ua/0wNuscrrB+0rIwOa+r2+
         Cc+wXiQNAjArt1gM1KT6ah1Ow3c6Byk45xiQpB0i23s0N1MnjQX+ebnHeU+UKKbZzyEU
         g0k+tabszYzczD+ZND/CzJ3A2Rjwa4KpeCGs4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TWw4jrGqaRBnkYcQfqiop7V17YZbYnhlHdZVYEDEOHG5J94ujhhxoQungVKGxnr231
         CmWYBXXJmeP+FeTh05+JJQivoNPK4HVQWdnGPcFvxn5uIZhEhUfHxJEPBQeAF+zwM1eM
         XvE46GsS8nvWaktAg/+6WzXmnl2WrTOMLPz0g=
Received: by 10.142.215.5 with SMTP id n5mr2973973wfg.292.1234880789992; Tue, 
	17 Feb 2009 06:26:29 -0800 (PST)
In-Reply-To: <20090217094850.GQ7504@wouts.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110388>

Hi,

Cc:ing Eric Wong, the git-svn author; further comments inline.

On Tue, Feb 17, 2009 at 04:48, Ward Wouts <ward@wouts.nl> wrote:
> $ git svn fetch
> Unable to parse date: 2004-03-09T09:44:33.Z
>  at /usr/bin/git-svn line 3995
>
> The message goes away with this one character patch:
>
> $ diff -bru git-svn*

Not using git to hack on git?

> --- git-svn     2009-02-17 10:23:24.000000000 +0100
> +++ git-svn.orig        2009-02-17 10:20:30.000000000 +0100
> @@ -2387,7 +2387,7 @@
>  sub parse_svn_date {
>        my $date = shift || return '+0000 1970-01-01 00:00:00';
>        my ($Y,$m,$d,$H,$M,$S) = ($date =~ /^(\d{4})\-(\d\d)\-(\d\d)T
> -                                           (\d\d)\:(\d\d)\:(\d\d).\d*Z$/x) or
> +                                           (\d\d)\:(\d\d)\:(\d\d).\d+Z$/x) or
>                                         croak "Unable to parse date: $date\n";
>        "+0000 $Y-$m-$d $H:$M:$S";
>  }

I was rather confused until I looked at the source currently in git,
but it looks like you have the patch lines backward.  Looking at the
diff header now that's more clear to me.  At any rate, it's clear why
this date didn't parse, and why your patch fixes it.

I don't have any idea what sort of date format git should be expecting
from svn, so the possibility exists that the current regex is actually
correct and svn is buggily leaving off the subseconds.  Especially
given that this timestamp issue doesn't seem to have come up before,
that feels like a very real possibility.  All the same, even if it is
svn's fault, we likely want to adjust to accommodate faulty svn
installs, certainly in easy cases like this; but I'll defer to Eric in
that regard.

I appreciate the time you took to address this issue, and go so far as
to submit a patch, but you'll be much farther ahead if you use git to
submit patches to git.  Your patch is pretty small and easy to
understand, but it's still lacking a commit message and a signoff from
you, and the diff is actually backwards.  Patches in this state often
end up dropped on the floor on this list- there's too much work to be
done to spend our time on stuff where people haven't used the list
conventions.  It'd be a shame for any further work you do improving
git go to waste, especially when it's not hard to correct, so I'm
trying to help out now by pointing you in the right direction.  You
can find git.git on the web at the following address, along with git
URLs from which you can clone:

http://git.kernel.org/?p=git/git.git;a=summary

Within the repository, Documentation/SubmittingPatches is your best
guide to sending stuff to the mailing list.

In anticipation of a proper commit message and the like, this patch is

Acked-by: Deskin Miller <deskinm@umich.edu>
