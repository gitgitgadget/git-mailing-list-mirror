From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG, PATCH 0/3] Fix {blame,cat-file} --textconv for cases with symlinks
Date: Sun, 19 Sep 2010 10:58:55 +0200
Message-ID: <vpq8w2yt8hc.fsf@bauges.imag.fr>
References: <cover.1284830388.git.kirr@landau.phys.spbu.ru>
	<vpqhbhmx6tg.fsf@bauges.imag.fr>
	<7vpqwa254i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kirill Smelkov <kirr@landau.phys.spbu.ru>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 19 11:00:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxFkn-0003eE-JJ
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 11:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187Ab0ISJAB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Sep 2010 05:00:01 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36629 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751946Ab0ISI77 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 04:59:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o8J8sR2P026758
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 19 Sep 2010 10:54:27 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OxFjc-0003c0-5c; Sun, 19 Sep 2010 10:58:56 +0200
In-Reply-To: <7vpqwa254i.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Sat\, 18 Sep 2010 13\:01\:17 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 19 Sep 2010 10:54:27 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o8J8sR2P026758
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1285491269.54245@bbMAr9fZLGEa1vp6ljzf3A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156486>

Junio C Hamano <gitster@pobox.com> writes:

> That said, if you changed a symlink from pointing at A to pointing at B,
> it does run the textual diff between the string we get from readlink(3).

Yes, and my question was to make sure we don't run the textconv filter
on these strings.

I've just checked, and from my little tests, git diff doesn't try to
textconv the pathnames, it runs the textual diff without textconv,
which is the expected behavior.

> I didn't look at the thread or problem description, but are we running the
> textconv filter on the file that symlink points at, instead of the
> pathname stored in the symlink?  If so I'd call that a bug.

No, we don't do that. And yes, it's good not to do that: AFAIK, Git
never looks at the file symlinks points to (which allows one to store
broken symlinks or symlinks pointing outside the repository).

> On the other hand, if we are running the textconv filter on the pathname,
> then I don't think we are doing anything wrong.  If you have a filter that
> is meant to munge a PDF file to some other format, and if you do not want
> to apply that filter to munge a pathname a symlink that happens to be
> named "foo.pdf", either the filter itself or the attributes pattern you
> are using to choose what paths to apply that filter might want to be
> written more carefully, that's all.

If a symlink points to "foo.pdf", then you really want to call the
string "foo.pdf" a pathname, not a "content", although it happens to
be stored in a blob content.

If you have a program that can textconv PDF files, then you really
want to say

*.pdf textconv=the-driver-for-that-program

in your .gitattributes file, and let Git call the program on _files_,
not pathnames, and hence not symlink target (i.e. result of readlink).

If you think Git should call the textconv filter on pathnames, and let
the driver decide whether to call it depending on whether it's a file
content or a symlink target, then you should 1) give a use-case where
it's usefull to textconv symlink targets (I really don't see any, and
even on highly artificial examples, I can't imagine one where the same
driver should textconv file content and pathnames), and 2) tell us the
syntax to use in .gitattributes or in the driver to call it only on
file content (I don't know any, and the .gitattribute manpage doesn't
containt either "link" or "mode", so I don't think there is actually
any).

So, I'm pretty sure either I misunderstood you or you misunderstood
something ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
