From: Jeff King <peff@peff.net>
Subject: Re: weird diff output?
Date: Thu, 31 Mar 2016 09:47:50 -0400
Message-ID: <20160331134750.GA29790@sigill.intra.peff.net>
References: <CA+P7+xoiFUiBwDU2Wo9nVukchBvJSknON2XN572b6rSHnOSWaQ@mail.gmail.com>
 <CAGZ79ka4ad5dQMWANJUDx-0+kV3qR=HttOJni2XfhFzjMKfcPw@mail.gmail.com>
 <xmqqzithxj8l.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZiiOgxh6vMDnaJ_b+VVGrFBfGzZukTN6OEBxUV9-2vQw@mail.gmail.com>
 <CA+P7+xoLZhKzHf6khQfT_pZ2=CQAp8Nmhc9B8+10+9=YYUZH3w@mail.gmail.com>
 <20160330045554.GA11007@sigill.intra.peff.net>
 <CA+P7+xqskf6Ti3tVwMrOAaj3EDykRLKiXG5EbbzkjRsZP0s_7w@mail.gmail.com>
 <CA+P7+xp+oT2zMBZqR8zvXKm8Zp5btaNyoOWFTts29HMwX+2o=Q@mail.gmail.com>
 <CA+P7+xrbNQqGhR_EoVe7zou_g6oVFGN_v+q+tyHguv1BCMcimQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 15:48:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alcx5-00052A-ME
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 15:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752898AbcCaNrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 09:47:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:41450 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752473AbcCaNry (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 09:47:54 -0400
Received: (qmail 18420 invoked by uid 102); 31 Mar 2016 13:47:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 09:47:52 -0400
Received: (qmail 12574 invoked by uid 107); 31 Mar 2016 13:47:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 09:47:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Mar 2016 09:47:50 -0400
Content-Disposition: inline
In-Reply-To: <CA+P7+xrbNQqGhR_EoVe7zou_g6oVFGN_v+q+tyHguv1BCMcimQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290380>

On Wed, Mar 30, 2016 at 12:31:30PM -0700, Jacob Keller wrote:

> So far I've only found a single location that ends up looking worse
> within the Linux kernel. Diffs of some Kbuild settings result in
> something like
> 
> before:
> 
>           If unsure, say Y.
> +
> +config RMI4_I2C
> +       tristate "RMI4 I2C Support"
> +       depends on RMI4_CORE && I2C
> +       help
> +         Say Y here if you want to support RMI4 devices connected to an I2C
> +         bus.
> +
> +         If unsure, say Y.
> 
> after:
> 
>           required for all RMI4 device support.
> 
> +         If unsure, say Y.
> +
> +config RMI4_I2C
> +       tristate "RMI4 I2C Support"
> +       depends on RMI4_CORE && I2C
> +       help
> +         Say Y here if you want to support RMI4 devices connected to an I2C
> +         bus.
> +
>           If unsure, say Y.
> 
> So in this particular instance which has multiple blank lines and is a
> similar issue as with Stefan's note above, this is where the heuristic
> falls apart. At least for C code this is basically vanishingly small
> compared to the number of comment header fix ups.
> 
> I think it may be that Stefan's suggestions above may be on the right
> track to resolve that too.

This is a tricky one. There _aren't_ actually multiple blank lines in
the ambiguous area, because this particular example comes at the very
end of the file. Try:

  git show 8d99758dee3 drivers/input/rmi4/Kconfig

which adds a block in the middle of the file. It looks good both before
and after running through the script. Now look at this example:

  git show fdf51604f10 drivers/input/rmi4/Kconfig

which looks like:

diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
index 5ea60e3..cc3f7c5 100644
--- a/drivers/input/rmi4/Kconfig
+++ b/drivers/input/rmi4/Kconfig
@@ -8,3 +8,12 @@ config RMI4_CORE
          required for all RMI4 device support.
 
          If unsure, say Y.
+
+config RMI4_I2C
+       tristate "RMI4 I2C Support"
+       depends on RMI4_CORE && I2C
+       help
+         Say Y here if you want to support RMI4 devices connected to an I2C
+         bus.
+
+         If unsure, say Y.


Note that there is no trailing context, as we're adding at the end of
the file. So the ambiguous portion consists of only two lines: an empty
line, and "If unsure...". And we bump the latter to the top, per the
heuristic (it's the exact opposite of every other case, where the blank
line is a true delimiter).

As a human, I think the indentation here is the real syntactic clue. But
getting into indentation heuristics is probably insane.

The script could probably make this work by disabling itself if the hunk
is at the end of the diffed file (i.e., we don't see more context lines
afterward). That covers any case like this where newline _is_ a
delimiter, but we just have some internal newlines, too. It wouldn't
cover the case where we had internal newlines but used some other
paragraph delimiter, but based on the results so far, that seems rather
rare.

Something like this:

--- foo.pl.orig	2016-03-31 09:44:44.281232230 -0400
+++ foo.pl	2016-03-31 09:44:34.901232632 -0400
@@ -24,13 +24,15 @@
       push @hunk, $_;
       $state = STATE_IN_CHUNK;
     } else {
-      flush_hunk();
+      print @hunk;
+      @hunk = ();
       $state = STATE_NONE;
       print;
     }
   }
 }
-flush_hunk();
+print @hunk;
+@hunk = ();
 
 sub flush_hunk {
   my $context_len = 0;

-Peff
