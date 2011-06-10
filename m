From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/6] zlib: wrap remaining calls to direct inflate/inflateEnd
Date: Fri, 10 Jun 2011 13:15:44 -0700
Message-ID: <1307736948-16956-3-git-send-email-gitster@pobox.com>
References: <1307736948-16956-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 22:16:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QV87n-00068o-TM
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 22:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758034Ab1FJUP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2011 16:15:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44962 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758045Ab1FJUP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2011 16:15:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A90ED4250
	for <git@vger.kernel.org>; Fri, 10 Jun 2011 16:18:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=6lWT
	W/4qd/39fDmP/vLoReWdNxc=; b=duZUaoJOIlLTm+C8Uv3qIA09gfYu9yAT6YYc
	VkixJu4DfSNtI4c6k+OfdPluKDkKp5K5LgJaalVd+IxejdXLYeYjLs1A8Yy7x29I
	29w9wjf9w5CqZHx5ixk6QZsfjt1JoWP2YQXRVUG3RunqHTAlsMDp7hLQl5w56Xzt
	misd5WQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=AhZUNa
	EQHmieoCPbWzPucHVhPpXCdX7UqPvaBOSC0Jw6HE0XlZSMEdDYfioGObUqekINpE
	P4fQ3wdnjH4mlyvo0tlHtMpfhOgZRFzUnUmQJ1/0HfF+Zc1to8VS8q6y/K2kvQjE
	QcfgJ5a5k9w4gcy7uylM/A07SWyE7OmDApPqk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5F250424F
	for <git@vger.kernel.org>; Fri, 10 Jun 2011 16:18:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BBB57424E for
 <git@vger.kernel.org>; Fri, 10 Jun 2011 16:18:03 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.rc1.118.ge175b4a
In-Reply-To: <1307736948-16956-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: BF3204DC-939E-11E0-BED2-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175620>

Two callsites in http-backend.c to inflate() and inflateEnd()
were not using git_ prefixed versions.  After this, running

    $ find all objects -print | xargs nm -ugo | grep inflate

shows only zlib.c makes direct calls to zlib for inflate operation,
except for a singlecall to inflateInit2 in http-backend.c

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http-backend.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 8501504..c74cb03 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -296,7 +296,7 @@ static void inflate_request(const char *prog_name, int out)
 			stream.next_out = out_buf;
 			stream.avail_out = sizeof(out_buf);
 
-			ret = inflate(&stream, Z_NO_FLUSH);
+			ret = git_inflate(&stream, Z_NO_FLUSH);
 			if (ret != Z_OK && ret != Z_STREAM_END)
 				die("zlib error inflating request, result %d", ret);
 
@@ -311,7 +311,7 @@ static void inflate_request(const char *prog_name, int out)
 	}
 
 done:
-	inflateEnd(&stream);
+	git_inflate_end(&stream);
 	close(out);
 }
 
-- 
1.7.6.rc1.118.ge175b4a
