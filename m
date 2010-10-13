From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 07/11] vcs-svn: Check declared number of output bytes
Date: Wed, 13 Oct 2010 04:41:15 -0500
Message-ID: <20101013094115.GH32608@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
 <20100810125317.GB3921@kytes>
 <20101011023435.GA706@burratino>
 <20101011040140.GC5649@burratino>
 <20101013091714.GA32608@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 11:44:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5xt4-0005Ym-Ud
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 11:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485Ab0JMJoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 05:44:38 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49147 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901Ab0JMJoh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 05:44:37 -0400
Received: by gyg13 with SMTP id 13so23829gyg.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 02:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=pLS2rAx3uwXM56Rnh16s2Cwga9ni06yH8iaoL1S0D90=;
        b=lSgYNbQWH/5xmczN0xt6npZfZXUJi3HCf91wK9YiRCi220JM6BBkoan++U49WB0iMV
         uurGKahmsjgMBY/GI4FOi+pVxXybW3o64Mid1htkYKUaBwivAacW8XMFveL2iJenZKOP
         q2Al7B/lGggPNGr+GXzd6AQfWlvb5RmFPNrqw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xBsQqE+gT1DgPMpfT8upahwREHKT8+fyrsWv7s78CO9RjEqVDxO/yH4VoV+C/OygvI
         CO5RW34qrO5FeLoYE/nw9y8rfi+VIcC7cBR3L+qUsjOj5Zh4/y1MIiUhkK4PrVgYC/RH
         9HjYy4RnszVBFUNu5u0TLgvVAgioGYefIS+GU=
Received: by 10.90.83.14 with SMTP id g14mr3846641agb.119.1286963076395;
        Wed, 13 Oct 2010 02:44:36 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id b8sm6489752ana.22.2010.10.13.02.44.35
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 02:44:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101013091714.GA32608@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158920>

Check that the declared output size for each window is correct, and
reserve that amount of space in the output buffer in advance.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/svndiff.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index ac776e0..c03cd7e 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -220,10 +220,15 @@ static int apply_one_window(struct line_buffer *delta, off_t *delta_len,
 		rv = error("Cannot read delta: %s", strerror(errno));
 		goto done;
 	}
+	strbuf_grow(&ctx.out, out_len);
 	if (apply_window_in_core(&ctx) || write_strbuf(&ctx.out, out)) {
 		rv = -1;
 		goto done;
 	}
+	if (ctx.out.len != out_len) {
+		rv = error("Invalid delta: incorrect postimage length");
+		goto done;
+	}
  done:
 	strbuf_release(&ctx.data);
 	strbuf_release(&ctx.instructions);
-- 
1.7.2.3
