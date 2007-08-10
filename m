From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-bundle.c - use stream buffered input for rev-list
Date: Fri, 10 Aug 2007 15:58:28 -0700
Message-ID: <7vvebnq9nv.fsf@assigned-by-dhcp.cox.net>
References: <11867849893486-git-send-email-mdl123@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Sat Aug 11 00:58:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJdRO-0007sq-4I
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 00:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686AbXHJW6a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 18:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752095AbXHJW6a
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 18:58:30 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:47735 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbXHJW63 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 18:58:29 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070810225828.ZMRP2095.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Fri, 10 Aug 2007 18:58:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id aNyU1X00P1kojtg0000000; Fri, 10 Aug 2007 18:58:28 -0400
In-Reply-To: <11867849893486-git-send-email-mdl123@verizon.net> (Mark
	Levedahl's message of "Fri, 10 Aug 2007 18:29:49 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55576>

Mark Levedahl <mdl123@verizon.net> writes:

> git-bundle create on cygwin was nearly unusable due to 1 character
> at a time (unbuffered) reading from an exec'ed process.

Gaah, well spotted.  I was wondering what that 20x difference
was, but did not notice that read_string() thing.

That function is probably sometimes necessary if you are reading
from a non-seekable fd and need to stop immediately after
reading the header (so that you can hand the rest to pack
handling code), but it really should be the last-ditch thing to
read one-byte-at-a-time.

Also, I even suspect that we are always reading from a seekable
bundle file in this program and it should be able to use
buffered input with seeking back as needed after you read
enough.
