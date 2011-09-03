From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCHv2 3/2] remote rename: warn when refspec was not updated
Date: Sat,  3 Sep 2011 11:26:59 -0400
Message-ID: <1315063619-6072-1-git-send-email-martin.von.zweigbergk@gmail.com>
References: <20110902160333.GB19690@sigill.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 03 17:27:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qzs7x-0007bx-Ic
	for gcvg-git-2@lo.gmane.org; Sat, 03 Sep 2011 17:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498Ab1ICP1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Sep 2011 11:27:21 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:35235 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241Ab1ICP1U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Sep 2011 11:27:20 -0400
Received: by vxi9 with SMTP id 9so2832404vxi.19
        for <git@vger.kernel.org>; Sat, 03 Sep 2011 08:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=949NOsc7Lm5FWNUtncaU2vuy/JguaGkEn0Z7vfAgA+0=;
        b=D7LjKNTFH0wbnb7uUIWqNSS+WE2SVxfkvEP301JX5cv/CccsZZ9lW7miFV8i86MTso
         hPuO0AbRUho6CFIiF9ytbHTu/0CC1g+kHHMppR4aM1bXQn9ZsoMEhxsQYRIeGM5w0p7L
         76Nl40JWz4f5nO1gTsssjoPaX3GfWDPsSr4rk=
Received: by 10.52.174.36 with SMTP id bp4mr2083129vdc.256.1315063640049;
        Sat, 03 Sep 2011 08:27:20 -0700 (PDT)
Received: from localhost.localdomain (modemcable094.77-37-24.mc.videotron.ca [24.37.77.94])
        by mx.google.com with ESMTPS id a10sm1638953vdk.7.2011.09.03.08.27.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Sep 2011 08:27:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.51.g07e0e
In-Reply-To: <20110902160333.GB19690@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180656>

When renaming a remote, we also try to update the fetch refspec
accordingly, but only if it has the default format. For others, such
as refs/heads/master:refs/heads/origin, we are conservative and leave
it untouched. Let's give the user a warning about refspecs that are
not updated, so he can manually update the config if necessary.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---

This addresses the first part of your email. I'm not sure what should
happen when only some refspecs can be updated. I can't think of any
sensible examples with mixed default and non-default refspecs, so for
me it's hard to see whether we would make things better or worse by
making it all-or-nothing. I have more or less always used the default
ones myself. Do you have any good examples?

 builtin/remote.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 0df6ab0..61326cb 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -672,6 +672,12 @@ static int mv(int argc, const char **argv)
 				      ptr-buf2.buf + strlen(":refs/remotes/"),
 				      strlen(rename.old), rename.new,
 				      strlen(rename.new));
+		else
+			warning("Not updating non-default fetch respec\n"
+				"\t%s\n"
+				"\tPlease update the configuration manually if necessary.",
+				buf2.buf);
+
 		if (git_config_set_multivar(buf.buf, buf2.buf, "^$", 0))
 			return error("Could not append '%s'", buf.buf);
 	}
-- 
1.7.6.51.g07e0e
