From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH] t5813: avoid creating urls that break on cygwin
Date: Sun, 8 Nov 2015 10:54:04 +0100
Message-ID: <20151108095400.GA9448@spirit>
References: <20151108051059.GB19191@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peff@peff.net, gitster@pobox.com, adam@dinwoodie.org,
	ramsay@ramsayjones.plus.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 08 10:54:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvMfv-0008GT-Ip
	for gcvg-git-2@plane.gmane.org; Sun, 08 Nov 2015 10:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693AbbKHJyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2015 04:54:11 -0500
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36728 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222AbbKHJyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2015 04:54:09 -0500
Received: by wimw2 with SMTP id w2so53948218wim.1
        for <git@vger.kernel.org>; Sun, 08 Nov 2015 01:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker_net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=awO06oaCVX+evmuxkRme6ebBHKFwb9QRbpYaNJkauz4=;
        b=tLLB6mepAEOcb+Hw4NIvPpBNdUv1XCy6fGJz59uTD1EIt5V1hBHEct5gQI5ybrg0Ee
         r7UqZjDY5VQp9e0KxqGrNhM5GpinId8IzP9QncwfnzrYZmZFzzYBVM3AbBYXE996OGBl
         PQxgoX5jBvjF88xtxuqZX7CQjG9KEiidrNY+6ll4N7T0ITMh2K1xNHiYPAnsp9lMc3Cn
         2q1EcQ3hnVVAWEVnnZySLkZfvoqGfIH5nfNtz1kbnmgPyC3MV4u5bl53pqu+ztoMIr0j
         toCXjcDpVYNdmKNVO3HqYf9pe/evK8UhHIvh+B7lRkgn0AasiI9D2p9XsgrrxnuEPdvY
         ljwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=awO06oaCVX+evmuxkRme6ebBHKFwb9QRbpYaNJkauz4=;
        b=AFYwc9IqdScjMj1OEGK7wUYX5qyctY7sw69PzcrDnm/F4PrfbL/R7MK/d4GJ4Uk3Nq
         xWTcvFS2PasgHGanAWHcGFIWBU0SQIEpLbclTuzULeWJXkTTlknFEzMXJGqJ6nPmzYir
         yX+l6OIFPu6I2oZeeDYCxxvuHruzoyVXPmh/1WQXByrS7tJddafGK6j2Tv9xOj07cs/d
         BGxTxQ58XD/XxvFP4LjpKhwFO7MaVBY+a4uwXngk1uP+tZRYWHOOcUueS30WpRNKU/Oz
         nWgqzfyIQ/hC1dzlcCBF/X5FqCdxLX8LTpZ7RZkm0KNGhVLITnLk50smaB1i0ddn+lCx
         gspQ==
X-Gm-Message-State: ALoCoQk8w6dc9chCCeaEFOBNQyS7gOZtwLwK6E9no//EhW08jyzI9aGU+j9Hx73cboDj0eCfybI9
X-Received: by 10.194.8.38 with SMTP id o6mr23981849wja.42.1446976448353;
        Sun, 08 Nov 2015 01:54:08 -0800 (PST)
Received: from spirit ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id c194sm1519202wmd.13.2015.11.08.01.54.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2015 01:54:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151108051059.GB19191@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281035>

The fake ssh used by this test simply strips ssh://host from the url,
leaving paths behind that start with //, which cygwin interprets as UNC
paths, causing the test to fail.

We may want to actually fix this in git itself, making it remove extra
slashes from urls before feeding them to transports or helpers, but
that's for another topic as it could cause regressions.

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
---
 t/t5813-proto-disable-ssh.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5813-proto-disable-ssh.sh b/t/t5813-proto-disable-ssh.sh
index ad877d7..a954ead 100755
--- a/t/t5813-proto-disable-ssh.sh
+++ b/t/t5813-proto-disable-ssh.sh
@@ -14,7 +14,7 @@ test_expect_success 'setup repository to clone' '
 '
 
 test_proto "host:path" ssh "remote:repo.git"
-test_proto "ssh://" ssh "ssh://remote/$PWD/remote/repo.git"
-test_proto "git+ssh://" ssh "git+ssh://remote/$PWD/remote/repo.git"
+test_proto "ssh://" ssh "ssh://remote$PWD/remote/repo.git"
+test_proto "git+ssh://" ssh "git+ssh://remote$PWD/remote/repo.git"
 
 test_done
-- 
2.6.3-495-gf0a7f49


-- 
Dennis Kaarsemaker <dennis@kaarsemaker.net>
http://twitter.com/seveas
