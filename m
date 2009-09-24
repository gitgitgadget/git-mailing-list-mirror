From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] perl/Makefile.PL: detect MakeMaker versions incompatible with DESTDIR
Date: Thu, 24 Sep 2009 13:02:55 -0500
Message-ID: <7wQSYSBJPoVtvyGI0lqsDW37w4byCpgpMaHiDKALwW_oJ9nHXddX9OBMnqXGZBVAo2U7Tc1BMxg@cipher.nrlssc.navy.mil>
References: <7vk4zrt035.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, c@gryning.com,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 24 20:03:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mqsfd-0006S8-Od
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 20:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544AbZIXSDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2009 14:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753541AbZIXSDi
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 14:03:38 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:39822 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753540AbZIXSDg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 14:03:36 -0400
Received: by mail.nrlssc.navy.mil id n8OI3J6i015105; Thu, 24 Sep 2009 13:03:21 -0500
In-Reply-To: <7vk4zrt035.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 24 Sep 2009 18:03:18.0898 (UTC) FILETIME=[4BE57D20:01CA3D41]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129053>

From: Brandon Casey <drafnel@gmail.com>

It appears that ExtUtils::MakeMaker versions older than 6.11 do not
implement the DESTDIR mechanism.  So add a test to the generated perl.mak
to detect when DESTDIR is used along with a too old ExtUtils::MakeMaker and
abort with a message suggesting the use of NO_PERL_MAKEMAKER.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


Junio C Hamano wrote:
> Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil> writes:
> 
>> Possibly it is related to the version of MakeMaker?  I am using version
>> 6.17 (Revision: 1.133) along with Perl 5.8.4 on Solaris 10 x86.  The
>> MakeMaker version should be in the header at the top of the perl.mak
>> file.
> 
> I think that is it.  DESTDIR support in MakeMaker seems to be lacking in
> medieval versions of Perl.  It appears that it started being usable at
> around its 6.11 (and 6.17 you have is fine).
> 
>     http://kobesearch.cpan.org/htdocs/ExtUtils-MakeMaker/Changes.html
>     https://issues.apache.org/SpamAssassin/show_bug.cgi?id=6131#c7

How about something like this?

Seems to work correctly for me on IRIX 6.5 and Solaris 7 with
ExtUtils::MakeMaker 6.03.

-brandon


 perl/Makefile.PL |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index 320253e..8974015 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -5,6 +5,14 @@ sub MY::postamble {
 instlibdir:
 	@echo '$(INSTALLSITELIB)'
 
+ifneq (,$(DESTDIR))
+ifeq (1,$(shell expr '$(MM_VERSION)' '<' 6.11))
+$(error ExtUtils::MakeMaker version "$(MM_VERSION)" is older than 6.11 and so \
+	is likely incompatible with the DESTDIR mechanism.  Try setting \
+	NO_PERL_MAKEMAKER=1 instead)
+endif
+endif
+
 MAKE_FRAG
 }
 
-- 
1.6.4.3
