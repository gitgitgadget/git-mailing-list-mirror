From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 09/12] git submodule update: Check url in C
Date: Thu, 15 Oct 2015 18:52:10 -0700
Message-ID: <1444960333-16003-10-git-send-email-sbeller@google.com>
References: <1444960333-16003-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 16 03:52:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmuCA-0002He-Oh
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 03:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752690AbbJPBw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 21:52:28 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34302 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbbJPBw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 21:52:27 -0400
Received: by payp3 with SMTP id p3so56448389pay.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 18:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h/GNcUvxNgYBbsctF12yi+SgCn9jwIZM5Mv2sMsnwlI=;
        b=QVWBW4+yELGwl0fLYUGTZFwEhWpdzITpDcvD9Bx6dTL+fuPLM/MtuxxG4z6rZqubCE
         dzBryFJq1ceG0pKqk2YGWzBw3at1vrYU1nMtr90TKd+9Lyynon76JEzM9U8SrYWwTwJB
         JoXhjVcE7slyo0GrSIsw19dcqzS/eQSCCzrap8whwAak6I0vKgMHPoMCitc87w0yA+kW
         R+FJ/iK9Fdg3AXzc98pN0YirjDRbNcZBH8zqVwQ4V9dS86wcCTCV6kELQb60DUUAcRIi
         qBR0fqoEYCuN1WGcjxmXWW5vgLCTcRGx73H8zdwehDYsaZe9Yv8S8SRF8J8bbbtxzwlZ
         KdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h/GNcUvxNgYBbsctF12yi+SgCn9jwIZM5Mv2sMsnwlI=;
        b=lje/SvYDyck91bDQRnQfZ9JyF27Cto3J55duRQGldPvUJlavuGwg8xNgP188TlRaVv
         7fUDNKU5/o3unCJ2b/iMqeWRUvLt/ArSwl09z76PuKtBBHizXB2/i8LdlB8I+MzT7+Ki
         5E1X8F5ggfyL7v/Tyx+yfLuoU4/3ADmg5pYJ77X/b+I7Yotaa7UQRkBVuP9BSsK36w3x
         gWf65iP+ybPdvP0ZYcQTv8l5baBdmKk2QuN/r+Ep7s6u8UCTfcaanIyMmaUQsa3JF0JB
         hMWuGRUdNZ/Pc5rWVVxgW4s/Ie29/8elnLgrFnybfFOTc+uaPFNfy5yq0MWq9XLQvzDM
         tJYQ==
X-Gm-Message-State: ALoCoQlQb2xNfFUAhsC+yD0dtys5o6JMlGF7yRT8S8eWxhiqyNqoiQqoum0cBLFYC3Id3zvfLw9C
X-Received: by 10.66.227.72 with SMTP id ry8mr13694488pac.105.1444960346543;
        Thu, 15 Oct 2015 18:52:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:8909:dd69:53c0:2cb6])
        by smtp.gmail.com with ESMTPSA id qb7sm17908552pab.47.2015.10.15.18.52.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 Oct 2015 18:52:26 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.277.gfdc362b.dirty
In-Reply-To: <1444960333-16003-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279720>

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 21 +++++++++++++++++++++
 git-submodule.sh            | 10 ----------
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 73954ac..7a2fd4e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -300,6 +300,7 @@ static int module_list_or_clone(int argc, const char **argv, const char *prefix)
 		const struct cache_entry *ce = list.entries[i];
 		struct strbuf sb = STRBUF_INIT;
 		const char *update_module = NULL;
+		const char *url = NULL;
 
 		char *env_prefix = getenv("prefix");
 		if (ce_stage(ce)) {
@@ -329,6 +330,26 @@ static int module_list_or_clone(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
+		/*
+		 * Looking up the url in .git/config.
+		 * We cannot fall back to .gitmodules as we only want to process
+		 * configured submodules. This renders the submodule lookup API
+		 * useless, as it cannot lookup without fallback.
+		 */
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "submodule.%s.url", sub->name);
+		git_config_get_string_const(sb.buf, &url);
+		if (!url) {
+			/*
+			 * Only mention uninitialized submodules when its
+			 * path have been specified
+			 */
+			if (pathspec.nr)
+				fprintf(stderr, _("Submodule path '%s' not initialized\n"
+					"Maybe you want to use 'update --init'?"), displaypath);
+			continue;
+		}
+
 		printf("%06o %s %d\t", ce->ce_mode, sha1_to_hex(ce->sha1), ce_stage(ce));
 		utf8_fprintf(stdout, "%s\n", ce->name);
 	}
diff --git a/git-submodule.sh b/git-submodule.sh
index 227fed6..80f41b2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -677,16 +677,6 @@ cmd_update()
 
 		displaypath=$(relative_path "$prefix$sm_path")
 
-		if test -z "$url"
-		then
-			# Only mention uninitialized submodules when its
-			# path have been specified
-			test "$#" != "0" &&
-			say >&2 "$(eval_gettext "Submodule path '\$displaypath' not initialized
-Maybe you want to use 'update --init'?")"
-			continue
-		fi
-
 		if ! test -d "$sm_path"/.git && ! test -f "$sm_path"/.git
 		then
 			git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$prefix" --path "$sm_path" --name "$name" --url "$url" "$reference" "$depth" || exit
-- 
2.5.0.277.gfdc362b.dirty
