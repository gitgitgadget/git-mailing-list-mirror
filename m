From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: avoid stack-buffer-read-overrun for very long name
Date: Wed, 25 Apr 2012 12:37:38 -0700
Message-ID: <xmqq1unbd2m5.fsf@junio.mtv.corp.google.com>
References: <87ty0jbt5p.fsf@rho.meyering.net> <20120416222713.GA2396@moj>
	<87397t862o.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcus Karlsson <mk@acc.umu.se>, git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Wed Apr 25 21:37:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN826-0003b8-Ii
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 21:37:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758017Ab2DYThk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 15:37:40 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:40217 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757595Ab2DYThj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 15:37:39 -0400
Received: by qcsp5 with SMTP id p5so59273qcs.1
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 12:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=cKhNnZvnwUOJ/8adtsJXAnnIsRu7giSjHxAN/KWu40g=;
        b=UbiT/5lzX2kn+WW/nEPyDtTYcn6jN5t+cOHKR1ehvafvDNel4uxGDwypOD/OmeE+2R
         9+ewmwfWBQ7ywcPzzESHDCpriR/fd3Bwib0Fs9kD2e2E/pxLpw/tvqWq8VUfDiLtyU9z
         /AeR027BbgGi45Q841pAJp9bbeVK0VfbWV8t83Qdlzm8m+sbBjsR7iZKPeB97kivyNCg
         YqQgh0emFiQ3BmOLC+AzbWS0X4jMeQI9GrSK/A/C+aIywJRpPMdYjc+AN0bmOTds0Y86
         Nsl1l8wXBlyeopkLnRoXF0G/RIPndNJfo+x/vodfODV1wLsCj79Q3KU/cdC+v0lfHBVt
         39FQ==
Received: by 10.236.79.74 with SMTP id h50mr4715722yhe.6.1335382658967;
        Wed, 25 Apr 2012 12:37:38 -0700 (PDT)
Received: by 10.236.79.74 with SMTP id h50mr4715699yhe.6.1335382658839;
        Wed, 25 Apr 2012 12:37:38 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id j51si609047yhi.1.2012.04.25.12.37.38
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 25 Apr 2012 12:37:38 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id A13CA10004D;
	Wed, 25 Apr 2012 12:37:38 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 4C110E125C; Wed, 25 Apr 2012 12:37:38 -0700 (PDT)
In-Reply-To: <87397t862o.fsf@rho.meyering.net> (Jim Meyering's message of
	"Tue, 24 Apr 2012 18:09:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmB3GVhIbw71CAxy/jcE5gP0k4gVP7Z9zXOpkpd28QXKc4zclElqZjXncpwVora0BiO4W4tFhcLc80fStQZ4IDSuvll3T3Ua68UYEwwuJBKz4qa3J2AuAx5zZJQxsMq9CoSz67tk0jcQt0tEwip8pqEdmbT1wswLMF8ZmEaNv8FeRWvHyU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196332>

Jim Meyering <jim@meyering.net> writes:

> Marcus Karlsson wrote:
> ...
>> Are there any guarantees that len1 and len2 does not exceed PATH_MAX?
>> Because if there aren't any then that function looks like it could need
>> even more improvements.
>
> Hi Marcus,
>
> You're right to ask.
> I've just confirmed that there is such a guarantee.

In any case, I think this is an old part of the codebase that has not
been updated to take advantage of newer API, partly because not many
people cared, and partly because there wasn't any serious bug there,
that can use some facelifting.  Wouldn't it make more sense to use
strbuf here, perhaps like this (not even compile tested), on top of your
patch?

 diff-no-index.c |   40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 5cd3ff5..b44473e 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -52,7 +52,7 @@ static int get_mode(const char *path, int *mode)
 }
 
 static int queue_diff(struct diff_options *o,
-		const char *name1, const char *name2)
+		      const char *name1, const char *name2)
 {
 	int mode1 = 0, mode2 = 0;
 
@@ -63,10 +63,11 @@ static int queue_diff(struct diff_options *o,
 		return error("file/directory conflict: %s, %s", name1, name2);
 
 	if (S_ISDIR(mode1) || S_ISDIR(mode2)) {
-		char buffer1[PATH_MAX], buffer2[PATH_MAX];
+		struct strbuf buffer1 = STRBUF_INIT;
+		struct strbuf buffer2 = STRBUF_INIT;
 		struct string_list p1 = STRING_LIST_INIT_DUP;
 		struct string_list p2 = STRING_LIST_INIT_DUP;
-		int len1 = 0, len2 = 0, i1, i2, ret = 0;
+		int i1, i2, ret = 0;
 
 		if (name1 && read_directory(name1, &p1))
 			return -1;
@@ -76,19 +77,15 @@ static int queue_diff(struct diff_options *o,
 		}
 
 		if (name1) {
-			len1 = strlen(name1);
-			if (len1 > 0 && name1[len1 - 1] == '/')
-				len1--;
-			memcpy(buffer1, name1, len1);
-			buffer1[len1++] = '/';
+			strbuf_addstr(&buffer1, name1);
+			if (buffer1.len && buffer1.buf[buffer1.len - 1] != '/')
+				strbuf_addch(&buffer1, '/');
 		}
 
 		if (name2) {
-			len2 = strlen(name2);
-			if (len2 > 0 && name2[len2 - 1] == '/')
-				len2--;
-			memcpy(buffer2, name2, len2);
-			buffer2[len2++] = '/';
+			strbuf_addstr(&buffer2, name2);
+			if (buffer2.len && buffer2.buf[buffer2.len - 1] != '/')
+				strbuf_addch(&buffer2, '/');
 		}
 
 		for (i1 = i2 = 0; !ret && (i1 < p1.nr || i2 < p2.nr); ) {
@@ -100,31 +97,28 @@ static int queue_diff(struct diff_options *o,
 			else if (i2 == p2.nr)
 				comp = -1;
 			else
-				comp = strcmp(p1.items[i1].string,
-					p2.items[i2].string);
+				comp = strcmp(p1.items[i1].string, p2.items[i2].string);
 
 			if (comp > 0)
 				n1 = NULL;
 			else {
-				n1 = buffer1;
-				strncpy(buffer1 + len1, p1.items[i1++].string,
-						PATH_MAX - len1);
-				buffer1[PATH_MAX-1] = 0;
+				strbuf_addstr(&buffer1, p1.items[i1++].string);
+				n1 = buffer1.buf;
 			}
 
 			if (comp < 0)
 				n2 = NULL;
 			else {
-				n2 = buffer2;
-				strncpy(buffer2 + len2, p2.items[i2++].string,
-						PATH_MAX - len2);
-				buffer2[PATH_MAX-1] = 0;
+				strbuf_addstr(&buffer2, p2.items[i2++].string);
+				n2 = buffer2.buf;
 			}
 
 			ret = queue_diff(o, n1, n2);
 		}
 		string_list_clear(&p1, 0);
 		string_list_clear(&p2, 0);
+		strbuf_reset(&buffer1);
+		strbuf_reset(&buffer2);
 
 		return ret;
 	} else {
