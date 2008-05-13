From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] builtin-apply: check for empty files when detecting
 creation patch
Date: Tue, 13 May 2008 15:58:44 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805131552410.3019@woody.linux-foundation.org>
References: <1210257579-30975-1-git-send-email-imre.deak@gmail.com> <7vlk2h8t4d.fsf@gitster.siamese.dyndns.org> <500f3d130805131316m59898392l46e0dbf7cb352981@mail.gmail.com> <7vprrpswof.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0805131514300.3019@woody.linux-foundation.org>
 <7vlk2dsujm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Imre Deak <imre.deak@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 14 01:00:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw3TC-0002ac-UG
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 00:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755271AbYEMW6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 18:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755513AbYEMW6w
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 18:58:52 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55165 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754906AbYEMW6w (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 May 2008 18:58:52 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4DMwjpE009690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 13 May 2008 15:58:47 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4DMwi3K004027;
	Tue, 13 May 2008 15:58:45 -0700
In-Reply-To: <7vlk2dsujm.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-5.417 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82052>



On Tue, 13 May 2008, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> >
> > So non-/dev/null'ness means absolutely nothing. It means "don't know", and 
> > we should leave is_new and is_delete as -1.
> 
> Ok, then what's the judgement for the original issue?  Is it a user error
> to have a tracked absolutely empty file in the index?

I think this is the fundamental problem:

	..
	if (patch->is_new < 0 && !oldlines) {
		patch->is_new = 1;
	..

because that logic simply isn't right. (is_new < 0 && !oldlines) does 
*not* mean that it must be new.

We can say it the other way around, of course:

	if (patch->is_new < 0 && oldlines)
		patch->is_new = 0;

and that's a valid rule, but I think we already would never set "is_new" 
to -1 if we had old lines, so that would probably be a pointless thing to 
do.

So: remove the check for (is_new < 0 && !oldlines) because it doesn't 
actually add any information, and leave "is_new" as unknown until later 
when we actually *see* that file or not. Hmm?

		Linus
