From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Fix git-init-db creating crap directories (zeroth try)
Date: Tue, 20 Sep 2005 02:19:50 +0200
Message-ID: <20050920001949.GL18320@pasky.or.cz>
References: <200509172141.31591.dtor_core@ameritech.net> <432F0D1B.60303@zytor.com> <20050919194445.GD18320@pasky.or.cz> <432F46BE.5000406@zytor.com> <20050919234030.GI18320@pasky.or.cz> <432F50BC.5000304@zytor.com> <20050920000731.GJ18320@pasky.or.cz> <432F5345.3020303@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Dmitry Torokhov <dtor_core@ameritech.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 02:20:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHVra-0006q5-FJ
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 02:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbVITATy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 20:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932726AbVITATy
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 20:19:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42120 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932724AbVITATx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 20:19:53 -0400
Received: (qmail 13432 invoked by uid 2001); 20 Sep 2005 02:19:51 +0200
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <432F5345.3020303@zytor.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8931>

Dear diary, on Tue, Sep 20, 2005 at 02:09:41AM CEST, I got a letter
where "H. Peter Anvin" <hpa@zytor.com> told me that...
> Petr Baudis wrote:
> >diff --git a/init-db.c b/init-db.c
> >--- a/init-db.c
> >+++ b/init-db.c
> >@@ -153,7 +153,8 @@ static void copy_templates(const char *g
> > 		return;
> > 	}
> > 
> >-	memcpy(path, git_dir, len);
> >+	memcpy(path, git_dir, len-1);
> >+	path[len] = 0;
> > 	copy_templates_1(path, len,
> 
> Wrong!  You're not initializing path[len-1]!

Oops, sorry. That's what you get when you want to make things marginally
better. ;-) We indeed want to pass copy_templates_1() the trailing slash
as well.

Let's just settle with the original patch then.

--

The base target directory for the templates copying was initialized
to git_dir, but git_dir[len] is not zero but / at the time we do the
initialization. This is not what we want for our target directory string
since we pass it to mkdir(), so make it zero-terminated manually.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
diff --git a/init-db.c b/init-db.c
--- a/init-db.c
+++ b/init-db.c
@@ -154,6 +154,7 @@ static void copy_templates(const char *g
 	}
 
 	memcpy(path, git_dir, len);
+	path[len] = 0;
 	copy_templates_1(path, len,
 			 template_path, template_len,
 			 dir);


-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
