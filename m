From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/5 v2] unpack_trees: group errors by type
Date: Tue, 15 Jun 2010 15:28:43 +0200
Message-ID: <vpq7hm0whkk.fsf@bauges.imag.fr>
References: <1276604576-28092-1-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276604576-28092-2-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276604576-28092-3-git-send-email-diane.gasselin@ensimag.imag.fr>
	<vpqljagzc39.fsf@bauges.imag.fr>
	<AANLkTin381eyaDabz3-z_8jB05N4CVKGmLOqVOprJMW2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 15 15:28:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOWCB-0006Ds-N6
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 15:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757116Ab0FON2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 09:28:47 -0400
Received: from mx2.imag.fr ([129.88.30.17]:39031 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756955Ab0FON2q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 09:28:46 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o5FDKeVC006821
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 15 Jun 2010 15:20:40 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OOWC3-00040Z-NA; Tue, 15 Jun 2010 15:28:43 +0200
In-Reply-To: <AANLkTin381eyaDabz3-z_8jB05N4CVKGmLOqVOprJMW2@mail.gmail.com> (Diane Gasselin's message of "Tue\, 15 Jun 2010 15\:15\:36 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 15 Jun 2010 15:20:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5FDKeVC006821
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1277212841.32771@riurarg77JS6SQj8HwOavA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149185>

Diane Gasselin <diane.gasselin@ensimag.imag.fr> writes:

> In display_error_msgs(), I cannot access o->msg because I would not
> know which error I am treating.

You do:

static void display_error_msgs(struct unpack_trees_options *o)
{
...
	for (i = 0; i < NB_UNPACK_TREES_ERROR; i++) {
		...
	}

You know "i", so you know which error it is. The difficulty is that
the rejected paths are in an array, while the error messages are in a
struct, but you can either:

* Turn the struct into an array, and say msgs[would_overwrite] instead
  of msgs.would_overwrite (which would also simplify the code
  elsewhere since you would be able to write "ERRORMSG(o, error)" and
  such things).

* Do

switch (i) {
case would_overwrite:
	msg = o->msg.would_overwrite;
	break;
case not_uptodate_file:
	msg = o->msg.not_uptodate_file;
	break;
case not_uptodate_dir:
	msg = o->msg.not_uptodate_dir;
	break;
case would_lose_untracked_overwritten:
	msg = o->msg.would_lose_untracked_overwritten;
	break;
case would_lose_untracked_removed:
	msg = o->msg.would_lose_untracked_removed;
	break;
case sparse_not_uptodate_file:
	msg = o->msg.sparse_not_uptodate_file;
	break;
}

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
