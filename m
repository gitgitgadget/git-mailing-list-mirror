From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/4] Introduce advise() to print hints
Date: Wed, 11 Aug 2010 03:36:41 -0500
Message-ID: <20100811083641.GC16495@burratino>
References: <20100725005443.GA18370@burratino>
 <AANLkTilnQhsopnuAf0nja8Qq63VrOlt0_uCJrqYv5X-v@mail.gmail.com>
 <201007251122.41166.trast@student.ethz.ch>
 <20100729235151.GB6623@burratino>
 <AANLkTi=ao2RY8NGm4cACqz3_5zfT2zvXB4JHOopBD9T5@mail.gmail.com>
 <20100811083100.GA16495@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 10:38:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj6pE-0002AL-BM
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 10:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754603Ab0HKIiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 04:38:11 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:42120 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753018Ab0HKIiK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 04:38:10 -0400
Received: by gwb20 with SMTP id 20so3982122gwb.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 01:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=9Pb2QiuHfTfx0EFX/XHdXrDOdQzYuLdf++Cy3NCV74Q=;
        b=kMYC7VMHUVeT3HYE709jl3s41v1DgxAM1qns+BUHvk4RHV9DHtI8IHdhx2LzdHVo+D
         wYuvuC2B5k6VAzK+T0K3C68yvSOAg4DHlVKuctzOg9t2vfEZvXORELXEdZMFnaGyzA7F
         5Iw9kRvPZX7Czg7fBwv/cExblCq+XxNBAImz8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NyCZActm6p5L5HIC/ZzxZTIRAQNo88JNEem0jRglB31savr/wDCUjxnuEAcRK40BGo
         EuKDP82Y5AaCQnLg786nd0gY1SHDC7MT/LNt5XpxWMei2jLdQfJvodFIm+4aZ66XZeq/
         6yZKTQT5v/25oOYBXIh0hdIvYO8comNoD9Aoo=
Received: by 10.151.63.22 with SMTP id q22mr21238613ybk.106.1281515889738;
        Wed, 11 Aug 2010 01:38:09 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id t20sm5139694ybm.17.2010.08.11.01.38.09
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 01:38:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100811083100.GA16495@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153206>

Like error(), warn(), and die(), advise() prints a short message
with a formulaic prefix to stderr.

It is local to revert.c for now because I am not sure this is
the right API (we may want to take an array of advice lines or a
boolean argument for easy suppression of unwanted advice).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/revert.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index c3d64af..74c1581 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -241,6 +241,15 @@ static void set_author_ident_env(const char *message)
 			sha1_to_hex(commit->object.sha1));
 }
 
+static void advise(const char *advice, ...)
+{
+	va_list params;
+
+	va_start(params, advice);
+	vreportf("hint: ", advice, params);
+	va_end(params);
+}
+
 static char *help_msg(void)
 {
 	struct strbuf helpbuf = STRBUF_INIT;
-- 
1.7.2.1.544.ga752d.dirty
