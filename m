From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool: respect autocrlf by using checkout-index
Date: Mon, 26 Jan 2009 14:08:06 -0800
Message-ID: <7vskn53em1.fsf@gitster.siamese.dyndns.org>
References: <20090121210348.GD9088@mit.edu>
 <1232578668-2203-1-git-send-email-charles@hashpling.org>
 <7v1vuuvt11.fsf@gitster.siamese.dyndns.org> <83skn6doxm.fsf@kalahari.s2.org>
 <20090126163114.GD32604@hashpling.org>
 <7v7i4h4v19.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hannu Koivisto <azure@iki.fi>, git@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Mon Jan 26 23:09:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRZeI-0000fg-Re
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 23:09:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbZAZWIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 17:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752289AbZAZWIQ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 17:08:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57505 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004AbZAZWIP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 17:08:15 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EC4491D5BB;
	Mon, 26 Jan 2009 17:08:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6DB3B1D5B2; Mon,
 26 Jan 2009 17:08:08 -0500 (EST)
In-Reply-To: <7v7i4h4v19.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 26 Jan 2009 13:28:02 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D389E1C8-EBF5-11DD-8BAB-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107291>

Junio C Hamano <gitster@pobox.com> writes:

> Charles Bailey <charles@hashpling.org> writes:
>
>> I suspect that the LF endings in the file is due to the fact that in
>> builtin-merge-file.c, the file is opened (fopen) in binary mode
>> ("wb"), but xdl_merge terminates all lines with a raw '\n'.
>>
>> The obvious fix would be to change fopen in builtin-file-merge.c to
>> use "w" instead, but this doesn't work in a number of scenarios. In
>> particular, it is wrong for repositories on windows with core.autocrlf
>> set to false, and would not fix non-windows repositories with
>> core.autocrlf set to true.
>>
>> Currently, I've no idea as to what the solution should be.
>
> "git file-merge" is designed to be a replacement for stock RCS merge, and
> unfortunately it does not call convert_to_working_tree(), nor has any way
> to know for which path it should take the attributes to apply to affect
> what convert_to_working_tree() should do even if it were to call it.
>
> I think we would need a new option to the command that says "pretend this
> is about merging this path, and use the gitattributes specified for it
> when writing out the result."

Perhaps something along this line to teach

    $ git merge-file --attribute-path=frotz.c file1 orig_file file2

to merge what happened since orig_file to file2 into file1, and deposit
the result after converting it appropriately for path "frotz.c" obeying
core.autocrlf and gitattribute rules.

I see rerere.c::merge() has the exact same issue, but its breakage is half
hidden by its use of fopen(path, "w").  It should explicitly use
convert_to_working_tree() like this patch does, and write the results out
in binary mode.

 builtin-merge-file.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git i/builtin-merge-file.c w/builtin-merge-file.c
index 96edb97..61d1092 100644
--- i/builtin-merge-file.c
+++ w/builtin-merge-file.c
@@ -5,7 +5,7 @@
 #include "parse-options.h"
 
 static const char *const merge_file_usage[] = {
-	"git merge-file [options] [-L name1 [-L orig [-L name2]]] file1 orig_file file2",
+	"git merge-file [options] [-L name1 [-L orig [-L name2]]] [--attribute-path path] file1 orig_file file2",
 	NULL
 };
 
@@ -30,10 +30,13 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	int merge_level = XDL_MERGE_ZEALOUS_ALNUM;
 	int merge_style = 0, quiet = 0;
 	int nongit;
+	char *attribute_path = NULL;
 
 	struct option options[] = {
 		OPT_BOOLEAN('p', "stdout", &to_stdout, "send results to standard output"),
 		OPT_SET_INT(0, "diff3", &merge_style, "use a diff3 based merge", XDL_MERGE_DIFF3),
+		OPT_STRING('a', "attribute-path", &attribute_path, "path",
+			   "apply work-tree conversion for the path"),
 		OPT__QUIET(&quiet),
 		OPT_CALLBACK('L', NULL, names, "name",
 			     "set labels for file1/orig_file/file2", &label_cb),
@@ -73,6 +76,19 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	for (i = 0; i < 3; i++)
 		free(mmfs[i].ptr);
 
+	if (ret >= 0 && attribute_path) {
+		struct strbuf buf = STRBUF_INIT;
+		ret = convert_to_working_tree(attribute_path,
+					      result.ptr, result.size,
+					      &buf);
+		free(result.ptr);
+		if (!ret) {
+			size_t len;
+			result.ptr = strbuf_detach(&buf, &len);
+			result.size = len;
+		}
+	}
+
 	if (ret >= 0) {
 		const char *filename = argv[0];
 		FILE *f = to_stdout ? stdout : fopen(filename, "wb");
