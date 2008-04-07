From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] log and rev-list: Fixed newline termination issues
 with --graph
Date: Mon, 07 Apr 2008 01:52:40 -0700
Message-ID: <7vwsnaoxlz.fsf@gitster.siamese.dyndns.org>
References: <1207518444-5955-1-git-send-email-adam@adamsimpkins.net>
 <1207555281-9362-1-git-send-email-adam@adamsimpkins.net>
 <1207555281-9362-2-git-send-email-adam@adamsimpkins.net>
 <7vod8mqdlw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Mon Apr 07 10:53:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jin6Z-0006ix-Lw
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 10:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430AbYDGIwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 04:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755428AbYDGIwr
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 04:52:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50747 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755163AbYDGIwr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 04:52:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 921F76B2B;
	Mon,  7 Apr 2008 04:52:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C8A976B2A; Mon,  7 Apr 2008 04:52:42 -0400 (EDT)
In-Reply-To: <7vod8mqdlw.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 07 Apr 2008 01:21:47 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78965>

Junio C Hamano <gitster@pobox.com> writes:

> I suspect that --pretty=format: (i.e. userformat) should have a way to
> explicitly tell which is wanted.  Perhaps we can keep the separator
> semantics not to break existing users, and introduce a dummy expand item
> (say, '%_') and when it appears in the pattern it would ask for the
> terminator semantics instead?
>
> In any case, I'm happy to see that somebody started looking into this, as
> this "separator vs terminator" issue in userformat has been nagging me for
> quite a while.  It might be good idea to have the change independently
> from the graph extension first and then build the graph stuff on top of
> the solidified base.  I dunno...

Some alternatives to specify terminator semantics I considered are:

 (1) Presence of %_ in "--pretty=format:..." triggers terminator
     semantics and %_ itself interpolates an empty string; otherwise
     separator semantics is used.

 (2) Presence of %n in "--pretty=format:..." means a multi-line output and
     uses separator as before; lack of %n means it is a one-line format
     and uses terminator.

 (3) A new option --pretty=tformat:... (i.e. tformat instead of format)
     means LF (or NUL) is used as terminator instead of separator;

 (4) A new syntax --pretty=format/... (i.e. slash instead of the usual
     colon) means LF (or NUL) is used as terminator instead of separator;

The first one is what I suggested in the message, but it feels somewhat
hacky.  I suspect that the second one would catch 99% of the cases, but it
is DWIM and it is known that DWIM can go wrong.  I favor design along
the lines of (3) or (4), which I think would be much cleaner.

I however do not particularly like either "tformat" which is a non-word,
nor ":" vs "/" whose differences do not intuitively translate to
"separator vs terminator" distinction.
