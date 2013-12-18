From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] prune_object_dir(): verify that path fits in the temporary buffer
Date: Wed, 18 Dec 2013 12:07:02 -0800
Message-ID: <xmqqwqj1hqjd.fsf@gitster.dls.corp.google.com>
References: <1387287838-25779-1-git-send-email-mhagger@alum.mit.edu>
	<1387287838-25779-3-git-send-email-mhagger@alum.mit.edu>
	<xmqq8uvjmhu5.fsf@gitster.dls.corp.google.com>
	<20131217232231.GA14807@sigill.intra.peff.net>
	<xmqqa9fyhrzt.fsf@gitster.dls.corp.google.com>
	<20131218200043.GA10244@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 18 21:07:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtNOl-0006hT-6J
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 21:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405Ab3LRUHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Dec 2013 15:07:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54175 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751277Ab3LRUHG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 15:07:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40C685A835;
	Wed, 18 Dec 2013 15:07:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ugkeHvcrbEp4E/v5NMaYb6kVXAU=; b=jWrZbJ
	fo4YH5Nyfa9BkP4vdS8DsrD7wfFLL5qtKGFG1sKADvPEPzsEwJrlvn/nvyPZRqah
	y5Jt9NLIMOe9jl3Hu1dDzs13rOHPJEVdYSpDs7mRcYXocKoE4Vm7pC931W7DPUYv
	wOdge8R114q7ed5WkS/+OmSJsbKz48u16tnLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dRyCVroSXT2KZZWsoa5h6tcWay07Bc8e
	QiKtFjsgPqXFUXDT9TfIwluaIbJu6a+zHiUpWKCgcPVP0LckNLmybknjE++CG9z3
	+/8Jp8UD6IdtxgdcskGyiY1lTWkd5qZv0pq86Iko+vspp6O2N0FP0jW2LR0ry29i
	ETGW/RLgSks=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 030FC5A834;
	Wed, 18 Dec 2013 15:07:05 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 283965A82E;
	Wed, 18 Dec 2013 15:07:04 -0500 (EST)
In-Reply-To: <20131218200043.GA10244@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 18 Dec 2013 15:00:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F698E654-681F-11E3-8793-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239478>

Jeff King <peff@peff.net> writes:

>> > +			prune_object(path->buf, sha1);
>> > +			path->len = baselen;
>> 
>> This is minor, but I prefer using strbuf_setlen() for this.
>
> Good catch. I do not think it is minor at all; my version is buggy.
> After the loop ends, path->len does not match the NUL in path->buf. That
> is OK if the next caller is strbuf-aware, but if it were to pass
> path->buf straight to a system call, that would be rather...confusing.

Hmph, rmdir(path->buf) at the end of prune_dir() may have that exact
issue.

Will squash in the following.

 builtin/prune.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/prune.c b/builtin/prune.c
index 4ca8ec1..99f3f35 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -17,7 +17,7 @@ static int verbose;
 static unsigned long expire;
 static int show_progress = -1;
 
-static int prune_tmp_object(const char *fullpath)
+static int prune_tmp_file(const char *fullpath)
 {
 	struct stat st;
 	if (lstat(fullpath, &st))
@@ -78,13 +78,13 @@ static int prune_dir(int i, struct strbuf *path)
 
 			strbuf_addf(path, "/%s", de->d_name);
 			prune_object(path->buf, sha1);
-			path->len = baselen;
+			strbuf_setlen(&path, baselen);
 			continue;
 		}
 		if (!prefixcmp(de->d_name, "tmp_obj_")) {
 			strbuf_addf(path, "/%s", de->d_name);
-			prune_tmp_object(path->buf);
-			path->len = baselen;
+			prune_tmp_file(path->buf);
+			strbuf_setlen(&path, baselen);
 			continue;
 		}
 		fprintf(stderr, "bad sha1 file: %s/%s\n", path->buf, de->d_name);
@@ -108,7 +108,7 @@ static void prune_object_dir(const char *path)
 	for (i = 0; i < 256; i++) {
 		strbuf_addf(&buf, "%02x", i);
 		prune_dir(i, &buf);
-		buf.len = baselen;
+		strbuf_setlen(&buf, baselen);
 	}
 }
 
@@ -130,7 +130,7 @@ static void remove_temporary_files(const char *path)
 	}
 	while ((de = readdir(dir)) != NULL)
 		if (!prefixcmp(de->d_name, "tmp_"))
-			prune_tmp_object(mkpath("%s/%s", path, de->d_name));
+			prune_tmp_file(mkpath("%s/%s", path, de->d_name));
 	closedir(dir);
 }
 
