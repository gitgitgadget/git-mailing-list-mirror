From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 11/13] Allow helpers to request the path to the .git directory
Date: Wed,  4 Nov 2009 20:48:16 +0100
Message-ID: <1257364098-1685-12-git-send-email-srabbelier@gmail.com>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:50:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5lrl-0000NL-Gt
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 20:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbZKDTth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 14:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758097AbZKDTtg
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 14:49:36 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:55343 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758090AbZKDTtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 14:49:16 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so3490482ewy.37
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 11:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=jz+f19IrUKieIYfHygt5C100a+UJ8ZSgmVoyyzKD2Ss=;
        b=XIzsfciVNbrgrdCHBgtfA5toLtZoATzrYReACybCW2VWwx/3cC0flXjxGIk38s6sTY
         BSpWRg4vO6Nij0zNx0RFaH6yLVReLaRn6sjwuVXjmgwJuBUqmH9wR4fVr0nqMPq7qDKW
         E39kn47E7Mkm+V6Wdj/6YibMpptMbBD2FitGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=I0GVJ5zx3C5GRE0aEGpCJRLXpvlOkoR0UPxgH3ga3MNJgcpVWUT/wz9edi+x90fjYG
         JFdk8Yxo56YVmlTobkUvlepWk5qt1ksDaiwnlaET+XS9VQtL6cev/t6G/E9DXm8xkRok
         h3rJ1sX2qoJsx9X7HG75f0k6erawnu+QNcPYc=
Received: by 10.213.96.65 with SMTP id g1mr1792943ebn.44.1257364161646;
        Wed, 04 Nov 2009 11:49:21 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 5sm4314489eyh.2.2009.11.04.11.49.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 11:49:20 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2.295.g0d105
In-Reply-To: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132123>

The 'gitdir' capability is reported by the remote helper if it
requires the location of the .git directory. The location of the .git
directory can then be used by the helper to store status files even
when the current directory is not a git repository (such as is the
case when cloning).

The location of the .git dir is specified as an absolute path.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	Daniel, is this a good idea, or should we perhaps tell the
	helper the location of the git repository otherwise?

 transport-helper.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index a80d803..4f95e7b 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -51,6 +51,12 @@ static struct child_process *get_helper(struct transport *transport)
 			data->fetch = 1;
 		if (!strcmp(buf.buf, "import"))
 			data->import = 1;
+		if (!strcmp(buf.buf, "gitdir")) {
+			struct strbuf gitdir = STRBUF_INIT;
+			strbuf_addf(&gitdir, "gitdir %s\n", get_git_dir());
+			write_in_full(helper->in, gitdir.buf, gitdir.len);
+			strbuf_reset(&gitdir);
+		}
 	}
 	return data->helper;
 }
-- 
1.6.5.2.295.g0d105
