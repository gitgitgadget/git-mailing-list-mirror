From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] transport-helper: check when helpers fail
Date: Mon, 22 Oct 2012 19:12:06 +0200
Message-ID: <CAMP44s27oPMu8Goded-Tcw9_fmgRux3yiNvu0FBPUxHOdp1Zgw@mail.gmail.com>
References: <1350847158-14154-1-git-send-email-felipe.contreras@gmail.com>
	<5084E931.3010809@viscovery.net>
	<CAMP44s2XDkLhKkqvxnGH+U5X=42dXU1550xVQvyQk=WD2p0c6Q@mail.gmail.com>
	<50854E20.1040303@viscovery.net>
	<CAMP44s1m9eVqqrgJFuWOBa3DCZAzAqpVwG8Nxn-6MbXWbF_2fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 22 19:12:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQLY5-0005sc-C0
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 19:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755599Ab2JVRMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2012 13:12:08 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:39693 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755484Ab2JVRMH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2012 13:12:07 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so2657758oag.19
        for <git@vger.kernel.org>; Mon, 22 Oct 2012 10:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wXeBglIriTwm1QlHJvT7Lzvyy7JhmToZvTLWAF6CWLU=;
        b=s7VWMP3J+gTHDK7Zp+1It8egQYTdNwBENE3FBNT6Oh9Q68SPCwfZJSs9dIYCCaKWhe
         doUA3Ty8Oyy+3dMHXSalf0Xni5mfP6jOMn6b1vOBITkaRQdpwi4c8ILRTXfOSgWv2nW9
         vVt+LOCtDDjUzZ43UaMRvGyb4zOBheyjGt/11WYLzb84p6Zp2qaPu/QurqO7YArXJVRx
         V0Rvj4cZ3X+8yuUwWPTvg0Gvd2Dn19lRcD2k7DEO8cJsYBDdBNDIE0kP0IKsDZp3BKWe
         1gG7858bszrNFs57uI8qAhq8Ka/IrjzRL5hA6GS+XOJcBJMKt7iutUZqr7VlxF0wyovC
         HNzQ==
Received: by 10.182.10.6 with SMTP id e6mr7554662obb.16.1350925926409; Mon, 22
 Oct 2012 10:12:06 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Mon, 22 Oct 2012 10:12:06 -0700 (PDT)
In-Reply-To: <CAMP44s1m9eVqqrgJFuWOBa3DCZAzAqpVwG8Nxn-6MbXWbF_2fw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208198>

On Mon, Oct 22, 2012 at 4:31 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> -> import-begin
> <- feature X
> <- feature Y
> -> import refs/heads/master
> <- exported stuff
> -> import refs/heads/devel
> <- exported stuff
> -> import-end
> <- done
>
> This would certainly makes things easier for transport-helpers that
> support multiple ref selections (like my remote-hg). Maybe I should
> add code that does this if certain feature is specified (so it doesn't
> break other helpers)

Never mind this, it's possible to do the same by assuming that all the
imports will be together, and finished by a line feed, so the code can
do:

if import
  do import-begin stuff
  while import
    import stuff
  do import-end stuff

Of course, this could break if for some reason transport-helper
changes, but that seems unlikely.

> But at least on my tests, even with 'feature done' the crash is not
> detected properly, either by the transport-helper, or fast-import.

Never mind this either; I was forcing the error before exporting that
feature. See the code at the end.

> And also, the msysgit branch does the same check for fast-export,
> which actually uses the 'done' feature always, so it should work fine,
> but perhaps because of the strange issue with fast-import I just
> mentioned, it's not actually detected. I should add tests for this
> too.

I have added tests for this, and the failure is detected reliably...
but only with remote-testgit, not with my remote-hg, and I've no idea
what is different.

I've tried everything, and yet a SIGPIPE is detected only with
remote-testgit, not with my code, and they both exit the same way, and
at the same time, and fast-export exits the main function (apparently
a process can finish with SIGPIPE after main?)

I have no idea what's going on, so I don't know if we need any extra
code in transport-helper at all.

Any ideas?

Here is what I have so far:

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index 5f3ebd2..b8707e6 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -159,6 +159,11 @@ def do_import(repo, args):
         ref = line[7:].strip()
         refs.append(ref)

+    print "feature done"
+
+    if os.getenv("GIT_REMOTE_TESTGIT_FAILURE"):
+        die('Told to fail')
+
     repo = update_local_repo(repo)
     repo.exporter.export_repo(repo.gitdir, refs)

@@ -172,6 +177,9 @@ def do_export(repo, args):
     if not repo.gitdir:
         die("Need gitdir to export")

+    if os.getenv("GIT_REMOTE_TESTGIT_FAILURE"):
+        die('Told to fail')
+
     update_local_repo(repo)
     changed = repo.importer.do_import(repo.gitdir)

diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index e7dc668..00b0cd3 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -145,4 +145,16 @@ test_expect_failure 'push new branch with old:new
refspec' '
 	compare_refs clone HEAD server refs/heads/new-refspec
 '

+test_expect_success 'proper failure checks for fetching' '
+	export GIT_REMOTE_TESTGIT_FAILURE=1 &&
+	(cd localclone && ! git fetch) 2> errors &&
+	grep -q "Error while running fast-import" errors
+'
+
+test_expect_success 'proper failure checks for pushing' '
+	export GIT_REMOTE_TESTGIT_FAILURE=1 &&
+	(cd localclone && ! git push --all) 2> errors &&
+	grep -q "Error while running fast-export" errors
+'
+
 test_done

-- 
Felipe Contreras
