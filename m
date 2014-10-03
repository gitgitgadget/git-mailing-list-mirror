From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH] bundle: plug minor memory leak in is_tag_in_date_range()
Date: Sat, 04 Oct 2014 00:40:24 +0200
Message-ID: <542F25D8.1000900@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 04 00:41:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XaBXq-0007cB-JO
	for gcvg-git-2@plane.gmane.org; Sat, 04 Oct 2014 00:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758695AbaJCWlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 18:41:45 -0400
Received: from mout.web.de ([212.227.17.12]:58890 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758690AbaJCWln (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 18:41:43 -0400
Received: from [192.168.178.27] ([79.253.134.107]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LwqJw-1YKa3m2wXY-016LHg; Sat, 04 Oct 2014 00:41:38
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
X-Provags-ID: V03:K0:J62uAzLXAwvhebLG4K14D0YQxx40qm9ggOUzJVCzuFfymARQBJ2
 e2is6FQDH6+axsbXkgI/ucogV8mraTVD3z/9gIE0+8OK0haUXaJT96IvX00bvQo0bFxx9bk
 6hZm7RybNDL2F7K6T6/weWsJvu5+A9NqdQp4SyHf//QAym9eIjSwnzHwa4jtvC3GcGxmjfy
 nJ9wrN8YPCj1EIK9z0wGg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257877>

Free the buffer returned by read_sha1_file() even if no valid tagger
line is found.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 bundle.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/bundle.c b/bundle.c
index b2b89fe..9ed865c 100644
--- a/bundle.c
+++ b/bundle.c
@@ -211,24 +211,28 @@ static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
 	enum object_type type;
 	char *buf, *line, *lineend;
 	unsigned long date;
+	int result = 1;
 
 	if (revs->max_age == -1 && revs->min_age == -1)
-		return 1;
+		goto out;
 
 	buf = read_sha1_file(tag->sha1, &type, &size);
 	if (!buf)
-		return 1;
+		goto out;
 	line = memmem(buf, size, "\ntagger ", 8);
 	if (!line++)
-		return 1;
+		goto out_free;
 	lineend = memchr(line, '\n', buf + size - line);
 	line = memchr(line, '>', lineend ? lineend - line : buf + size - line);
 	if (!line++)
-		return 1;
+		goto out_free;
 	date = strtoul(line, NULL, 10);
-	free(buf);
-	return (revs->max_age == -1 || revs->max_age < date) &&
+	result = (revs->max_age == -1 || revs->max_age < date) &&
 		(revs->min_age == -1 || revs->min_age > date);
+out_free:
+	free(buf);
+out:
+	return result;
 }
 
 int create_bundle(struct bundle_header *header, const char *path,
-- 
2.1.2
