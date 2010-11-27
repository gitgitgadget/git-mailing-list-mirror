From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] help: always suggest common-cmds if prefix of cmd
Date: Fri, 26 Nov 2010 16:18:57 -0800
Message-ID: <7voc9bpqj2.fsf@alter.siamese.dyndns.org>
References: <AANLkTinKDqykfuV5=oHav9PRehDtJZct_q=zm7p8PAeo@mail.gmail.com>
 <1290787239-4508-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, ziade.tarek@gmail.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 27 01:19:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM8Vb-0006St-67
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 01:19:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964Ab0K0ATM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 19:19:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60384 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625Ab0K0ATL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 19:19:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9F86D26CC;
	Fri, 26 Nov 2010 19:19:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O2dES2T5xT+Nq7UJ3+sqj5gmp4A=; b=KF1BtT
	+h/0wn5dP3YDFdKJv6ZxEEkLw+1yDJS7tuDxwMRfm1qrBrerHY+nUCkFrUgZenMC
	eAxf7bb7s60yNB6xO9Evjv4+2dshiItozSduOKUKRSzOWxv18MhJYDSMF+xqxVeI
	nG//Osq8ER/vJFIwvWRkxKUsth9T6c95962KY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s88ZsWnrJ0w4I2CxYX6pInKaI6FY68YB
	QeyyRuwgpA2zGrOjbFH+4/pdWzgupQ9nBT+tx+eY822s2bg+uJknWtivHr/uc20p
	A+mmBO/wqL3zVBRMBZX4NehWJgXx7A9MCsFcA53yBqW+bVMCpKfU72Gx0pwh1CBU
	J6ylv9FtJQc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 69EDE26CB;
	Fri, 26 Nov 2010 19:19:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7739626CA; Fri, 26 Nov 2010
 19:19:17 -0500 (EST)
In-Reply-To: <1290787239-4508-1-git-send-email-kusmabite@gmail.com> (Erik
 Faye-Lund's message of "Fri\, 26 Nov 2010 17\:00\:39 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FC70CD42-F9BB-11DF-ABA0-DF8536391E49-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162285>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> @@ -320,9 +321,16 @@ const char *help_unknown_cmd(const char *cmd)
>  	uniq(&main_cmds);
>  
>  	/* This reuses cmdname->len for similarity index */
> -	for (i = 0; i < main_cmds.cnt; ++i)
> -		main_cmds.names[i]->len =
> +	for (i = 0; i < main_cmds.cnt; ++i) {
> +		main_cmds.names[i]->len = 1 +
>  			levenshtein(cmd, main_cmds.names[i]->name, 0, 2, 1, 4);
> +		for (n = 0; n < ARRAY_SIZE(common_cmds); ++n) {
> +			if (!strcmp(main_cmds.names[i]->name,
> +			    common_cmds[n].name) &&
> +			    !prefixcmp(main_cmds.names[i]->name, cmd))
> +				main_cmds.names[i]->len = 0;
> +		}
> +	}

This is an error codepath so performance would not matter much, but this
is doing it in an unnecessarily slow way, no?  At this point, both arrays
are sorted the same way, so we should be able to walk common_cmds[]
alongside the main_cmds.names[] (see below).

> +	if (n < main_cmds.cnt) {
> +		best_similarity = main_cmds.names[n++]->len;
> +		while (n < main_cmds.cnt &&
> +		       best_similarity == main_cmds.names[n]->len)
> +			++n;
> +	} else
> +		best_similarity = 0;

Think about what does this case _means_... The end user input was so
ambiguous that it prefix matched all the common commands!  Is it really
similar enough?

Note that most of the time main_cmds[] has more than what common_cmds[]
has, and because prefix match is done only against common_cmds[],
"everything is a prefix-match" never happens.  You might want to mark it
as a BUG(), but someday we may change the rules to give 0 to non common
commands with prefix match under some condition, so thinking these rare
corner cases through would defend ourselves from future gotchas.

How about doing it this way instead?  Isn't it more readable?

diff --git a/help.c b/help.c
index 7f4928e..7654f1b 100644
--- a/help.c
+++ b/help.c
@@ -3,6 +3,7 @@
 #include "exec_cmd.h"
 #include "levenshtein.h"
 #include "help.h"
+#include "common-cmds.h"
 
 /* most GUI terminals set COLUMNS (although some don't export it) */
 static int term_columns(void)
@@ -298,7 +299,8 @@ static void add_cmd_list(struct cmdnames *cmds, struct cmdnames *old)
 }
 
 /* An empirically derived magic number */
-#define SIMILAR_ENOUGH(x) ((x) < 6)
+#define SIMILARITY_FLOOR 7
+#define SIMILAR_ENOUGH(x) ((x) < SIMILARITY_FLOOR)
 
 const char *help_unknown_cmd(const char *cmd)
 {
@@ -319,10 +321,28 @@ const char *help_unknown_cmd(const char *cmd)
 	      sizeof(main_cmds.names), cmdname_compare);
 	uniq(&main_cmds);
 
-	/* This reuses cmdname->len for similarity index */
-	for (i = 0; i < main_cmds.cnt; ++i)
+	/* This abuses cmdname->len for levenshtein distance */
+	for (i = 0, n = 0; i < main_cmds.cnt; i++) {
+		int cmp = 0; /* avoid compiler stupidity */
+		const char *candidate = main_cmds.names[i]->name;
+
+		/* Does the candidate appear in common_cmds list? */
+		while (n < ARRAY_SIZE(common_cmds) &&
+		       (cmp = strcmp(common_cmds[n].name, candidate)) < 0)
+			n++;
+		if ((n < ARRAY_SIZE(common_cmds)) && !cmp) {
+			/* Yes, this is one of the common commands */
+			n++; /* use the entry from common_cmds[] */
+			if (!prefixcmp(candidate, cmd)) {
+				/* Give prefix match a very good score */
+				main_cmds.names[i]->len = 0;
+				continue;
+			}
+		}
+
 		main_cmds.names[i]->len =
-			levenshtein(cmd, main_cmds.names[i]->name, 0, 2, 1, 4);
+			levenshtein(cmd, candidate, 0, 2, 1, 4) + 1;
+	}
 
 	qsort(main_cmds.names, main_cmds.cnt,
 	      sizeof(*main_cmds.names), levenshtein_compare);
@@ -330,10 +350,21 @@ const char *help_unknown_cmd(const char *cmd)
 	if (!main_cmds.cnt)
 		die ("Uh oh. Your system reports no Git commands at all.");
 
-	best_similarity = main_cmds.names[0]->len;
-	n = 1;
-	while (n < main_cmds.cnt && best_similarity == main_cmds.names[n]->len)
-		++n;
+	/* skip and count prefix matches */
+	for (n = 0; n < main_cmds.cnt && !main_cmds.names[n]->len; n++)
+		; /* still counting */
+
+	if (main_cmds.cnt <= n) {
+		/* prefix matches with everything? that is too ambiguous */
+		best_similarity = SIMILARITY_FLOOR + 1;
+	} else {
+		/* count all the most similar ones */
+		for (best_similarity = main_cmds.names[n++]->len;
+		     (n < main_cmds.cnt &&
+		      best_similarity == main_cmds.names[n]->len);
+		     n++)
+			; /* still counting */
+	}
 	if (autocorrect && n == 1 && SIMILAR_ENOUGH(best_similarity)) {
 		const char *assumed = main_cmds.names[0]->name;
 		main_cmds.names[0] = NULL;
