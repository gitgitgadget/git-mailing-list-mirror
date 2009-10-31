From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/8] Handle more shell metacharacters in editor names
Date: Fri, 30 Oct 2009 20:24:04 -0500
Message-ID: <20091031012404.GB5160@progeny.tock>
References: <20091030101634.GA1610@progeny.tock>
 <20091031012050.GA5160@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 02:13:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N42XS-0000x4-QV
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 02:13:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933127AbZJaBNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 21:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933098AbZJaBNo
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 21:13:44 -0400
Received: from mail-gx0-f212.google.com ([209.85.217.212]:49185 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933077AbZJaBNo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 21:13:44 -0400
Received: by gxk4 with SMTP id 4so2446521gxk.8
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 18:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=e5PUYfXKJ5RS7cKUGRtKukG4JFmvD8spQSqLh0rdKYU=;
        b=XT7bewP8oTNQI5XOImSFtcudolyv05+ceEKR3qjaOSC+OEfTlNpX/thblHorH2am+P
         1NT/DQ9C91nrieQrCIJeYbUqPmdj/iA7vqX6MH+CvrReaYBqS3AOl7Yk1pROG0FyQum8
         WXzU1IFgKEE9vrIAMwmQ+EmjGFBzT+sOX9xY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=qKWTCRKp/wuLHA4lA6gFxq9MiLajD/0u6Xck5B4W+jeFyCkBQUNdNzK8m10TS6NfAe
         GiLbT2AkEBq8fHBAoSe+kAnbPtFIt8uh16/OBwSXw2lIwd0hN5lZw3RBBhslKrT+xJMT
         n71dogikl3b/5saFv1Ac9xHxI2zfB4Jvj8tOo=
Received: by 10.90.62.4 with SMTP id k4mr6011384aga.56.1256951627972;
        Fri, 30 Oct 2009 18:13:47 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm246542yxe.39.2009.10.30.18.13.46
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 18:13:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091031012050.GA5160@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131814>

Pass the editor name to the shell if it contains any susv3 shell
special character (globs, redirections, variable substitutions,
escapes, etc).  This way, the meaning of some characters will not
meaninglessly change when others are added, and git commands
implemented in C and in shell scripts will interpret editor names
in the same way.

This does not make the GIT_EDITOR setting any more expressive,
since one could always use single quotes to force the editor to
be passed to the shell.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Unchanged from v2.

 editor.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/editor.c b/editor.c
index 4d469d0..941c0b2 100644
--- a/editor.c
+++ b/editor.c
@@ -28,7 +28,7 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 		const char *args[6];
 		struct strbuf arg0 = STRBUF_INIT;
 
-		if (strcspn(editor, "$ \t'") != len) {
+		if (strcspn(editor, "|&;<>()$`\\\"' \t\n*?[#~=%") != len) {
 			/* there are specials */
 			strbuf_addf(&arg0, "%s \"$@\"", editor);
 			args[i++] = "sh";
-- 
1.6.5.2
