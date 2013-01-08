From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] clone: forbid --bare --separate-git-dir <dir>
Date: Tue, 8 Jan 2013 21:16:50 +0700
Message-ID: <20130108141650.GA18637@lanh>
References: <20130106091642.GA10956@elie.Belkin>
 <1357465670-32766-1-git-send-email-pclouds@gmail.com>
 <20130106101948.GD10956@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	"W. Trevor King" <wking@drexel.edu>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 08 15:17:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsZzB-0001Zt-Rb
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 15:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756322Ab3AHOQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 09:16:42 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:51560 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756278Ab3AHOQl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 09:16:41 -0500
Received: by mail-pa0-f44.google.com with SMTP id hz11so358175pad.17
        for <git@vger.kernel.org>; Tue, 08 Jan 2013 06:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Spl2XPgV/FcSmI7rXqJw62c11KtgMU12C2iUBLdq6Bw=;
        b=McHx5zyMeLNWyLGaL/KW55y1d1xG8dKlH/sjTYiim5Vr9XSJsw6gKKLP9zy9HVQ75R
         gFwRMucuC9ctUYpxgA1o0lP7naZF6VnNhadikfoUJxWMyEsq6qWmQ6+6kxTOgMowcqwf
         XQYftvlWmeuz2AX2okHbzGbLwxFx3Jqn34p/UIl9uu6HDBiwVDQcBhmgiMxVu1t2oT8f
         oIbd6+gv9Qaa9UZIgnZGdyHVsPnZm8+8+xZwqltU4M/EiBlP47oCjs6RJ8KVaA/a4fN6
         O+14u4+qgrrBu6eiozO5bVaFM4LmpDzmUDUpe93ASKSQProzZCONEmWs9FUrYjOrJXlY
         mVkQ==
X-Received: by 10.68.233.197 with SMTP id ty5mr202438512pbc.9.1357654600959;
        Tue, 08 Jan 2013 06:16:40 -0800 (PST)
Received: from lanh ([115.74.46.148])
        by mx.google.com with ESMTPS id nh4sm2126290pbc.18.2013.01.08.06.16.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Jan 2013 06:16:39 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 08 Jan 2013 21:16:50 +0700
Content-Disposition: inline
In-Reply-To: <20130106101948.GD10956@elie.Belkin>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212964>

On Sun, Jan 06, 2013 at 02:19:48AM -0800, Jonathan Nieder wrote:
> 	Unfortunately we forgot to forbid the --bare
> 	--separate-git-dir combination.  In practice, we know no one
> 	could be using --bare with --separate-git-dir because it is
> 	broken in the following way: <explanation here>.  So it is
> 	safe to make good on our mistake and forbid the combination,
> 	making the command easier to explain.
> 
> I don't know what would go in the <explanation here> blank above,
> though.  Is it possible that some people are relying on this option
> combination?

I can't say it's broken in what way. Maybe it's easier to just support
this case, it's not much work anyway. Jens, maybe squash this to your
original patch?

-- 8< --
diff --git a/builtin/clone.c b/builtin/clone.c
index 8d23a62..c8b09ad 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -375,6 +375,7 @@ static void clone_local(const char *src_repo, const char *dest_repo)
 
 static const char *junk_work_tree;
 static const char *junk_git_dir;
+static const char *junk_git_file;
 static pid_t junk_pid;
 
 static void remove_junk(void)
@@ -392,6 +393,8 @@ static void remove_junk(void)
 		remove_dir_recursively(&sb, 0);
 		strbuf_reset(&sb);
 	}
+	if (junk_git_file)
+		unlink(junk_git_file);
 }
 
 static void remove_junk_on_signal(int signo)
@@ -772,6 +775,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	set_git_dir_init(git_dir, real_git_dir, 0);
 	if (real_git_dir) {
+		if (option_bare)
+			junk_git_file = git_dir;
 		git_dir = real_git_dir;
 		junk_git_dir = real_git_dir;
 	}
diff --git a/t/t5600-clone-fail-cleanup.sh b/t/t5600-clone-fail-cleanup.sh
index 4435693..231bc8a 100755
--- a/t/t5600-clone-fail-cleanup.sh
+++ b/t/t5600-clone-fail-cleanup.sh
@@ -49,4 +49,14 @@ test_expect_success 'failed clone --separate-git-dir should not leave any direct
 	rmdir foo/.git/objects.bak
 '
 
+test_expect_success 'failed clone --separate-git-dir --bare should not leave any directories' '
+	mkdir foo/.git/objects.bak/ &&
+	mv foo/.git/objects/* foo/.git/objects.bak/ &&
+	test_must_fail git clone --bare --separate-git-dir gitdir foo baaar &&
+	test_must_fail test -e gitdir &&
+	test_must_fail test -e baaar &&
+	mv foo/.git/objects.bak/* foo/.git/objects/ &&
+	rmdir foo/.git/objects.bak
+'
+
 test_done
-- 8< --
