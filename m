From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-grep Bus Error
Date: Sun, 08 Mar 2009 18:11:40 -0700
Message-ID: <7vtz63ijoz.fsf@gitster.siamese.dyndns.org>
References: <C36B091A-ABE9-4C74-9E59-4EBD50E3B9F5@gernhardtsoftware.com>
 <20090308234141.GJ12880@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Brian Gernhardt <brian@gernhardtsoftware.com>
To: Sam Hocevar <sam@zoy.org>
X-From: git-owner@vger.kernel.org Mon Mar 09 02:13:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgU3S-0002cb-DQ
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 02:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392AbZCIBLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 21:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753406AbZCIBLu
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 21:11:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62751 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165AbZCIBLt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 21:11:49 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7252BA095D;
	Sun,  8 Mar 2009 21:11:47 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 24331A095C; Sun,
  8 Mar 2009 21:11:42 -0400 (EDT)
In-Reply-To: <20090308234141.GJ12880@zoy.org> (Sam Hocevar's message of "Mon,
 9 Mar 2009 00:41:41 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 430724B8-0C47-11DE-A4C8-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112660>

Sam Hocevar <sam@zoy.org> writes:

> On Sun, Mar 08, 2009, Brian Gernhardt wrote:
>
>> >			printf( "%d %d %d",
>> >				  match.rm_so, match.rm_eo,
>> >				  match.rm_eo - match.rm_so );
>> 
>> .gitignore:0 0 3\033[31m\033[1m(nugit
>> .mailmap:23 0 26(null)\033[31m\033[1m(nugit-shortlog to fix a few  
>> botched name translations-shortlog to fix a few botched name  
>> translations
>> 
>> And now I'm baffled.  Apparently my computer thinks 0 - 0 == 3 and 0 -  
>> 23 == 26.
>
>    rm_so and rm_eo are ints on Linux but off_t's on Darwin, hence
> probably int64_t's here. You should cast the arguments.

That is a very good point.  In fact, "git grep -n -e 'printf.*%\.\*s'"
reveals that many existing call sites to this form casts the precision
argument explicitly to "int".

Brian, would this patch help?

 grep.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index cace1c8..dcdbd5e 100644
--- a/grep.c
+++ b/grep.c
@@ -490,9 +490,9 @@ static void show_line(struct grep_opt *opt, char *bol, char *eol,
 		*eol = '\0';
 		while (next_match(opt, bol, eol, ctx, &match, eflags)) {
 			printf("%.*s%s%.*s%s",
-			       match.rm_so, bol,
+			       (int) match.rm_so, bol,
 			       opt->color_match,
-			       match.rm_eo - match.rm_so, bol + match.rm_so,
+			       (int)(match.rm_eo - match.rm_so), bol + match.rm_so,
 			       GIT_COLOR_RESET);
 			bol += match.rm_eo;
 			rest -= match.rm_eo;
