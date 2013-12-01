From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH] path_treatment: also ignore $GIT_DIR if it's not .git
Date: Mon, 02 Dec 2013 00:38:13 +0100
Message-ID: <1385941093.3240.10.camel@localhost>
References: <1385922611.3240.6.camel@localhost>
	 <20131201190447.GA31367@kaarsemaker.net>
	 <CACsJy8CxR+wj-P+fxF37DU=Tzk=su+V=UudbO7NkqTMS8qTn_w@mail.gmail.com>
	 <877gbop3so.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>, ingy@ingy.net
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Dec 02 00:38:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnGaw-0002ER-CF
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 00:38:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596Ab3LAXiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Dec 2013 18:38:18 -0500
Received: from mail-wg0-f51.google.com ([74.125.82.51]:60450 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412Ab3LAXiS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Dec 2013 18:38:18 -0500
Received: by mail-wg0-f51.google.com with SMTP id b13so8408080wgh.30
        for <git@vger.kernel.org>; Sun, 01 Dec 2013 15:38:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=V7y2UQgmm28yeKTN/12tStExDSmIxwV3GpbIKcINkwA=;
        b=RvfY0bD8LNE3OZi5xOYoapndJCiHlaP1Yy7epR1TlKXFD12lyaJgXPMQJ2Xfm+mGvD
         A3Qst6ZnFzpyWgkLV/6J9ViaTf0c/Bw2GiQjRg9ji/1rYHE3Pg8vqJt7NVl+JbEQQkWR
         WENTgm+lNulQEXETQsMEFlaVBOxNddcddxtvsPNlAxcCL1fX0yHgXjp1rntpyLqb30EN
         J8JDZwY8Emfl2hCKqwJH9kdpd/OsWT5fY5vZQ2taOnRVJkOzSRr6dHUlXFPT2MIA81t5
         aE6bxj6X5nnCHKJy18mjHYY99YCyhEhcRsyvmS+fqMD4dreJq0DE/CN49+Lzy9mAjaqb
         A7YA==
X-Gm-Message-State: ALoCoQlZ0zXRcgMdFfrd8UEQ6K+ZOteLZwp1nvRv9k9xrHwQpPaB/A6txQWPiL1VQtf4WJbD8vZ5
X-Received: by 10.180.107.193 with SMTP id he1mr15671354wib.50.1385941096465;
        Sun, 01 Dec 2013 15:38:16 -0800 (PST)
Received: from [10.42.1.4] (82-168-11-8.ip.telfort.nl. [82.168.11.8])
        by mx.google.com with ESMTPSA id je17sm25314876wic.4.2013.12.01.15.38.14
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 01 Dec 2013 15:38:15 -0800 (PST)
In-Reply-To: <877gbop3so.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238604>

On ma, 2013-12-02 at 00:08 +0100, Thomas Rast wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > On Mon, Dec 2, 2013 at 2:04 AM, Dennis Kaarsemaker
> > <dennis@kaarsemaker.net> wrote:
> >> We always ignore anything named .git, but we should also ignore the git
> >> directory if the user overrides it by setting $GIT_DIR
> [...]
> >> +       if (simplify_away(path->buf, path->len, simplify) || is_git_directory(path->buf))
> >>                 return path_none;
> >
> > this adds 2 access, 1 lstat, 1 open, 1 read, 1 close to _every_ path
> > we check. Is it worth the cost?
> 
> Moreover it is a much more inclusive check than what the commit message
> claims: it will ignore anything that looks like a .git directory,
> regardless of the name.  In particular GIT_DIR doesn't have anything to
> do with it.

Ah, yes thanks, that's rather incorrect indeed. How about the following
instead? Passes all tests, including the new one.

--- a/dir.c
+++ b/dir.c
@@ -1198,7 +1198,7 @@ static enum path_treatment treat_path(struct dir_struct *dir,
                return path_none;
        strbuf_setlen(path, baselen);
        strbuf_addstr(path, de->d_name);
-       if (simplify_away(path->buf, path->len, simplify))
+       if (simplify_away(path->buf, path->len, simplify) || !strncmp(get_git_dir(), path->buf, path->len))
                return path_none;
 
-- 
Dennis Kaarsemaker
www.kaarsemaker.net
