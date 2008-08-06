From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] perl/Makefile: handle paths with spaces by adding additional
 quoting
Date: Wed, 06 Aug 2008 16:38:22 -0500
Message-ID: <S9LtwBbR-xqpcHr3teNenKBeyoVR63FrWUFS7_4iBRcVwE1vdOAZFw@cipher.nrlssc.navy.mil>
References: <7vy739nbmp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 06 23:39:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQqjO-0006Px-MQ
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 23:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbYHFVij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 17:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbYHFVij
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 17:38:39 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:60486 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbYHFVii (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 17:38:38 -0400
Received: by mail.nrlssc.navy.mil id m76LcMOR017159; Wed, 6 Aug 2008 16:38:22 -0500
In-Reply-To: <7vy739nbmp.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 06 Aug 2008 21:38:22.0666 (UTC) FILETIME=[C01FBAA0:01C8F80C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91542>

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> There are problems here with spaces, single quotes, and double quotes.
>> I'll follow up in another email.
> 
> I guess we've opened up a large can of worms.  Let's have the minimum fix
> that says "We do support whitespace in these paths but no other funnies"
> and leave the more intrusive one for post 1.6.0, for now.

That is this patch.

BUT. It produces some strangeties in the perl.mak file.

PREFIX looks great:

    PREFIX = '/home/casey/opt/test spaces/'

but then down in the $(MAKE_APERL_FILE) section we get something like:

    PREFIX=''/home/casey/opt/test spaces/''

because MakeMaker was already single quoting it.

Everything compiles and installs correctly for me.

In addition to putting a space in the prefix path, I also tried semicolon,
colon, and backslash. semicolon didn't work, but it didn't work before either.
colon and backslash worked. A backslash in the prefix path produced some
complaints when compiling some of the source files caused by the macros that
I mentioned earlier that are used by some of the files. The warning was
'unknown escape sequence ...'. The backslash was interpreted as an escape
sequence and then just dropped, so the path compiled into the object files
was wrong. I guess this doesn't happen on windows?

Summary: with this patch spaces in the prefix path work. It didn't break
         anything that I tested.

Maybe there's a MakeMaker expert in the audience?

-brandon


 perl/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/perl/Makefile b/perl/Makefile
index b8547db..6d2a200 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -38,7 +38,7 @@ $(makfile): ../GIT-CFLAGS Makefile
 	echo '	echo $(instdir_SQ)' >> $@
 else
 $(makfile): Makefile.PL ../GIT-CFLAGS
-	$(PERL_PATH) $< PREFIX='$(prefix_SQ)'
+	$(PERL_PATH) $< PREFIX=\''$(prefix_SQ)'\'
 endif
 
 # this is just added comfort for calling make directly in perl dir
-- 
1.5.6.2
