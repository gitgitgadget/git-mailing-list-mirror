From: Junio C Hamano <gitster@pobox.com>
Subject: Re: v1.7.0-rc0 shows lots of "unable to find <sha1>" on git-stash
Date: Sat, 30 Jan 2010 12:01:46 -0800
Message-ID: <7v8wbfnyz9.fsf@alter.siamese.dyndns.org>
References: <57518fd11001290712s2585e468o73b746b7ca27e1f1@mail.gmail.com>
 <7vzl3wiz59.fsf@alter.siamese.dyndns.org>
 <57518fd11001291646l5b0b581dm553689232b0910e8@mail.gmail.com>
 <4B642696.2070501@web.de>
 <57518fd11001300523xf7d931by254581c8494171af@mail.gmail.com>
 <4B643DEF.8010809@web.de>
 <57518fd11001300836v7f21a8a9qc09953d9091a4513@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 21:02:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbJW7-0005ZT-UE
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 21:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754378Ab0A3UB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 15:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754018Ab0A3UB4
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 15:01:56 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60274 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768Ab0A3UBz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 15:01:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E65FB95318;
	Sat, 30 Jan 2010 15:01:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rxikO1opg8IDtxrcYinYQ7E0LDg=; b=Z18dYD
	gSuUnarSdtM63nz4B7c/V2We/yWtV+qve78CFypxquaifaDfnItshqglP2FkAkON
	jpBdQwkbYYlOyyaxqZgcM+DbuFeYQSiG6ft+V13dfnZlLU8bYOz8l3i3/MIhqMRv
	8wrq+rZEp40CNyM2EDGMoloRaFSfzpF20P9a8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ChzoVAswLOha6szltLIdMrV1MEelMJmU
	4CeQ4TG9ILtQYX+gyh9EpZQpyJPESruCxybo49NHprjJMLUlhu/UTUrMSxdMKgfo
	QIzYLZbRkmz/eFCgTi9aIYXDyIYhjYJ6XXGOkkjPTXqQedqffLL0f8UJ+Y71OIG7
	MlosmM1YQw4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AD7BB95316;
	Sat, 30 Jan 2010 15:01:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C4C8795315; Sat, 30 Jan
 2010 15:01:47 -0500 (EST)
In-Reply-To: <57518fd11001300836v7f21a8a9qc09953d9091a4513@mail.gmail.com>
 (Jonathan del Strother's message of "Sat\, 30 Jan 2010 16\:36\:45 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4E8ECE9A-0DDA-11DF-864B-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138498>

Please try this.

The thing is that "add -u" internally runs "diff-files" equivalent, but
the code to check the submodule freshness doesn't reset the GIT_INDEX_FILE
exported from the caller and tries to use that even when checking the
submodule repository.

diff --git a/submodule.c b/submodule.c
index ca0527f..8bd0a30 100644
--- a/submodule.c
+++ b/submodule.c
@@ -126,7 +126,7 @@ int is_submodule_modified(const char *path)
 		"--porcelain",
 		NULL,
 	};
-	char *env[3];
+	char *env[4];
 	struct strbuf buf = STRBUF_INIT;
 
 	strbuf_addf(&buf, "%s/.git/", path);
@@ -142,7 +142,9 @@ int is_submodule_modified(const char *path)
 	env[0] = strbuf_detach(&buf, NULL);
 	strbuf_addf(&buf, "GIT_DIR=%s/.git", path);
 	env[1] = strbuf_detach(&buf, NULL);
-	env[2] = NULL;
+	strbuf_addf(&buf, "GIT_INDEX_FILE=");
+	env[2] = strbuf_detach(&buf, NULL);
+	env[3] = NULL;
 
 	memset(&cp, 0, sizeof(cp));
 	cp.argv = argv;
@@ -161,6 +163,7 @@ int is_submodule_modified(const char *path)
 
 	free(env[0]);
 	free(env[1]);
+	free(env[2]);
 	strbuf_release(&buf);
 	return len != 0;
 }
