From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: Fix termination issues for remote svn   connections
Date: Fri, 06 Sep 2013 09:41:15 -0700
Message-ID: <xmqqa9jpzyvo.fsf@gitster.dls.corp.google.com>
References: <6970c0cab40c60195c8f042a3b930a0a.squirrel@83.236.132.106>
	<xmqqli3bhzop.fsf@gitster.dls.corp.google.com>
	<A46AD76E-56FA-4555-8811-6141284300DD@gmail.com>
	<07b9b270090d6b42515c5dc3dfb8ab4f.squirrel@83.236.132.106>
	<9D2EC674-887A-479B-B8FB-3EFEAC391435@gmail.com>
	<f2fe486a6ca0bf40be4489bfe888d517.squirrel@83.236.132.106>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Eric Wong" <normalperson@yhbt.net>
To: "Uli Heller" <uli.heller@daemons-point.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 18:41:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHz67-00056V-9C
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 18:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758750Ab3IFQlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 12:41:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51321 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756647Ab3IFQlW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 12:41:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D5FE3DF62;
	Fri,  6 Sep 2013 16:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YNn+UI9p6JO93hpDo/NvAVqeTQg=; b=pHmiTg
	tnHOxO/0uM5z4egVyK1oXQVIApgELVb1VqRmh+ckWIIczUuhj/OMtAtdCWWtz/Z9
	YZYObniLC7QU2g6HoDyXOoWwB6cm4zI4tauxCzWDn3zRe35pZQYZI+Q67SUaDKrP
	u7mqLEJTiUXhAWOJA0943TEcNHaFlTP92VBzc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XbrQIl3zdbCJCdhv1vVErnZEE9Cv53Gh
	Gz0mJ6cClbd6PiFwoRXFl68WFgS8dBe0O0HOFwlhPp/wwH58neEbN1q9LIEy2oXC
	gwgmAW60lbk8OW8dQU4PqPKI1afGaEcmr6/6myd+qvn3zf1ir1bZwC1mwmR9SYXt
	igImnnFpe6Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C98E13DF5F;
	Fri,  6 Sep 2013 16:41:19 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 690943DF59;
	Fri,  6 Sep 2013 16:41:17 +0000 (UTC)
In-Reply-To: <f2fe486a6ca0bf40be4489bfe888d517.squirrel@83.236.132.106> (Uli
	Heller's message of "Fri, 6 Sep 2013 15:18:32 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2733C18E-1713-11E3-94C8-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234060>

"Uli Heller" <uli.heller@daemons-point.com> writes:

> On Fri, September 6, 2013 2:44 pm, Kyle J. McKay wrote:
> ...
>> In any case, I can now reproduce the problem (serf 1.3.1 still breaks
>> since it does not yet contain the fix and it is the most recent serf
>> release available).
>>
>> And the Git/SVN/Ra.pm fix does eliminate the problem for me (both with
>> bulk updates and with skelta updates -- the crash occurs with either).
>
> Great. So I don't have to run any more tests ;)
>
> What shall I do next? Add some inline comments to the patch?

Something like this?

-- >8 --

From: Uli Heller <uli.heller@daemons-point.com>
Subject: [PATCH] git-svn: fix termination issues for remote svn connections

git-svn used in combination with serf to talk to svn repository
served over HTTPS dumps core on termination.

This is caused by a bug in serf, and the most recent serf release
1.3.1 still exhibits the problem; a fix for the bug exists (see
https://code.google.com/p/serf/source/detail?r=2146).

Until the bug is fixed, work around the issue within the git perl
module Ra.pm by freeing the private copy of the remote access object
on termination, which seems to be sufficient to prevent the error
from happening.

Note: Since subversion-1.8.0 and later do require serf-1.2.1 or
later, this issue typically shows up when upgrading to a recent
version of subversion.

Credits go to Jonathan Lambrechts for proposing a fix to Ra.pm,
Evgeny Kotkov and Ivan Zhakov for fixing the issue in serf and
pointing me to that fix.

Signed-off-by: Uli Heller <uli.heller@daemons-point.com>
Tested-by: Kyle J. McKay <mackyle@gmail.com>
---
 perl/Git/SVN/Ra.pm | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index 75ecc42..78dd346 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -32,6 +32,14 @@ BEGIN {
 	}
 }
 
+# serf has a bug that leads to a coredump upon termination if the
+# remote access object is left around (not fixed yet in serf 1.3.1).
+# Explicitly free it to work around the issue.
+END {
+	$RA = undef;
+	$ra_invalid = 1;
+}
+
 sub _auth_providers () {
 	my @rv = (
 	  SVN::Client::get_simple_provider(),
-- 
1.8.4-431-g94f3a6b
