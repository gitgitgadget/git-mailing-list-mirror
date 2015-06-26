From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git error in tag ...: unterminated header
Date: Fri, 26 Jun 2015 10:37:19 -0700
Message-ID: <xmqqh9puv0a8.fsf@gitster.dls.corp.google.com>
References: <20150625155128.C3E9738005C@gemini.denx.de>
	<xmqqegkzzoaz.fsf@gitster.dls.corp.google.com>
	<20150625201309.5026A384E81@gemini.denx.de>
	<xmqqegkzy1ri.fsf@gitster.dls.corp.google.com>
	<2b124e09d9c89ff3892f246ea91aa3c4@www.dscho.org>
	<xmqqoak3wkkq.fsf@gitster.dls.corp.google.com>
	<xmqqbng3wheu.fsf@gitster.dls.corp.google.com>
	<d455a77d76b3558fb79d550d6ed4468d@www.dscho.org>
	<20150626155248.GB30273@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Wolfgang Denk <wd@denx.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 26 19:37:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8XZC-0005S9-QJ
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 19:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbbFZRhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 13:37:24 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:35164 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbbFZRhW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 13:37:22 -0400
Received: by iebrt9 with SMTP id rt9so80184169ieb.2
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 10:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ll4B2013A6FxNxBc8yo5UMXfBYwdhGmiGD1c5vq0vHg=;
        b=GnZxQo3JFdkzmVwpsU5S/T9KRZVII/4gSyiuLRMAxPEWkRpWPUs+x1GG6Og/JJecNO
         Uxn0CWJck1KfRba5r8RXLgcFSzKtvbyLz6IvuZgA35Gb6Yc397zdcfV6CcpmB8nEIMIA
         JNJxlx9jVIgmyKDeML0rOn2cHpORW1T4vd5YjFZZJMK+KBgABrE04ku1j1kusGzuzrmj
         EQTdTmmnOSd+fuAI54g4tSjBKPzfpb4eggDZto8VFFPdvXJJWzj/gNrCmWXO4alEGPaM
         8AaB9vYV5k8sIABxBGzXQhfDn7yBrnasBCjI3FfF+lKq2DtG7QqN2mosXZ+Jl+DNtTjJ
         luwQ==
X-Received: by 10.50.8.68 with SMTP id p4mr5150590iga.4.1435340241854;
        Fri, 26 Jun 2015 10:37:21 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6587:7c7a:db33:ca35])
        by mx.google.com with ESMTPSA id e3sm1254409igq.21.2015.06.26.10.37.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jun 2015 10:37:21 -0700 (PDT)
In-Reply-To: <20150626155248.GB30273@peff.net> (Jeff King's message of "Fri,
	26 Jun 2015 11:52:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272804>

Jeff King <peff@peff.net> writes:

> On Fri, Jun 26, 2015 at 10:06:20AM +0200, Johannes Schindelin wrote:
>
>> I understood what you were saying, but it still appears too fragile to
>> me to mix functions that assume NUL-terminated strings with an ad-hoc
>> counted string check.
>
> Yeah, I agree. It is not that you cannot make it safe, but that it is
> simply a fragile maintenance burden in the future. I thought we dealt
> with this already with a1e920a (index-pack: terminate object buffers
> with NUL, 2014-12-08), though.

Hmph, that is an interesting point.

It would mean that the require_eoh() can be reduced a bit further.

 * It is still a good idea to make sure we do not have NUL in the
   header part,

 * It can still stop scanning when it finds a blank line (i.e. we do
   not care what is in the message part of commit and tag),

 * It does not have to insist that a commit or a tag has a blank
   line to reject a header-only object.

That would mean the name of the helper needs to change, though.

Perhaps like this?

 fsck.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fsck.c b/fsck.c
index 10bcb65..c23e84e 100644
--- a/fsck.c
+++ b/fsck.c
@@ -241,8 +241,8 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
 	return retval;
 }
 
-static int require_end_of_header(const void *data, unsigned long size,
-	struct object *obj, fsck_error error_func)
+static int verify_headers(const void *data, unsigned long size,
+			  struct object *obj, fsck_error error_func)
 {
 	const char *buffer = (const char *)data;
 	unsigned long i;
@@ -257,8 +257,13 @@ static int require_end_of_header(const void *data, unsigned long size,
 				return 0;
 		}
 	}
-
-	return error_func(obj, FSCK_ERROR, "unterminated header");
+	/*
+	 * did not find a blank line -- is the last header line
+	 * correctly terminated with LF?
+	 */
+	if (size && buffer[size - 1] != '\n')
+		return error_func(obj, FSCK_ERROR, "unterminated header");
+	return 0;
 }
 
 static int fsck_ident(const char **ident, struct object *obj, fsck_error error_func)
