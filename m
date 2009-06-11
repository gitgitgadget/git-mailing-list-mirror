From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [RF sanity check] send-email threading fixes
Date: Fri, 12 Jun 2009 00:49:01 +0200
Message-ID: <200906120049.02368.markus.heidelberg@web.de>
References: <1244410857-920-1-git-send-email-markus.heidelberg@web.de> <200906111849.40232.markus.heidelberg@web.de> <7vprdah5es.fsf@alter.siamese.dyndns.org>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 00:48:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEt4l-00017T-Et
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 00:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758523AbZFKWsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 18:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758212AbZFKWsm
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 18:48:42 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:59886 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758019AbZFKWsl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 18:48:41 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 229B61052646C;
	Fri, 12 Jun 2009 00:48:43 +0200 (CEST)
Received: from [89.59.73.219] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MEt4c-0005EQ-00; Fri, 12 Jun 2009 00:48:43 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <7vprdah5es.fsf@alter.siamese.dyndns.org>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19ehvYkv8U61Sn3D+goJXasyUnETArWV3zhqOQy
	cpx28LeyCE9HCIzT6LldN/bvITzkbkq/aDyPNexINXQkUfMNXs
	ARjgkiUhqiutKA4Tx5TQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121371>

Junio C Hamano, 11.06.2009:
> Markus Heidelberg <markus.heidelberg@web.de> writes:
> 
> >> [PATCH 4/6] send-email: fix threaded mails without chain-reply-to
> >> [PATCH 5/6] add a test for git-send-email for threaded mails without chain-reply-to
> >> [PATCH 6/6] send-email: fix a typo in a comment
> >> 
> >> Patch 4/6 applies on top of 15da108 to fix a breakage introduced by that
> >> commit.  Together with the result of applying the first three patches to
> >> maint, they fix --no-thread and --thread (without --chain-reply-to) cases.
> >> The result can be verified by applying Patch 5/6 on top of them.
> >
> > Out of curiosity: why are 4/6 and 5/6 applied on different branches
> > without the usual commits first "test with test_expect_fail" then "fix +
> > test changed to test_expect_success"?
> 
> Maybe I misunderstood your problem description, but my impression from it
> was that 4/6 is a fix to a latent bug in 15da108

Right, ...

> that later affected what

... but the bug was immediately noticable.

> was done by new code that appeard somewhere between 15da108 and 'master',

The other regression from 3e0c4ff appeared before 15da108, not after it.
This regression was immediately noticable as well.

> and the test 5/6 was about that breakage.

No, 5/6 was only about the breakage in 15da108 fixed by 4/6. I noticed
the regression in 3e0c4ff after it.

> IOW, root cause was older than
> the symptom.

Since it's a bit confusing, I'll try to clarify:

* 3e0c4ff (2009-03-01) broke non-threaded
  This sent threaded mails instead of non-threaded:
    $ git send-email --no-thread --no-chain-reply-to
    $ git send-email --no-thread --chain-reply-to
* 1/6 tests this
* 2/6 fixes this

* 15da108 (2009-04-13) broke threaded without chain-reply
  This sent non-threaded mails instead of threaded:
    $ git send-email --thread --no-chain-reply-to
  This correctly sent threaded mails:
    $ git send-email --thread --chain-reply-to
* 4/6 fixes this
* 5/6 tests this
* 15da108 additionally changed another behaviour
  (this is the side effect from the 2/6 description, which is
   anticipating in view of the reordered patch sequence):
  This now sent non-threaded mails again, which has been broken by 3e0c4ff:
    $ git send-email --no-thread --no-chain-reply-to
  This still sent threaded mails instead of non-threaded, it was still
  broken since 3e0c4ff:
    $ git send-email --no-thread --chain-reply-to

HTH and I got everything explained correctly.
