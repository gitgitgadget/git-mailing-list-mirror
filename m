From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] push: Correctly initialize nonfastforward in do_push.
Date: Wed, 16 Sep 2009 19:26:08 +0200
Message-ID: <vpqfxamby33.fsf@bauges.imag.fr>
References: <1253119020-26547-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vpr9q24oa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 19:29:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnyJi-0005XK-0Q
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 19:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758843AbZIPR3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 13:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758651AbZIPR3H
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 13:29:07 -0400
Received: from imag.imag.fr ([129.88.30.1]:43398 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754635AbZIPR3G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 13:29:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n8GHQ8GQ017272
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 16 Sep 2009 19:26:09 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MnyGe-0003NF-N1; Wed, 16 Sep 2009 19:26:08 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MnyGe-00088m-Lf; Wed, 16 Sep 2009 19:26:08 +0200
In-Reply-To: <7vpr9q24oa.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 16 Sep 2009 10\:13\:57 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 16 Sep 2009 19:26:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128668>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> The variable is assigned unconditionally in print_push_status, but
>> print_push_status is not reached by all codepaths. In particular, this
>> fixes a bug where "git push ... nonexisting-branch" was complaining about
>> non-fast forward.
>
> Hmm, the patch looks correct but I am scratching my head to see how this
> is triggered.  "git push ... nonexisting-branch" seems to get:

Short answer: trust me, without the patch, you get the non-fast
forward (and valgrind tells you about conditional jump on
uninitialized value), with, you don't ;-).

Longer one:

int transport_push(struct transport *transport,
		   int refspec_nr, const char **refspec, int flags,
		   int * nonfastforward)
{
[...]
		if (match_refs(local_refs, &remote_refs,
			       refspec_nr, refspec, match_flags)) {
			return -1; /* <------------------------------ you stop here */
		}
[...]
		if (!quiet || push_had_errors(remote_refs))
			print_push_status(transport->url, remote_refs,
					verbose | porcelain, porcelain,
					nonfastforward); /* <----- you would have updated nonfastforward there */
[...]
}

Actually, my initial version probably had the condition of the second
if too. And with the first "return" statement in transport_push.
Writting this, I'm wondering if it wouldn't be a better coding style
to initialize nonfastforward to 0 within transport_push (in case other
callers to transport_push appear one day, they won't get the the same
bug). Second version of the patch is comming.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
