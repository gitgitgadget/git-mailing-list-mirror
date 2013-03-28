From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Thu, 28 Mar 2013 08:37:58 -0700
Message-ID: <7vfvzfwn55.fsf@alter.siamese.dyndns.org>
References: <20130327122216.5de0c336@hoelz.ro>
 <20130327182345.GD28148@google.com> <20130327211554.GH28148@google.com>
 <7vsj3gjy3t.fsf@alter.siamese.dyndns.org> <20130327174845.5e3081d1@hoelz.ro>
 <20130327230943.GA5204@jtriplet-mobl1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rob Hoelz <rob@hoelz.ro>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Thu Mar 28 16:38:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULEuN-0000n0-1g
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 16:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754983Ab3C1PiC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 11:38:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53873 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753610Ab3C1PiB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 11:38:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8739FA183;
	Thu, 28 Mar 2013 11:38:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pgqHCb6Im9HbKWikhxvHnKo5kwU=; b=EcrVAp
	XwoN23wEr2bgLog6n5W6SZhZAMEnahNeXm3q49kkEN0TYq0vODeFttEktB5Y8yNh
	Lb3hRW8J/O4fiDtR6q9Re51qJvNZBRj6E1Xuy1RG9QB04k64C2ixT8oF7g8x6deD
	lkk5Mlq4jcPnyegNUFkhnWBmaifqMtjlL5PBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TGlZ5tIVdIruwms1Unw1LDLCCLMKi5Vm
	l3oEa7VBWGEODXi9M9VKnAfJYG5CzVePWONyKJhpo39P9tMZKTozvCJg8aDTHBzX
	1qXOkKJjvEAjRpmiRIVlUNra4V4AOoUmdlI2/8GFUDyMwsHODggGQN++YkWFaIgL
	1YXWql2yof8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 782A3A182;
	Thu, 28 Mar 2013 11:38:00 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B39A5A17D; Thu, 28 Mar 2013
 11:37:59 -0400 (EDT)
In-Reply-To: <20130327230943.GA5204@jtriplet-mobl1> (Josh Triplett's message
 of "Wed, 27 Mar 2013 16:09:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 784CA34A-97BD-11E2-AC06-CBA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219411>

Josh Triplett <josh@joshtriplett.org> writes:

> On Wed, Mar 27, 2013 at 05:48:45PM -0500, Rob Hoelz wrote:
> ...
>> The test that checked that pushInsteadOf + pushurl shouldn't work as I
>> expect was actually broken; I have removed it, updated the
>> documentation, and sent a new patch to the list.
>
> There's an argument for either behavior as valid.  My original patch
> specifically documented and tested for the opposite behavior, namely
> that pushurl overrides any pushInsteadOf, because I intended
> pushInsteadOf as a fallback if you don't have an explicit pushurl set.

For only this bit.

I think the test in question is this one from t5516:

test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf should not rewrite)' '
	mk_empty &&
	TRASH="$(pwd)/" &&
	git config "url.trash2/.pushInsteadOf" trash/ &&
	git config remote.r.url trash/wrong &&
	git config remote.r.pushurl "$TRASH/testrepo" &&
	git push r refs/heads/master:refs/remotes/origin/master &&
	(
		cd testrepo &&
		r=$(git show-ref -s --verify refs/remotes/origin/master) &&
		test "z$r" = "z$the_commit" &&

		test 1 = $(git for-each-ref refs/remotes/origin | wc -l)
	)
'

It defines a remote "r", with URL "trash/wrong" (used for fetch) and
pushURL "$(pwd)/testrepo" (used for push).  There is a pushInsteadOf
rule to rewrite anything that goes to "trash/*" to be pushed to
"trash2/*" instead but that shouldn't be used to rewrite an explicit
pushURL.

And then the test pushes to "r" and checks if testrepo gets updated;
in other words, it wants to make sure remote.r.pushURL defines the
final destination, without pushInsteadOf getting in the way.

But $(pwd)/testrepo does not match trash/* in the first place, so
there is no chance for a pushInsteadOf to interfere; it looks to me
that it is not testing what it wants to test.

Perhaps we should do something like this?  We tell it to push to
"testrepo/" with pushURL, and set up a pushInsteadOf to rewrite
"testrepo/" to "trash2/", but because for this push it comes from an
explicit pushURL, it still goes to "testrepo/".

As we do not have "trash2/" repository, the test not just tests the
push goes to "testrepo/", but it also tests that it does not attempt
to push to "trash2/", checking both sides of the coin.

 t/t5516-fetch-push.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index d3dc5df..b5ea32c 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -230,10 +230,9 @@ test_expect_success 'push with pushInsteadOf' '
 
 test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf should not rewrite)' '
 	mk_empty &&
-	TRASH="$(pwd)/" &&
-	git config "url.trash2/.pushInsteadOf" trash/ &&
+	git config "url.trash2/.pushInsteadOf" testrepo/ &&
 	git config remote.r.url trash/wrong &&
-	git config remote.r.pushurl "$TRASH/testrepo" &&
+	git config remote.r.pushurl "testrepo/" &&
 	git push r refs/heads/master:refs/remotes/origin/master &&
 	(
 		cd testrepo &&
