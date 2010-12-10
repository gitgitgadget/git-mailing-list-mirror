From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/3] fetch/pull: Add the --recurse-submodules option
Date: Fri, 10 Dec 2010 09:30:45 -0800
Message-ID: <7vlj3xedru.fsf@alter.siamese.dyndns.org>
References: <4CDB3063.5010801@web.de> <20101111000538.GB14189@burratino>
 <4CDD391C.2000905@web.de> <7vei9qfxzy.fsf@alter.siamese.dyndns.org>
 <4D016146.9010907@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Kevin Ballard <kevin@sb.org>,
	Jon Seymour <jon.seymour@gmail.com>,
	Chris Packham <judge.packham@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Dec 10 18:31:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR6oO-0004Sl-E4
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 18:31:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749Ab0LJRbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 12:31:09 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50882 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197Ab0LJRbH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 12:31:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 857F32C97;
	Fri, 10 Dec 2010 12:31:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=okmbCEb1axENWjw5Xlf+xunBhaw=; b=ryTAKD
	a+x65pP5OFc/letW0o2fIipl3NkIwZ5/aT81w4bjK6uZmM8IsPJzJxSmGbqESzsE
	vouAAPxov4CTODQoRGl72If0v7IbSzg5+6pwSZYlbAExofMlHN0GVVlivUBs6Dnk
	B/O1bE2bzlJrOHbR2X0sRBEcVQrI2NYxmx8Ls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cg8T0MkfQBXJP9cok9vBVhkcp4iVQQcf
	UIFDqT/dkxvftCtgiwsP/ncJbDcbnTpyF/6BTylQ2aNOLW9EegflixZWAdq1XmPa
	/keHuYcFsRLpVbaqCR9n+aWA9pUEedR7mSTma/SLgozcKxdvSFm6GUE9+VHwRfvz
	OCFo6mYQJSw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DB5072C7F;
	Fri, 10 Dec 2010 12:31:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9303F2C7E; Fri, 10 Dec 2010
 12:31:14 -0500 (EST)
In-Reply-To: <4D016146.9010907@web.de> (Jens Lehmann's message of "Fri\, 10
 Dec 2010 00\:07\:50 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4F49DC62-0483-11E0-A4D1-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163422>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 09.12.2010 22:16, schrieb Junio C Hamano:
> ...
>>> +int fetch_populated_submodules(int num_options, const char **options,
>>> +			       const char *prefix, int quiet)
>>> +{
>>> +	int i, result = 0, argc = 0;
>>> +	struct child_process cp;
>>> +	const char **argv;
>>> +	struct string_list_item *name_for_path;
>>> +	const char *work_tree = get_git_work_tree();
>>> +	if (!work_tree)
>>> +		return 0;
>>> +
>>> +	if (!the_index.initialized)
>>> +		if (read_cache() < 0)
>>> +			die("index file corrupt");
>>> +
>>> +	argv = xcalloc(num_options + 5, sizeof(const char *));
>> 
>> Where is this '5' coming from?  "fetch" "--submodule-prefix", the prefix,
>> and the terminating NULL?  What did I miss?
>
> No, you didn't miss anything but I have been off by one ... '4' is
> sufficient here.

Ok, thanks for double checking.

-- >8 --
Subject: [PATCH] fetch_populated_submodules(): document dynamic allocation size

... while fixing a miscounting.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 submodule.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/submodule.c b/submodule.c
index 4e62900..6f1c107 100644
--- a/submodule.c
+++ b/submodule.c
@@ -264,7 +264,8 @@ int fetch_populated_submodules(int num_options, const char **options,
 		if (read_cache() < 0)
 			die("index file corrupt");
 
-	argv = xcalloc(num_options + 5, sizeof(const char *));
+	/* 4: "fetch" (options) "--submodule-prefix" prefix NULL */
+	argv = xcalloc(num_options + 4, sizeof(const char *));
 	argv[argc++] = "fetch";
 	for (i = 0; i < num_options; i++)
 		argv[argc++] = options[i];
