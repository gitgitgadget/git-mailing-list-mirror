From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCH] Add contrib/credentials/netrc with GPG support, try #2
Date: Mon, 04 Feb 2013 18:31:29 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87bobzslke.fsf@lifelogs.com>
References: <87ehgvua6h.fsf@lifelogs.com>
	<20130204211726.GB13186@sigill.intra.peff.net>
	<87mwvjsqjc.fsf_-_@lifelogs.com>
	<7vd2wf1yex.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 00:31:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2VVx-0007YY-OB
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 00:31:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755174Ab3BDXbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 18:31:31 -0500
Received: from z.lifelogs.com ([173.255.230.239]:55382 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754629Ab3BDXba (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 18:31:30 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id DC035DE0E0;
	Mon,  4 Feb 2013 23:31:29 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <7vd2wf1yex.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 04 Feb 2013 14:56:06 -0800")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215431>

On Mon, 04 Feb 2013 14:56:06 -0800 Junio C Hamano <gitster@pobox.com> wrote: 

JCH> I recall that netrc/authinfo files are _not_ line oriented.  Earlier
JCH> you said "looks for entries that match" which is a lot more correct,
JCH> but then we see "look for lines in authfile".

Hmm, do you mean backslashed newlines?  I think the Net::Netrc parser
doesn't support them, and I haven't seen them in the wild, but I could
support them if you think that's useful.

>> +my $mode = shift @ARGV;
>> +
>> +# credentials may get 'get', 'store', or 'erase' as parameters but
>> +# only acknowledge 'get'
>> +die "Syntax: $0 [-f AUTHFILE] [-d] get" unless defined $mode;
>> +
>> +# only support 'get' mode
>> +exit unless $mode eq 'get';

JCH> The above looks strange.  Why does the invoker get the error message
JCH> only when it runs this without arguments?  Did you mean to say more
JCH> like this?

JCH> 	unless (defined $mode && $mode eq 'get') {
JCH> 		die "...";
JCH> 	}

I mean:

- if the mode is not given, exit badly (since it's required)

- if the mode is given but we don't support it, exit pleasantly

I thought that was the right thing, according to my reading of the
credentials API.  If not, I'll be glad to change it.

JCH> By the way, I think statement modifiers tend to get overused and
JCH> make the resulting program harder to read.  die "..." at the
JCH> beginning of line makes the reader go "Whoa, it already is done and
JCH> existing on error", and then forces the eyes to scan the error
JCH> message to find "unless" and the condition.

JCH> It may be a cute syntax and some may find it even cool, but cuteness
JCH> or coolness is less valuable compared with the readability.

Your coding guidelines said you prefer one-line if statements, and I
thought it would be OK to lean on modifiers.  I changed many of the
modifiers but not all; please let me know if you'd like me to change
them all.  It's no problem.

JCH> Is it sensible to squelch the error message by default and force
JCH> user to specify --debug?  You could argue that the option is to
JCH> debug the user's configuration, but the name of the option sounds
JCH> more like it is for debugging this script itself.

It's both... without a clear separation because it's such a small
script.  Let me know how you'd like to change it, if at all.

JCH> I saw Peff already pointed out error conditions, but I am not sure
JCH> why all of these exit with 0.  If the user has configured

JCH> 	git config credential.helper 'netrc -f $HOME/.netcr'

JCH> shouldn't it be diagnosed as an error?  It is understandable to let
JCH> this go silently

JCH> 	git config credential.helper 'netrc'

JCH> and let other credential helpers take over when no $HOME/.{netrc,authinfo}{,.gpg}
JCH> file exist, but in that case the user may still want to remove the
JCH> config item that is not doing anything useful and erroring out with
JCH> a message may be a way to help the user know about the situation.

You and Peff should tell me how it should behave, or perhaps make the
changes after it's in.  I'm happy to change it any way you like, but at
this point I'm just following instructions, not really contributing,
about the exit statuses.  I thought I knew what you wanted 2 iterations
ago :)

>> +	print STDERR "Sorry, we could not load data from [$file]\n" if $debug;
>> +	exit;

JCH> Is this really an error?  The file perhaps was empty.  Shouldn't
JCH> that case treated the same way as the case where no entry that
JCH> matches the criteria invoker gave you was found?

exit(0) is not an error, so the behavior is exactly the same, we just
don't print anything to STDOUT because there was no data, with a nicer
error message.  I think that's what we want?

PATCHv3 is out with the rest of your suggestions.  Thank you for the
thorough review.  I am happy to improve the script to meet your standards.

Thanks
Ted
