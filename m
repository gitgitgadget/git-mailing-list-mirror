From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFH] git-log vs git-rev-list performance
Date: Sat, 29 Dec 2007 21:05:11 +0100
Message-ID: <e5bfff550712291205m56521977tfe380969e06e93d4@mail.gmail.com>
References: <e5bfff550712290418h22d7f7edqda519e7f4dcd25b8@mail.gmail.com>
	 <alpine.LFD.0.9999.0712291038560.2778@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Dec 29 21:05:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8hwL-0003Fo-Jl
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 21:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbXL2UFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2007 15:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbXL2UFQ
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Dec 2007 15:05:16 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:6528 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbXL2UFP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2007 15:05:15 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3958876rvb.1
        for <git@vger.kernel.org>; Sat, 29 Dec 2007 12:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=nylaW5mH8w0K9jHkFTRjtoNPrKdBBwuxBaxhodE671Y=;
        b=wRIiVVRhWNMx+jgcBB3sm7G0TyboAu62kcToD9TXooibeNh7qqMtqQ7iGhI66l4aNhTI++eY0Rsfpcux64GlEAHVZ+FXAkNlC2Yv0PaaAOplTyK7EnPLjKlKLWIlZ4LioFkDwverzWQv06Et8VK6Ccirewhw+yMK+QZ0DA3WpSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dItiWiR3PmZ7cV+rRfK5ptyl8hvq3tSYlDPDGT+zz7KB39rrKQx1r1rEne8TbLVZowz/ctmIO7ADobCz//oosflsywSPJzyDuggWXPngruJjYEnQALFlWkb5CvPSTOJ5sJbx+kr2lruHJ+eWnzUxXvcSmrHBJlxu0WBR2QnSddA=
Received: by 10.141.169.9 with SMTP id w9mr5549526rvo.77.1198958711974;
        Sat, 29 Dec 2007 12:05:11 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sat, 29 Dec 2007 12:05:11 -0800 (PST)
In-Reply-To: <alpine.LFD.0.9999.0712291038560.2778@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69328>

On Dec 29, 2007 7:51 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Sat, 29 Dec 2007, Marco Costalba wrote:
> >
> > [marco@localhost linux-2.6]$ time git log --topo-order --no-color
> > --parents --boundary -z --log-size
> > --pretty=format:"%m%HX%PX%n%an<%ae>%n%at%n%s%n%b" HEAD > /dev/null
>
> Don't compare "--pretty=format" to the pre-formatted versions.
>
> Use "--pretty=raw" for "git log" if you want to approximate "git
> rev-list --header".
>

I have switched to --pretty=format instead of preformatted one to save
RAM, becuase needed memory is about 35% less with a custom format, the
preformatted ones give me additional info that is not shown on qgit so
it's just a waste.

As example a full Linux tree loaded with qgit takes less then 80MB,
with gitk as comparison we are above 400MB although of course the
optimized format is not the whole reason for this difference.

What I have seen looking expecially at the pretty.c sources with a
profiler is that the custom format is continuosly reparsed _for each
revision_ also if it never changes during the whole git-log run. This
could explain why the custom format although cheaper in terms of
quantity of outputted data is slower then a preformatted one.

A caching of the parsed custom --pretty=format at the beginning of
git-log could help...

Marco
