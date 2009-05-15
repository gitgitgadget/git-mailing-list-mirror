From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git-tag bug? confusing git fast-export with double tag objects
Date: Fri, 15 May 2009 16:54:09 +0200
Message-ID: <4A0D8211.5010806@viscovery.net>
References: <op.utv93sdo1e62zd@merlin.emma.line.org>	<op.utwdsutn1e62zd@merlin.emma.line.org>	<7v8wl01iev.fsf@alter.siamese.dyndns.org>	<op.utwyczlf1e62zd@merlin.emma.line.org>	<20090514182249.GA11919@sigill.intra.peff.net>	<op.utxydvnu1e62zd@merlin.emma.line.org>	<20090515020206.GA12451@coredump.intra.peff.net>	<op.uty0pjb51e62zd@balu> <m34ovmlcve.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthias Andree <matthias.andree@gmx.de>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 15 16:54:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4ynw-0001sv-BS
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 16:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756363AbZEOOyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 10:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756841AbZEOOyP
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 10:54:15 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:8852 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbZEOOyO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 10:54:14 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M4ynZ-00010b-F1; Fri, 15 May 2009 16:54:09 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3CB5E795; Fri, 15 May 2009 16:54:09 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <m34ovmlcve.fsf@localhost.localdomain>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119257>

Jakub Narebski schrieb:
> "Matthias Andree" <matthias.andree@gmx.de> writes:
>> 	commit <-- signed-by-- NIL (removed) <--signed-by-- tag1.
> 
> THIS IS A FEATURE, NOT A BUG.

Please stop it. Everone agrees about this.

Matthias only wants a patch like below. Matthias, if you are serious about
it, please pick this up and turn it into a proper submission. I don't care
enough.

-- Hannes


diff --git a/builtin-tag.c b/builtin-tag.c
index 01e7374..35d39a2 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -367,6 +367,7 @@ int cmd_tag(int argc, const char **argv, const char
*prefix)
 	unsigned char object[20], prev[20];
 	char ref[PATH_MAX];
 	const char *object_ref, *tag;
+	struct tag *tag_object;
 	struct ref_lock *lock;

 	int annotate = 0, sign = 0, force = 0, lines = -1,
@@ -472,6 +473,15 @@ int cmd_tag(int argc, const char **argv, const char
 	else if (!force)
 		die("tag '%s' already exists", tag);

+	if ((tag_object = (struct tag *)parse_object(object)) &&
+	    tag_object->object.type == OBJ_TAG &&
+	    tag_object->tag &&
+	    !strcmp(tag_object->tag, tag)) {
+		error("A tag cannot tag itself. If you meant to tag the commit");
+		error("that the tag refers to, use 'git tag %s %s^{}'.", tag, object_ref);
+		exit(1);
+	}
+
 	if (annotate)
 		create_tag(object, tag, &buf, msg.given || msgfile,
 			   sign, prev, object);
