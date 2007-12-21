From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-commit: add --verbatim to allow unstripped commit
 messages
Date: Thu, 20 Dec 2007 16:03:26 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712201555570.21557@woody.linux-foundation.org>
References: <20071220211835.GA3052@steel.home> <alpine.LFD.0.9999.0712201324270.21557@woody.linux-foundation.org> <7vlk7plydv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 01:04:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5VNY-0006de-D6
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 01:04:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754261AbXLUAER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 19:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754245AbXLUAER
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 19:04:17 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52484 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754155AbXLUAEQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Dec 2007 19:04:16 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBL03QCI028328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 20 Dec 2007 16:03:27 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBL03QdT020078;
	Thu, 20 Dec 2007 16:03:26 -0800
In-Reply-To: <7vlk7plydv.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-4.713 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69031>



On Thu, 20 Dec 2007, Junio C Hamano wrote:
> 
> But I wonder if people are using a workflow like this:
> 
> 	$ cp $company_template my_message
>         $ edit my_message
>         $ git commit -F my_message

Yes. See the email I just sent to Alex.

I think that the above kind of workflow is trivial to support with the 
"new" semantics (ie the patch under discussion), by just rewriting that 
last step as

	$ git stripspace -s < my_message | git-commit -F -

so in that sense, we don't really "lose" anything, although I do agree 
that backwards compatibility (in case somebody actually does this!) 
suffers.

But for the case of actually using the built-in editing capability, we 
don't have that choice, so I'd argue that regardless, we should make the 
"--verbatim" switch be a three-way choice between (a) not touching things 
at all, (b) touching up just whitespace, or (c) doing the full enchilada.

And if we introduce such a flag, then I think we can make the *default* 
(in the absense of an explicit flag) be something like

	if (no_edit)
		default = touch_up_just_whitespace;
	else
		default = whole_enchilada

and obviously it could also be a configuration option.

That way, you could always get the existing behaviour with

	git commit --verbatim=full-enchilada -F my_message

(yeah, bad name - I'm not seriously suggesting it be called 
"full-enchilada", and I'm also not sure the flag should be called 
"--verbatim" any more if it has choices, it's more likely that we should 
call it something like "--cleanup={verbatim,whitespace,strip}" or 
something like that.

			Linus
