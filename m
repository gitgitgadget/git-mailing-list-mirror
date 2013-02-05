From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH] Add contrib/credentials/netrc with GPG support, try #2
Date: Tue, 05 Feb 2013 08:39:40 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87sj5ariar.fsf@lifelogs.com>
References: <87ehgvua6h.fsf@lifelogs.com>
	<20130204211726.GB13186@sigill.intra.peff.net>
	<87mwvjsqjc.fsf_-_@lifelogs.com>
	<7vd2wf1yex.fsf@alter.siamese.dyndns.org>
	<87bobzslke.fsf@lifelogs.com>
	<7vy5f3zlzj.fsf@alter.siamese.dyndns.org>
	<87zjzjr5y4.fsf@lifelogs.com>
	<7vmwvjzkcs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 14:40:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2ikt-0001Aq-MY
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 14:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755409Ab3BENjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 08:39:44 -0500
Received: from z.lifelogs.com ([173.255.230.239]:41680 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755395Ab3BENjm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 08:39:42 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id 2831DDE0E0;
	Tue,  5 Feb 2013 13:39:41 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <7vmwvjzkcs.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 04 Feb 2013 16:15:47 -0800")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215501>

On Mon, 04 Feb 2013 16:15:47 -0800 Junio C Hamano <gitster@pobox.com> wrote: 

JCH> Ted Zlatanov <tzz@lifelogs.com> writes:

>> - do you want to support backslashed newlines?

JCH> What for?  netrc/authinfo is not a line oriented file format at all,
JCH> and

JCH> 	machine k.org
JCH> 	        	login me
JCH>                         password mysecret

JCH> is a single entry; you do not need backslash at the end of any line.

Hmm. The parser I implemented only does single-line parsing, and I
misunderstood the format to be single-line (partly because I have never
seen anyone using the multi-line format you show).  Looking at
Net::Netrc more carefully, it seems that the "machine" token is what
defines an entry, so a new entry starts with a new line that contains a
"machine" token.  Is that acceptable and does it match your
understanding of the format?  It matches Net::Netrc, at least.

I'll add this change to PATCHv4 with the assumption you agree.

>> - should all die() calls just print to STDERR and exit(0)?

JCH> Where "when unhandled, the helper should silently exit with 0" is
JCH> expected by the invoker, we shouldn't say anything to error stream,
JCH> and exit with zero.  Please leave a comment to make it easy to
JCH> understand to the readers that is what is going on there.

JCH> If on the other hand it diagnosed an error (not a bug in the
JCH> implementation but a misconfiguration on the user's side), I _think_
JCH> it should loudly die() so that the user can notice and take
JCH> corrective action.

OK, I'll review these for PATCHv4 (also see below).  Thanks.

>> - do you want to support multiple netrc files, as you and Peff suggested?

JCH> I didn't even suggest such thing IIRC---I expected it to iterate
JCH> from the most desirable (.authinfo.gpg) to the least (.netrc) and
JCH> stop at the first found one.  There may be use cases people use more
JCH> than one and expect an entry to be found in any file, but I suspect
JCH> that might be more confusing than it is worth.  But I do not care
JCH> very deeply myself either way.

After thinking about it, I agree with Peff multiple sources make sense
and will simplify the code flow (especially the default case, which
won't need to be handled separately).  And the functionality doesn't
have to be confusing with the right debugging messages.  So I'll add
them in PATCHv4.

The debugging messages will be fewer and simpler with this approach,
which makes it feel like the right track :)

Thanks
Ted
