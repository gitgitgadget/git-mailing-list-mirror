From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v2] link_alt_odb_entry: fix read over array bounds reported
	by valgrind
Date: Mon, 30 Jul 2012 19:33:29 +0200
Message-ID: <20120730173328.GA28420@book.hvoigt.net>
References: <20120728154635.GB98893@book.hvoigt.net> <7v4noqul05.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Torsten =?iso-8859-1?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 19:36:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvttL-0004YM-HW
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 19:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194Ab2G3RgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 13:36:06 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.29]:46134 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755098Ab2G3Rdj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 13:33:39 -0400
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1SvtqU-0001Lc-NU; Mon, 30 Jul 2012 19:33:30 +0200
Content-Disposition: inline
In-Reply-To: <7v4noqul05.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202589>

pfxlen can be longer than the path in objdir when relative_base contains
the path to Git's object directory.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---

On Sun, Jul 29, 2012 at 05:54:02PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > pfxlen can be longer than the path in objdir when relative_base contains
> > the path to gits object directory.
> 
> s/gits/????/ perhaps "Git's", but I am not sure.

Git's is correct.

> > @@ -298,7 +298,8 @@ static int link_alt_odb_entry(const char * entry, int len, const char * relative
> >  			return -1;
> >  		}
> >  	}
> > -	if (!memcmp(ent->base, objdir, pfxlen)) {
> > +	objdirlen = strlen(objdir);
> > +	if (!memcmp(ent->base, objdir, pfxlen > objdirlen ? objdirlen : pfxlen)) {
> 
> The new code tells us to compare up to the shorter length between
> objdir (i.e. path/to/.git/objects) and the given alternate object
> directory (i.e. alt/path/to/.git/objects), but is that really what
> we want?  What happens if the given alternate object directory were
> "path/to/.git/objects-not-quite", with objdir "path/to/.git/objects"?
> 
> They are not the same directory, and this check is about avoiding
> "the common mistake of listing ... object directory itself", no?

You are right. strcmp is the correct solution for this. I tried your
change and it also fixes the error valgrind reported.

 sha1_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 4ccaf7a..af5cfbd 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -298,7 +298,7 @@ static int link_alt_odb_entry(const char * entry, int len, const char * relative
 			return -1;
 		}
 	}
-	if (!memcmp(ent->base, objdir, pfxlen)) {
+	if (!strcmp(ent->base, objdir)) {
 		free(ent);
 		return -1;
 	}
-- 
1.7.12.rc0.24.g3fa2a49
