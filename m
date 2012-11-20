From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH] gitweb: make remote_heads config setting work.
Date: Tue, 20 Nov 2012 14:21:40 -0800
Message-ID: <7vpq37rk3v.fsf_-_@alter.siamese.dyndns.org>
References: <20121105235047.GA78156@redoubt.spodhuis.org>
 <7vk3tvqthw.fsf@alter.siamese.dyndns.org>
 <20121109163710.GD19725@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Pennock <phil@apcera.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 20 23:22:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TawCk-0005Br-3A
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 23:22:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007Ab2KTWVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 17:21:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55262 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752958Ab2KTWVn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 17:21:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F2DE9170;
	Tue, 20 Nov 2012 17:21:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o6IkRABr0bWaa0E/gZFPi7tSC8w=; b=f8vtKr
	0zaFPjY8HXkxnBDLc2+v2TotQMW0cY0Fm9rYMfNLQ0oTARqFH5Kngfzkn0swe58f
	nCfOtvKI+fquuIIBFbigTrrZ0TlQiH9ZQyXmdJUuErzW5o9jO9w1pkih7yLDyoBu
	KIUIM/9w1yuUfm/2vfrbWH1DuLOpKMcW/4S64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qxtCE9vrOLO6TerR57N49eWe9XRiqP4T
	wjmWNLuDq1M7kRW+w+nvM0ywXW7bsopJ1B2UlCHFBBuzZKIvC7nWtqjWgHshXZ4p
	66Jce/j4UXhLTABXQj/VJtU6n+HD8MsqBEZRzCSaNY38o8BY7lcaci7iuGGM5jJc
	KmlYXPV0Q30=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A490916F;
	Tue, 20 Nov 2012 17:21:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0F47916A; Tue, 20 Nov 2012
 17:21:41 -0500 (EST)
In-Reply-To: <20121109163710.GD19725@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 9 Nov 2012 11:37:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A8D0D98A-3360-11E2-BF3F-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210117>

Jeff King <peff@peff.net> writes:

> On Thu, Nov 08, 2012 at 08:40:11PM -0800, Junio C Hamano wrote:
>
>> Looking at the code before this part:
>> 
>> 	if (my ($hi, $mi, $lo) = ($key =~ /^([^.]*)\.(.*)\.([^.]*)$/)) {
>> 		$key = join(".", lc($hi), $mi, lc($lo));
>> 	} else {
>> 		$key = lc($key);
>> 	}
>> 	$key =~ s/^gitweb\.//;
>> 	return if ($key =~ m/\W/);
>> 
>> the new code is munding the $hi and $mi parts, while the mistaken
>> configuration this patch is trying to correct is about the $lo part,
>> and possibly the $hi part, but never the $mi part.
>
> Good catch. I think the "return" in the existing code suffers from the
> same problem: it will bail on non-word characters in the $mi part, but
> that part should allow arbitrary characters.

I am tired of keeping the "expecting reroll" entries and having to
worry about them, so let's do this

-- >8 --
Subject: [squash] gitweb: make remote_heads config setting work

Only the top-level and bottom-level names are case insensitive and
spelled without "_".  Protect future support of subsection names
from name mangling.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 gitweb/gitweb.perl | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git c/gitweb/gitweb.perl w/gitweb/gitweb.perl
index f2144c8..c421fa4 100755
--- c/gitweb/gitweb.perl
+++ w/gitweb/gitweb.perl
@@ -2697,13 +2697,15 @@ sub git_get_project_config {
 	# only subsection, if exists, is case sensitive,
 	# and not lowercased by 'git config -z -l'
 	if (my ($hi, $mi, $lo) = ($key =~ /^([^.]*)\.(.*)\.([^.]*)$/)) {
+		$lo =~ s/_//g;
 		$key = join(".", lc($hi), $mi, lc($lo));
+		return if ($lo =~ /\W/ || $hi =~ /\W/);
 	} else {
 		$key = lc($key);
+		$key =~ s/_//g;
+		return if ($key =~ /\W/);
 	}
 	$key =~ s/^gitweb\.//;
-	$key =~ s/_//g;
-	return if ($key =~ m/\W/);
 
 	# type sanity check
 	if (defined $type) {
