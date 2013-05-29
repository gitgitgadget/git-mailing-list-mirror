From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] cherry-pick: add support to copy notes
Date: Tue, 28 May 2013 21:46:07 -0500
Message-ID: <51a56bef1b9c2_807b33e1899991@nysa.mail>
References: <1369745947-19416-1-git-send-email-felipe.contreras@gmail.com>
 <1369745947-19416-2-git-send-email-felipe.contreras@gmail.com>
 <7vobbv119k.fsf@alter.siamese.dyndns.org>
 <87mwrfx9ug.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Thomas Rast <trast@inf.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 04:49:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhWRe-0005Os-OF
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 04:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759434Ab3E2Csy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 22:48:54 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:39798 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759366Ab3E2Csx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 22:48:53 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so6770554obc.34
        for <git@vger.kernel.org>; Tue, 28 May 2013 19:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=khYdF8fGl3gPp/6eg5cW+ti+6YEN9WHOKBWyDykUkh4=;
        b=lgbJIzyh8sdJJd8DVd/uwF+q6a+fgYVhDZ+WxNs+8v1ns18hPQ0DT6U00Ha2Kox3Nj
         KmRTIBO7OebKmK3T4tzwGG7zglJ+3qsx5zE8pBMMsvnNUlXi34u0pvG4DEVDMS2Fv2La
         3peWAY1us6nuESsjijnxGQnYxfSbChbT3rH03+Tft7sRXtnI0gHBDv7mud5/xokAGnm2
         U7m0Zr29mgT/qEkhHzw5GiN0FaWQK18uPN6VuNh7GnhdKkt5WIdeIqwj48yja0TlofDS
         jbAada6f9ImoL3S1GVv0A2xTions1iaa1nWtkfHnw+1skuYoEbR51HpM8Ic1gHDkXW5r
         ihBw==
X-Received: by 10.182.224.162 with SMTP id rd2mr347475obc.95.1369795733218;
        Tue, 28 May 2013 19:48:53 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id eq4sm38064698obb.5.2013.05.28.19.48.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 19:48:52 -0700 (PDT)
In-Reply-To: <87mwrfx9ug.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225703>

Thomas Rast wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Thomas Rast Cc'ed as he has been the primary force behind this line
> > of "notes" usability.
> 
> Thanks for pointing this out to me.
> 
> > Felipe Contreras <felipe.contreras@gmail.com> writes:
> >
> >> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> >> ---
> >>  builtin/revert.c  |   2 +
> >>  sequencer.c       | 136 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
> >>  sequencer.h       |   2 +
> >>  t/t3500-cherry.sh |  32 +++++++++++++
> >>  4 files changed, 169 insertions(+), 3 deletions(-)
> >
> > "git cherry-pick" should help maintaining notes just like amend and
> > rebase, but how should this interact with notes.rewrite.<command>,
> > where the command is capable of doing this without an explicit
> > option once you tell which notes need to be maintained?
> 
> Since we already have the notes.rewrite.<command> convention, it would
> seem the obvious choice to line it up with the others.  The main
> bikeshedding opportunity is whether this should be an exception and
> default to false (all other commands default it to true).
> 
> Also: how does this interact with notes.rewriteRef and the corresponding
> env vars?  Why?
> 
> How does it interact with 'cherry-pick -n' if this is done in sequence,
> effectively squashing several commits (this use-case is actually
> suggested by the manpage), if multiple source commits had notes?  Should
> it respect notes.rewriteMode (and by default concatenate)?  (I don't
> know if the sequencer state is expressive enough already to carry this
> in a meaningful way across cherry-pick commands.)

Feel free to implement that. I'm just interested in 'git cherry-pick' being
usable for 'git rebase' purposes.

-- 
Felipe Contreras
