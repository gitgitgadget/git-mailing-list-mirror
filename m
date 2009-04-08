From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/3] list-objects: add "void *data" parameter to show functions
Date: Wed, 8 Apr 2009 06:39:35 +0200
Message-ID: <200904080639.35499.chriscool@tuxfamily.org>
References: <20090407040819.4338.4291.chriscool@tuxfamily.org> <20090407040854.4338.94304.chriscool@tuxfamily.org> <7vk55vubcv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 06:42:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrPc9-0006uY-Gd
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 06:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038AbZDHEkq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Apr 2009 00:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbZDHEkp
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 00:40:45 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:33494 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800AbZDHEko convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Apr 2009 00:40:44 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 840E89400C4;
	Wed,  8 Apr 2009 06:40:35 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 5CF6B940019;
	Wed,  8 Apr 2009 06:40:33 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vk55vubcv.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116031>

Le mercredi 8 avril 2009, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > The goal of this patch is to get rid of the "static struct rev_info
> > revs" static variable in "builtin-rev-list.c".
>
> Hmm.  If it were a more library-ish file, a removal of such a static
> variable might help you to make more than one calls to a library
> function, but does it matter in files like builtin-rev-list.c?  Its
> cmd_rev_list() is like main() --- it is meant to run once and exit.
>
> So if it is the only goal of this series, I am inclined to say that I=
 do
> not have a reason to look at the rest of the series, but as a side ef=
fect
> does this removal make some other API better?  Perhaps a more library=
-ish
> function is in builtin-rev-list.c and this structure should really ne=
eds
> to be passed around as a parameter, but I cannot tell solely by readi=
ng
> the goal above, without reading the patches themselves.

In the cover letter, I wrote that the patch series removes restrictions=
 on=20
using the "show_bisect_vars" function.

In fact there was a restriction on the use of the BISECT_SHOW_ALL flag=20
because that would use the "show_commit" function that was using static=
=20
variables.

The restriction was described in a comment in "bisect.h" and this comme=
nt is=20
removed by the series.=20

This is the relevant hunk in patch 2/3:

diff --git a/bisect.h b/bisect.h
index f5d1067..b1c334d 100644
--- a/bisect.h
+++ b/bisect.h
@@ -14,12 +14,14 @@ extern struct commit_list *filter_skipped(struct=20
commit_list *list,
 #define BISECT_SHOW_TRIED      (1<<1)
 #define BISECT_SHOW_STRINGED   (1<<2)
=20
-/*
- * The flag BISECT_SHOW_ALL should not be set if this function is call=
ed
- * from outside "builtin-rev-list.c" as otherwise it would use
- * static "revs" from this file.
- */
-extern int show_bisect_vars(struct rev_info *revs, int reaches, int al=
l,
+struct rev_list_info {
+       struct rev_info *revs;
+       int show_timestamp;
+       int hdr_termination;
+       const char *header_prefix;
+};
+
+extern int show_bisect_vars(struct rev_list_info *info, int reaches, i=
nt=20
all,
                            int flags);
=20
 extern int bisect_next_vars(const char *prefix);


Best regards,
Christian.

> > Anyway this makes the code more clean and more generic, so it
> > should be a good thing in the long run.
>
> I wouldn't disagree with that "long run" thing, but the answer to the
> above question affects the placement of this series in my prioritized
> queue.
