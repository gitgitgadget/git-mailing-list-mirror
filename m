From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: [PATCH] Fix argument handling for fetch-pack call when stdout is connected and -q/--quiet is supplied.
Date: Fri, 3 Oct 2008 21:34:33 +0200
Message-ID: <4ac8254d0810031234x26ebc96cy7cf5dcae2ef516e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: barkalow@iabervon.org, davej@codemonkey.org.uk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 21:35:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlqRG-0001QX-9p
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 21:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbYJCTeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 15:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752534AbYJCTef
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 15:34:35 -0400
Received: from el-out-1112.google.com ([209.85.162.176]:22032 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475AbYJCTef (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 15:34:35 -0400
Received: by el-out-1112.google.com with SMTP id z25so359129ele.1
        for <git@vger.kernel.org>; Fri, 03 Oct 2008 12:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=6kxcUjYE7T9s9MUfvZK4FyR6IkqTavV3V6+FoOXu/L4=;
        b=Q8HerIUgF+vmhgRbdVvBMGdOl89qLekxBjXe9dsBSf9PQYndp4emarUgY9xFkWjohj
         M3R2ogEYe87SjAnHBrbTJexZZv6QCy0iQ6NULUmjRPtY7Af4VrlQ2A+0TFSDbXV8brFw
         RbdxC9srYL11zBJoS4+BcBEbA+R7Fms8EqTD8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=CeA6dXK5hperQpmO8nprSzZ2z3evSMo0izswNxNfBhM+3j7MYITzKMi2GlUMbL2gvw
         mIaqaMxudomvk7qFxn0eIlh+WWhGvyiXkR4lYTGRLq7Fe6N8RMUWXNddq2K4kEVmD2sP
         2hLhufSHfTRSJgYx3pz04TIjRkmqPHiMrwB5o=
Received: by 10.151.113.5 with SMTP id q5mr2212884ybm.37.1223062473752;
        Fri, 03 Oct 2008 12:34:33 -0700 (PDT)
Received: by 10.65.251.6 with HTTP; Fri, 3 Oct 2008 12:34:33 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97445>

Following is a patch to complete the changes discussed
here http://marc.info/?l=git&m=121529226023180&w=2.

I hope it makes sense and doesn't break something else.

With this simple one-liner patch applied I no longer see
the following remote messages as no-progress is correctly
sent to the remote site:
remote: Counting objects: 84102, done.
remote: Compressing objects: 100% (24720/24720), done.
remote: Total 84102 (delta 60949), reused 80810 (delta 57900)

Regards,

        Tuncer Ayaz

Signed-off-by: Tuncer Ayaz <tuncer.ayaz@gmail.com>
---
 transport.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/transport.c b/transport.c
index 71433d9..1f24011 100644
--- a/transport.c
+++ b/transport.c
@@ -644,7 +644,7 @@ static int fetch_refs_via_pack(struct transport *transport,
    args.include_tag = data->followtags;
    args.verbose = (transport->verbose > 0);
    args.quiet = args.no_progress = (transport->verbose < 0);
-   args.no_progress = !isatty(1);
+   args.no_progress = args.quiet || !isatty(1);
    args.depth = data->depth;

    for (i = 0; i < nr_heads; i++)
-- 
1.6.0.2
