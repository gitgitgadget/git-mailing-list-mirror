From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] git-merge-one-file: revise merge error reporting
Date: Mon, 25 Mar 2013 10:20:48 -0700
Message-ID: <7vboa7z98v.fsf@alter.siamese.dyndns.org>
References: <CAJDDKr4swZzzv3e+Huz72CVmisFKU8T74jFj3-uGmZHReRGVBw@mail.gmail.com>
 <1364127985-13366-1-git-send-email-kevin@bracey.fi>
 <1364127985-13366-4-git-send-email-kevin@bracey.fi>
 <7vk3ovz9zb.fsf@alter.siamese.dyndns.org>
 <7vfvzjz9ej.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Mon Mar 25 18:21:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKB5D-00053W-1P
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 18:21:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758714Ab3CYRUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 13:20:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45332 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758497Ab3CYRUu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 13:20:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5109DBC4C;
	Mon, 25 Mar 2013 13:20:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gv4dVPToPkT/N4CN8NdufSMtkkk=; b=R2Q6z8
	zCVKfqQ8BOSNxGZGy0ZzqLIGRnCSj77tabr4QS2GYIb+27yrdUFRrDz6TgiwHrJs
	ZY7R6/heM+jdVWjhT3mTPTth0fvxyuncYQBl1Meb/bAwPcV0bqec3mBSgCxEc7qr
	EzzUWNGeqzBSCX/EndwnrrB5qKqeCGpMn2gsQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kVy2taqQS3/YLypMGPh2MjZeyYfDjHWu
	887g7V/Mr4VG9Wo6604Wgo67nCsazAfrUUrTarHxHgxSn0moGKr9/0PTLlDaXCUW
	FJR8GQMdm6RvsGOGLlpvgJsS8x2gG3nMrp2TWaGW9PW8a8TDpkVzm0eBaWI0icJw
	cPoVqOpd0Vg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 442E5BC4B;
	Mon, 25 Mar 2013 13:20:50 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97BC1BC49; Mon, 25 Mar 2013
 13:20:49 -0400 (EDT)
In-Reply-To: <7vfvzjz9ej.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 25 Mar 2013 10:17:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5699396A-9570-11E2-B3FD-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219048>

Junio C Hamano <gitster@pobox.com> writes:

> Actually, this one is even better, I think.  Again on top of your
> two patches applied on 'maint'.

Scratch that one.  The "if test -z "$1"" block needs to be moved a
bit higher, like this (the log message can stay the same):

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 62016f4..a4ecf33 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -134,9 +134,10 @@ case "${1:-.}${2:-.}${3:-.}" in
 	git merge-file "$src1" "$orig" "$src2"
 	ret=$?
 	msg=
-	if test $ret != 0
+	if test $ret != 0 || test -z "$1"
 	then
 		msg='content conflict'
+		ret=1
 	fi
 
 	# Create the working tree file, using "our tree" version from the
@@ -153,11 +154,6 @@ case "${1:-.}${2:-.}${3:-.}" in
 		msg="${msg}permissions conflict: $5->$6,$7"
 		ret=1
 	fi
-	if test -z "$1"
-	then
-		msg='content conflict'
-		ret=1
-	fi
 
 	if test $ret != 0
 	then
