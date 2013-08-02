From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [regression] Re: git-cat-file --batch reversion; cannot query filenames with spaces
Date: Fri, 02 Aug 2013 09:32:52 -0700
Message-ID: <7vy58koxxn.fsf@alter.siamese.dyndns.org>
References: <20130801201842.GA16809@kitenet.net>
	<20130802064003.GB3013@elie.Belkin>
	<20130802105402.GA25697@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Joey Hess <joeyh@debian.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 02 18:33:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5IHo-0001FT-Ac
	for gcvg-git-2@plane.gmane.org; Fri, 02 Aug 2013 18:33:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754908Ab3HBQc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 12:32:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41481 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930Ab3HBQc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 12:32:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2D66344F4;
	Fri,  2 Aug 2013 16:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=chacKMYpFokPL25vXXTppPF+Mco=; b=nE0HNt
	dpl4VgGWRJOKTrpurTp1N5m3eJa3K3yWm1PNhfLUUJyBmo1i8zhhlbL3xL4ZoXjE
	bDGpXcRWRtXa2luvX+JHsnF2oqg+BMGzhtkQjWy81pFsrY77cy3F4xBxkLvQBIZh
	b7zoaV0NksN5kkhwsM4q42iq+ocB1OfLypogI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bn595g9gLT2SIARCH3RMLjESTa9TYQJ4
	B9AgokBqHx2AUS++TVU/HyU0Z/IPPaySLmCTaSV/wZG4/DX/k8wppung4rgMXx8m
	I4+qCyr7Nfo8YaQpfdidX4MRPjwGvQtcI7phuVNjfFGqFZporVJbzyQi/CuTwyOB
	gzxgwDz4zmI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E18E344F3;
	Fri,  2 Aug 2013 16:32:55 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9C8F344F0;
	Fri,  2 Aug 2013 16:32:53 +0000 (UTC)
In-Reply-To: <20130802105402.GA25697@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 2 Aug 2013 03:54:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E38D264-FB91-11E2-9232-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231529>

Jeff King <peff@peff.net> writes:

> We need to revert that commit before the release. It can either be
> replaced with:
>
>   1. A "--split" (or similar) option to use the behavior only when
>      desired.
>
>   2. Enabling splitting only when %(rest) is used in the output format.
>
> And I suppose it is too late in the cycle for either of those to go into
> v1.8.4. That's a shame, but I think losing that particular patch does
> not affect the rest of the series, so we are OK to ship without it.
>
> Thanks Joey for a timely bug report.

Thanks.  Will do this to jk/cat-file-batch-optim topic and merge it
to 'master' for now.

-- >8 --
Subject: [PATCH] Revert "cat-file: split --batch input lines on whitespace"

This reverts commit c334b87b30c1464a1ab563fe1fb8de5eaf0e5bac; the
update assumed that people only used the command to read from
"rev-list --objects" output, whose lines begin with a 40-hex object
name followed by a whitespace, but it turns out that scripts feed
random extended SHA-1 expressions (e.g. "HEAD:$pathname") in which
a whitespace has to be kept.
---
 Documentation/git-cat-file.txt | 10 ++--------
 builtin/cat-file.c             | 20 +-------------------
 t/t1006-cat-file.sh            |  7 -------
 3 files changed, 3 insertions(+), 34 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 3ddec0b..10fbc6a 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -88,10 +88,8 @@ BATCH OUTPUT
 If `--batch` or `--batch-check` is given, `cat-file` will read objects
 from stdin, one per line, and print information about them.
 
-Each line is split at the first whitespace boundary. All characters
-before that whitespace are considered as a whole object name, and are
-parsed as if given to linkgit:git-rev-parse[1]. Characters after that
-whitespace can be accessed using the `%(rest)` atom (see below).
+Each line is considered as a whole object name, and is parsed as if
+given to linkgit:git-rev-parse[1].
 
 You can specify the information shown for each object by using a custom
 `<format>`. The `<format>` is copied literally to stdout for each
@@ -112,10 +110,6 @@ newline. The available atoms are:
 	The size, in bytes, that the object takes up on disk. See the
 	note about on-disk sizes in the `CAVEATS` section below.
 
-`rest`::
-	The text (if any) found after the first run of whitespace on the
-	input line (i.e., the "rest" of the line).
-
 If no format is specified, the default format is `%(objectname)
 %(objecttype) %(objectsize)`.
 
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 163ce6c..4253460 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -119,7 +119,6 @@ struct expand_data {
 	enum object_type type;
 	unsigned long size;
 	unsigned long disk_size;
-	const char *rest;
 
 	/*
 	 * If mark_query is true, we do not expand anything, but rather
@@ -164,9 +163,6 @@ static void expand_atom(struct strbuf *sb, const char *atom, int len,
 			data->info.disk_sizep = &data->disk_size;
 		else
 			strbuf_addf(sb, "%lu", data->disk_size);
-	} else if (is_atom("rest", atom, len)) {
-		if (!data->mark_query && data->rest)
-			strbuf_addstr(sb, data->rest);
 	} else
 		die("unknown format element: %.*s", len, atom);
 }
@@ -277,21 +273,7 @@ static int batch_objects(struct batch_options *opt)
 	warn_on_object_refname_ambiguity = 0;
 
 	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
-		char *p;
-		int error;
-
-		/*
-		 * Split at first whitespace, tying off the beginning of the
-		 * string and saving the remainder (or NULL) in data.rest.
-		 */
-		p = strpbrk(buf.buf, " \t");
-		if (p) {
-			while (*p && strchr(" \t", *p))
-				*p++ = '\0';
-		}
-		data.rest = p;
-
-		error = batch_one_object(buf.buf, opt, &data);
+		int error = batch_one_object(buf.buf, opt, &data);
 		if (error)
 			return error;
 	}
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index d499d02..4e911fb 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -78,13 +78,6 @@ $content"
 	echo $sha1 | git cat-file --batch-check="%(objecttype) %(objectname)" >actual &&
 	test_cmp expect actual
     '
-
-    test_expect_success '--batch-check with %(rest)' '
-	echo "$type this is some extra content" >expect &&
-	echo "$sha1    this is some extra content" |
-		git cat-file --batch-check="%(objecttype) %(rest)" >actual &&
-	test_cmp expect actual
-    '
 }
 
 hello_content="Hello World"
-- 
1.8.4-rc1-125-g7a0ec02
