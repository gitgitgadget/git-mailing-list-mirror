From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Autoconf: Disable inline for compilers that don't
 support it.
Date: Sun, 15 Mar 2009 12:52:54 -0700
Message-ID: <7vab7m7ecp.fsf@gitster.siamese.dyndns.org>
References: <20090114223832.GC30710@genesis.frugalware.org>
 <20090314010421.GA6642@linux.vnet>
 <7vy6v7al37.fsf@gitster.siamese.dyndns.org>
 <20090315152127.GA7988@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Allan Caffee <allan.caffee@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 20:55:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiwQg-0000aa-LR
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 20:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756957AbZCOTxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2009 15:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755776AbZCOTxE
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Mar 2009 15:53:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56361 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754162AbZCOTxB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2009 15:53:01 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7844EA29A0;
	Sun, 15 Mar 2009 15:52:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 285BCA299D; Sun,
 15 Mar 2009 15:52:55 -0400 (EDT)
In-Reply-To: <20090315152127.GA7988@linux.vnet> (Allan Caffee's message of
 "Sun, 15 Mar 2009 11:21:27 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E2B4956A-119A-11DE-88D8-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113296>

Allan Caffee <allan.caffee@gmail.com> writes:

> My mistake; it looks like this macro will only work the way I described
> when using a config.h, which I see git is not currently doing.  I
> assumed that it would also provide a -D flag to the precompiler if a
> configuration header isn't used but this doesn't appear to be case (from
> a cursory glance at the macros definition).

The design of our Makefile is such that it will default to some reasonable
values for the make variables depending on the environment, and people who
do not want to use the configure script can override them by creating
custom entries in config.mak manually, which is included by the Makefile.

OPTIONALLY configure can be used to produce config.mak.autogen that is
included just before config.mak is included (so that misdetection by
configure script can be overridden away by config.mak), so the same kind
of overriding happens.

I suspect addition of config.h, unless done carefully, will close the door
to the people who do not use configure to get certain customizations, and
when the same carefulness is applied, we probably do no need to introduce
config.h.

For example, for -Dinline=__inline__, I think you can:

 (1) Add something like this near the beginning of the Makefile:

     # Define USE_THIS_INLINE=__inline__ if your compiler does not
     # understand "inline", but does understand __inline__.
     #
     # Define NO_INLINE=UnfortunatelyYes if your compiler does not
     # understand "inline" at all.

 (2) Add something like this after include "config.mak" happens in the
     Makefile:

     ifdef USE_THIS_INLINE
         BASIC_CFLAGS += -Dinline=$(USE_THIS_INLINE)
     else
         ifdef NO_INLINE
             BASIC_CFLAGS += -Dinline=""
	 endif
     endif

 (3) Add your new logic to configure.ac, _and_ arrange it to substitute
     USE_THIS_INLINE if ac_cv_c_inline is not "inline", and set NO_INLINE
     if it detected that the compiler does not understand inline in any
     shape or form.  You would need two new entries in config.mak.in, I
     think.
