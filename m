From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git grep -I bug
Date: Mon, 02 Feb 2009 09:54:31 -0800
Message-ID: <7vwsc8hgh4.fsf@gitster.siamese.dyndns.org>
References: <20090202174257.GA8259@Ambelina.erc-wireless.uc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeremy O'Brien <obrien654j@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 18:56:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU31j-0003zw-Tx
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 18:56:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890AbZBBRyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 12:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752725AbZBBRyk
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 12:54:40 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60694 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbZBBRyj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 12:54:39 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CBE2796DBF;
	Mon,  2 Feb 2009 12:54:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BFE9696DBC; Mon,
  2 Feb 2009 12:54:33 -0500 (EST)
In-Reply-To: <20090202174257.GA8259@Ambelina.erc-wireless.uc.edu> (Jeremy
 O'Brien's message of "Mon, 2 Feb 2009 12:42:57 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8E505B20-F152-11DD-A61C-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108101>

Jeremy O'Brien <obrien654j@gmail.com> writes:

> I am running git version 1.6.1.2.309.g2ea3.
>
> When I use
>
> git grep -I "string_to_match"
>
> to ignore binary files in my grep, binary files are returned anyway.

One sanity check.  What does 'git grep --cached -I "string_to_match"' do
in that case?

If it works as expected but without --cached it doesn't, then I think the
following patch will fix it.

-- >8 --
Subject: grep: pass -I (ignore binary) down to external grep

The external-grep codepath forgets to pass this option.  Fix it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-grep.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git c/builtin-grep.c w/builtin-grep.c
index bebf15c..c799fdd 100644
--- c/builtin-grep.c
+++ w/builtin-grep.c
@@ -297,6 +297,8 @@ static int external_grep(struct grep_opt *opt, const char **paths, int cached)
 		push_arg("-l");
 	if (opt->unmatch_name_only)
 		push_arg("-L");
+	if (opt->binary == GREP_BINARY_NOMATCH)
+		push_arg("-I");
 	if (opt->null_following_name)
 		/* in GNU grep git's "-z" translates to "-Z" */
 		push_arg("-Z");
