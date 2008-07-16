From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH v2] Fix buffer overflow in prepare_attr_stack
Date: Wed, 16 Jul 2008 19:39:55 +0400
Message-ID: <20080716153955.GE2925@dpotapov.dyndns.org>
References: <37fcd2780807160733o156e49c6m51314ff18764ccd5@mail.gmail.com> <1216220043-27678-1-git-send-email-dpotapov@gmail.com> <1216220043-27678-2-git-send-email-dpotapov@gmail.com> <487E11F7.60601@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jul 16 17:41:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ97p-0006Y4-QQ
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 17:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756672AbYGPPkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 11:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756505AbYGPPkG
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 11:40:06 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:1106 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756191AbYGPPkF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 11:40:05 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2730820ywe.1
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 08:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=mjGf1KNkpG+zlQ3e5dLNbRiLZsDM1R6QjM2w/UzqY7A=;
        b=TAsOUDYLQiPlabFPUPfSVVdwqlwUM3pvqV76JMOKd58EN+V+0jjOvrlC4nCPKTcf5h
         9M/0JB2GECAxL4peHf+v9NQUMYDrttElF/Sd/EqkMJynF2ecvKHyiMPLU/dVqw4LAUSP
         /g2VDWePaac4MJt6WrNHmjuudOKmm9EOwb1EI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=o0H0wbfoO7p33uhlwe3dDH5UeHgxqHLlQIGSV/cGrA6NZb52y8K9Imh7iuNWrKYKDp
         kjoaB0ZvzYH4dvLySztulEqBFF9uIC4C33wY2Wb18hG987nHAOuh4wmZXhVFIh1yax93
         s8G7SrWddO+5H27WjIraAG8WmiDahAn/I7dO0=
Received: by 10.103.249.7 with SMTP id b7mr1013961mus.2.1216222799216;
        Wed, 16 Jul 2008 08:39:59 -0700 (PDT)
Received: from localhost ( [85.141.237.219])
        by mx.google.com with ESMTPS id g1sm6934355muf.7.2008.07.16.08.39.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Jul 2008 08:39:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <487E11F7.60601@viscovery.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88690>

If PATH_MAX on your system is smaller than a path stored in the git repo,
it may cause the buffer overflow in prepare_attr_stack.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---

On Wed, Jul 16, 2008 at 05:21:27PM +0200, Johannes Sixt wrote:
> Dmitry Potapov schrieb:
> > +			pathbuf.len = 0;
> 
> +			strbuf_reset(&pathbuf);
> 
> -- Hannes

 attr.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/attr.c b/attr.c
index 0fb47d3..17f6a4d 100644
--- a/attr.c
+++ b/attr.c
@@ -459,7 +459,9 @@ static void prepare_attr_stack(const char *path, int dirlen)
 {
 	struct attr_stack *elem, *info;
 	int len;
-	char pathbuf[PATH_MAX];
+	struct strbuf pathbuf;
+
+	strbuf_init(&pathbuf, dirlen+2+strlen(GITATTRIBUTES_FILE));
 
 	/*
 	 * At the bottom of the attribute stack is the built-in
@@ -510,13 +512,14 @@ static void prepare_attr_stack(const char *path, int dirlen)
 			len = strlen(attr_stack->origin);
 			if (dirlen <= len)
 				break;
-			memcpy(pathbuf, path, dirlen);
-			memcpy(pathbuf + dirlen, "/", 2);
-			cp = strchr(pathbuf + len + 1, '/');
+			strbuf_reset(&pathbuf);
+			strbuf_add(&pathbuf, path, dirlen);
+			strbuf_addch(&pathbuf, '/');
+			cp = strchr(pathbuf.buf + len + 1, '/');
 			strcpy(cp + 1, GITATTRIBUTES_FILE);
-			elem = read_attr(pathbuf, 0);
+			elem = read_attr(pathbuf.buf, 0);
 			*cp = '\0';
-			elem->origin = strdup(pathbuf);
+			elem->origin = strdup(pathbuf.buf);
 			elem->prev = attr_stack;
 			attr_stack = elem;
 			debug_push(elem);
-- 
1.5.6.3.3.geccd
