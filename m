From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 13/16] revert: simplify get_oneline() using mempcpy
Date: Wed, 17 Mar 2010 07:17:46 -0500
Message-ID: <20100317121746.GM25641@progeny.tock>
References: <20100317113655.GA25470@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Monnier <monnier@iro.umontreal.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 17 13:17:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrsBj-0004NN-0W
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 13:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760Ab0CQMRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 08:17:22 -0400
Received: from mail-px0-f198.google.com ([209.85.216.198]:59413 "EHLO
	mail-px0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754713Ab0CQMRV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 08:17:21 -0400
Received: by pxi36 with SMTP id 36so451276pxi.21
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 05:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=+rq52N8vb3S60PSK4GhjD5hQEw5NjhefkBhAaRU0YMI=;
        b=OOaqWEgxdJMS6IiqPWZkadd7y0N1AKOg6+0bi1wV4C1OaHvt0QlAyMV977OTH97RIE
         5QvGO9+UUMrXEnYOMF692qK4urBGnJZ5do+v7gNM6qQkYrZX2CL9xGNmCi1ZZka6+HMe
         tLAFO0aC1qE39b3y82cjSYG61+4UKlIYn6mS0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lJcFuFHeM3rWZ1rDovXnpEI1RcPDP5/p+HiSgQha88HoXiLKSztKm9Jr8ccDgvmBtw
         T9wchE0Mw1YzRLMmhG7PiLKR6XBc7yyKWmQyqx0CMjKX4bK58Nxd0OXg2eF3gLOF0mya
         p3JHtOjrMcnLs/d+F7vR272Dsq3cwm3vxM8qA=
Received: by 10.140.56.20 with SMTP id e20mr637349rva.1.1268828241156;
        Wed, 17 Mar 2010 05:17:21 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm6384883iwn.1.2010.03.17.05.17.20
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Mar 2010 05:17:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100317113655.GA25470@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142388>

Avoid some pointer arithmetic and make future modifications easier by
using mempcpy to advance a pointer as the result is written.

While at it, make the code more self-explanatory by using strlen() on
constant strings.  GCC will compute the length at compile time; I am
not sure about other compilers, but this is not performance-critical
anyway.  It should be simple to add a conststrlen() macro later if
needed.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/revert.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 4b2042f..6a47655 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -75,7 +75,7 @@ static void parse_args(int argc, const char **argv)
 
 static char *get_oneline(const char *message, char **body)
 {
-	char *result;
+	char *result, *q;
 	const char *p = message, *abbrev, *eol;
 	int abbrev_len, oneline_len;
 
@@ -94,12 +94,11 @@ static char *get_oneline(const char *message, char **body)
 	abbrev = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
 	abbrev_len = strlen(abbrev);
 	oneline_len = eol - p;
-	result = xmalloc(abbrev_len + 5 + oneline_len);
-	memcpy(result, abbrev, abbrev_len);
-	memcpy(result + abbrev_len, "... ", 4);
-	memcpy(result + abbrev_len + 4, p, oneline_len);
-	result[abbrev_len + 4 + oneline_len] = '\0';
-	*body = result + abbrev_len + 4;
+	q = result = xmalloc(abbrev_len + strlen("... ") + oneline_len + 1);
+	q = mempcpy(q, abbrev, abbrev_len);
+	*body = q = mempcpy(q, "... ", strlen("... "));
+	q = mempcpy(q, p, oneline_len);
+	*q = '\0';
 	return result;
 }
 
-- 
1.7.0
