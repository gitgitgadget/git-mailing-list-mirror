From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add / command in add --patch (feature request)
Date: Wed, 26 Nov 2008 14:54:34 -0800
Message-ID: <7vod02cd3p.fsf@gitster.siamese.dyndns.org>
References: <492DB6C8.7010205@gmail.com>
 <20081126223858.GB10786@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: William Pursell <bill.pursell@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 26 23:56:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5TJ8-0001lI-VN
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 23:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755048AbYKZWzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 17:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752371AbYKZWzK
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 17:55:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37099 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbYKZWzI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 17:55:08 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6CDDC178E3;
	Wed, 26 Nov 2008 17:55:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5B7DA178C4; Wed,
 26 Nov 2008 17:54:35 -0500 (EST)
In-Reply-To: <20081126223858.GB10786@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 26 Nov 2008 17:38:58 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 454E3976-BC0D-11DD-AB82-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101781>

Jeff King <peff@peff.net> writes:

> On Wed, Nov 26, 2008 at 08:51:20PM +0000, William Pursell wrote:
>
>> This is naive, and it is easy for an invalid
>> search string to cause a perl error.
>> [...]
>> +			if( $text !~ $search_s ) {
>
> Yeah, a bad regex will cause the whole program to barf. Maybe wrap it in
> an eval, like this?
>
>   my $r = eval { $text !~ $search_s };
>   if ($@) {
>     print STDERR "error in search string: $@\n";
>     next;
>   }
>   if ($r) {
>     ...
>
> Or similar (I didn't look at the code closely enough to know if "next"
> is the right thing there).

Use of eval is a good way to protect against this kind of breakage, but it
should be done close to where the string is given by the user, perhaps in
here:


+			elsif ($line =~ m|^/(.*)|) {
+				$search_s = $1;
+			}

Something like...

	elsif ($line =~ m|^/(.*)|) {
        	$search_string = $1;
                eval {
                	$search_string =~ /$search_string/;
		};
                if ($@) {
                	print STDERR "Regexp error in $search_string: $@";
			next;
		}
	...
