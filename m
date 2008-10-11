From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH (GITK) v2 4/4] gitk: Implement batch lookup and caching of encoding attrs.
Date: Sat, 11 Oct 2008 11:31:13 +1100
Message-ID: <18671.62417.328489.317909@cargo.ozlabs.ibm.com>
References: <1222772422-28020-1-git-send-email-angavrilov@gmail.com>
	<1222772422-28020-2-git-send-email-angavrilov@gmail.com>
	<1222772422-28020-3-git-send-email-angavrilov@gmail.com>
	<1222772422-28020-4-git-send-email-angavrilov@gmail.com>
	<1222772422-28020-5-git-send-email-angavrilov@gmail.com>
	<18671.16658.667581.499095@cargo.ozlabs.ibm.com>
	<bb6f213e0810100522v653507d6r75cc4c64b57aa459@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Johannes Sixt" <johannes.sixt@telecom.at>
To: "Alexander Gavrilov" <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 11 02:32:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoSPR-0000Z3-Jc
	for gcvg-git-2@gmane.org; Sat, 11 Oct 2008 02:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754042AbYJKAb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 20:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754005AbYJKAb3
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 20:31:29 -0400
Received: from ozlabs.org ([203.10.76.45]:38961 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753942AbYJKAb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 20:31:28 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 60ADCDE1D1; Sat, 11 Oct 2008 11:31:27 +1100 (EST)
In-Reply-To: <bb6f213e0810100522v653507d6r75cc4c64b57aa459@mail.gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97959>

Alexander Gavrilov writes:

> OS-enforced command-line size limit on Windows is 32K. Cramming in
> 1000 paths would leave only 32 characters for each path.

Eeek.  OK.

> > Also, I wonder why we now have two levels of caching of the encoding
> > attribute.  Your patch 1/4 introduced path_encoding_cache, which was
> > fine, but now we have path_attr_cache as well, which seems to me to
> > serve exactly the same function since the encoding is the only
> > attribute we ever ask about.  Surely we don't need both caches?
> 
> If the (git-gui) patch that reimplements the tcl_encoding procedure is
> applied, we may drop the path_encoding_cache. Current implementation
> is too slow for batch lookup, especially if the encoding is actually
> not supported, and without the cache the lookup would be done on every
> loading of a diff.

I was thinking more in terms of dropping the path_attr_cache actually.

Actually, if [tcl_encoding] is slow, then why is $gui_encoding the
untranslated version, so that we do [tcl_encoding $gui_encoding] on
each call to get_path_encoding?  Why don't we do the tcl_encoding call
once and have $gui_encoding be the result of that?  In fact
$gui_encoding should be the result of this code (from
get_path_encoding):

	set tcl_enc [tcl_encoding $gui_encoding]
	if {$tcl_enc eq {}} {
		set tcl_enc [encoding system]
	}

And if [tcl_encoding] is slow, then it should have a cache.  There's
only likely to be at most 2 or 3 values it gets called for, and it's
a constant function.

At this point, what I think I might do is apply your set of patches
(but with 2/4 and 3/4 folded into a single patch) and then go through
and do another commit that addresses the concerns I've raised.  OK?

Paul.
