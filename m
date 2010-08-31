From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] merge: Make '--log' an integer option for number of
 shortlog entries
Date: Tue, 31 Aug 2010 11:17:12 -0700
Message-ID: <7vzkw2abpz.fsf@alter.siamese.dyndns.org>
References: <1282991734-3368-1-git-send-email-artagnon@gmail.com>
 <1283226800-28980-1-git-send-email-artagnon@gmail.com>
 <20100831143236.GC2315@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 20:17:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqVOj-0004AS-Ax
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 20:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754501Ab0HaSRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 14:17:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36919 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237Ab0HaSRX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 14:17:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 061C1D20CD;
	Tue, 31 Aug 2010 14:17:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6oUKj3FqkCbaI6X0wzunx7fBHjQ=; b=o83tl9
	U4IQBCJRJgJ5MzVbOgvapt4NUUonUOwnXOnM/O3k9nFNojOmHKrZhAw6LN6/3Y4n
	Qs3pAvikQqTKPHVSd1oK0J6KrSs4Nf6vJIa9jPVWKZki/GVN4gMz7ZKMqxIMidXi
	dQ0Df63VgfrSMeeecyu7b+eobgQ2TZZbUhqxg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tHbFPfvr4nCLbKdBEDqLRxjDGrKI0IRq
	2G449o0eeTMKOByp4tlvrhfwSJvUHIuuPHmiCzopanu6hiyriPQa0QvIr9JMYMLc
	jLDLrPvbCVsmxCeg/VH7SqG2dwtoRINFT/PK7VZt6y1qejbw0d9fT7INMBbyb/fu
	aJuwNKyu1pM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C654FD20CB;
	Tue, 31 Aug 2010 14:17:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0076D20CA; Tue, 31 Aug
 2010 14:17:14 -0400 (EDT)
In-Reply-To: <20100831143236.GC2315@burratino> (Jonathan Nieder's message of
 "Tue\, 31 Aug 2010 09\:32\:36 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FDA12290-B52B-11DF-82B2-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154955>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Ramkumar Ramachandra wrote:
>
>> Change the command-line '--log' option from a boolean option to an
>> integer option
>
> What does "git merge --log=-1" do?
>
> It looks like you have made "git fmt-merge-msg --log=-1" equivalent to
> --log=20, but it might be better to error out or use INT_MAX or
> something (especially because of plans to make -1 mean "infinity"
> later).

Hmm, do we plan on that?  It sounds a little bit insane.  Erroring it out
would be Ok.  How about doing this on top?

 builtin/fmt-merge-msg.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 0997c26..7c6e226 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -322,7 +322,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	const char *message = NULL;
 	struct option options[] = {
 		{ OPTION_INTEGER, 0, "log", &shortlog_len, "n",
-		  "populate log with <n> entries from shortlog",
+		  "populate log with at most <n> entries from shortlog",
 		  PARSE_OPT_OPTARG, NULL, DEFAULT_MERGE_LOG_LEN },
 		{ OPTION_INTEGER, 0, "summary", &shortlog_len, "n",
 		  "alias for --log (deprecated)",
@@ -350,7 +350,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 		return 0;
 	}
 	if (shortlog_len < 0)
-		shortlog_len = DEFAULT_MERGE_LOG_LEN;
+		die("Negative --log=%d???", shortlog_len);
 
 	if (inpath && strcmp(inpath, "-")) {
 		in = fopen(inpath, "r");
