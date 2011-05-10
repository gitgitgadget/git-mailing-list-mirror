From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/9] grep: use get_pathspec() correctly
Date: Mon,  9 May 2011 22:51:10 -0700
Message-ID: <1305006678-4051-2-git-send-email-gitster@pobox.com>
References: <1304852906-29272-1-git-send-email-pclouds@gmail.com>
 <1305006678-4051-1-git-send-email-gitster@pobox.com>
Cc: pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 07:51:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJfrA-0001Bh-7h
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 07:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581Ab1EJFv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 01:51:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53029 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818Ab1EJFv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 01:51:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8EB9B5C85;
	Tue, 10 May 2011 01:53:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=DTDN
	C3ZoJuEoqJFthkLAukOpzpQ=; b=mnZEZ8wTZW4njC3d0OcjMavMH92LsZSC63iM
	JCYKD8ULCjlgOffQP8C7EOhJ4prI/aUPfJTDzBvcrviiW788Q+jHNVqRvs7wVQ61
	xTlSHjrPaTMEpv9KJGSinqE3gBTPe3ohXYuhyrv2WfJ0kp/EP3RQxKhWcaIuybvS
	TauutiA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	HOK8etUc7ZOXeSDisEC1WmDqplg0Dd3LdFrgUVHv7WThWGBpHlyM9ZXlTPQU436i
	KauG21voNBIAqCfFv/et1O6/7l3bxTWapwEtYUPHRxk9hVmNiXiauTAZrejPvcHW
	mQmGGDo5bfX65cenpElvJFc8ykzF/DCeI4yevXEt/cY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 78D855C84;
	Tue, 10 May 2011 01:53:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B978C5C83; Tue, 10 May 2011
 01:53:28 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.290.g1b565
In-Reply-To: <1305006678-4051-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D5244608-7AC9-11E0-9E5F-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173307>

When there is no remaining string in argv, get_pathspec(prefix, argv)
will return a two-element array that has prefix as the first element,
so there is no need to re-roll that logic in the code that uses
get_pathspec().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/grep.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 0bf8c01..222dd6d 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -956,13 +956,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			verify_filename(prefix, argv[j]);
 	}
 
-	if (i < argc)
-		paths = get_pathspec(prefix, argv + i);
-	else if (prefix) {
-		paths = xcalloc(2, sizeof(const char *));
-		paths[0] = prefix;
-		paths[1] = NULL;
-	}
+	paths = get_pathspec(prefix, argv + i);
 	init_pathspec(&pathspec, paths);
 	pathspec.max_depth = opt.max_depth;
 	pathspec.recursive = 1;
-- 
1.7.5.1.290.g1b565
