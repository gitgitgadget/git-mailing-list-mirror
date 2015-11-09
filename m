From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH] t5813: avoid creating urls that break on cygwin
Date: Mon, 9 Nov 2015 18:49:35 +0100
Message-ID: <20151109174932.GA14146@spirit>
References: <20151109154501.GA27224@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, adam@dinwoodie.org,
	ramsay@ramsayjones.plus.com
To: peff@peff.net
X-From: git-owner@vger.kernel.org Mon Nov 09 18:49:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvqZb-00007Z-FN
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 18:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbbKIRtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 12:49:39 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34133 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbbKIRti (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2015 12:49:38 -0500
Received: by wmnn186 with SMTP id n186so117743262wmn.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2015 09:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker_net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/52K5sgRN/zGnywIOWgygke5s7E8O2B/SOKvSuXHb2A=;
        b=03zM37nv0PmNsr6yIo9V90S4fm/cdczE4oSRzy6es920JMBiAd/YfIsqCIFpW8y7Ta
         rg5WdwF2A/sb9Cc6WOrHrytOjwjq/Kok0UJij4T5n/eLs9EaxlzGdwZSDGBUBCPvEULT
         O/tJk1NOfS8NwRGF7lU5sQG1S7EYNLaiGIDEd4WIaGfll4+brdsWWAA0wfoIztKuW/dT
         ny05Use0FPCZE0VUUDQIrn2g80/1ALyXST5qai6TxKexD2SoGkcdqdRhKDELLFf4mjiP
         UD3C9lRK6rWh9y+xRoxyJvHOzat2Hj+pw9lSwy2LFmpV1QblCHp7udC8P3HdYaD/nMr4
         wj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=/52K5sgRN/zGnywIOWgygke5s7E8O2B/SOKvSuXHb2A=;
        b=mvL/0IdD2K88vl9jSZJKiNEXJnpeaWUtgAN6DAlAuzBHyhasrbumNq8YJq8IfwfPtM
         kLiUoSRgMgRtake2JtxdfPNTV5rYUqcgpVW+3fjBfI94dCEg4oQ0OLDvAeUf8ZXCfaHZ
         LvfmWRPj75x4enC3B7tVpCrki4pGBwUN3MsO6QtfsSEeCoPgL66g4FiIrqNps2dl7fYk
         3NmbOBvwJ6H2ADZJ3QAubt4SkzOcGXAzDkHjwkSq7TNy++OoNNjmvrM640bsamJM8nI3
         qthB6imFLwoE9kG+wVEgLpKOx/aZdoafTW97umKkfDHvkObdh1Q4eYePumUZCW/VJiE/
         Jheg==
X-Gm-Message-State: ALoCoQl/0dHEx6y7cKKMMyZT9UNNaLeUFeb5bpshHgnnTCCCaNiJ1XKq1jMfudS41ZK6+1QLfB4v
X-Received: by 10.194.219.169 with SMTP id pp9mr36010581wjc.119.1447091377675;
        Mon, 09 Nov 2015 09:49:37 -0800 (PST)
Received: from spirit ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id 20sm15446268wmh.8.2015.11.09.09.49.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2015 09:49:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20151109154501.GA27224@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281070>

When passed an ssh:// url, git strips ssh://host from the url but does
not remove leading slashes from the path. So when this test used
ssh://remote//path/to/pwd, the path accessed by our fake SSH is
//path/to/pwd, which cygwin interprets as a UNC path, causing the test
to fail.

We may want to actually fix this in git itself, making it remove extra
slashes from urls before feeding them to transports or helpers, but
that's for another topic as it could cause regressions.

Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
---

You're right of course. Somehow I remembered that the fake ssh was doing the
stripping, but didn't check that when writing the commit message. How about
this version?

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
