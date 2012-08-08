From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fast-import: Handle 'sub/testname' to
 'sub/testname/testfile' renaming correctly
Date: Wed, 08 Aug 2012 15:04:11 -0700
Message-ID: <7vd331qbvo.fsf@alter.siamese.dyndns.org>
References: <1344454971-19559-1-git-send-email-techlivezheng@gmail.com>
 <1344454971-19559-2-git-send-email-techlivezheng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Elijah Newren" <newren@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Techlive Zheng <techlivezheng@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 00:04:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzEMY-0005us-6r
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 00:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439Ab2HHWEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 18:04:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40059 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409Ab2HHWEO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 18:04:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3B1C6D6C;
	Wed,  8 Aug 2012 18:04:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5NyfX5i2EUED0ccWY6QEw8cgSdA=; b=Qfb6NY
	WwatckKZC60qBE2x2lvykII1FFLRZRZ512hggWHcHu7St16odSs4HZEluy24AhB1
	Y0IypCTiBSZl7jUAIRETB7Md1OBj0kxOarEB7q9S5ZbtvjsRjz5pKhwd4RL80mxh
	8qcw4sxmuWZHIrBMD4/Xl7T8YdlXzr7BbOb1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VliiVk3ZekOJnov7RmaX0Alc+OXFnf2m
	HSadiLR9KJIt9xfO49V0UuAtqbfNnio/Q2bhpzzL5AWFXUcmh6jYHIRa3M+pI59I
	3qnwSTuJhJKkAHocJ2SmZXyXBC6DH9FKIlu0+4GsE47z5KcKtDV1JcNTDuPnRDi4
	dlJdUy4FYlo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1A206D68;
	Wed,  8 Aug 2012 18:04:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 331CD6D66; Wed,  8 Aug 2012
 18:04:13 -0400 (EDT)
In-Reply-To: <1344454971-19559-2-git-send-email-techlivezheng@gmail.com>
 (Techlive Zheng's message of "Thu, 9 Aug 2012 03:42:50 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FCEE0EBA-E1A4-11E1-A5C8-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203137>

Judging from "git shortlog --since=6.months fast-import.c", Jonathan
may be the most qualified to see if this makes sense, among the
active list regulars, so....

-- >8 --
From: Techlive Zheng <techlivezheng@gmail.com>
Subject: [PATCH 2/2] fast-import: Handle 'sub/testname' to 'sub/testname/testfile' renaming correctly
Date: Thu,  9 Aug 2012 03:42:50 +0800

The current git-fast-import would not correctly handle such a commit stream
in which a file was deleted and at the same time a directory with the same
name was created. All paths under the newly created directory will be lost
after the importing.
---
 fast-import.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fast-import.c b/fast-import.c
index eed97c8..8874b4b 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1595,6 +1595,15 @@ static int tree_content_remove(
 				 * exist and need not be deleted.
 				 */
 				return 1;
+			if (!slash1 && S_ISREG(e->versions[0].mode) && S_ISDIR(e->versions[1].mode))
+			    /*
+			     * If p names a file in some subdirectory and in
+			     * some commit that file got deleted, a directory
+			     * with the same name was set up in the same directory,
+			     * then there is no need to step into for further
+			     * iteration or deletion.
+			     */
+				return 0;
 			if (!slash1 || !S_ISDIR(e->versions[1].mode))
 				goto del_entry;
 			if (!e->tree)
-- 
1.7.11.4
