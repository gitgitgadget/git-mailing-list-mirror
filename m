From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t5539 broken under Mac OS X
Date: Thu, 15 Jan 2015 12:29:39 -0800
Message-ID: <xmqqwq4n6b4c.fsf@gitster.dls.corp.google.com>
References: <54B68D99.2040906@web.de>
	<xmqqmw5l9pje.fsf@gitster.dls.corp.google.com>
	<54B6C897.5030405@web.de> <20150114211712.GE1155@peff.net>
	<064010B3-BC58-42F2-B5C0-DAADAA59B87D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 21:30:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBr3H-0000yO-SG
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 21:30:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940AbbAOU3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 15:29:55 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59729 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752257AbbAOU3y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 15:29:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E28A2F895;
	Thu, 15 Jan 2015 15:29:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gLuyxn77rh/RLa1J5Gmkcyx7U0g=; b=qNwHU3
	Q4bAEy9iXgBdcmn8bLjZDxXUDWRikWR7+DGwbDmeMuHMXJf1P1d4dp7CstzVdYch
	mGgYYKsSVBn8LM22UW2KbzbR/EddQ43wtxDpVKltV56870MpgCI6Db8M6iVchNCq
	qS4uCD2ZVln3IXw+GWiT5Qr6LyHgazF0fi9mI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SVAm2H4gAt0Q3ZPEZEgDO5jLo1uTEVH4
	Ko3W6F0HiBLEddGHgn0BucY4d7cIW4LQZGfuP2s07kaiERPnmjHzg7HnKyUjHCwE
	p+ZTTV7YCVDHQgi//Y+0BsOMSs/+YtggCplR7MyxnU261SF2ybzgCJCSY1AWZNfP
	fjinUpTRLt0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 447852F894;
	Thu, 15 Jan 2015 15:29:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 885EF2F88C;
	Thu, 15 Jan 2015 15:29:40 -0500 (EST)
In-Reply-To: <064010B3-BC58-42F2-B5C0-DAADAA59B87D@gmail.com> (Kyle J. McKay's
	message of "Wed, 14 Jan 2015 21:48:28 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3B6A40BA-9CF5-11E4-A6E7-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262507>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> I ran into this problem.  It seems like (at least on older Mac OS X)  
> that the root directory is created like so:
>
>    drwxrwxr-t  39 root  admin  /
>
> And since the first (and likely only user) on Mac OS X is a member of  
> the admin group, the SANITY test fails and complains even though  
> you're not running as root (the failure message is misleading).

The design choice Mac OS X makes around filesystems may deserve the
!SANITY label ;-) but we may want to tighten the check for SANITY,
or better yet, rethink the interaction between POSIXPERM and SANITY.

What we want to express with SANITY is:

	On this system, if the user who is running the test
        does not have write permission to a file, write to such a
        file would fail.

So running our tests as a non-root admin user should be labeled as
being sane.  We just use a more expedient "if you can write into the
root directory, you must be root, asit is crazy to allow non-root
user to 'mv /etc /foo && mkdir /etc && write /etc/passwd'"
heuristics which is old-school.

This should not be the final patch (I think it should become a lazy
prereq as it does a lot more), but just for testing, how does this
look?

 t/test-lib.sh | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index bb1402d..cdafab5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1033,7 +1033,16 @@ test_lazy_prereq USR_BIN_TIME '
 
 # When the tests are run as root, permission tests will report that
 # things are writable when they shouldn't be.
-test -w / || test_set_prereq SANITY
+if test_have_prereq POSIXPERM &&
+	! test -w / &&
+	>sanitytest &&
+	chmod a= sanitytest &&
+	! (>sanitytest) 2>/dev/null &&
+	chmod +w sanitytest &&
+	rm -f sanitytest
+then
+	test_set_prereq SANITY
+fi
 
 GIT_UNZIP=${GIT_UNZIP:-unzip}
 test_lazy_prereq UNZIP '
