From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn.perl: fix a false-positive in the "already
 exists" test
Date: Tue, 21 Feb 2012 21:08:49 -0800
Message-ID: <7vmx8bcv4u.fsf@alter.siamese.dyndns.org>
References: <20120219105442.GA11889@dcvr.yhbt.net>
 <1329747474-17976-1-git-send-email-stevenrwalter@gmail.com>
 <7vk43feho8.fsf@alter.siamese.dyndns.org>
 <CAK8d-aLXs0yMzYMXm7fKytOGDXesUEx7a8PN_Mg9gw6+Q6OTBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: normalperson@yhbt.net, git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 06:08:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S04Rk-0004do-Fu
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 06:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798Ab2BVFIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 00:08:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34508 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750714Ab2BVFIw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 00:08:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 549227CAC;
	Wed, 22 Feb 2012 00:08:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9QwtROTH2CoX7yiGufI4Rlq7jyc=; b=wsV6ab
	YvFw8iaiztGIiY0vQ8OaOIkcItv2zRcL5Yti69jBUyGUugZIm7YwbOFQYk5tRPL4
	PanypfO70BgffKr4aakDk1HG+0lTtHnBmeMa3awuP9/HoFF9beYLZ4d8I5DdAVGG
	KnrBcKa3xhzP8R6SUFNt6ssJtyK6h3ApH3rLc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R7C5aoIja0A5gowr5Fojx+HGwfKdO2mh
	eaZ/kaZr+BlxV0sGKD6Qkhv+xUkmy8RiFslDIMDh6XBpkNFp15dl7uGGKHXix1uj
	Ph4ScQ6vY77QrE2jyhX+nq/7iTn4D5esR1AdAZSR3nvmjUH9UtqF+bS9c+nnjrIP
	R9iq6xEIQPc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B0957CAB;
	Wed, 22 Feb 2012 00:08:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 99F5C7CAA; Wed, 22 Feb 2012
 00:08:50 -0500 (EST)
In-Reply-To: <CAK8d-aLXs0yMzYMXm7fKytOGDXesUEx7a8PN_Mg9gw6+Q6OTBA@mail.gmail.com> (Steven
 Walter's message of "Tue, 21 Feb 2012 21:32:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4ED8B606-5D13-11E1-8374-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191229>

Steven Walter <stevenrwalter@gmail.com> writes:

>>> +     test -e "$SVN_TREE"/bar/zzz/yyy ' || true
>>
>> Care to explain what this " || true" is doing here, please?
>
> Ahh, good catch.  I think the answer is that it shouldn't be there.
> It was originally there because of the "test_must_fail" line, I think
> (at least the other tests that use test_must_fail also have "||
> true").

Ok, that may explain the copy&paste error.

But I do not think test_must_fail followed by || true makes much sense,
either.  The purpose of "test_must_fail" is to make sure the tested git
command exits with non-zero status in a controlled way (i.e. not crash)
so if the tested command that is expected to exit with non-zero status
exited with zero status, the test has detected an *error*.  E.g. if you
know that the index and the working tree are different at one point in the
test sequence, you would say:

	... other setup steps ... &&
	test_must_fail git diff --exit-code &&
        ... and other tests ...

so that failure by "git diff --exit-code" to exit with non-zero status
(i.e. it did not find any difference when it should have) breaks the &&
cascade.

I just took a quick look at t9100 but I think all " || true" can be safely
removed.  None of them is associated with test_must_fail in any way.  For
whatever reason, these test seem to do

	test_expect_success 'label of the test' '
        	body of the test
	' || true

for no good reason.

> Do you want to just fix that up, or a new version of the original patch,
> or a fix on top of the original patches?

Eric queued the patch and then had me pull it as part of his history
already, so it is doubly too late to replace it.

Can you apply this patch and re-test?


 t/t9100-git-svn-basic.sh |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
index 4029f84..749b75e 100755
--- a/t/t9100-git-svn-basic.sh
+++ b/t/t9100-git-svn-basic.sh
@@ -65,7 +65,8 @@ test_expect_success "$name" "
 	git update-index --add dir/file/file &&
 	git commit -m '$name' &&
 	test_must_fail git svn set-tree --find-copies-harder --rmdir \
-		${remotes_git_svn}..mybranch" || true
+		${remotes_git_svn}..mybranch
+"
 
 
 name='detect node change from directory to file #1'
@@ -79,7 +80,8 @@ test_expect_success "$name" '
 	git update-index --add -- bar &&
 	git commit -m "$name" &&
 	test_must_fail git svn set-tree --find-copies-harder --rmdir \
-		${remotes_git_svn}..mybranch2' || true
+		${remotes_git_svn}..mybranch2
+'
 
 
 name='detect node change from file to directory #2'
@@ -96,7 +98,8 @@ test_expect_success "$name" '
 		${remotes_git_svn}..mybranch3 &&
 	svn_cmd up "$SVN_TREE" &&
 	test -d "$SVN_TREE"/bar/zzz &&
-	test -e "$SVN_TREE"/bar/zzz/yyy ' || true
+	test -e "$SVN_TREE"/bar/zzz/yyy
+'
 
 name='detect node change from directory to file #2'
 test_expect_success "$name" '
@@ -109,7 +112,8 @@ test_expect_success "$name" '
 	git update-index --add -- dir &&
 	git commit -m "$name" &&
 	test_must_fail git svn set-tree --find-copies-harder --rmdir \
-		${remotes_git_svn}..mybranch4' || true
+		${remotes_git_svn}..mybranch4
+'
 
 
 name='remove executable bit from a file'
@@ -162,7 +166,7 @@ test_expect_success "$name" '
 
 name='modify a symlink to become a file'
 test_expect_success "$name" '
-	echo git help > help || true &&
+	echo git help >help &&
 	rm exec-2.sh &&
 	cp help exec-2.sh &&
 	git update-index exec-2.sh &&
