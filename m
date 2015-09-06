From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] am: match --signoff to the original scripted version
Date: Sat, 05 Sep 2015 21:56:27 -0700
Message-ID: <xmqqio7ob0xw.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Sep 06 06:56:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYS0f-0006RN-6s
	for gcvg-git-2@plane.gmane.org; Sun, 06 Sep 2015 06:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbbIFE4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2015 00:56:31 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35878 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbbIFE43 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2015 00:56:29 -0400
Received: by pacwi10 with SMTP id wi10so62796274pac.3
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 21:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=TzDSFTGwgRzsarr3BmEWIGAZs44nY0R9XefIlJNScYk=;
        b=d6+7ViOZ7FrPVNubIsLPcT8Q23r7n81hsoMhDGkURu3RQyT8f7NPhF0z/QeFvbLveI
         3aiw8Dq63iPAi4mdEhGIpsTGBUC1IoKERvkHsB+NjwxIUhPf+g+J6gU8ErJllZkmUf54
         78fM+DcD/Vr8vMQZRKTb6QHotsfTihtpo/2O4dLcimMo/nyFr6ypQUc7eKKmL1OUSbrV
         LqtFvDqWgDmClu0IORp4KEgfIFy0azwiPT92ikGk4/4roWL+ggKgvun2DhojSrjr92xK
         JTpOoOrKqIKZbr40Df4lFHWuO8SxE+52naYqygEACdL6zHqWlxRveG3jR422Sxf1kg+l
         oiRw==
X-Received: by 10.66.101.7 with SMTP id fc7mr28547604pab.57.1441515388597;
        Sat, 05 Sep 2015 21:56:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:91db:290:be53:1b89])
        by smtp.gmail.com with ESMTPSA id sr4sm7514538pab.26.2015.09.05.21.56.27
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Sat, 05 Sep 2015 21:56:27 -0700 (PDT)
In-Reply-To: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
	(Linus Torvalds's message of "Fri, 4 Sep 2015 16:47:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277415>

Linus noticed that the recently reimplementated "git am -s" defines
the trailer block too rigidly, resulting an unnecessary blank line
between the existing sign-offs and his new sign-off.  An e-mail
submission sent to Linus in real life ends with mixture of sign-offs
and commentaries, e.g.

	title here

	message here

	Signed-off-by: Original Author <original@auth.or>
	[rv: tweaked frotz and nitfol]
	Signed-off-by: Re Viewer <rv@ew.er>
	Signed-off-by: Other Reviewer <other@rev.ewer>
	---
	patch here

Because the reimplementation reused append_signoff() helper that is
used by other codepaths, which is unaware that people intermix such
comments with their sign-offs in the trailer block, such a message
was judged to end with a non-trailer, resulting in an extra blank
before adding a new sign-off.

The original scripted version of "git am" used a lot looser
definition, i.e. "if and only if there is no line that begins with
Signed-off-by:, add a blank line before adding a new sign-off".  For
the upcoming release, stop using the append_signoff() in "git am"
and reimplement the looser definition used by the scripted version
to use only in "git am" to fix this regression in "am" while
avoiding new regressions to other users of append_signoff().

In the longer term, we should look into loosening append_signoff()
so that other codepaths that add a new sign-off behave the same way
as "git am -s", but that is a task for post-release.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * So this is essentially that "third try", but with a bit of test
   to cast in stone that we expect things that are not "key: value"
   in the trailer block.  Let's have this (or a fix along this line)
   as a regression fix for the upcoming release.

 builtin/am.c  | 31 +++++++++++++++++++++++++++++--
 t/t4150-am.sh | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 634f7a7..e7828e5 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1191,6 +1191,33 @@ static void NORETURN die_user_resolve(const struct am_state *state)
 	exit(128);
 }
 
+static void am_signoff(struct strbuf *sb)
+{
+	char *cp;
+	struct strbuf mine = STRBUF_INIT;
+
+	/* Does it end with our own sign-off? */
+	strbuf_addf(&mine, "\n%s%s\n",
+		    sign_off_header,
+		    fmt_name(getenv("GIT_COMMITTER_NAME"),
+			     getenv("GIT_COMMITTER_EMAIL")));
+	if (mine.len < sb->len &&
+	    !strcmp(mine.buf, sb->buf + sb->len - mine.len))
+		goto exit; /* no need to duplicate */
+
+	/* Does it have any Signed-off-by: in the text */
+	for (cp = sb->buf;
+	     cp && *cp && (cp = strstr(cp, sign_off_header)) != NULL;
+	     cp = strchr(cp, '\n')) {
+		if (sb->buf == cp || cp[-1] == '\n')
+			break;
+	}
+
+	strbuf_addstr(sb, mine.buf + !!cp);
+exit:
+	strbuf_release(&mine);
+}
+
 /**
  * Appends signoff to the "msg" field of the am_state.
  */
@@ -1199,7 +1226,7 @@ static void am_append_signoff(struct am_state *state)
 	struct strbuf sb = STRBUF_INIT;
 
 	strbuf_attach(&sb, state->msg, state->msg_len, state->msg_len);
-	append_signoff(&sb, 0, 0);
+	am_signoff(&sb);
 	state->msg = strbuf_detach(&sb, &state->msg_len);
 }
 
@@ -1303,7 +1330,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 	stripspace(&msg, 0);
 
 	if (state->signoff)
-		append_signoff(&msg, 0, 0);
+		am_signoff(&msg);
 
 	assert(!state->author_name);
 	state->author_name = strbuf_detach(&author_name, NULL);
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index dd627c4..5e48555 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -873,4 +873,52 @@ test_expect_success 'am --message-id -s signs off after the message id' '
 	test_cmp expected actual
 '
 
+test_expect_success 'am -s unexpected trailer block' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	echo signed >file &&
+	git add file &&
+	cat >msg <<-EOF &&
+	subject here
+
+	Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	[jc: tweaked log message]
+	Signed-off-by: J C H <j@c.h>
+	EOF
+	git commit -F msg &&
+	git cat-file commit HEAD | sed -e '1,/^$/d' >original &&
+	git format-patch --stdout -1 >patch &&
+
+	git reset --hard HEAD^ &&
+	git am -s patch &&
+	(
+		cat original &&
+		echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
+	) >expect &&
+	git cat-file commit HEAD | sed -e '1,/^$/d' >actual &&
+	test_cmp expect actual &&
+
+	cat >msg <<-\EOF &&
+	subject here
+
+	We make sure that there is a blank line between the log
+	message proper and Signed-off-by: line added.
+	EOF
+	git reset HEAD^ &&
+	git commit -F msg file &&
+	git cat-file commit HEAD | sed -e '1,/^$/d' >original &&
+	git format-patch --stdout -1 >patch &&
+
+	git reset --hard HEAD^ &&
+	git am -s patch &&
+
+	(
+		cat original &&
+		echo &&
+		echo "Signed-off-by: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
+	) >expect &&
+	git cat-file commit HEAD | sed -e '1,/^$/d' >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.6.0-rc0-130-gfaaaedc
