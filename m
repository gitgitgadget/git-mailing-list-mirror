Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F394E2907
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721665137; cv=none; b=BqQ8xgjRgMCf1APNOCdxWflQoXCkNEFIDjFSuN5729y06jI9Lq2Vl1HI3gCFvXncyiSog+zdCJ3JyLmHfRvFwoSZh6XN4IvaBYrbjAxIc8EJWddZ2NVkTu5t0UmrDJIZ3EoVcow5zglb2gLuDBlIiGJoCEXgrx5CiozlfWQ16LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721665137; c=relaxed/simple;
	bh=OLT4ZOxbcG2IMyBZ+gfmvdesJO2fuVbeJK2T+yvbajg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hBf3q/8llcs3an4Rvv4fnMu8SGetzuuKW+XQ4Hc4yFk6V4diIgahLfOk0R69cf1oO3Gi9Yw37ZvQG0N3aCIkAGcDgxFlfldgsL0VH9lMXWkh/tCXqyTM5kFS7mHQaC2k8H1PNW8f/5vsiKco1UrWikkjDraiFjRyOvQg9Pvzm9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=w1k6/Mjc; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="w1k6/Mjc"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 866B222BA9;
	Mon, 22 Jul 2024 12:18:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OLT4ZOxbcG2IMyBZ+gfmvdesJO2fuVbeJK2T+y
	vbajg=; b=w1k6/Mjc20mAq4JwHQ7gwhu2OtTQCZ609iR1y75BP5DMePLJlCAWfI
	4j9TF7D++ccuXq04TZ+1hHb0pnsh6UniEGo1JEGxXlocV34Yh0Db23zimWXPE1h6
	p0LT+/9Yn0TjBIsEni0emm+G8coFWMeRsZBQxmE2el9WjBlv98V/M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7F21522BA8;
	Mon, 22 Jul 2024 12:18:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0F5A422BA7;
	Mon, 22 Jul 2024 12:18:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: seen branch dirty after 'make clean'
In-Reply-To: <57f9a518-8b71-442e-ae21-58b283b073a9@ramsayjones.plus.com>
	(Ramsay Jones's message of "Sun, 21 Jul 2024 21:43:29 +0100")
References: <57f9a518-8b71-442e-ae21-58b283b073a9@ramsayjones.plus.com>
Date: Mon, 22 Jul 2024 09:18:44 -0700
Message-ID: <xmqq34o1fli3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 122007BA-4846-11EF-9AC5-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Just a quick heads up; with current seen branch, if you do a 'make clean'
> before building (as I routinely do), then:
>   $ git describe --dirty
>   v2.46.0-rc1-129-g19a89823f5
>   $ 
>  
> This is because commit dbc2de902e ("asciidoctor: fix `synopsis` rendering",
> 2024-07-20) adds a tracked file (Documentation/docinfo.html) which the clean
> target deletes (via *.html).

Not just "make clean" but Documentation/.gitignore explicitly says
that in this project, we consider HTML files expendable, which is a
sensible stance to take, because they are generated from other
sources and nobody ought to be writing HTML by hand.

Let me squash this (or something like that) in.

Thanks.

 Documentation/Makefile                          | 5 +++++
 Documentation/{docinfo.html => docinfo-html.in} | 0
 2 files changed, 5 insertions(+)

diff --git c/Documentation/Makefile w/Documentation/Makefile
index 78e407e4bd..371d56eb5e 100644
--- c/Documentation/Makefile
+++ w/Documentation/Makefile
@@ -209,6 +209,8 @@ XMLTO_EXTRA += --skip-validation
 XMLTO_EXTRA += -x manpage.xsl
 endif
 
+ASCIIDOC_DEPS += docinfo.html
+
 SHELL_PATH ?= $(SHELL)
 # Shell quote;
 SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
@@ -337,6 +339,9 @@ clean:
 	$(RM) $(cmds_txt) $(mergetools_txt) *.made
 	$(RM) GIT-ASCIIDOCFLAGS
 
+docinfo.html: docinfo-html.in
+	$(QUIET_GEN)$(RM) $@ && cat $< >$@
+
 $(MAN_HTML): %.html : %.txt $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) -d manpage -o $@ $<
 
diff --git c/Documentation/docinfo.html w/Documentation/docinfo-html.in
similarity index 100%
rename from Documentation/docinfo.html
rename to Documentation/docinfo-html.in
