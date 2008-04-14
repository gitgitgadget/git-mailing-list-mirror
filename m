From: Alberto Bertogli <albertito@gmail.com>
Subject: [PATCH] builtin-apply: Show a more descriptive error on failure when opening a patch
Date: Mon, 14 Apr 2008 12:30:27 -0300
Message-ID: <1208187027-29198-1-git-send-email-albertito@gmail.com>
References: <alpine.DEB.1.00.0804141532390.28504@racer>
Cc: Alberto Bertogli <albertito@gmail.com>
To: Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 14 17:35:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlQg7-0002oX-7b
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 17:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788AbYDNPcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 11:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753924AbYDNPcT
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 11:32:19 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:47986 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbYDNPcS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 11:32:18 -0400
Received: by wa-out-1112.google.com with SMTP id m16so2462512waf.23
        for <git@vger.kernel.org>; Mon, 14 Apr 2008 08:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=QtmsR0kQpEJj1Vp94HIpcTY2QeHF9PmYzF8IPcB2HW8=;
        b=OYmtuV3VKZq9nTF/2uKm/I0cClVUvkZwEUaeTjyPdLr7flWh8XwmyHRCYMmu0tdC799jj+MsSu9ej/puQWd5IP9xjepOMN+CdTlZB4QkiimNJHMjoVhM6teO8CMbWWdZwCBEUlLOs+m7W1yc+xnLLetjdlorQyANX/LnAYEG2Sw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=U4+lbZMSenpbu0Iyfb8jUDX6yyI05sUXr3ppGqkZp1AlZCm0gr1Clcuvd1Eb1GbBBEd2NRvY9ETinsqb4w51pqx9R0JOjCvp6tOkRQPTkN6132rl6SYSfShgrAbm7q8c0FRAH23xZmroiq6Po23W2dDw6NJSKp28vN9Gs2hf3tA=
Received: by 10.115.58.1 with SMTP id l1mr7062904wak.110.1208187136688;
        Mon, 14 Apr 2008 08:32:16 -0700 (PDT)
Received: from gmail.com ( [201.253.179.18])
        by mx.google.com with ESMTPS id a44sm38251rne.2.2008.04.14.08.31.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Apr 2008 08:32:06 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.105.g7849.dirty
In-Reply-To: <alpine.DEB.1.00.0804141532390.28504@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79509>

When a patch can't be opened (it doesn't exist, there are permission
problems, etc.) we get the usage text, which is not a proper indication of
failure.

This patch fixes that by calling error() instead.

Signed-off-by: Alberto Bertogli <albertito@gmail.com>
---

On Mon, Apr 14, 2008 at 03:33:54PM +0100, Johannes Schindelin wrote:
> On Mon, 14 Apr 2008, Alberto Bertogli wrote:
> 
> > +           if (fd < 0) {
> > +                   error("can't open patch '%s': %s", arg,
> > +                                   strerror(errno));
> > +                   return 1;
> > +           }
> 
> Do you absolutely want to retain the curly braces, and have two 
> statements?   I would prefer "return error(...)", and if you absolutely 
> insist on a return 1: "return !!error(...)".

No, I'm not insisting on any version, I just thought returning 1 would be
better since it will become the script exit status; Now that I think a bit
more about it, maybe I should just use die() instead.

Anyway, here's the version returning directly from error(); if you prefer it
some other way just let me know.

Thanks,
		Alberto


 builtin-apply.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index abe73a0..56032ce 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -3121,7 +3121,9 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 
 		fd = open(arg, O_RDONLY);
 		if (fd < 0)
-			usage(apply_usage);
+			return error("can't open patch '%s': %s", arg,
+					strerror(errno));
+
 		read_stdin = 0;
 		set_default_whitespace_mode(whitespace_option);
 		errs |= apply_patch(fd, arg, inaccurate_eof);
-- 
1.5.5.105.g7849.dirty
