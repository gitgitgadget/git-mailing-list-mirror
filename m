From: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH] upload-pack: keep poll(2)'s timeout to -1
Date: Fri, 22 Aug 2014 15:19:11 +0000
Message-ID: <20140822151911.GA8531@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 17:19:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKqcc-0001rz-1u
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 17:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756542AbaHVPTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 11:19:18 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:37247 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756308AbaHVPTR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 11:19:17 -0400
Received: by mail-pd0-f180.google.com with SMTP id v10so16096424pde.11
        for <git@vger.kernel.org>; Fri, 22 Aug 2014 08:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=YXpCQWglh3Tm6164rKqWumNfo8nLnJl80ecV1S+EX0I=;
        b=H08DNI7nM9xudurn98DM7zSLSgxQGzxnyC2ArpnAfv54SxO4KSZbU36RlVWLPar4Qd
         KOChwJvoqN7tdB8GiAEqpUo0NGSrZCLUVcLHiZBRYPL556KLJ4u/fnmlgTjdK5Bvj9CY
         cRqJjvFFl72pAQhSBrhIkTEqcxAv4QwKVLbZ0FaJlom0uIV1Fm794oNtEoioZNdVWkBe
         Ef+bjLVic4Rfls8eoe+nPFWzaQlEFOu7r/CJi1EGw2yUrbGoSSEvqSRxRGupMZ8HjZOb
         +awgS33MYWxlqBjIOSCRNTafGu7q01/8YMfaGq6AvU1Y1PCW/jdh7mz3lDLBWqXbsVha
         ksdQ==
X-Gm-Message-State: ALoCoQldfPyJCxCPB3/olUTSPJrjjzYolKPsk29/5FloF10gxBAZIhQ7WsaA6j9EoljtkwzBXLeN
X-Received: by 10.66.141.164 with SMTP id rp4mr7164276pab.65.1408720756970;
        Fri, 22 Aug 2014 08:19:16 -0700 (PDT)
Received: from debian ([2600:3c01::f03c:91ff:fe73:b980])
        by mx.google.com with ESMTPSA id nw14sm55438583pab.15.2014.08.22.08.19.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 Aug 2014 08:19:16 -0700 (PDT)
X-Google-Original-From: Edward Thomson <ethomson@microsoft.com>
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255677>

Keep poll's timeout at -1 when uploadpack.keepalive = 0, instead of
setting it to -1000, since some pedantic old systems (eg HP-UX) and
the gnulib compat/poll will treat only -1 as the valid value for
an infinite timeout.

Signed-off-by: Edward Thomson <ethomson@microsoft.com>
---
 upload-pack.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/upload-pack.c b/upload-pack.c
index 01de944..433211a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -167,7 +167,9 @@ static void create_pack_file(void)
 		if (!pollsize)
 			break;
 
-		ret = poll(pfd, pollsize, 1000 * keepalive);
+		ret = poll(pfd, pollsize,
+			keepalive < 0 ? -1 : 1000 * keepalive);
+
 		if (ret < 0) {
 			if (errno != EINTR) {
 				error("poll failed, resuming: %s",
-- 
1.7.10.4
