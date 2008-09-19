From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 3/4] diff.*.xfuncname which uses "extended" regex's for
 hunk header selection
Date: Fri, 19 Sep 2008 13:14:51 -0500
Message-ID: <UnIVj68wrBMolSCdIK6HiPbWuYW_tHaOLLRXg8Om13cHwLqzQ8QNNw@cipher.nrlssc.navy.mil>
References: <7v3ak06jzj.fsf@gitster.siamese.dyndns.org> <wgfIh_UVzwhXaVTN46Io8UDAq72MVwOkk7CobrAvp0330VRzwT2fuA@cipher.nrlssc.navy.mil> <7vd4j212gb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Arjen Laarhoven <arjen@yaph.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 19 20:16:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgkWt-0003EZ-6e
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 20:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbYISSPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 14:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbYISSPX
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 14:15:23 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:39602 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbYISSPX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 14:15:23 -0400
Received: by mail.nrlssc.navy.mil id m8JIEpLJ023022; Fri, 19 Sep 2008 13:14:51 -0500
In-Reply-To: <7vd4j212gb.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 19 Sep 2008 18:14:51.0598 (UTC) FILETIME=[9BEF9EE0:01C91A83]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96306>

Junio C Hamano wrote:

> I personally think it was a mistake that the loop returns failure when
> there is any pattern that does not match (it is a useful feature that a
> match with a negated one forces an early return, though).
> 
> We may want to fix the semantics to be something like:
> 
> 	for (i = 0; i < regs->nr; i++) {
>         	struct ff_reg *reg = &regs->array[i];
>                 if (!regexec(&reg->re, line_buffer, 2, pmatch, 0)) {
> 			if (reg->negate) {
> 	                	free(line_buffer);
> 	                	return -1;
> 			}
>                         break;
> 		}
> 	}
>         if (regs->nr <= i) {
>         	free(line_buffer);
> 		return -1;
> 	}
> 	... use pmatch() ...
> 
> I.e. (1) negative match forces an early return (useful for catching
> language keywords), (2) first positive match is used, and (3) no match is
> a failure.
> 
> Of course, by definition the above "fix" changes the semantics, and will
> break people's existing setup if somebody has an existing custom pattern
> string that does use more than one positive regexp anded together with
> "\n", but I somehow suspect nobody sane depends on the current broken
> semantics.
> 
> It would help making JdS's ObjC alternates easier to write.  You can say:
> 
> 
> 	/* A or B */
> 	"...(A|B)$"
>         "\n" /* or C or D */
>         "...(C|D)$"
> 
> and both captures around A|B and C|D would be saved in $1.

Just to let you know another pair of eyes has given the above a
once over, I agree with your proposal. "or" semantics makes more sense
than "and".

-brandon
