From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git merge conflicts and encoding of logs
Date: Tue, 23 Dec 2008 02:04:57 -0800
Message-ID: <7vlju7fbqu.fsf@gitster.siamese.dyndns.org>
References: <87lju7h4yb.dancerj%dancer@netfort.gr.jp>
 <7vprjjfgi7.fsf@gitster.siamese.dyndns.org> <4950A422.5030100@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Junichi Uekawa <dancer@netfort.gr.jp>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Dec 23 11:06:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LF49p-0006k0-PL
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 11:06:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649AbYLWKFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 05:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752624AbYLWKFI
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 05:05:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44212 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbYLWKFH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 05:05:07 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 27FEB1AE62;
	Tue, 23 Dec 2008 05:05:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6D6CD1AE4C; Tue,
 23 Dec 2008 05:05:00 -0500 (EST)
In-Reply-To: <4950A422.5030100@viscovery.net> (Johannes Sixt's message of
 "Tue, 23 Dec 2008 09:41:06 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2BC0B444-D0D9-11DD-8CB9-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103806>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Junio C Hamano schrieb:
>> <<<<<<< HEAD:foo
>> これはサイドブランチの変更です。
>> やはり JIS コードで書いてます。
>> =======
>> 日本語のファイルです。
>> JIS コードで書いてます。
>>>>>>>>> master:foo
>> 
>> The above will probably come out as UTF-8 in this mail text, but the point
>> is that the confict side markers do not have anything but filename and the
>> branch name.  I am still scratching my head trying to see where in the
>> merge-recursive codepath you got snippet of log message.
>
> Try rebase -i instead of merge: This should put summary lines onto the
> conflict markers.

Ah, that's cherry-pick.

The fix should be around the area this weather-balloon patch touches.

Note that this does not correctly work yet, and it seems that somewhere the
string is truncated.

But I won't be debugging it further for now...

----
 builtin-revert.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git c/builtin-revert.c w/builtin-revert.c
index d48313c..47ff16f 100644
--- c/builtin-revert.c
+++ w/builtin-revert.c
@@ -244,6 +244,19 @@ static struct tree *empty_tree(void)
 	return tree;
 }
 
+static char *branch_label_to_output_encoding(char *oneline)
+{
+	if (git_log_output_encoding &&
+	    strcmp(git_log_output_encoding, git_commit_encoding)) {
+		char *it = reencode_string(oneline,
+					   git_log_output_encoding,
+					   git_commit_encoding);
+		if (it)
+			return it;
+	}
+	return oneline;
+}
+
 static int revert_or_cherry_pick(int argc, const char **argv)
 {
 	unsigned char head[20];
@@ -373,7 +386,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	read_cache();
 	init_merge_options(&o);
 	o.branch1 = "HEAD";
-	o.branch2 = oneline;
+	o.branch2 = branch_label_to_output_encoding(oneline);
 
 	head_tree = parse_tree_indirect(head);
 	next_tree = next ? next->tree : empty_tree();
