From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-daemon: Simplify child management and associated
 logging by
Date: Tue, 12 Aug 2008 15:05:08 -0700
Message-ID: <7vzlnhq48b.fsf@gitster.siamese.dyndns.org>
References: <20080812193613.32388.92145.stgit@aristoteles.cuci.nl>
 <20080812212534.6871.19377.stgit@aristoteles.cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed Aug 13 00:06:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT20h-00078f-T7
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 00:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832AbYHLWFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 18:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753777AbYHLWFS
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 18:05:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59447 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717AbYHLWFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 18:05:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D1AC35635D;
	Tue, 12 Aug 2008 18:05:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 381045635C; Tue, 12 Aug 2008 18:05:12 -0400 (EDT)
In-Reply-To: <20080812212534.6871.19377.stgit@aristoteles.cuci.nl> (Stephen
 R. van den Berg's message of "Tue, 12 Aug 2008 23:25:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BDCC3408-68BA-11DD-BA3B-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92146>

"Stephen R. van den Berg" <srb@cuci.nl> writes:

> making the signal handler almost a no-op.
> Fix the killing code to actually be smart instead of the
> pseudo-random mess.
> Get rid of the silly fixed array of children and make
> max-connections dynamic and configurable in the process.
> Make git-daemon a proper syslogging citizen with PID-info.
> Simplify the overzealous double buffering in the logroutine,
> remove the artificial maximum logline length in the process.
>
> Signed-off-by: Stephen R. van den Berg <srb@cuci.nl>

Sorry, but this does too many things in one patch.

 - Taking advantage of poll() getting interrupted by SIGCHLD, so that you
   do not have to do anything in the signal handler, is so obvious that I
   am actually ashamed of not having to think of it the last time we
   touched this code.  Is there a poll() that does not return EINTR but
   just call the handler and restart after that as if nothing has
   happened, I have to wonder...

 - Conversion from silly fixed array to dynamic and configurable maximum
   would be a good idea, but that is independent from the above, isn't it?

 - I see you have a call to vsyslog, which is the first user of the
   function.  How portable is it (the patch coming from you, I know
   Solaris would have it, and recent 4BSD also would, but what about the
   others)?
