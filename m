From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 1/8] commit.c: prefer get_header() to manual searching
Date: Wed, 13 Oct 2010 14:59:21 -0700
Message-ID: <7vocaxiwjq.fsf@alter.siamese.dyndns.org>
References: <1286478657-61581-1-git-send-email-patnotz@gmail.com>
 <1286478657-61581-2-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Pat Notz" <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 23:59:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P69ML-0000p3-Ur
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 23:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753373Ab0JMV73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 17:59:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56758 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab0JMV72 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 17:59:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 068D5DEAE5;
	Wed, 13 Oct 2010 17:59:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=+sQVgkBy7KMzhY+U3pvWeBx5+ws=; b=hVn296zzewbRIw7fx8SF1tc
	hjf+oknrG+zeRi6pNmFel8XvOi6j9rGoU+Mdl1YkgAoZkHACy0vlwwZs5AzlF3IU
	DXMj9sogwvhcikx4utv9t8j5C0Nd4ovtXS9ua+6F+RibC+aqjT6lTGdWCdfnsUHm
	wOMEaJCxUMW8Aeouq450=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Vop6drWEN5nN5nqDNERUgS4xfHOgJzcuqKenIgQxeQ1/Pa7e/
	imK7k32Xb0fJJ4lRWcRwNoxyHY+GfQ9SlKRSU/vlewadW9pGuXAd51pWY/U4B6X9
	LMNtHkFeDUGR1bMIE7M0XhVGHwdLpCxTgVfBINB0Wkghmv/ejE9Jdny/gE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CD020DEAE3;
	Wed, 13 Oct 2010 17:59:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E599EDEAE2; Wed, 13 Oct
 2010 17:59:22 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 24EB3556-D715-11DF-A06F-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158987>

"Pat Notz" <patnotz@gmail.com> writes:

> diff --git a/commit.h b/commit.h
> index 9113bbe..c246c94 100644
> --- a/commit.h
> +++ b/commit.h
> @@ -87,6 +87,7 @@ struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
>  extern char *reencode_commit_message(const struct commit *commit,
>  				     const char **encoding_p);
>  extern void get_commit_format(const char *arg, struct rev_info *);
> +extern char *get_header(const struct commit *commit, const char *key);

The name of the function was perfectly Ok within the context of pretty.c,
as the file was about commit log message and nothing else, but it is a bit
mindless to expose it to outside world still with such a generic name.

But the bigger question is why the patch doesn't get rid of the bulk of
the body of the block and replace it with a call to logmsg_reencode().


diff --git a/builtin/commit.c b/builtin/commit.c
index 66fdd22..021fb1c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -899,7 +899,6 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		unsigned char sha1[20];
 		static char utf8[] = "UTF-8";
 		const char *out_enc;
-		char *enc, *end;
 		struct commit *commit;
 
 		if (get_sha1(use_message, sha1))
@@ -908,18 +907,8 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		if (!commit || parse_commit(commit))
 			die("could not parse commit %s", use_message);
 
-		enc = strstr(commit->buffer, "\nencoding");
-		if (enc) {
-			end = strchr(enc + 10, '\n');
-			enc = xstrndup(enc + 10, end - (enc + 10));
-		} else {
-			enc = utf8;
-		}
 		out_enc = git_commit_encoding ? git_commit_encoding : utf8;
-
-		if (strcmp(out_enc, enc))
-			use_message_buffer =
-				reencode_string(commit->buffer, out_enc, enc);
+		use_message_buffer = logmsg_reencode(commit, out_enc);
 
 		/*
 		 * If we failed to reencode the buffer, just copy it
@@ -929,8 +918,6 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		 */
 		if (use_message_buffer == NULL)
 			use_message_buffer = xstrdup(commit->buffer);
-		if (enc != utf8)
-			free(enc);
 	}
 
 	if (!!also + !!only + !!all + !!interactive > 1)
