From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t4055 failure: see error
Date: Tue, 02 Oct 2012 12:09:33 -0700
Message-ID: <7vpq507ksy.fsf@alter.siamese.dyndns.org>
References: <7667682A-3BDB-484F-A3E4-0E5826FD2076@cs.rochester.edu>
 <7vy5jo7l7r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Charles Gernhardt <gernhard@cs.rochester.edu>
X-From: git-owner@vger.kernel.org Tue Oct 02 21:10:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ7qk-0005N4-JJ
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 21:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003Ab2JBTJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 15:09:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60574 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016Ab2JBTJg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 15:09:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10F8681DF;
	Tue,  2 Oct 2012 15:09:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=suXBnYbFiPynwqysERvdVRBf6hk=; b=qoWokx
	nvF70oNVpS1GICMu6VpMpPUoxfiJ8eZ9LIJoESOQc5UuEz5X99RY8Wd0aKVx8uaO
	fxu+WlDGvyhIXmLcE+QnrBxr9xqeJSEItYPVDhGv5W/zn6EchxyobGuP46wtzSgd
	s+vTxEQruEvejqFd/+NSNxH+BPaLxvBt4aN1E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pzERWs9hwvRET8Z0+VeYrgNPZNnMvyWb
	ovJEmPVgVqNc4mXk06Wcx5fu46VXCkmBfi6JI0fXe+gABQ6jblzGNURncC0nO9P/
	EsUW9UFDUrE8LzSW7DoNFXC4Jm0Gq2dlyozVxEPiYouwkYpUIf62DikYyj4gDPkd
	3N/4gIX+BTc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0FBD81DE;
	Tue,  2 Oct 2012 15:09:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3DAAE81D8; Tue,  2 Oct 2012
 15:09:35 -0400 (EDT)
In-Reply-To: <7vy5jo7l7r.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 02 Oct 2012 12:00:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B44CF6D0-0CC4-11E2-9A1E-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206836>

Junio C Hamano <gitster@pobox.com> writes:

> Brian Charles Gernhardt <gernhard@cs.rochester.edu> writes:
>
>> Another problem caused by BSD v GNU sed, I think.
>>
>> 	git cat-file blob HEAD:x |
>> 	sed "/preline/a\
>> 	ADDED" >x &&
>
> Actually, I think what is happening is that inside "", the backslash
> at the end of line is eaten by the shell together with that end of
> line, so it is not BSD vs GNU, but it simply is that my quoting was
> wrong.
>
> This (disregarding the previous "TARGET" patch) may be a smaller fix.

I'll find a brown paper bag big enough to hide in.  Please disregard
it.

-- >8 --
Subject: [PATCH] t4055: avoid use of sed 'a' command

The 'a', 'i' and 'c' commands take a literal text to be added
followed by backslash, but then in the source we cannot indent
the literal text which makes it ugly.

We need to also remember to double the backslash inside double
quotes.

Avoid these issues altogether by having an extra line in a template
file and generate test vectors by deleting the line or replacing the
line and not using the 'a' command.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4055-diff-context.sh | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
index 3527686..97172b4 100755
--- a/t/t4055-diff-context.sh
+++ b/t/t4055-diff-context.sh
@@ -8,7 +8,7 @@ test_description='diff.context configuration'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-	cat >x <<-\EOF &&
+	cat >template <<-\EOF &&
 	firstline
 	b
 	c
@@ -16,6 +16,7 @@ test_expect_success 'setup' '
 	e
 	f
 	preline
+	TARGET
 	postline
 	i
 	j
@@ -24,17 +25,15 @@ test_expect_success 'setup' '
 	m
 	n
 	EOF
+	sed "/TARGET/d" >x <template &&
 	git update-index --add x &&
 	git commit -m initial &&
 
-	git cat-file blob HEAD:x |
-	sed "/preline/a\
-	ADDED" >x &&
+	sed "s/TARGET/ADDED/" >x <template &&
 	git update-index --add x &&
 	git commit -m next &&
 
-	git cat-file blob HEAD:x |
-	sed s/ADDED/MODIFIED/ >x
+	sed "s/TARGET/MODIFIED/" >x <template
 '
 
 test_expect_success 'the default number of context lines is 3' '
-- 
1.8.0.rc0.45.g7ce8dc5
