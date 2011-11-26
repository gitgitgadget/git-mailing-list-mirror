From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git branch -M" regression in 1.7.7?
Date: Sat, 26 Nov 2011 02:54:55 -0600
Message-ID: <20111126085455.GB22656@elie.hsd1.il.comcast.net>
References: <CALxtSbRbwkVDKJcXiKY9rHYCjA3XGgCytbXQnRhQvbEnY8SpjA@mail.gmail.com>
 <20111126023002.GA17652@elie.hsd1.il.comcast.net>
 <CAOTq_pv4dyAkbqye+diK9mTTsrTg9OKg0tExKcfDgs8RfiTwTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?4piCSm9zaCBDaGlhICjosKLku7vkuK0p?= <joshchia@gmail.com>,
	git@vger.kernel.org, Soeren Sonnenburg <sonne@debian.org>
To: =?utf-8?Q?Conrad=C2=A0Irwin?= <conrad.irwin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 26 09:55:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUE2O-0001xW-TL
	for gcvg-git-2@lo.gmane.org; Sat, 26 Nov 2011 09:55:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942Ab1KZIzA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Nov 2011 03:55:00 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44022 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808Ab1KZIy7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Nov 2011 03:54:59 -0500
Received: by iage36 with SMTP id e36so5745220iag.19
        for <git@vger.kernel.org>; Sat, 26 Nov 2011 00:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/MC31SRNwTVjCBdakrDZKNMjRT6mymkrG67oHYvOnSU=;
        b=Y5ZStu8tHmcpFHVbIBpwBLmTCpn9kX2ZbWB8AVCjMk499Qo0spL2mXiwAjPJ31nFdw
         9aJ2wtAI4ZaCRybyyk0glh/xD+cPrLL9hJwIIGFaRalCmp4B12tRxOL1sKz4ZmNz3gG5
         j6tPh9fwEu/2RxqcOB3BLZ8bPl78EFskKU2pQ=
Received: by 10.42.161.132 with SMTP id t4mr16516001icx.16.1322297699310;
        Sat, 26 Nov 2011 00:54:59 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id dd36sm13555264ibb.7.2011.11.26.00.54.58
        (version=SSLv3 cipher=OTHER);
        Sat, 26 Nov 2011 00:54:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAOTq_pv4dyAkbqye+diK9mTTsrTg9OKg0tExKcfDgs8RfiTwTQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185950>

Conrad=C2=A0Irwin wrote:

> I thought after reading your patch about making it just do:
>
>     if (!strcmp(oldname, newname))
>         exit(0);
>
> but I guess it would then not mark an entry in the reflog that people
> could be relying on...

Ah, this deserves a comment.

I thought about doing the same thing, and then didn't do it because I
wanted to make sure that

	git branch -M nonexistent nonexistent

does not succeed.  Which presumably warrants another test:

 test_expect_success "rename-to-self dwimery doesn't hide nonexistent r=
ef" '
	test_must_fail git branch -M nonexistent nonexistent &&
	test_must_fail git rev-parse --verify nonexistent
 '

Sloppy of me.

>> + =C2=A0 =C2=A0 =C2=A0 clobber_head_ok =3D !strcmp(oldname, newname)=
;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 validate_new_branchname(newname, &newref, for=
ce, clobber_head_ok);
>
> This looks ok, and will be improvable if the NEEDSWORK in branch.h is=
 done.

Thanks for looking it over.

> The other thing I wonder is whether "git checkout -B master HEAD" or
> "git branch -f master master" should have the same short-cut?

I think "git branch -M" is the only one buildbot was relying on.

As an aside, I'm not convinced the check is needed for checkout -B at
all.  In an ideal world, the order of operations would be:

	1. look up commit argument
	2. merge working tree
	3. update branch to match commit
	4. update HEAD symref to point to branch

In other words, when on master, "git checkout -B master <commit>"
would be another way to say "git reset --keep <commit>", except that
it also sets up tracking.

Surprisingly, switch_branches() seems to match that pretty well already=
=2E

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 branch.c                   |    6 ++++--
 branch.h                   |    3 ++-
 builtin/branch.c           |    2 +-
 builtin/checkout.c         |   15 +++++++++++----
 t/t2018-checkout-branch.sh |    9 +++++----
 5 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/branch.c b/branch.c
index 025a97be..f85c4382 100644
--- a/branch.c
+++ b/branch.c
@@ -160,7 +160,8 @@ int validate_new_branchname(const char *name, struc=
t strbuf *ref,
=20
 void create_branch(const char *head,
 		   const char *name, const char *start_name,
-		   int force, int reflog, enum branch_track track)
+		   int force, int reflog, int clobber_head,
+		   enum branch_track track)
 {
 	struct ref_lock *lock =3D NULL;
 	struct commit *commit;
@@ -175,7 +176,8 @@ void create_branch(const char *head,
 		explicit_tracking =3D 1;
=20
 	if (validate_new_branchname(name, &ref, force,
-				    track =3D=3D BRANCH_TRACK_OVERRIDE)) {
+				    track =3D=3D BRANCH_TRACK_OVERRIDE ||
+				    clobber_head)) {
 		if (!force)
 			dont_change_ref =3D 1;
 		else
diff --git a/branch.h b/branch.h
index 1285158d..e125ff4c 100644
--- a/branch.h
+++ b/branch.h
@@ -13,7 +13,8 @@
  * branch for (if any).
  */
 void create_branch(const char *head, const char *name, const char *sta=
rt_name,
-		   int force, int reflog, enum branch_track track);
+		   int force, int reflog,
+		   int clobber_head, enum branch_track track);
=20
 /*
  * Validates that the requested branch may be created, returning the
diff --git a/builtin/branch.c b/builtin/branch.c
index 51ca6a02..730f9139 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -730,7 +730,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 		if (kinds !=3D REF_LOCAL_BRANCH)
 			die(_("-a and -r options to 'git branch' do not make sense with a b=
ranch name"));
 		create_branch(head, argv[0], (argc =3D=3D 2) ? argv[1] : head,
-			      force_create, reflog, track);
+			      force_create, reflog, 0, track);
 	} else
 		usage_with_options(builtin_branch_usage, options);
=20
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2a807724..ca00a853 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -540,7 +540,9 @@ static void update_refs_for_switch(struct checkout_=
opts *opts,
 		else
 			create_branch(old->name, opts->new_branch, new->name,
 				      opts->new_branch_force ? 1 : 0,
-				      opts->new_branch_log, opts->track);
+				      opts->new_branch_log,
+				      opts->new_branch_force ? 1 : 0,
+				      opts->track);
 		new->name =3D opts->new_branch;
 		setup_branch_path(new);
 	}
@@ -565,8 +567,12 @@ static void update_refs_for_switch(struct checkout=
_opts *opts,
 		create_symref("HEAD", new->path, msg.buf);
 		if (!opts->quiet) {
 			if (old->path && !strcmp(new->path, old->path)) {
-				fprintf(stderr, _("Already on '%s'\n"),
-					new->name);
+				if (opts->new_branch_force)
+					fprintf(stderr, _("Reset branch '%s'\n"),
+						new->name);
+				else
+					fprintf(stderr, _("Already on '%s'\n"),
+						new->name);
 			} else if (opts->new_branch) {
 				if (opts->branch_exists)
 					fprintf(stderr, _("Switched to and reset branch '%s'\n"), new->na=
me);
@@ -1057,7 +1063,8 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 		struct strbuf buf =3D STRBUF_INIT;
=20
 		opts.branch_exists =3D validate_new_branchname(opts.new_branch, &buf=
,
-							     !!opts.new_branch_force, 0);
+							     !!opts.new_branch_force,
+							     !!opts.new_branch_force);
=20
 		strbuf_release(&buf);
 	}
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 75874e85..27412623 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -189,12 +189,13 @@ test_expect_success 'checkout -b <describe>' '
 	test_cmp expect actual
 '
=20
-test_expect_success 'checkout -B to the current branch fails before me=
rging' '
+test_expect_success 'checkout -B to the current branch works' '
 	git checkout branch1 &&
+	git checkout -B branch1-scratch &&
+
 	setup_dirty_mergeable &&
-	git commit -mfooble &&
-	test_must_fail git checkout -B branch1 initial &&
-	test_must_fail test_dirty_mergeable
+	git checkout -B branch1-scratch initial &&
+	test_dirty_mergeable
 '
=20
 test_done
--=20
1.7.8.rc3
