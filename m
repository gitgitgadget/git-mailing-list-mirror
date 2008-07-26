From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] custom strategies in builtin-merge
Date: Fri, 25 Jul 2008 18:12:17 -0700
Message-ID: <7vvdyto3da.fsf@gitster.siamese.dyndns.org>
References: <20080725113316.GF32057@genesis.frugalware.org>
 <bd6139dc0807250450m25a932b8h68fcee13f8c343dc@mail.gmail.com>
 <7viqutpjqq.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807260250480.11976@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sverre@rabbelier.nl, Miklos Vajna <vmiklos@frugalware.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 26 03:17:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMYPO-0002Oe-6f
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 03:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbYGZBMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 21:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbYGZBMZ
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 21:12:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57833 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbYGZBMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 21:12:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C6A6C36F77;
	Fri, 25 Jul 2008 21:12:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1972736F75; Fri, 25 Jul 2008 21:12:18 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807260250480.11976@eeepc-johanness> (Johannes
 Schindelin's message of "Sat, 26 Jul 2008 02:51:41 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E757402E-5AAF-11DD-8687-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90144>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> ... especially since I hope that we have them builtin soon, and not only 
> that, but have builtin-merge call them as C functions, not with fork() and 
> exec().

Because builtin-merge.c does not directly use fork/exec but uses
run_command() interface, non POSIX platforms can spawn subprocesses just
fine, can't they?

I do not think at this point it is of any high priority to call strategies
internally, avoiding fork/exec.  We may apply hundreds of patches per
minute, but would fork/exec overhead matter for merges?

Especially because some strategies (recursive and perhaps the rumored
"blame" even more so) are quite data intensive operations, libifying them
is not worth it, compared to the nice isolation between processes we get
from running them as a separate program.  We get the necessary clean-up
after strategy did its thing for almost free (well, "at the cost of
fork/exec").
