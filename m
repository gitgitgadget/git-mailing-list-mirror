From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [RFC/PATCH] extend meaning of "--root" option to index
 comparisons
Date: Fri, 19 Sep 2008 13:27:46 -0700
Message-ID: <7vskrvswxp.fsf@gitster.siamese.dyndns.org>
References: <3665a1a00809151301p7d8e6387g3cacfb879b45da2f@mail.gmail.com>
 <48CECA42.1050209@drmicha.warpmail.net>
 <bd6139dc0809151411p49f5adeaq4beff452574ca980@mail.gmail.com>
 <20080915223442.GD20677@sigill.intra.peff.net>
 <bd6139dc0809152319m31a79877h5dc1b701a8210802@mail.gmail.com>
 <20080916062105.GA12708@coredump.intra.peff.net>
 <20080918092152.GA18732@coredump.intra.peff.net>
 <3665a1a00809180931t191b5a24wd58554cdb761535@mail.gmail.com>
 <20080919142537.GA1287@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>, sverre@rabbelier.nl,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 19 22:29:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgmbB-0005vB-BI
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 22:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237AbYISU15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 16:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754162AbYISU15
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 16:27:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37673 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754135AbYISU14 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 16:27:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CC12763712;
	Fri, 19 Sep 2008 16:27:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 94F5063711; Fri, 19 Sep 2008 16:27:49 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7091D412-8689-11DD-9FC9-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96310>

Jeff King <peff@peff.net> writes:

> On Thu, Sep 18, 2008 at 09:31:24AM -0700, Anatol Pomozov wrote:
>
>> > Can you think of any other cases?
>> 
>> git log??
>> 
>> git log --root for empty repo should not print anything (instead of
>> error message that we have now).
>
> I'm not sure that's the same as "--root", though. In existing --root
> cases, we are saying "pretend that beyond the initial commit, there is a
> commit that contains the empty tree". The logical extension of git-log
> here would be to print out that commit.

I would say:

 (1) A user getting an error message from "git init && git log" may be
     annoyed, but he very well knows there is no history yet _anyway_.
     This initial annoyance will pass immediately after creating any
     commit, so I do not think it is a big issue.

     "bad default revision 'HEAD'" is a cryptic way to give that indicaion
     that can be improved but that is a separate issue.  Rewording it so
     that it explains the situation better in user's terms would be a
     worthy improvement.

 (2) "--root" is about "do we show a creation event as a huge diff from
     emptyness?".  Yes, we turn it on for "git log" but it does not have
     anything to do with the issue of yet to be born branch, where there
     isn't even a big creation event yet.

I am reluctant to agree with the opinion that "git log" should be _silent_
in a world without any history.

Perhaps something like this would be a good compromise?  I dunno.

 builtin-log.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git c/builtin-log.c w/builtin-log.c
index 081e660..881324c 100644
--- c/builtin-log.c
+++ w/builtin-log.c
@@ -42,7 +42,14 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	if (default_date_mode)
 		rev->date_mode = parse_date_format(default_date_mode);
 
-	argc = setup_revisions(argc, argv, rev, "HEAD");
+	argc = setup_revisions(argc, argv, rev, NULL);
+	if (!rev->pending.nr) {
+		add_head_to_pending(rev);
+		if (!rev->pending.nr) {
+			printf("No commits (yet).\n");
+			exit(0);
+		}
+	}
 
 	if (rev->diffopt.pickaxe || rev->diffopt.filter)
 		rev->always_show_header = 0;
