From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 4/7] remote-helpers: allow requesing the path to the .git directory
Date: Mon, 29 Mar 2010 11:48:26 -0500
Message-ID: <1269881309-19690-5-git-send-email-srabbelier@gmail.com>
References: <1269881309-19690-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Git List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jonathan Niede
X-From: git-owner@vger.kernel.org Mon Mar 29 18:49:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwI9b-0007r6-20
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 18:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754931Ab0C2Qsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 12:48:53 -0400
Received: from mail-iw0-f182.google.com ([209.85.223.182]:57074 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754914Ab0C2Qsv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 12:48:51 -0400
Received: by iwn12 with SMTP id 12so697878iwn.21
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 09:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5pj4+0D8wKHVfn8fryFzBQaPqWUsajMIE1Ggwia3UZg=;
        b=e30WsYWERr1qk/K4Vp1F+Gy32colP22WrWcz0XeR9mMoiM/Uvj2UmwE8izn1/HjMSa
         NGLPDCJJ66PXE5GNOICUPLdVhhg4EWZJs4V9YbVh3+ktUPeMG6BH/w3GimzH3ohdR8Gb
         ya4tSO+UgXVQ5RYQYOcWOn0f97ysZUZikSOf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XrewUBBLMdm9/hQApu+RAzat7MRq9GfhNOCMLUueNOLILL3Zi9gMjyCtN020VZYmnS
         F4mgD2dbpc2p4zozdsz+W3yEDPT9gdNvPZzSGWdBF0H5C3yJp9aWHr9MH/pDKi+nOJ4X
         zz1jX/0S/y+o8dzdFNk8R1iUn3feZisqjQ8vI=
Received: by 10.114.105.3 with SMTP id d3mr5197942wac.162.1269881330561;
        Mon, 29 Mar 2010 09:48:50 -0700 (PDT)
Received: from localhost.localdomain (97-114-181-145.frgo.qwest.net [97.114.181.145])
        by mx.google.com with ESMTPS id 23sm4102040iwn.10.2010.03.29.09.48.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Mar 2010 09:48:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.317.gbb04ec
In-Reply-To: <1269881309-19690-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143495>

The 'gitdir' capability is reported by the remote helper if it
requires the location of the .git directory. The location of the .git
directory can then be used by the helper to store status files even
when the current directory is not a git repository (such as is the
case when cloning).

The location of the .git dir is specified as an absolute path.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	This should probably be advertised as a required capability,
	but I haven't looked into those yet.

 transport-helper.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 2638781..c8705b7 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -170,6 +170,11 @@ static struct child_process *get_helper(struct transport *transport)
 			refspecs[refspec_nr++] = strdup(buf.buf + strlen("refspec "));
 		} else if (!strcmp(capname, "connect")) {
 			data->connect = 1;
+		} else if (!strcmp(buf.buf, "gitdir")) {
+			struct strbuf gitdir = STRBUF_INIT;
+			strbuf_addf(&gitdir, "gitdir %s\n", get_git_dir());
+			sendline(data, &gitdir);
+			strbuf_release(&gitdir);
 		} else if (mandatory) {
 			die("Unknown mandatory capability %s. This remote "
 			    "helper probably needs newer version of Git.\n",
-- 
1.7.0.3.317.gbb04ec
