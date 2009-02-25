From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/2] git submodule: Fix adding of submodules at paths
 with ./
Date: Wed, 25 Feb 2009 13:35:33 +0100
Message-ID: <49A53B15.4060608@drmicha.warpmail.net>
References: <80055d7c0902241556s4d24285bqd171275f58bdb37d@mail.gmail.com> <1235559820-3096-1-git-send-email-git@drmicha.warpmail.net> <1235559820-3096-2-git-send-email-git@drmicha.warpmail.net> <1235559820-3096-3-git-send-email-git@drmicha.warpmail.net> <49A529AB.8010700@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Andrei Thorp <garoth@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Feb 25 13:37:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcJ0k-00088h-Jz
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 13:37:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbZBYMfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 07:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbZBYMfp
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 07:35:45 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36406 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751799AbZBYMfo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Feb 2009 07:35:44 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 288772A6146;
	Wed, 25 Feb 2009 07:35:42 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 25 Feb 2009 07:35:42 -0500
X-Sasl-enc: zi+R2GsC2IGbNE0ZN6ZlVzAFQ9N9cqIhG757+8PCJV6v 1235565341
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4D5962DD85;
	Wed, 25 Feb 2009 07:35:41 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090223 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <49A529AB.8010700@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111449>

Johannes Sixt venit, vidit, dixit 25.02.2009 12:21:
> Michael J Gruber schrieb:
>> +	# strip superfluous ./ from path
>> +	path=$(echo "$path" | sed -e 's|^\(\./\)*||' -e's|/\./|/|g')
> 
> At a minimum:
> 
> 	path=$(echo "$path" | sed -e 's|^/\(\./\)*|/|g' -e's|^\./||')
> 
> Otherwise you would turn "foo./bar" into "foobar", right?

Wrong.

My regexp:
echo "foo./bar"  | sed -e 's|^\(\./\)*||' -e's|/\./|/|g'
foo./bar

echo "foo/./bar" | sed -e 's|^\(\./\)*||' -e's|/\./|/|g'
foo/bar


Your regexp:
echo "foo./bar"  | sed -e 's|^/\(\./\)*|/|g' -e's|^\./||'
foo./bar

echo "foo/./bar" | sed -e 's|^/\(\./\)*|/|g' -e's|^\./||'
foo/./bar

Testing your claim isn't that hard to do before hand...

> But why only care about ./ but not ../ or /// or trailing / as well?

You really haven't even looked at the included context of the patch
(which you stripped), have you? I mean, I'm open for suggestions and
criticism, but please don't shoot blindly.

./ have been reported and are a common use case.

Trailing / are dealt with by the code (see context).

Now, the /// are in fact a valid concern[1], although probably not that
common an isue. If we really want to cater for that (and more) we need
to implement normalize_path_copy() (from path.c). There it says:

* Performs the following normalizations on src, storing the result in dst:
 * - Ensures that components are separated by '/' (Windows only)
 * - Squashes sequences of '/'.
 * - Removes "." components.
 * - Removes ".." components, and the components the precede them.
 * Returns failure (non-zero) if a ".." component appears as first path
 * component anytime during the normalization. Otherwise, returns
success (0).

OK, two more regexps for sed. Thanks, I don't need suggestions for the
regexps ;)

I can add /// and .. testing and handling in a v2, but I'll definitely
leave the Windoze paths to someone who can actually test on Win.

Michael

[1] git sm init uses git ls-files, which in turn,..., which calls
normalize_path_copy. git sm add can't use git ls-files because it has to
deal with an as yet unknown path.
