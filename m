From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make verify-tag a builtin.
Date: Fri, 27 Jul 2007 00:05:35 -0700
Message-ID: <7vr6mu2uo0.fsf@assigned-by-dhcp.cox.net>
References: <46A96F86.2030704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 09:05:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEJtX-00008K-QJ
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 09:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760416AbXG0HFh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 03:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759614AbXG0HFh
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 03:05:37 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:46346 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807AbXG0HFg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 03:05:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070727070537.BCAR1393.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 27 Jul 2007 03:05:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id UX5b1X00F1kojtg0000000; Fri, 27 Jul 2007 03:05:36 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53904>

Carlos Rica <jasampler@gmail.com> writes:

> This replaces "git-verify-tag.sh" with "builtin-verify-tag.c".

This is better overall, but you need to drop free(path) as you
are using git_mkstemp() now on a on-stack buffer.

> Signal SIGPIPE is ignored because the program sometimes was
> terminated because that signal when writing the input for gpg.

This "sometimes" does not give confidence to readers, I am
afraid.

What is happening is perfectly normal, not "sometimes it gets
the signal mysteriously, so we need to paper it over by ignoring
it".

You invoke gpg, giving it a file that is supposed to contain a
detached signature, and start feeding the payload that ought to
verify Ok with the signature.  If the tag is not signed, after
gpg has read the detached signature, it already knows that the
signature will not verify and it can exit without reading the
payload from its standard input.  When you try to write the
payload to the pipe, you would get SIGPIPE.

Anyway, I'll replace the tip of cr/tag topic with this version,
and merge it to 'next'.
