From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] gc: remove broken symrefs
Date: Mon, 05 Oct 2015 15:06:12 -0700
Message-ID: <xmqq612lx963.fsf@gitster.mtv.corp.google.com>
References: <xmqqr3lnuzqu.fsf@gitster.mtv.corp.google.com>
	<cover.1443448748.git.johannes.schindelin@gmx.de>
	<fb29b39adf14a702c5127d722d86647a3dc9c891.1443448748.git.johannes.schindelin@gmx.de>
	<xmqqpp12croq.fsf@gitster.mtv.corp.google.com>
	<xmqqh9mecrap.fsf@gitster.mtv.corp.google.com>
	<da381393c0b6174cc07b4333308cf611@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 06 00:06:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjDtk-0003et-2T
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 00:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbbJEWGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 18:06:15 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36820 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbbJEWGO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 18:06:14 -0400
Received: by pablk4 with SMTP id lk4so187441736pab.3
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 15:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=4ignB+clEHLjyl9XfjDJkEL6fM7tveDu5oza9h4cB/k=;
        b=gfZuu99IjG5Z5LJL+dMahZk7MrtFRZidKtJ6cvYalPqiE8ZkMAXaZDqRRq1g5KgeeN
         PgbOH6V4NzWp1bOsI48u8N+Zsv8B5+4d7PP3F6ycV8Sxi2ooeJi9pfLAyUrlk295BGS7
         JxFxJ9KV7HlKzjlWU3wXzH+hxf5GwXhXmgAkb1JJgHwiyw+YPDEPGBXVXTARMfjnJ7L3
         j7RPoLSsT/P8s9sKUCBSWGw+YNj4Kf98O1yiopXmbXnwarO3APsujvqJ+xQhULXu9THs
         r0XN7p8c3fBQA+3r4OrW2cKawPoZb+09It3bVIGvSDvxLzxBHDkRYsDEIWX4QIziKWH5
         SVpg==
X-Received: by 10.66.228.233 with SMTP id sl9mr42971111pac.139.1444082773828;
        Mon, 05 Oct 2015 15:06:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:a14c:f96c:97d2:eee0])
        by smtp.gmail.com with ESMTPSA id zn9sm29722099pac.48.2015.10.05.15.06.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 05 Oct 2015 15:06:13 -0700 (PDT)
In-Reply-To: <da381393c0b6174cc07b4333308cf611@dscho.org> (Johannes
	Schindelin's message of "Mon, 28 Sep 2015 21:58:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279100>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Oh, I appreciate your feedback. I am actually not all *that* certain
> that removing the broken symref is the correct thing. It is this sort
> of fruitful exchange that allows me to throw out an idea and be
> relatively certain that something better will come out of v3 or v8 of
> the patch series than what I had in mind.
>
> To be honest, the most important outcome is probably 2/4 -- which
> should be enough to fix the issue reported by the Git for Windows
> user. I could adjust the test so that it no longer insists that
> origin/HEAD` be deleted, but still requires that `git gc` succeeds.
>
> I would have no problem to let this sit for a couple of days until
> the final verdict.

... and a few days have passed.  I am tempted to do the easy bits
first, discarding the parts that both of us feel iffy for now
without prejudice, keeping the first two commits with a bit of
tweak.

The primary tweak is to t6500 in the first patch, which I retitled
below (and the patch shows s/failure/success/ but in the first step
that only adds a failing test, it would of course expect a failure).

And with "pack-objects: do not get distracted", the test will start
passing.

diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index b736774..5d7d414 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -30,7 +30,7 @@ test_expect_success 'gc -h with invalid configuration' '
 	test_i18ngrep "[Uu]sage" broken/usage
 '
 
-test_expect_failure 'gc removes broken refs/remotes/<name>/HEAD' '
+test_expect_success 'gc is not aborted due to a stale symref' '
 	git init remote &&
 	(
 		cd remote &&
@@ -39,9 +39,7 @@ test_expect_failure 'gc removes broken refs/remotes/<name>/HEAD' '
 		git branch -m develop &&
 		cd ../client &&
 		git fetch --prune &&
-		git gc &&
-		git branch --list -r origin/HEAD >actual &&
-		test_line_count = 0 actual
+		git gc
 	)
 '
 
diff --git a/reachable.c b/reachable.c
index 6356ae8..4cfd0de 100644
--- a/reachable.c
+++ b/reachable.c
@@ -28,7 +28,7 @@ static int add_one_ref(const char *path, const unsigned char *sha1, int flag, vo
 	struct object *object;
 
 	if ((flag & REF_ISSYMREF) && (flag & REF_ISBROKEN)) {
-		warning("ref is broken: %s", path);
+		warning("symbolic ref is dangling: %s", path);
 		return 0;
 	}
 
