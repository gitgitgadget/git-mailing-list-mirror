From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Can I fetch an arbitrary commit by sha1?
Date: Tue, 7 Oct 2014 20:12:57 +0700
Message-ID: <20141007131257.GA24348@lanh>
References: <CAENte7htO13s91UJFNzW4aBhsGxE=LpnvaZfce+vqQU5+a-cYg@mail.gmail.com>
 <CAPBPrnsA4KxNximtKXcC37kuwBHK0Esytdm4nsgLHkrJSg3Ufw@mail.gmail.com>
 <20141002161006.GB2505@peff.net>
 <CACh33FpWPuyJRryf6hzbAkqWJMwzz1mLLDDRxEQ0niT2CznTRg@mail.gmail.com>
 <CACsJy8B0dbE0C3M0PO-EfaZ_bSxwGJSFVejEGFzjHSOZKOc+Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Dan Johnson <computerdruid@gmail.com>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Git <git@vger.kernel.org>
To: Patrick Donnelly <batrick@batbytes.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 15:13:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbUZX-0005gk-Tt
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 15:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753764AbaJGNM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 09:12:56 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:38283 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753758AbaJGNMz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 09:12:55 -0400
Received: by mail-pd0-f177.google.com with SMTP id v10so5039283pde.36
        for <git@vger.kernel.org>; Tue, 07 Oct 2014 06:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=siwFqRIFSOcXvyPu+MKtaHMQ9o6ayHDmapPvhAIZa48=;
        b=B0ZLrflIY4uLpLZ3P7MK809iXEN1NA37CMQYCtLBOlRoMrw0CGmVa8Dt8JofWBwVVP
         VaqRZn4xEsD1S9VjxzewYu0m71ezpMkloSZKDuFEzPw1AS/BtCNTwRM2+wHh/kk7cXfr
         irll4/gCE3QV5178l5vvurgAkj9cktQp3QPIYChWjzMYdtlwwmCxbCjHBEgyq623mJay
         zDH5LWAjbSlt7TfXPv+W+Z7IN7BGxDsyNO0tp6b5nFUEMgP9jqSYr8xvDqXWzn+ItZvY
         3TbNUsl38xbdScmzqySToM/a+VXHYXmbkfYvEnBBDegj7XYuw/GZ8ticNGPjYaGi+cFL
         OaaQ==
X-Received: by 10.68.239.202 with SMTP id vu10mr3492290pbc.109.1412687566974;
        Tue, 07 Oct 2014 06:12:46 -0700 (PDT)
Received: from lanh ([115.73.241.101])
        by mx.google.com with ESMTPSA id ha10sm16051601pbd.7.2014.10.07.06.12.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Oct 2014 06:12:46 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 07 Oct 2014 20:12:57 +0700
Content-Disposition: inline
In-Reply-To: <CACsJy8B0dbE0C3M0PO-EfaZ_bSxwGJSFVejEGFzjHSOZKOc+Jw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257925>

On Tue, Oct 07, 2014 at 07:34:36PM +0700, Duy Nguyen wrote:
> If we can verify the asked sha-1 is reachable from the visible ref
> set, then we should allow it. With pack bitmaps, it's getting much
> cheaper to do such a test. If pack bitmaps are not used, we could
> set a default/configurable limit, like not traversing more than 1000
> commits from any ref for this reachability test).

Hmm.. Junio already did most of the work in 051e400 (helping
smart-http/stateless-rpc fetch race - 2011-08-05), so all we need to
do is enable uploadpack.allowtipsha1inwant and apply this patch

-- 8< --
diff --git a/upload-pack.c b/upload-pack.c
index c789ec0..493f8ee 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -454,10 +454,6 @@ static void check_non_tip(void)
 	char namebuf[42]; /* ^ + SHA-1 + LF */
 	int i;
 
-	/* In the normal in-process case non-tip request can never happen */
-	if (!stateless_rpc)
-		goto error;
-
 	cmd.argv = argv;
 	cmd.git_cmd = 1;
 	cmd.no_stderr = 1;
-- 8< --

If we already let smart-http do this, I don't see any harm in letting
git protocol do the same (even though it's the the original reason why
this code exists).
--
Duy
