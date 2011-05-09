From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH] only warn about ambiguous refs if stderr is a tty
Date: Mon,  9 May 2011 09:51:18 +0200
Message-ID: <1304927478-3112-1-git-send-email-kusmabite@gmail.com>
References: <BANLkTinLCirA4XP9AOb9piGo9ucMsmrmkQ@mail.gmail.com>
Cc: steveire@gmail.com, felipe.contreras@gmail.com, peff@peff.net,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 09:51:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJLFr-0000K2-96
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 09:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841Ab1EIHvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 03:51:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46974 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000Ab1EIHvl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 03:51:41 -0400
Received: by fxm17 with SMTP id 17so3415514fxm.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 00:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=iMmHG+Kmz5YzTvvuQ5CFTFTQHxVLP5fVfoLJwembFTo=;
        b=iOXWKdnRdb0FPrH1QuBEM37bsCSoaBNGc+sjjcxctP3inD/0LrQ2EXOduUdf+Sj0CG
         f68AfuE9WxTc1xBM2+EJePqnKYONFyLaAPEVvjAhKKJ6rBpoQYx7jc6rbYFbPTmLk5zE
         G2h4ShLtWHfeKvtQ112OAoha5e9Hsd7YUg9Tc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=x5L8AtJIv2v5hLFVEwYbU/nKxPKo9n1CN+08rSwZBb9w1BLvVvinTMJR+vnWNycv6O
         1HuQ8puCq9mbIQKbauYoOD8unpSALe27po+Mhta2z34krH+DtBh2J155IBTWJHduCFyL
         jRUBMWFITTZSBtDWSFJ5gUyKryOIGbDyDDnFE=
Received: by 10.223.127.197 with SMTP id h5mr1896059fas.36.1304927500295;
        Mon, 09 May 2011 00:51:40 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id c3sm1337997fav.27.2011.05.09.00.51.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2011 00:51:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.3775.ga8770a
In-Reply-To: <BANLkTinLCirA4XP9AOb9piGo9ucMsmrmkQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173203>

If there's a branch (either local or remote) called 'HEAD'
commands that take a ref currently emits a warning, no matter
if the output is going to a TTY or not.

Fix this by making sure we only output this warning when stderr
is a TTY. Other git commands or scripts should not care about
this ambiguity.

This fix prevents gitk from barfing when given no arguments and
there's a branch called 'HEAD'.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>

---

In 2f8acdb ('core.warnambiguousrefs: warns when "name" is used
and both "name" branch and tag exists.'), a check for collisions
of refs was introduced. It does not seem to me like the intention
was to check HEAD for ambiguty (because the commit talks about
branches and tags), but it does.

Because HEAD cannot be disambiguated like branches and tags can,
this can lead to an annoying warning, or even an error in the case
of gitk.

A branch called HEAD can be 'injected' into another user's repo
through remotes, and this can cause annoyance (and in the case of
gitk, brokenness) just by pulling the wrong remote. Yuck.

The particular problem of gitk can be fixed by making gitk able
to parse the warning, and probably forwarding it to the user.
This strikes me as The Right Thing To Do(tm), but is outside of my
gitk and TCL/TK skills.

Alternatively, gitk could state that it doesn't care about
ambiguous refs, by calling 'git -c core.warnambiguousrefs=0
show-ref <ref>'.

One question is if ANY warnings should be output to stderr if it's
not a TTY. My guess is that there probably are some classes of
warnings that should, but the vast majority should probably not.

Perhaps it's better to make warning() filter the output if stderr
is not a tty instead, and make the places that needs to warn just
do fprintf(stderr, ...) instead? That's one huge hammer, though.

Another question is if we should come up with a way of
disambiguating HEAD. Perhaps having something like 'refs/HEAD'
will do?

So, to recap: The way I see it, these are our options:

 1) Discard this specific warning when stderr isn't a TTY (i.e
    what this patch does)
 2) Discard all warnings when stderr isn't a TTY
 3) Make gitk understand and forward warnings to the user
 4) Have gitk explicitly ignore ambiuous refs
 5) Come up with a way to disambiguate HEAD, and use that instead
    by default
 6) Force HEAD to never be ambiguous
 7) Leave things as they are

I think 3) + 5) might be the most sane solution. That way we
inform the user that there's an ambiguity if he or she runs
'gitk HEAD' (so he or she has a chance the chance to correct it),
but the correct HEAD is chosen (without any annoying warnings) if
the user didn't specify a ref.

This combination also relies on us NOT doing 1), 2) or 4); i.e the
warning must still be output to reach the user.

Thoughs?

 sha1_name.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index faea58d..c7e855e 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -391,7 +391,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	if (!refs_found)
 		return -1;
 
-	if (warn_ambiguous_refs && refs_found > 1)
+	if (warn_ambiguous_refs && refs_found > 1 && isatty(2))
 		warning(warn_msg, len, str);
 
 	if (reflog_len) {
-- 
1.7.5.3775.ga8770a
