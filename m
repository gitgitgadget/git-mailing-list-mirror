From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] allow git-update-index work on subprojects
Date: Tue, 10 Apr 2007 15:39:07 +0200
Message-ID: <81b0412b0704100639y331864f9ne0306aa4bf8de663@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_37040_24994396.1176212347527"
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 17:58:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbGZD-0006z5-0m
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 15:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097AbXDJNjK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 09:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753742AbXDJNjK
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 09:39:10 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:55247 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753097AbXDJNjI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 09:39:08 -0400
Received: by an-out-0708.google.com with SMTP id b33so1947350ana
        for <git@vger.kernel.org>; Tue, 10 Apr 2007 06:39:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=bxWWBn/ahnEOi5TkRC/XCGPPrsxPtjG0HqstIN/eQs4uqTDVVcEPf9aLjuz9vbqmLE9LZfXyU3gqopdmRQwxCbmsvoWNDAjQEec5J4VuQSKDEQvZO0ZfWB7k70W/u0KZh/t+Uh+It91YHhWARZkqmfBHQ7T91Ic5LGx0lUj9d+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=NyW3/hyomQgS1P3U2jb/jvX5CVZ7t0Zpwqpuzb5IrUYLjqGVZnxoNOvllGxlGbk26iLMaFoPW3RxAQQUbDt5IOFISmLpUjswhbzJkyl6cmQQH2Kmob7RsQbY4gKbQcRwe7+O5cVJLG7CPsCwe/b6D/LBWu8erbMpqvPEGFrhEEg=
Received: by 10.100.214.8 with SMTP id m8mr4858334ang.1176212347578;
        Tue, 10 Apr 2007 06:39:07 -0700 (PDT)
Received: by 10.100.86.14 with HTTP; Tue, 10 Apr 2007 06:39:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44127>

------=_Part_37040_24994396.1176212347527
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 4/10/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Mon, 9 Apr 2007, Linus Torvalds wrote:
> >
> > NOTE! This series of six patches does not actually contain everything you
> > need to do that - in particular, this series will not actually connect up
> > the magic to make "git add" (and thus "git commit") actually create the
> > gitlink entries for subprojects. That's another (quite small) patch, but I
> > haven't cleaned it up enough to be submittable yet.
>
> Here is, for your enjoyment, the last patch I used to actually test this
> all. I do *not* submit it as a patch for actual inclusion - the other
> patches in the series are, I think, ready to actually be merged. This one
> is not.
>
> It's broken for a few reasons:
>
>  - it allows you to do "git add subproject" to add the subproject to the
>    index (and then use "git commit" to commit it), but even something as
>    simple as "git commit -a" doesn't work right, because the sequence that
>    "git commit -a" uses to update the index doesn't work with the current
>    state of the plumbing (ie the
>
>         git-diff-files --name-only -z |
>                 git-update-index --remove -z --stdin
>

At least git-update-index should work.

---
 builtin-update-index.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index 47d42ed..55c9f93 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -94,12 +94,10 @@ static int process_file(const char *path)
 				             path);
 			}
 		}
-		if (0 == status)
-			return error("%s: is a directory - add files inside instead",
-			             path);
-		else
+		if (status)
 			return error("lstat(\"%s\"): %s", path,
 				     strerror(errno));
+		/* could be a subproject */
 	}

 	namelen = strlen(path);
@@ -211,7 +209,7 @@ static void update_one(const char *path, const
char *prefix, int prefix_length)
 		goto free_return;
 	}
 	if (process_file(p))
-		die("Unable to process file %s", path);
+		die("Unable to process \"%s\"", path);
 	report("add '%s'", path);
  free_return:
 	if (p < path || p > path + strlen(path))
-- 
1.5.1.147.gbaa5

------=_Part_37040_24994396.1176212347527
Content-Type: text/plain; 
	name=0001-allow-git-update-index-work-on-subprojects.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f0cdvg2w
Content-Disposition: attachment; filename="0001-allow-git-update-index-work-on-subprojects.txt"

RnJvbSAyNTJhZGM1NWY5YThhN2VlMzZiZTFhYmY3NmQ4NTExZDZmMTJkNGYzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8YXJpZXNlbkBoYXJtYW5iZWNrZXIuY29t
PgpEYXRlOiBUdWUsIDEwIEFwciAyMDA3IDE1OjE5OjMwICswMjAwClN1YmplY3Q6IFtQQVRDSF0g
YWxsb3cgZ2l0LXVwZGF0ZS1pbmRleCB3b3JrIG9uIHN1YnByb2plY3RzCgotLS0KIGJ1aWx0aW4t
dXBkYXRlLWluZGV4LmMgfCAgICA4ICsrKy0tLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9idWlsdGluLXVwZGF0ZS1pbmRl
eC5jIGIvYnVpbHRpbi11cGRhdGUtaW5kZXguYwppbmRleCA0N2Q0MmVkLi41NWM5ZjkzIDEwMDY0
NAotLS0gYS9idWlsdGluLXVwZGF0ZS1pbmRleC5jCisrKyBiL2J1aWx0aW4tdXBkYXRlLWluZGV4
LmMKQEAgLTk0LDEyICs5NCwxMCBAQCBzdGF0aWMgaW50IHByb2Nlc3NfZmlsZShjb25zdCBjaGFy
ICpwYXRoKQogCQkJCSAgICAgICAgICAgICBwYXRoKTsKIAkJCX0KIAkJfQotCQlpZiAoMCA9PSBz
dGF0dXMpCi0JCQlyZXR1cm4gZXJyb3IoIiVzOiBpcyBhIGRpcmVjdG9yeSAtIGFkZCBmaWxlcyBp
bnNpZGUgaW5zdGVhZCIsCi0JCQkgICAgICAgICAgICAgcGF0aCk7Ci0JCWVsc2UKKwkJaWYgKHN0
YXR1cykKIAkJCXJldHVybiBlcnJvcigibHN0YXQoXCIlc1wiKTogJXMiLCBwYXRoLAogCQkJCSAg
ICAgc3RyZXJyb3IoZXJybm8pKTsKKwkJLyogY291bGQgYmUgYSBzdWJwcm9qZWN0ICovCiAJfQog
CiAJbmFtZWxlbiA9IHN0cmxlbihwYXRoKTsKQEAgLTIxMSw3ICsyMDksNyBAQCBzdGF0aWMgdm9p
ZCB1cGRhdGVfb25lKGNvbnN0IGNoYXIgKnBhdGgsIGNvbnN0IGNoYXIgKnByZWZpeCwgaW50IHBy
ZWZpeF9sZW5ndGgpCiAJCWdvdG8gZnJlZV9yZXR1cm47CiAJfQogCWlmIChwcm9jZXNzX2ZpbGUo
cCkpCi0JCWRpZSgiVW5hYmxlIHRvIHByb2Nlc3MgZmlsZSAlcyIsIHBhdGgpOworCQlkaWUoIlVu
YWJsZSB0byBwcm9jZXNzIFwiJXNcIiIsIHBhdGgpOwogCXJlcG9ydCgiYWRkICclcyciLCBwYXRo
KTsKICBmcmVlX3JldHVybjoKIAlpZiAocCA8IHBhdGggfHwgcCA+IHBhdGggKyBzdHJsZW4ocGF0
aCkpCi0tIAoxLjUuMS4xNDcuZ2JhYTUKCg==
------=_Part_37040_24994396.1176212347527--
