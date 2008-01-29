From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH/PATCH] prefix_path(): disallow absolute paths
Date: Mon, 28 Jan 2008 18:03:00 -0800
Message-ID: <7vd4rls817.fsf@gitster.siamese.dyndns.org>
References: <47975FE6.4050709@viscovery.net>
	<1201463731-1963-1-git-send-email-shawn.bohrer@gmail.com>
	<alpine.LSU.1.00.0801272043040.23907@racer.site>
	<7v3asiyk2i.fsf@gitster.siamese.dyndns.org>
	<20080128003404.GA18276@lintop>
	<7vodb6wtix.fsf@gitster.siamese.dyndns.org>
	<479D805E.3000209@viscovery.net>
	<7vprvmuykw.fsf@gitster.siamese.dyndns.org>
	<479D9ADE.6010003@viscovery.net>
	<alpine.LSU.1.00.0801281210440.23907@racer.site>
	<7vwspts9vj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 29 03:03:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJfpF-00006Y-TE
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 03:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756677AbYA2CDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 21:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755433AbYA2CDK
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 21:03:10 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38024 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754946AbYA2CDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 21:03:09 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id BAABF2951;
	Mon, 28 Jan 2008 21:03:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C90E294F;
	Mon, 28 Jan 2008 21:03:02 -0500 (EST)
In-Reply-To: <7vwspts9vj.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 28 Jan 2008 17:23:12 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71914>

This is on top of the original "sanitary_path_copy()" patch to
fix the case where the user gives `pwd`/foobar (or just `pwd`)
to us.  After making sure the leading part matches with the work
tree, we need to strip that to make the result relative to the
work tree.

 setup.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/setup.c b/setup.c
index 156d417..0688e7b 100644
--- a/setup.c
+++ b/setup.c
@@ -110,6 +110,9 @@ const char *prefix_path(const char *prefix, int len, const char *path)
 			free(sanitized);
 			return NULL;
 		}
+		sanitized += len;
+		if (*sanitized == '/')
+			sanitized++;
 	}
 	return sanitized;
 }
@@ -201,6 +204,8 @@ const char **get_pathspec(const char *prefix, const char **pathspec)
 		src++;
 	}
 	*dst = NULL;
+	if (!*pathspec)
+		return NULL;
 	return pathspec;
 }
 
