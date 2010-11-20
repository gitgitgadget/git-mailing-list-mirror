From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 14/15] vcs-svn: Sharpen parsing of property lines
Date: Fri, 19 Nov 2010 18:54:45 -0600
Message-ID: <20101120005444.GO17445@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 01:55:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJbju-0003cJ-07
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 01:55:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756002Ab0KTAzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 19:55:33 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40191 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755795Ab0KTAzd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 19:55:33 -0500
Received: by gyb11 with SMTP id 11so331394gyb.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 16:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rfTJUmthF2sCwDgyhEQmtnXCcypj4Bvv2n/QV2yF1pk=;
        b=PNC80GeNTnn577L63HMFqHjoumuqWNFL2gcaWLzEHcR/cjZmpXlbJd2bOc8v6Ov52r
         yAEm9sHlDPvsZBJ8sZt1piZWLKPvSSSl5LkhM1pnLnEnh+3/K3vLIO42YGjEt5TQzzBN
         0Vlc1/qvLr5ccA2J8kIeIcpVfyz9oaB8G8Omo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PrE1CpmD0uU+BmSZ7NsS6DY4livyqSIuMYVcJeetkzzbfwBpSBJgp/UbikyG7eYtkD
         LhAJBzXi+hjXzZ409Bk8lskx6uRGe0+DDiDoAZ+7obcQJJyzIyYO6KFZ80NRCYInK43Y
         hP5dwsx0V59Vls4gB7rRMJtmaTgn+9CCLHIE4=
Received: by 10.150.199.15 with SMTP id w15mr4615806ybf.326.1290214532488;
        Fri, 19 Nov 2010 16:55:32 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id q4sm197697yba.2.2010.11.19.16.55.31
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 16:55:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120004525.GA17445@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161814>

Prepare to add a new type of property line (the 'D' line) to
handle property deltas.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/svndump.c |   30 +++++++++++++++++++-----------
 1 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 3acc36c..c3e1e32 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -134,21 +134,29 @@ static void handle_property(uint32_t key, const char *val, uint32_t len)
 
 static void read_props(void)
 {
-	uint32_t len;
 	uint32_t key = ~0;
-	char *val = NULL;
-	char *t;
+	const char *t;
 	while ((t = buffer_read_line()) && strcmp(t, "PROPS-END")) {
-		if (!strncmp(t, "K ", 2)) {
-			len = atoi(&t[2]);
-			key = pool_intern(buffer_read_string(len));
-			buffer_read_line();
-		} else if (!strncmp(t, "V ", 2)) {
-			len = atoi(&t[2]);
-			val = buffer_read_string(len);
+		uint32_t len;
+		const char *val;
+		const char type = t[0];
+
+		if (!type || t[1] != ' ')
+			die("invalid property line: %s\n", t);
+		len = atoi(&t[2]);
+		val = buffer_read_string(len);
+		buffer_skip_bytes(1);	/* Discard trailing newline. */
+
+		switch (type) {
+		case 'K':
+			key = pool_intern(val);
+			continue;
+		case 'V':
 			handle_property(key, val, len);
 			key = ~0;
-			buffer_read_line();
+			continue;
+		default:
+			die("invalid property line: %s\n", t);
 		}
 	}
 }
-- 
1.7.2.3
