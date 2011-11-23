From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] Fix revert --abort on Windows
Date: Wed, 23 Nov 2011 09:49:38 +0100
Message-ID: <4ECCB3A2.5030102@viscovery.net>
References: <20111120073059.GA2278@elie.hsd1.il.comcast.net> <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com> <20111120094650.GB2278@elie.hsd1.il.comcast.net> <20111122111207.GA7399@elie.hsd1.il.comcast.net> <20111122112001.GF7399@elie.hsd1.il.comcast.net> <7vr50zd5x0.fsf@alter.siamese.dyndns.org> <20111123012721.GA14217@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Phil Hord <phil.hord@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 09:49:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RT8Wf-0003KT-Uu
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 09:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758766Ab1KWItq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 03:49:46 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:10917 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270Ab1KWIto (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 03:49:44 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RT8WR-0004YH-63; Wed, 23 Nov 2011 09:49:39 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id CE4EB1660F;
	Wed, 23 Nov 2011 09:49:38 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.24) Gecko/20111103 Thunderbird/3.1.16
In-Reply-To: <20111123012721.GA14217@elie.hsd1.il.comcast.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185828>

From: Johannes Sixt <j6t@kdbg.org>

On Windows, it is not possible to rename or remove a directory that has
open files. 'revert --abort' renamed .git/sequencer when it still had
.git/sequencer/head open. Close the file as early as possible to allow
the rename operation on Windows.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 I guess it's too late to squash this in. ;)

 -- Hannes

 builtin/revert.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 0c61668..5dedb51 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -931,8 +931,10 @@ static int sequencer_rollback(struct replay_opts *opts)
 	if (strbuf_getline(&buf, f, '\n')) {
 		error(_("cannot read %s: %s"), filename, ferror(f) ?
 			strerror(errno) : _("unexpected end of file"));
+		fclose(f);
 		goto fail;
 	}
+	fclose(f);
 	if (get_sha1_hex(buf.buf, sha1) || buf.buf[40] != '\0') {
 		error(_("stored pre-cherry-pick HEAD file '%s' is corrupt"),
 			filename);
@@ -941,11 +943,9 @@ static int sequencer_rollback(struct replay_opts *opts)
 	if (reset_for_rollback(sha1))
 		goto fail;
 	strbuf_release(&buf);
-	fclose(f);
 	return 0;
 fail:
 	strbuf_release(&buf);
-	fclose(f);
 	return -1;
 }
 
-- 
1.7.8.rc3.1164.gba869.dirty
