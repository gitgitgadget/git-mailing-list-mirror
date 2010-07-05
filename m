From: Gisle Aas <gisle@aas.no>
Subject: Make author and committer available to pre-commit hook
Date: Mon, 5 Jul 2010 13:30:46 +0200
Message-ID: <AANLkTinpCDRf_Yhuj2-tdZwmvHk8yna1Xjdtbrmx35CB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 05 13:31:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVjtG-0006nY-Rq
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 13:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195Ab0GELat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 07:30:49 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50260 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009Ab0GELas (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 07:30:48 -0400
Received: by fxm14 with SMTP id 14so3558786fxm.19
        for <git@vger.kernel.org>; Mon, 05 Jul 2010 04:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=fMUftqfQFx/3a2a5CxXXT+A6qFLdo/Wm1LX9KKNSXWw=;
        b=fSC++pbakSlqVYEgZ2Gn90OE0l9nG9mMjdSuiHRbH3ynn+qMWoRYanvMmt+7+Jn8rF
         EeFThw9/1Mk26xIikJi0WyC5/NBr1qxBlpnaWHM0wH04w3ohc0AWtTQ88Tb7vtXER1Y/
         BzVvqLT8d+/AlEtp2WcabzptRgvTNfoIns5Gs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=QttnG8WghD35hgXSEJZqijxzD0MbVakXEZegVvd7lazb1JAY+dGnZGax17irS0buMw
         QJhKFIPykAXhVndzfj7tRePVxkTCWZPJ/WmMw823qu6eY3U3cYunjmyAnYVyeGkRIaBK
         UM0punT94wtTLXkw6OzNQBgWw/70ZFV2oBbD4=
Received: by 10.103.177.3 with SMTP id e3mr272207mup.38.1278329446876; Mon, 05 
	Jul 2010 04:30:46 -0700 (PDT)
Received: by 10.103.250.16 with HTTP; Mon, 5 Jul 2010 04:30:46 -0700 (PDT)
X-Google-Sender-Auth: vCs8XbxAriQ3Q7cH_7PbAS_F0uQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150257>

I would like to implement a pre-commit hook that validates the
--author set for the commit.  Our use case is a shared repository of
configuration info where different persons all commit as root; but we
want to make sure they override the --author to something sensible.

What would be the preferred mechanism to pass on this information?  It
could for instance be arguments to the hook script or via environment
variables.

I created the following patch to explore what it would take to pass on
this information as command line arguments.  It seems to do the trick
for me.  Any drawback with this approach?

Regards,
Gisle


diff --git a/builtin/commit.c b/builtin/commit.c
index c101f00..acb8dc2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -557,8 +557,20 @@ static int prepare_to_commit(const char
*index_file, const char *prefix,
        const char *hook_arg2 = NULL;
        int ident_shown = 0;

-       if (!no_verify && run_hook(index_file, "pre-commit", NULL))
+       determine_author_info();
+       if (!no_verify) {
+           int rc;
+           hook_arg1 = xstrdup(fmt_name(author_name, author_email));
+           hook_arg2 = xstrdup(fmt_name(getenv("GIT_COMMITTER_NAME"),
+                                        getenv("GIT_COMMITTER_EMAIL")));
+           rc = run_hook(index_file, "pre-commit", hook_arg1, hook_arg2, NULL);
+           free((char*)hook_arg1);
+           free((char*)hook_arg2);
+           if (rc)
                return 0;
+           hook_arg1 = NULL;
+           hook_arg2 = NULL;
+       }

        if (message.len) {
                strbuf_addbuf(&sb, &message);
@@ -632,8 +644,6 @@ static int prepare_to_commit(const char
*index_file, const char *prefix,

        strbuf_release(&sb);

-       determine_author_info();
-
        /* This checks if committer ident is explicitly given */
        git_committer_info(0);
        if (use_editor && include_status) {
