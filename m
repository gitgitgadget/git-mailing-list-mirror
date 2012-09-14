From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: =?UTF-8?q?=5BPATCHv2=5D=20clone=3A=20fix=20refspec=20on=20=22--single-branch=22=20option?=
Date: Fri, 14 Sep 2012 20:11:07 +0200
Message-ID: <1347646267-25891-1-git-send-email-ralf.thielow@gmail.com>
References: <7vipbh6qxa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 14 20:11:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCaMU-0008Lf-5b
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 20:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759819Ab2INSLV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Sep 2012 14:11:21 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:49863 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759770Ab2INSLT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 14:11:19 -0400
Received: by wgbdr13 with SMTP id dr13so3746849wgb.1
        for <git@vger.kernel.org>; Fri, 14 Sep 2012 11:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=SHrIGU2cgnmbR/rUJKvP2cNTFOSjVxL5t/JxGJu0wV0=;
        b=VduHnPTS2rvj8TiZe6nNmLCTUSTDRBJ7t+cz3gzyuc+t+BVrKb8WtMrhZ3oPFj8i8/
         57GLQAc5Yf048seCM7t12ajT8Bwk1N32sjIoiC1kAsTP3f5SQy8Ii0Z++V002eIknfqv
         vzz1wiPfhyi0KEzVPMVC7YcBFHgaQcWTJMYbA+GHtotJUZ0vb8yDGkbSozOro8ovUDRx
         0mFQMn/BTej4mBO/rTkNctjkYMVxOkmNX05s8TltP7grjfTEPGVELzLitgKRlJco5A52
         s5djgPmvqag1kawE7Yfw25F/NbQVvOXnZAhYyX+JndVT/dnrbY6LTopsZu82eJAbNWcV
         bL6A==
Received: by 10.180.108.45 with SMTP id hh13mr49669960wib.15.1347646277962;
        Fri, 14 Sep 2012 11:11:17 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-222-138-170.pools.arcor-ip.net. [94.222.138.170])
        by mx.google.com with ESMTPS id ct3sm20015139wib.5.2012.09.14.11.11.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Sep 2012 11:11:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.395.g6b149ce.dirty
In-Reply-To: <7vipbh6qxa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205522>

After a repo was cloned with the "--single-branch"
option, the configured refspec looks like
"+refs/heads/*:refs/remotes/origin/*".
After fetching from this repo again, it'll receive
all refs instead of just the ref from the single
branch. Fixing this by configure exactly the ref
of the branch the user specified in the "git clone"
command.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---

> Alternatively, if you can move the logic to set up this
> configuration further down so that it happens after we talked to the
> other side and figured out remote_head_points_at, you could instead
> set it up to keep a single remote tracking branch.
>
> Even if you did so, guess_remote_head() may not find any branch when
> the other repository's HEAD is detached, so you would need to decide
> what to do in such a case, and "fetch and integrate their HEAD
> without using any remote tracking branch" may be a reasonable thing
> to do in such a case.

This second version now covers also the "--single-branch"
option when it was called without "--branch". It also covers
the "detached HEAD" case.
I've tested all the use-cases that have been described above and it wor=
ks
as expected with this patch. But there's just one thing. It fetches
also all the tags even if they're not on this branch. I'm still in the
"learning process", perhaps someone else can fix this problem or point
me to the reason.=20
I think it comes from "transport_fetch_refs(transport, mapped_refs);"
on line 813 which is called with a full "+refs/heads/*:refs/remotes/ori=
gin/*"
refspec. Thanks

 builtin/clone.c | 41 +++++++++++++++++++++++++++--------------
 1 Datei ge=C3=A4ndert, 27 Zeilen hinzugef=C3=BCgt(+), 14 Zeilen entfer=
nt(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 5e8f3ba..3ddf5ab 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -755,20 +755,6 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 	}
=20
 	strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
-
-	if (option_mirror || !option_bare) {
-		/* Configure the remote */
-		strbuf_addf(&key, "remote.%s.fetch", option_origin);
-		git_config_set_multivar(key.buf, value.buf, "^$", 0);
-		strbuf_reset(&key);
-
-		if (option_mirror) {
-			strbuf_addf(&key, "remote.%s.mirror", option_origin);
-			git_config_set(key.buf, "true");
-			strbuf_reset(&key);
-		}
-	}
-
 	strbuf_addf(&key, "remote.%s.url", option_origin);
 	git_config_set(key.buf, repo);
 	strbuf_reset(&key);
@@ -853,6 +839,33 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 					      "refs/heads/master");
 	}
=20
+	if (option_mirror || !option_bare) {
+		strbuf_reset(&value);
+		if (option_single_branch) {
+			if (option_branch)
+				strbuf_addf(&value, "+%s%s:%s%s", src_ref_prefix, option_branch,
+						branch_top.buf, option_branch);
+			else if (remote_head_points_at)
+					strbuf_addf(&value, "+%s:%s%s", our_head_points_at->name,
+									branch_top.buf, prettify_refname(remote_head_points_at->name)=
);
+		} else {
+			strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
+		}
+		/* Configure the remote */
+		if (value.len) {
+			strbuf_reset(&key);
+			strbuf_addf(&key, "remote.%s.fetch", option_origin);
+			git_config_set_multivar(key.buf, value.buf, "^$", 0);
+			strbuf_reset(&key);
+
+			if (option_mirror) {
+				strbuf_addf(&key, "remote.%s.mirror", option_origin);
+				git_config_set(key.buf, "true");
+				strbuf_reset(&key);
+			}
+		}
+	}
+
 	if (is_local)
 		clone_local(path, git_dir);
 	else if (refs && complete_refs_before_fetch)
--=20
1.7.12.395.g6b149ce.dirty
