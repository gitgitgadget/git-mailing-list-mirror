From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 1/4] Add parse_date_format() convenience function for converting a format string to an enum date_mode
Date: Fri, 28 Sep 2007 15:17:26 +0100
Message-ID: <200709281517.26627.andyparkins@gmail.com>
References: <200709281516.05438.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 16:18:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbGfA-0001MF-4z
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 16:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758590AbXI1ORg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 10:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759362AbXI1ORg
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 10:17:36 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:3222 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758590AbXI1ORe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 10:17:34 -0400
Received: by fk-out-0910.google.com with SMTP id z23so3083572fkz
        for <git@vger.kernel.org>; Fri, 28 Sep 2007 07:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        bh=amNCZIXZMg8PiCmt1507VvUCSMMtldUFCDTirAwhTF8=;
        b=Sh8MhvgStU6X6rnSQgmiW0g0sI8CMiiqaL5My7ejrOU4E4mmmhph+5G+PRwTbYcM/WaVC77UqWnKAA0dIe86jkP4gb3CfWDhBASp7nhST7J+XZ2zaz0eRubz8ei419oY1Z+WHm3/Oge7BrD1bC+JmZZ/RCqKifnqGKs4sXcpWlM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=EsL6/72uA56nbkLglgmXEf4LfKo0alrpYQE0QCa6zZRFhTCY/CtWgMkCWH8eK2JuYNPStuQDzUItRI+4CuK2TbhOUYBn0TeFG9DEPooKGjdqe+Oc5dlewB9WzSYgGNyHkiiaLF5hLeJ9lwKwbYoRcZgv9wJOXZHt5i/i+JYQhmE=
Received: by 10.82.175.17 with SMTP id x17mr7721501bue.1190989048710;
        Fri, 28 Sep 2007 07:17:28 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id k5sm3943968nfd.2007.09.28.07.17.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 28 Sep 2007 07:17:27 -0700 (PDT)
In-Reply-To: <200709281516.05438.andyparkins@gmail.com>
X-TUID: 5d72cd79e5953b97
X-UID: 332
X-Length: 2362
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59398>

parse_date_format() is passed a string that is compared against a
pre-defined list and converted to an enum date_format.  The table is as
follows:

 - "relative"         => DATE_RELATIVE
 - "iso8601" or "iso" => DATE_ISO8601
 - "rfc2822"          => DATE_RFC2822
 - "short"            => DATE_SHORT
 - "local"            => DATE_LOCAL
 - "default"          => DATE_NORMAL

In the event that none of these strings is found, the function die()s.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 cache.h |    1 +
 date.c  |   20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 8246500..5587f7e 100644
--- a/cache.h
+++ b/cache.h
@@ -432,6 +432,7 @@ const char *show_date(unsigned long time, int timezone, enum date_mode mode);
 int parse_date(const char *date, char *buf, int bufsize);
 void datestamp(char *buf, int bufsize);
 unsigned long approxidate(const char *);
+enum date_mode parse_date_format(const char *format);
 
 extern const char *git_author_info(int);
 extern const char *git_committer_info(int);
diff --git a/date.c b/date.c
index 93bef6e..8f70500 100644
--- a/date.c
+++ b/date.c
@@ -584,6 +584,26 @@ int parse_date(const char *date, char *result, int maxlen)
 	return date_string(then, offset, result, maxlen);
 }
 
+enum date_mode parse_date_format(const char *format)
+{
+	if (!strcmp(format, "relative"))
+		return DATE_RELATIVE;
+	else if (!strcmp(format, "iso8601") ||
+		 !strcmp(format, "iso"))
+		return DATE_ISO8601;
+	else if (!strcmp(format, "rfc2822") ||
+		 !strcmp(format, "rfc"))
+		return DATE_RFC2822;
+	else if (!strcmp(format, "short"))
+		return DATE_SHORT;
+	else if (!strcmp(format, "local"))
+		return DATE_LOCAL;
+	else if (!strcmp(format, "default"))
+		return DATE_NORMAL;
+	else
+		die("unknown date format %s", format);
+}
+
 void datestamp(char *buf, int bufsize)
 {
 	time_t now;
-- 
1.5.3.2.105.gf47f2-dirty
