From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/3] clone: do not include authentication data in guessed dir
Date: Wed, 05 Aug 2015 12:36:44 -0700
Message-ID: <xmqqr3nh34tv.fsf@gitster.dls.corp.google.com>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
	<1438769179-5943-1-git-send-email-ps@pks.im>
	<1438769179-5943-2-git-send-email-ps@pks.im>
	<xmqqzj253a39.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com, pclouds@gmail.com
To: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 05 21:36:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN4Ud-0006Sf-I3
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 21:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbbHETgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 15:36:46 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35104 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbbHETgq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 15:36:46 -0400
Received: by pabxd6 with SMTP id xd6so25587759pab.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 12:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ezKTgGX1P8vRcqcgXkfVlnLy78Tn6kZUCWU1wJGkDyQ=;
        b=WPQrcowyqLWYeXtFTEp7T9j0gd8qDGPbksxvJd67/t8GsGG0fg5W1LgXWBa7nuY6dP
         A4YIA0P/4XW4ZgS//IoX1DhDuhPA6K0IZVYmZMn4bW+nAeyGCKBUNu/8GEFRH1I40SFy
         DyrwoNxNvQDmktIdSPyz26kmel918kxqD4E61hk3zMmLK5nexc+qVAnKt3+66dFIqxgH
         NU0skDyB0PRuVwuSTcoPojW7oIPyIbC6lgmXYp3BmuHkMN/xSovPun0VZWn/t25ZdynA
         s1xs4+2ANRqbjKbj0gdlUwr78C/qwld2vj5nD/rsuWQkYCo/TNVVqv8xRi5uhdM7kj9d
         aNyw==
X-Received: by 10.66.119.201 with SMTP id kw9mr22869096pab.49.1438803405727;
        Wed, 05 Aug 2015 12:36:45 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:5cf0:2451:9503:37d])
        by smtp.gmail.com with ESMTPSA id bc10sm3806181pbd.14.2015.08.05.12.36.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 05 Aug 2015 12:36:45 -0700 (PDT)
In-Reply-To: <xmqqzj253a39.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 05 Aug 2015 10:43:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275388>

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps add
>
> "test_clone_dir ssh://user:passw@rd@host/ host"
>
> here?  How is this expected to be parsed?

For completeness, here is what I think the end result (together with
Peff's series) of the test should look like.

The first hunk is merely style.  We could drop 'in "$@"' from there
and some people may argue that it would be more obvious, but I think
being explict is fine.

As to the second hunk:

 - the first batch is for "trailing slash removal" for scp-like
   syntax;

 - the second batch is for "omitting path should default to host" for
   the same;

 - the third batch is for "omitting authentication material" for the
   same.

Note that ssh://user:passw@rd@host:1234/ and user:passw@rd@host:/
tests fail for the same reason (finding @ should be greedy, I think).

 t/t5603-clone-dirname.sh | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/t/t5603-clone-dirname.sh b/t/t5603-clone-dirname.sh
index 27dbd6c..4897ea8 100755
--- a/t/t5603-clone-dirname.sh
+++ b/t/t5603-clone-dirname.sh
@@ -22,7 +22,8 @@ test_clone_dir () {
 	expect=success
 	bare=non-bare
 	clone_opts=
-	for i in "$@"; do
+	for i in "$@"
+	do
 		case "$i" in
 		fail)
 			expect=failure
@@ -61,12 +62,23 @@ test_clone_dir ssh://host/foo/ foo
 test_clone_dir ssh://host/foo.git/ foo
 test_clone_dir ssh://host/foo/.git/ foo
 
+test_clone_dir host:foo/ foo
+test_clone_dir host:foo.git/ foo
+test_clone_dir host:foo/.git/ foo
+
 # omitting the path should default to the hostname
 test_clone_dir ssh://host/ host
 test_clone_dir ssh://host:1234/ host
 test_clone_dir ssh://user@host/ host
+test_clone_dir host:/ host
+
+# auth materials should be redacted
 test_clone_dir ssh://user:password@host/ host
 test_clone_dir ssh://user:password@host:1234/ host
+test_clone_dir ssh://user:passw@rd@host:1234/ host
+test_clone_dir user@host:/ host
+test_clone_dir user:password@host:/ host
+test_clone_dir user:passw@rd@host:/ host
 
 # trailing port-like numbers should not be stripped for paths
 test_clone_dir ssh://user:password@host/test:1234 1234
