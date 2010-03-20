From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/5] tag -v: Do not spawn a separate process for verify-tag
Date: Sat, 20 Mar 2010 00:14:14 -0500
Message-ID: <20100320051414.GD24791@progeny.tock>
References: <20100320050953.GA24746@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos Rica <jasampler@gmail.com>,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 06:13:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsr05-0000sR-Mn
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 06:13:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147Ab0CTFNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 01:13:25 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:51167 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab0CTFNY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 01:13:24 -0400
Received: by ywh2 with SMTP id 2so936703ywh.33
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 22:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=X6ldSnWjDJxSsHr2d3Vn39gIzqhRrmt+Inp3RHFSKtw=;
        b=aE7gINijFiOrp0GSRvINRj2kmBhcwn7CxsOBSD3iikhH5dzh7vb1rh4CGl9Gdw2Rbw
         H/N2bMMKGLte+v1VtcK7Yq3T183aNZxmobDlLrC6dOm5qvVmCxEDiKkaEsJFEDlJ1bzX
         ugBlc38aFgWceVTLECPO1b7iCHAJ3rFv2R9Fo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=O1sD5BYce4qx26utEonXm9li38LpNYAVPuNj/bekIriUD1k9YfdXqV7OMn4n7brUO7
         8NsaFpnZKLdCqRpRBbnKndsBSXNyBCqtgl0gkQl0pqg4Kfq0MMMlyFTKqOC41JiVtlA/
         qKeRSc9hoPi+IqemuyawS0e1X7I1FaKdSwtWM=
Received: by 10.100.21.27 with SMTP id 27mr9296261anu.93.1269062002757;
        Fri, 19 Mar 2010 22:13:22 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm865176iwn.7.2010.03.19.22.13.22
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Mar 2010 22:13:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100320050953.GA24746@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142686>

Aside from handling of SIGPIPE, there was no reason for verify-tag
to run in a separate process.

Not much advantage to this I can see.  It just simplifies things
a little.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/tag.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index d56c882..d138e0c 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -147,11 +147,7 @@ static int delete_tag(const char *name, const char *ref,
 static int verify_tag(const char *name, const char *ref,
 				const unsigned char *sha1)
 {
-	const char *argv_verify_tag[] = {"git", "verify-tag",
-					"-v", "SHA1_HEX", NULL};
-	argv_verify_tag[3] = sha1_to_hex(sha1);
-
-	if (run_command_v_opt(argv_verify_tag, 0))
+	if (verify_tag_signature(sha1_to_hex(sha1), 1))
 		return error("could not verify the tag '%s'", name);
 	return 0;
 }
-- 
1.7.0.2
