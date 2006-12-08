X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem compiling: that perl thing again
Date: Fri, 08 Dec 2006 12:49:49 -0800
Message-ID: <7vvekmgljm.fsf@assigned-by-dhcp.cox.net>
References: <805469.91804.qm@web31805.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 20:49:59 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <805469.91804.qm@web31805.mail.mud.yahoo.com> (Luben Tuikov's
	message of "Fri, 8 Dec 2006 12:36:28 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33742>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsmfJ-00035P-L1 for gcvg-git@gmane.org; Fri, 08 Dec
 2006 21:49:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1761197AbWLHUtv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 15:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946575AbWLHUtv
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 15:49:51 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:34024 "EHLO
 fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1761197AbWLHUtu (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 15:49:50 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061208204950.CPLX15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>; Fri, 8
 Dec 2006 15:49:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id wLpD1V00H1kojtg0000000; Fri, 08 Dec 2006
 15:49:13 -0500
To: ltuikov@yahoo.com
Sender: git-owner@vger.kernel.org

Luben Tuikov <ltuikov@yahoo.com> writes:

> Over the last 2 months each time I pull, check out next and compile,
> I'm seeing _some_ kind of problem with compiling the perl section
> of git.  Sometimes git-reset --hard, or a fresh checkout, or git-clean
> resolve the situation.  But not this time.
> ...
> So, where is "perl.mak"?

This particular breakage cannot be "last two months", but there
was a recent breakage by commit f848718a last week on the 'master'
branch.

---
Junio C Hamano <junkio@cox.net> writes:
> merlyn@stonehenge.com (Randal L. Schwartz) writes:
>
>>>>>>> "Alex" == Alex Riesen <raa.lkml@gmail.com> writes:
>>
>> Alex> Strange. You seem to have the old, generated Makefile you perl/
>> Alex> directory. Haven't your pull failed? If so, I suspect that
>>
>> Alex>  rm perl/Makefile
>> Alex>  git reset --hard
>> Alex>  git pull git...
>>
>> I ended up having to do another reset afterward.
>>
>> Definitely something went weird when Makefile was removed
>> from .gitignore.
>
> Yes, perl/Makefile is getting overwritten by what Makefile.PL
> generates.  I thought the point of Alex's patch was to have it
> muck with perl.mak and leave the tracked Makefile alone?

Now, I am CLUELESS about what MakeMaker does, but would this
help?

--- 
diff --git a/perl/Makefile b/perl/Makefile
index bd483b0..099beda 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -29,7 +29,7 @@ $(makfile): ../GIT-CFLAGS Makefile
 	echo '	echo $(instdir_SQ)' >> $@
 else
 $(makfile): Makefile.PL ../GIT-CFLAGS
-	'$(PERL_PATH_SQ)' $< FIRST_MAKEFILE='$@' PREFIX='$(prefix_SQ)'
+	'$(PERL_PATH_SQ)' $< PREFIX='$(prefix_SQ)'
 endif
 
 # this is just added comfort for calling make directly in perl dir
diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index de73235..4168775 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -24,5 +24,6 @@ WriteMakefile(
 	NAME            => 'Git',
 	VERSION_FROM    => 'Git.pm',
 	PM		=> \%pm,
+	MAKEFILE	=> 'perl.mak',
 	%extra
 );
