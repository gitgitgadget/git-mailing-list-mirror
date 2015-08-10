From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/17] path.c: drop git_path_submodule
Date: Mon, 10 Aug 2015 16:52:13 -0700
Message-ID: <xmqq7fp2u2fm.fsf@gitster.dls.corp.google.com>
References: <20150810092731.GA9027@sigill.intra.peff.net>
	<20150810093627.GJ30981@sigill.intra.peff.net>
	<xmqqfv3qu5a7.fsf@gitster.dls.corp.google.com>
	<xmqqbneeu4ys.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 11 01:52:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOwrc-0001tS-6s
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 01:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933481AbbHJXwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 19:52:16 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33413 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933454AbbHJXwP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2015 19:52:15 -0400
Received: by pabyb7 with SMTP id yb7so116318346pab.0
        for <git@vger.kernel.org>; Mon, 10 Aug 2015 16:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=fhomzaLQOsOwofXNvngmcnfo6dFik/jK9hbKalAqcNE=;
        b=YDYqZkjv1wWL2IW1CjYh4qz8d9tMPJAX2ZT8KLRCQRGqu7PJDGm1oCRo3cPnpG8CT+
         xfYk2ty+3eqoRaKyCfaY2HVnCJ/kl/J9eeYFkflRzMXUzP/ZSKum5m4SMsb0dztXBmjs
         rs+93DiL+tQ9UHR6sxUzeHKIxBrrXWxORzU7c7DxSrnX/G5pyeqJxLvk3vN6mhNYVFPY
         uDAG07nyevIXZaGDHZuos1ErZYujHTRTuUX8bvFik3yoj+Ets2OkKRn9sRsjd6GV77JS
         wK3XiWAJE3Pn1F5mWOuuhyb2eKXrxAH46wyLV+XmgYy9YxCT+mB4gwpTnEI6oySobDvd
         6YBw==
X-Received: by 10.66.147.131 with SMTP id tk3mr50306828pab.104.1439250735355;
        Mon, 10 Aug 2015 16:52:15 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d90:bc93:a451:6e95])
        by smtp.gmail.com with ESMTPSA id fg5sm117218pdb.33.2015.08.10.16.52.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 10 Aug 2015 16:52:14 -0700 (PDT)
In-Reply-To: <xmqqbneeu4ys.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 10 Aug 2015 15:57:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275665>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jeff King <peff@peff.net> writes:
>>
>>> There are no callers of the slightly-dangerous static-buffer
>>> git_path_submodule left. Let's drop it.
>>
>> There are a few callers added on 'pu', though.
>
> Actually there is only one.  Here is a proposed evil merge.

Sorry, that didn't work X-<.

diff --git a/submodule.c b/submodule.c
index dfe8b7b..0cdaeb8 100644
--- a/submodule.c
+++ b/submodule.c
@@ -120,10 +120,10 @@ void stage_updated_gitmodules(void)
 static int add_submodule_odb(const char *path)
 {
 	struct alternate_object_database *alt_odb;
-	const char *objects_directory;
+	char *objects_directory;
 	int ret = 0;
 
-	objects_directory = git_path_submodule(path, "objects/");
+	objects_directory = git_pathdup_submodule(path, "objects/");
 	if (!is_directory(objects_directory)) {
 		ret = -1;
 		goto done;
@@ -148,6 +148,7 @@ static int add_submodule_odb(const char *path)
 	read_info_alternates(objects_directory, 0);
 	prepare_alt_odb();
 done:
+	free(objects_directory);
 	return ret;
 }
 
