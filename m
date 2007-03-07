From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: Re: pcre performance, was Re: git log filtering
Date: Wed, 07 Mar 2007 19:03:32 +0100
Message-ID: <45EEFE74.1090309@lu.unisi.ch>
References: <68948ca0702070841m76817d9el7ce2ec69835c50e@mail.gmail.com> <Pine.LNX.4.64.0702070856190.8424@woody.linux-foundation.org> <Pine.LNX.4.63.0702071822430.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7v64ad7l12.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071257490.8424@woody.linux-foundation.org> <7vps8l65fh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071334060.8424@woody.linux-foundation.org> <20070208061654.GA8813@coredump.intra.peff.net> <Pine.LNX.4.63.0703071807250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 07 19:06:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HP0Wc-0004Ts-S1
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 19:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422973AbXCGSDy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 7 Mar 2007 13:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422972AbXCGSDx
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 13:03:53 -0500
Received: from server.usilu.net ([195.176.178.200]:54557 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1422982AbXCGSDm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 13:03:42 -0500
Received: from [1.240.182.245] ([213.140.22.65] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 7 Mar 2007 19:03:38 +0100
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <Pine.LNX.4.63.0703071807250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-OriginalArrivalTime: 07 Mar 2007 18:03:38.0309 (UTC) FILETIME=[EE785F50:01C760E2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41685>


> Result: external grep wins hands-down. GNU regex loses hands-down. pc=
re=20
> seems to be better than glibc's regex engine, and gains ever so sligh=
tly=20
> when using NO_MMAP.

Indeed GNU regex 0.12 loses, and that's why it was rewritten for (IIRC)
glibc 2.3.  Older glibc's use code derived from GNU regex 0.12; but the
old GNU regex code is dead in general (maybe it survives in Emacs -- bu=
t
I don't remember), and the glibc regex code can be used by external
programs via gnulib.

glibc is slower than PCRE mostly because it is internationalized.  So
for example it supports things like stra[.ss.]e matching both strasse
and stra=DFe in a German locale, or [[=3Da=3D]] matching a=E0=E1=E4=E2 =
and possibly
more variations.  In theory.  In practice I couldn't make it work
while writing this message...

External grep wins hands-down because it's a DFA engine.  If the regex
uses backreferences (or the above esoteric constructs), however, extern=
al
grep will not be able to give a definite answer using the fast engine,
and will fall back to glibc regex.

Paolo
