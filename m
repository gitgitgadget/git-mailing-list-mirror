From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/5 v2] tag -v: Do not spawn a separate process for
 verify-tag
Date: Sat, 20 Mar 2010 17:14:51 -0500
Message-ID: <20100320221451.GB31098@progeny.tock>
References: <20100320050953.GA24746@progeny.tock>
 <20100320051414.GD24791@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos Rica <jasampler@gmail.com>,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 23:14:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt6vh-0003b7-Is
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 23:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203Ab0CTWN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 18:13:56 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:53573 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab0CTWNz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 18:13:55 -0400
Received: by gwaa18 with SMTP id a18so365312gwa.19
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 15:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=24f6B/EslvU0O1DB5PzlFx/2glkHEOxeuqum7DK8L5g=;
        b=GhWOdvmwvfQYYcsWIZLMVmVq7zaRUZe9FrY7hchi5gYC3qv3rTcE+YJ8IcJyXzQpmY
         IDOyE4I0LRaR3v92H/yIu5QXEpn00GBgOjJDQJshDiHVTEgYVhm5T/65iVTM+hcALUjk
         PBGtSxccg/+5gsxtrWhUPZy4tOKghKQ/2KJZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fm18/b5JJS7saZN9K9cU6mb3Wq4wzyljZzIwwekIii6oorq3m1YDL8ua7SZxmLI6mH
         D3VLZsdPguNKpjJozgafqCnzDNHnqWsKl9+UIYws1liXE04XRhk2BmiE36ZZvhLjN/P7
         G4tROZkg7GIfjwkayH43WXrl209bWbct/MAOI=
Received: by 10.100.76.6 with SMTP id y6mr11630422ana.189.1269123234874;
        Sat, 20 Mar 2010 15:13:54 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm1747446iwn.7.2010.03.20.15.13.52
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Mar 2010 15:13:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100320051414.GD24791@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142762>

Aside from handling of SIGPIPE, there was no reason for verify-tag
to run in a separate process.

Not much advantage to this I can see.  It just simplifies things
a little.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Rebased to remove the churn from patch 1, as suggested by Johannes.
Thanks.

The new series has only 4 patches:

  [PATCH 2/5] verify-tag: use sigchain library to block SIGPIPE
  [PATCH 3/5] Expose verify_tag()
  [PATCH 4/5 v2] tag -v: Do not spawn a separate process for verify-tag
  [PATCH 5/5] verify_tag_signature(): let caller look up tag object sha1

 builtin/tag.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 4ef1c4f..d138e0c 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -147,11 +147,7 @@ static int delete_tag(const char *name, const char *ref,
 static int verify_tag(const char *name, const char *ref,
 				const unsigned char *sha1)
 {
-	const char *argv_verify_tag[] = {"git-verify-tag",
-					"-v", "SHA1_HEX", NULL};
-	argv_verify_tag[2] = sha1_to_hex(sha1);
-
-	if (run_command_v_opt(argv_verify_tag, 0))
+	if (verify_tag_signature(sha1_to_hex(sha1), 1))
 		return error("could not verify the tag '%s'", name);
 	return 0;
 }
-- 
1.7.0.2
