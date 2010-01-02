From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: Filename quoting / parsing problem
Date: Sat, 2 Jan 2010 12:36:26 +0100
Organization: SUSE Labs
Message-ID: <201001021236.26947.agruen@suse.de>
References: <201001011844.23571.agruen@suse.de> <7vws01li4c.fsf@alter.siamese.dyndns.org> <7vr5q9lhm8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 02 12:36:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NR2Hk-00038z-UQ
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 12:36:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616Ab0ABLgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 06:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752426Ab0ABLgk
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 06:36:40 -0500
Received: from cantor.suse.de ([195.135.220.2]:34206 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685Ab0ABLgj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 06:36:39 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 6B1D493717;
	Sat,  2 Jan 2010 12:36:34 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31.5-0.1-desktop; KDE/4.3.1; x86_64; ; )
In-Reply-To: <7vr5q9lhm8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136026>

On Friday 01 January 2010 09:01:19 pm Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > I used "cat -e" to make it easier to see that "c file " not only has SP
> > in it but it has trailing space.  Let's try the result.
> >
> >         $ git diff --cached | cat -e
> >         diff --git "a/a\001file" "b/a\001file"$
> >         new file mode 100644$
> >         index 0000000..e69de29$
> >         diff --git a/b file b/b file$
> >         new file mode 100644$
> >         index 0000000..e69de29$
> >         diff --git a/c file  b/c file $
> >         new file mode 100644$
> >         index 0000000..e69de29$
> >         $ git diff --cached >P.diff
> >
> > And as you described, "b file" and "c file " are not quoted and they do
> > not have ---/+++ lines.
> >
> > But observe this:
> > ...
> > We are now back in the state without any of these files, and P.diff
> > records a patch to recreate these three files, one with quoting and the
> > other two without.
> >
> >         $ git apply --index P.diff
> >         $ git ls-files -s | cat -e
> >         100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0      
> > "a\001file"$ 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       b
> > file$ 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       c file $
> > 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0       hello$
> >
> > This demonstrates that The claim below is false, doesn't it?
> >
> > > Not parseable:
> > >     diff --git a/baz  b/baz
> > >     new file mode 100644
> > >     index 0000000..e69de29
> >
> > Both "b file" and "c file " are parsed by "git apply" perfectly fine.

Right, the "diff --git" lines are technically still parseable when the file 
name stays the same.  With renames, lines like "diff --git a/f a/f b/f" or 
"diff --git a/f b/f b/f" are possible, but then there will also be "renamed 
from" and "renamed to" headers which will disambiguate things.  Still, it 
doesn't seem like a good idea to allow such ambiguities in the first place.

> Having said all that, I don't think we would mind a change to treat a
> pathname with trailing SP a bit specially (iow, quoting "c file " in the
> above failed attempt to reproduce the issue).

I would prefer quoting file names which contain spaces anywhere, not only at 
the end.  If quoting helps to disambiguate a program's output, I'm all for it.  
People who can't be bothered with such details can always use a pretty printer 
(side by side view, whatever).

Thanks,
Andreas
