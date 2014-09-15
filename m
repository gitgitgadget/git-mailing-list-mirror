From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] check-headers: add header usage checks for .c files
Date: Mon, 15 Sep 2014 12:19:06 -0700
Message-ID: <xmqqfvfs66ad.fsf@gitster.dls.corp.google.com>
References: <1410680445-84593-1-git-send-email-davvid@gmail.com>
	<xmqqk35466e1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 21:23:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTbsS-0007Kp-Jd
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 21:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532AbaIOTWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 15:22:24 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50729 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754531AbaIOTTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 15:19:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E85173A2B1;
	Mon, 15 Sep 2014 15:19:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lP/KQh9O5ige3p0BsV6QsNXmCO4=; b=Beo99c
	HzSAb/ch9OdQr1xu0CHptBnbIEedikhbrvi38OuDk1pCaNhLYwjiNx+Yy+8BqW2y
	+1Z+DagqNyKI9UfEF4r2Uc2DGkfw1P5kk3vNrLVvdXVxaUYdubJYWIx3sJRed2UK
	P1RaFFKR+wf2lvU0WQouZfmgpAGN+sQ2/zrHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MwMNADRcLA55Z3b7GNw9xWjYjTUrjIsQ
	pgdTWgswnRRGIJ1CXALGAz073GoGjWcuNVMS6mRKKMq1hjrjYLxKdx5oMrP0Wy2b
	4c4wGJ+rtH5LYG7x4fDUwVR/xkyRNGBVS9hdm/UqVnQ5K0Uc3sXeJ4rI7l6zGkRR
	pLXSruOU6uc=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6237D3A2AF;
	Mon, 15 Sep 2014 15:19:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B2F2B3A2AE;
	Mon, 15 Sep 2014 15:19:07 -0400 (EDT)
In-Reply-To: <xmqqk35466e1.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 15 Sep 2014 12:16:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2A0F5578-3D0D-11E4-9DF7-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257075>

Junio C Hamano <gitster@pobox.com> writes:

> David Aguilar <davvid@gmail.com> writes:
>
>> Teach check-header.sh to ensure that the first included header in .c
>> files is either git-compat-util.h, builtin.h, or cache.h.
>>
>> Ensure that common-cmds.h is only included by help.c.
>>
>> Move the logic into functions so that we can skip parts of the check.
>>
>> Signed-off-by: David Aguilar <davvid@gmail.com>
>> ---
>> This depends on my previous patch that adds check-header.sh.
>> ...
>> +check_headers () {
>> +	for header in *.h ewah/*.h vcs-svn/*.h xdiff/*.h
>> +	do
>> +		check_header "$header"
>
> Hmmmm, doesn't check_header run "$@" as a command?

Taking the previous two together, perhaps

 check-headers.sh | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/check-headers.sh b/check-headers.sh
index 7f25e7a..526381e 100755
--- a/check-headers.sh
+++ b/check-headers.sh
@@ -20,6 +20,7 @@ maybe_exit () {
 
 check_header () {
 	header="$1"
+	shift
 	case "$header" in
 	common-cmds.h)
 		# should only be included by help.c, not checked
@@ -38,15 +39,17 @@ check_header () {
 check_headers () {
 	for header in *.h ewah/*.h vcs-svn/*.h xdiff/*.h
 	do
-		check_header "$header"
+		check_header "$header" "$@"
 	done
 }
 
 check_header_usage () {
-	first=$(grep '^#include' "$1" |
-		head -n1 |
-		sed -e 's,#include ",,' -e 's,"$,,')
-
+	first=$( 
+		sed -n -e '/^#include/{
+			s/#include ["<]\(.*\)".*/\1/p
+			q
+		}' "$1"
+	)
 	case "$first" in
 	cache.h|builtin.h|git-compat-util.h)
 		# happy
