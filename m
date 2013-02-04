From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH] Add contrib/credentials/netrc with GPG support, try #2
Date: Mon, 04 Feb 2013 18:42:05 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <877gmnsl2q.fsf@lifelogs.com>
References: <87ehgvua6h.fsf@lifelogs.com>
	<20130204211726.GB13186@sigill.intra.peff.net>
	<87mwvjsqjc.fsf_-_@lifelogs.com>
	<7vd2wf1yex.fsf@alter.siamese.dyndns.org>
	<20130204232317.GA17705@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 05 00:42:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2VgJ-0004Lk-HK
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 00:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755984Ab3BDXmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 18:42:10 -0500
Received: from z.lifelogs.com ([173.255.230.239]:59742 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755297Ab3BDXmH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 18:42:07 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id B8975DE0E0;
	Mon,  4 Feb 2013 23:42:06 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <20130204232317.GA17705@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 4 Feb 2013 18:23:17 -0500")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215434>

On Mon, 4 Feb 2013 18:23:17 -0500 Jeff King <peff@peff.net> wrote: 

>> Perhaps "-r $file", if you say "is not accessible"?

JK> Even better: look at whether opening the file was successful. Though I
JK> guess that is complicated by the use of gpg, who will probably not
JK> distinguish ENOENT from other failures for us.

Yup.  I think the outcome for the user will be the same, so this is
mostly for debugging, right?  And we do look at the outcome of opening
the file, and die if that failed (which would change if your suggestion
below is implemented).

JK> I was trying not to be too nit-picky with my review, but here is how I
JK> would have written the outer logic of the script:

JK>   my $tokens = read_credential_data_from_stdin();
JK>   if ($options{file}) {
JK>           my @entries = load_netrc($options{file})
JK>                   or die "unable to open $options{file}: $!";
JK>           check_netrc($tokens, @entries);
JK>   }
JK>   else {
JK>           foreach my $ext ('.gpg', '') {
JK>                   foreach my $base (qw(authinfo netrc)) {
JK>                           my @entries = load_netrc("$base$ext")
JK>                                   or next;
JK>                           if (check_netrc($tokens, @entries)) {
JK>                                   last;
JK>                           }
JK>                   }
JK>           }
JK>   }

JK> I.e., to fail on "-f", but otherwise treat unreadable auto-selected
JK> files as a no-op, for whatever reason.

JK> I'd also consider checking all files if they are available, in case
JK> the user has multiple (e.g., they keep low-quality junk unencrypted
JK> but some high-security passwords in a .gpg file). Not that likely,
JK> but not any harder to implement.

I think that makes everything more complicated, and the user can name a
specific netrc file in the helper spec if he wants it.  It's too
automagic for me.  But if you and Junio feel this is the right approach,
I'll rewrite to basically allow --file to take a list of filenames and
default that list to the base list of ~/.{authinfo,netrc}{,.gpg}

Ted
