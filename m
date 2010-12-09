From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] get_sha1: support relative path "<obj>:<sth>" syntax
Date: Thu, 09 Dec 2010 13:37:51 -0800
Message-ID: <7v7hfifx00.fsf@alter.siamese.dyndns.org>
References: <m3eiatfbg2.fsf@localhost.localdomain>
 <1289407021-30287-1-git-send-email-pclouds@gmail.com>
 <7vipz2fy98.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jnareb@gmail.com, dirson@bertin.fr,
	kevin@sb.org, peff@peff.net
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 22:38:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQoBv-0005iF-O7
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 22:38:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757038Ab0LIViM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 16:38:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49067 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325Ab0LIViL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 16:38:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2943239E1;
	Thu,  9 Dec 2010 16:38:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TTWO2j46S7IroMX+rIYe0L9hMXQ=; b=MuM+d3
	O+V4Ci+78wE7n1wkKnmlYKjkdfmhx8k/NHYy0Sbq2kxdlLP66P/iGfiuomrKGg7j
	5CLUpJa2ESprp8INTdtrBUgaDhxBt/hqS7n80F5T/rfJOZ+UPTIUyUgJyOK3vi8/
	oJ4SDLRb8KrI4ffqYD5OB3n4fXeeZ/QFkND54=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v8KAYxB+fG6rETS/JTp4R3A2Q3UMQlzM
	p8g4R/IuA77GgtXZRvOuyhVGeMJAJrpbUh7OmyIHG8hp/1omHh+3g5N+1d2uEWNG
	Es+PbXoLDj5RrKLNmkSHl1oEkzTpsmsfW7GOM0vknjUOt7ayN8cgyPkS8L9CHI4P
	XovseTxXeUE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B878739CE;
	Thu,  9 Dec 2010 16:38:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AD0E039C4; Thu,  9 Dec 2010
 16:38:16 -0500 (EST)
In-Reply-To: <7vipz2fy98.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 09 Dec 2010 13\:10\:43 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A6CBAE2C-03DC-11E0-A562-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163325>

Junio C Hamano <gitster@pobox.com> writes:

> I think it is just the matter of moving "if (startup-info)..." logic
> outside the "is the :$path lacking an explicit stage number" block and
> having it after that if/else, no?

Like this, perhaps?

-- >8 --
Subject: get_sha1: teach ":$n:<path>" the same relative path logic

Earlier we taught the object name parser ":<path>" syntax that uses a path
relative to the current working directory.  Given that ":<path>" is just a
short-hand for ":0:<path>" (i.e. "take stage #0 of that path"), we should
allow ":$n:<path>" to use relative path the same way.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c                    |   14 ++++++++------
 t/t1506-rev-parse-diagnosis.sh |   24 ++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index f918faf..2074056 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1091,17 +1091,19 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 			return get_sha1_oneline(name + 2, sha1);
 		if (namelen < 3 ||
 		    name[2] != ':' ||
-		    name[1] < '0' || '3' < name[1]) {
+		    name[1] < '0' || '3' < name[1])
 			cp = name + 1;
-			new_path = resolve_relative_path(cp);
-			if (new_path)
-				cp = new_path;
-		}
 		else {
 			stage = name[1] - '0';
 			cp = name + 3;
 		}
-		namelen = strlen(cp);
+		new_path = resolve_relative_path(cp);
+		if (!new_path) {
+			namelen = namelen - (cp - name);
+		} else {
+			cp = new_path;
+			namelen = strlen(cp);
+		}
 
 		strncpy(oc->path, cp,
 			sizeof(oc->path));
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index 1866470..9f8adb1 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -34,6 +34,8 @@ test_expect_success 'correct file objects' '
 test_expect_success 'correct relative file objects (0)' '
 	git rev-parse :file.txt >expected &&
 	git rev-parse :./file.txt >result &&
+	test_cmp expected result &&
+	git rev-parse :0:./file.txt >result &&
 	test_cmp expected result
 '
 
@@ -68,6 +70,28 @@ test_expect_success 'correct relative file objects (4)' '
 	)
 '
 
+test_expect_success 'correct relative file objects (5)' '
+	git rev-parse :subdir/file.txt >expected &&
+	(
+		cd subdir &&
+		git rev-parse :./file.txt >result &&
+		test_cmp ../expected result &&
+		git rev-parse :0:./file.txt >result &&
+		test_cmp ../expected result
+	)
+'
+
+test_expect_success 'correct relative file objects (6)' '
+	git rev-parse :file.txt >expected &&
+	(
+		cd subdir &&
+		git rev-parse :../file.txt >result &&
+		test_cmp ../expected result &&
+		git rev-parse :0:../file.txt >result &&
+		test_cmp ../expected result
+	)
+'
+
 test_expect_success 'incorrect revision id' '
 	test_must_fail git rev-parse foobar:file.txt 2>error &&
 	grep "Invalid object name '"'"'foobar'"'"'." error &&
