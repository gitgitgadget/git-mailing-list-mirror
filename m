From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/9] Handle more shell metacharacters in editor names
Date: Wed, 11 Nov 2009 17:52:44 -0600
Message-ID: <20091111235244.GB1140@progeny.tock>
References: <20091030101634.GA1610@progeny.tock>
 <20091031012050.GA5160@progeny.tock>
 <20091111235100.GA1140@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 00:42:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Mph-0004lr-M8
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 00:42:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbZKKXm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 18:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbZKKXm0
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 18:42:26 -0500
Received: from mail-gx0-f226.google.com ([209.85.217.226]:52576 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932085AbZKKXmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 18:42:25 -0500
Received: by gxk26 with SMTP id 26so1564321gxk.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 15:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=yquHJCCwSUrLNbh2HXh+M2z84QUz7PXthccL2JRNTSU=;
        b=e7eUsmsZE+aIQSBGn2uP1WiNeaVwcenuDO72kC5BI0bCSIjxMfpokIf7os5i+srWxc
         0+pDZW4211ac8u2aDbLiwuoUB4mYCfJLBjWn2UNqwQ01w1t3/tFe6pt0IXqbRsHrLN2H
         HV/glWdDwWf0JYdCb+QvfELyd7JTJmqf9T4GQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=eMBy4mc/9h6QAeFI0T3rqVyhhlM5jukSsCJ1Mp+77hCSL5NaEB1I3VhF9YAE/JguPo
         sx6pTe3JZEO7eM0Wk4UlAVLAY4Lu7PKs9LWWE2DCtZROCW+AGo6a4OGKYL9a4AnOzpLV
         s/mW5t89aNJH14S3DqnaZe5eG9E2CiK1ri/OE=
Received: by 10.150.113.13 with SMTP id l13mr3901780ybc.248.1257982950965;
        Wed, 11 Nov 2009 15:42:30 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 13sm1022978gxk.5.2009.11.11.15.42.29
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 15:42:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091111235100.GA1140@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132722>

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Unchanged from jn/editor-pager, included only for reference.

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
