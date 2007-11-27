From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] builtin-commit: add --cached to operate only on index
Date: Tue, 27 Nov 2007 19:18:56 +0100
Message-ID: <81b0412b0711271018m6419b076n269a0175494fac84@mail.gmail.com>
References: <81b0412b0711270254i58be4d2fi5021767d99fcb753@mail.gmail.com>
	 <474C0105.3010908@viscovery.net>
	 <81b0412b0711270448s6534a849u86bcb161d4d7b3fe@mail.gmail.com>
	 <7vfxyrd2x2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"=?UTF-8?Q?Kristian_H=C3=B8gsberg?=" <krh@redhat.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 19:19:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix51s-0008U8-IY
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 19:19:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757357AbXK0STA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 13:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758131AbXK0STA
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 13:19:00 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:31476 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757190AbXK0SS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 13:18:59 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1055738nfb
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 10:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ZJB25H1WI3BIXhBHu2YRiNYne5XGAo/teJ4pKHXlJm0=;
        b=sHbTYa3wio2sX5S1c7HHaa6HOFCqN0A1KkgKCf2r38CaQTeXDHR/2QlntHIePqeCx/XmMKVnfV5PWyVANVq+Rj6SrFm2KD/C0sWOhaLohMmWWJtcgc+U6MPTmcayP6pSE7cPXNrVO6ljhWMBkhQXdBP8jVNlTn0scOZ1RyZKqSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aGMIObQbTctPFejCTZTlFv4GQ0Q+L+RQbVlksLMClBFmzhYZ9dKS4mABIapvlZse8cHH/vTeS9PJgudLFYM/WynulP30ZEtdXWXZfVTWZOcnrum7ygm5q6Pvv8NmsGVjhTRqU+JkonKReizQDfo58ZXEhv7og0CbjDGFFjcXQIg=
Received: by 10.78.156.6 with SMTP id d6mr4665511hue.1196187536120;
        Tue, 27 Nov 2007 10:18:56 -0800 (PST)
Received: by 10.78.120.4 with HTTP; Tue, 27 Nov 2007 10:18:56 -0800 (PST)
In-Reply-To: <7vfxyrd2x2.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66251>

On 27/11/2007, Junio C Hamano <gitster@pobox.com> wrote:
> On the other hand, when we know we do not have to _show_ the list of
> staged/modified/untracked files (i.e. we already have the commit log
> message via -m, -F, or -C and we were told not to invoke editor), we do
> not have to call run_status(), only to discard its output.  In such a
> case, we are calling it only to see if we have something committable,
> and we should be able to optimize THAT without being told by the user
> with this new option.  Incidentally I just checked the scripted version;
> it does not do this optimization (git-commit.sh, ll. 514-517).  The C
> rewrite in 'next' does not have it in either (builtin-commit.c,
> ll. 387-390).  When no_edit is in effect, I think these two places can
> be replaced with an equivalent of "diff-index --cached HEAD --" (which
> should not hit the work tree at all) to see if there is anything to be
> committed.  For initial commit the check would obviously be "is the
> index empty?" instead.

This is of course very useful optimization, and will speed up things
everywhere (and especially here).

But still: I didn't mean it. I really meant the interactive case, with
editor and prepared commit message which has status list.
Sometimes this list is the reason why a commit is aborted:
I notice that I'm committing something I didn't really intend to.
