From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] strbuf: add "include_delim" parameter to
 "strbuf_split"
Date: Thu, 12 Mar 2009 22:17:30 -0700
Message-ID: <7v1vt2j91x.fsf@gitster.siamese.dyndns.org>
References: <20090312085103.e83b34a5.chriscool@tuxfamily.org>
 <20090312190846.6117@nanako3.lavabit.com>
 <200903130548.30370.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Mar 13 06:19:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhzng-00065D-9P
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 06:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbZCMFRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 01:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbZCMFRp
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 01:17:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59191 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbZCMFRp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 01:17:45 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 91F0DA1A78;
	Fri, 13 Mar 2009 01:17:42 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5FBDFA1A76; Fri,
 13 Mar 2009 01:17:32 -0400 (EDT)
In-Reply-To: <200903130548.30370.chriscool@tuxfamily.org> (Christian Couder's
 message of "Fri, 13 Mar 2009 05:48:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 476B6E84-0F8E-11DE-89DD-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113141>

Christian Couder <chriscool@tuxfamily.org> writes:

> Yes, my patch does not do that, because I think including the delimiter is a 
> special case of the more general and useful behavior of not including it.

You got it backwards.

With the way the returned string is used by the single caller that your
patch adds (which splits at ","), I would agree that lack of delimiter
allows the result to get used directly in the further processing.

But even in that codepath, I have to say that it is just lazy programming
that the caller does not postprocess the returned value from the splitter
function.  If it wants not just accept input such as "a,b,c" but also
wants to tolerate things like "a, b, c", it will have to look at the
resulting string, and ignoring the delimiter at the end becomes just a
small part of the general clean-up process [*1*].

Once you start allowing "split at one of these characters" and/or "split
at delimiter that matches this pattern", you cannot just discard the
delimiter if you want to support non-simplistic callers, because they
would want to know what the delimiter was.

Stripping out the delimiter is the special case for simplistic callers
(think "gets()" that strips, and "fgets()" that doesn't).  A more general
solution should be by default not to strip it, and I do not think your new
caller, if it were written correctly, needs stripping behaviour either.
That means there is no need for the "optionally strip" flag to the
function in order to support the rest of the series [*2*].

Also comparing this with Perl/Python split() forgets that you are working
in C, where truncating an existing string is quite cheap (just assign '\0').
There is a different trade-off to be made in these language environments.

[Footnote]

*1* and this is not a made-up feature enhancement request.  If you tell
people that they can give more than one value with comma separated, some
of them _will_ feed you --option="a, b, c".  Your parser can error out by
saying "I do not understand ' b'", but you will be told "What other
possible interpretation is there for that thing, other than 'b'!", and
would grudgingly have to change your code to accept such a list.

*2* In any case, as I told you in a separate review comments, I think
passing a huge list as a command line parameter, be it separated with
comma or whatever, is not an appropriate way to solve the issue of
filter_skipped() your primary topic seems to be trying to address, so I
expect your series would not need strbuf_split() at all.  You would most
likely be calling for_each_ref(), looking at the refs under "refs/bisect"
hierarchy, instead of having shell feed you the list.
