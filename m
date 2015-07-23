From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] refs: loosen restriction on wildcard "*" refspecs
Date: Thu, 23 Jul 2015 15:12:05 -0700
Message-ID: <xmqqvbdao762.fsf@gitster.dls.corp.google.com>
References: <1437599133-13012-1-git-send-email-jacob.e.keller@intel.com>
	<1437599133-13012-3-git-send-email-jacob.e.keller@intel.com>
	<CAPig+cRS0NcNcw-0wG4mThN_PW0RoN3b09Yu2GzCr=UFPLYd6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.iabervon.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 00:12:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIOis-0005Z5-5M
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 00:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983AbbGWWMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 18:12:10 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:36830 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716AbbGWWMI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 18:12:08 -0400
Received: by pdjr16 with SMTP id r16so2719875pdj.3
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 15:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=WMXTndVzs2qfVuGlA5ve3AIebGT0ojDjckjzKFMpT2o=;
        b=CCzNxDbS2wb8ylKqpzggO3XNw+i1NqB8tKA9q9gUyP6PCoopDHv31dM51RRniDM8HO
         erdPnAG9LiCvkKr7wep17gxs+61u3NFAPVLUzFSqG87L4SCqiIEDdwyTP1Re7dNGNRf4
         GEnVUymFeKZ74Vwg0OrF52SZRWzc27Br906tVaUJR3YO1foIAotLk6HovHoIi2JmCmLh
         YlxM08sTkQC+bjLO2bBwtkv1FtF/1gi2UGOS4mrda0P+Gip9Rrl/unzOleoNuPnQoIYD
         dD/7BQk1d4IuCDJj7h0zHDiBT0lImx8T+f1FhRqVIBJMnD1bEHgS02kOh4kjpmO/eDcI
         Gjqg==
X-Received: by 10.66.217.138 with SMTP id oy10mr23482521pac.83.1437689527615;
        Thu, 23 Jul 2015 15:12:07 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:156f:a37c:e915:d6df])
        by smtp.gmail.com with ESMTPSA id 2sm10727966pdp.68.2015.07.23.15.12.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jul 2015 15:12:06 -0700 (PDT)
In-Reply-To: <CAPig+cRS0NcNcw-0wG4mThN_PW0RoN3b09Yu2GzCr=UFPLYd6A@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 23 Jul 2015 18:00:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274529>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Jul 22, 2015 at 5:05 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Modify logic of check_refname_component and add a new disposition
>> regarding "*". Allow refspecs that contain a single "*" if
>> REFNAME_REFSPEC_PATTERN is set. Change the function to pass the flags as
>> a pointer, and clear REFNAME_REFSPEC_PATTERN after the first "*" so that
>> only a single "*" is accepted.
>>
>> This loosens restrictions on refspecs by allowing patterns that have
>> a "*" within a component instead of only as the whole component. Also
>> remove the code that hangled refspec patterns in check_refname_format
>
> s/hangled/handled/
> ...

Thanks; here is what I queued yesterday.

-- >8 --
From: Jacob Keller <jacob.keller@gmail.com>
Date: Wed, 22 Jul 2015 14:05:33 -0700
Subject: [PATCH] refs: loosen restriction on wildcard "*" refspecs

Loosen restrictions on refspecs by allowing patterns that have a "*"
within a component instead of only as the whole component.

Remove the logic to accept a single "*" as a whole component from
check_refname_format(), and implement an extended form of that logic
in check_refname_component().  Pass the pointer to the flags argument
to the latter, as it has to clear REFNAME_REFSPEC_PATTERN bit when
it sees "*".

Teach check_refname_component() function to allow an asterisk "*"
only when REFNAME_REFSPEC_PATTERN is set in the flags, and drop the
bit after seeing a "*", to ensure that one side of a refspec
contains at most one asterisk.

This will allow us to accept refspecs such as `for/bar*:foo/baz*`.
Any refspec which functioned before shall continue functioning with
the new logic.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-check-ref-format.txt |  4 ++--
 refs.c                                 | 36 +++++++++++++++++++---------------
 refs.h                                 |  4 ++--
 t/t1402-check-ref-format.sh            |  8 +++++---
 t/t5511-refspec.sh                     | 11 +++++++----
 5 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index fc02959..9044dfa 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -94,8 +94,8 @@ OPTIONS
 	Interpret <refname> as a reference name pattern for a refspec
 	(as used with remote repositories).  If this option is
 	enabled, <refname> is allowed to contain a single `*`
-	in place of a one full pathname component (e.g.,
-	`foo/*/bar` but not `foo/bar*`).
+	in the refspec (e.g., `foo/bar*/baz` or `foo/bar*baz/`
+	but not `foo/bar*/baz*`).
 
 --normalize::
 	Normalize 'refname' by removing any leading slash (`/`)
diff --git a/refs.c b/refs.c
index 0900f54..3127518 100644
--- a/refs.c
+++ b/refs.c
@@ -21,12 +21,13 @@ struct ref_lock {
  * 2: ., look for a preceding . to reject .. in refs
  * 3: {, look for a preceding @ to reject @{ in refs
  * 4: A bad character: ASCII control characters, and
- *    "*", ":", "?", "[", "\", "^", "~", SP, or TAB
+ *    ":", "?", "[", "\", "^", "~", SP, or TAB
+ * 5: *, reject unless REFNAME_REFSPEC_PATTERN is set
  */
 static unsigned char refname_disposition[256] = {
 	1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
 	4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4,
-	4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 2, 1,
+	4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 2, 1,
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 0, 4,
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 0, 4, 0,
@@ -73,12 +74,13 @@ static unsigned char refname_disposition[256] = {
  * - any path component of it begins with ".", or
  * - it has double dots "..", or
  * - it has ASCII control characters, or
- * - it has "*", ":", "?", "[", "\", "^", "~", SP, or TAB anywhere, or
+ * - it has ":", "?", "[", "\", "^", "~", SP, or TAB anywhere, or
+ * - it has "*" anywhere unless REFNAME_REFSPEC_PATTERN is set, or
  * - it ends with a "/", or
  * - it ends with ".lock", or
  * - it contains a "@{" portion
  */
-static int check_refname_component(const char *refname, int flags)
+static int check_refname_component(const char *refname, int *flags)
 {
 	const char *cp;
 	char last = '\0';
@@ -99,6 +101,16 @@ static int check_refname_component(const char *refname, int flags)
 			break;
 		case 4:
 			return -1;
+		case 5:
+			if (!(*flags & REFNAME_REFSPEC_PATTERN))
+				return -1; /* refspec can't be a pattern */
+
+			/*
+			 * Unset the pattern flag so that we only accept
+			 * a single asterisk for one side of refspec.
+			 */
+			*flags &= ~ REFNAME_REFSPEC_PATTERN;
+			break;
 		}
 		last = ch;
 	}
@@ -123,18 +135,10 @@ int check_refname_format(const char *refname, int flags)
 
 	while (1) {
 		/* We are at the start of a path component. */
-		component_len = check_refname_component(refname, flags);
-		if (component_len <= 0) {
-			if ((flags & REFNAME_REFSPEC_PATTERN) &&
-					refname[0] == '*' &&
-					(refname[1] == '\0' || refname[1] == '/')) {
-				/* Accept one wildcard as a full refname component. */
-				flags &= ~REFNAME_REFSPEC_PATTERN;
-				component_len = 1;
-			} else {
-				return -1;
-			}
-		}
+		component_len = check_refname_component(refname, &flags);
+		if (component_len <= 0)
+			return -1;
+
 		component_count++;
 		if (refname[component_len] == '\0')
 			break;
diff --git a/refs.h b/refs.h
index cf642e6..417f2c8 100644
--- a/refs.h
+++ b/refs.h
@@ -224,8 +224,8 @@ extern int for_each_reflog(each_ref_fn, void *);
  * to the rules described in Documentation/git-check-ref-format.txt.
  * If REFNAME_ALLOW_ONELEVEL is set in flags, then accept one-level
  * reference names.  If REFNAME_REFSPEC_PATTERN is set in flags, then
- * allow a "*" wildcard character in place of one of the name
- * components.  No leading or repeated slashes are accepted.
+ * allow a single "*" wildcard character in the refspec. No leading or
+ * repeated slashes are accepted.
  */
 extern int check_refname_format(const char *refname, int flags);
 
diff --git a/t/t1402-check-ref-format.sh b/t/t1402-check-ref-format.sh
index e5dc62e..0790edf 100755
--- a/t/t1402-check-ref-format.sh
+++ b/t/t1402-check-ref-format.sh
@@ -62,9 +62,11 @@ invalid_ref 'heads/foo\bar'
 invalid_ref "$(printf 'heads/foo\t')"
 invalid_ref "$(printf 'heads/foo\177')"
 valid_ref "$(printf 'heads/fu\303\237')"
-invalid_ref 'heads/*foo/bar' --refspec-pattern
-invalid_ref 'heads/foo*/bar' --refspec-pattern
-invalid_ref 'heads/f*o/bar' --refspec-pattern
+valid_ref 'heads/*foo/bar' --refspec-pattern
+valid_ref 'heads/foo*/bar' --refspec-pattern
+valid_ref 'heads/f*o/bar' --refspec-pattern
+invalid_ref 'heads/f*o*/bar' --refspec-pattern
+invalid_ref 'heads/foo*/bar*' --refspec-pattern
 
 ref='foo'
 invalid_ref "$ref"
diff --git a/t/t5511-refspec.sh b/t/t5511-refspec.sh
index de6db86..f541f30 100755
--- a/t/t5511-refspec.sh
+++ b/t/t5511-refspec.sh
@@ -71,15 +71,18 @@ test_refspec fetch ':refs/remotes/frotz/HEAD-to-me'
 test_refspec push ':refs/remotes/frotz/delete me'		invalid
 test_refspec fetch ':refs/remotes/frotz/HEAD to me'		invalid
 
-test_refspec fetch 'refs/heads/*/for-linus:refs/remotes/mine/*-blah' invalid
-test_refspec push 'refs/heads/*/for-linus:refs/remotes/mine/*-blah' invalid
+test_refspec fetch 'refs/heads/*/for-linus:refs/remotes/mine/*-blah'
+test_refspec push 'refs/heads/*/for-linus:refs/remotes/mine/*-blah'
 
-test_refspec fetch 'refs/heads*/for-linus:refs/remotes/mine/*' invalid
-test_refspec push 'refs/heads*/for-linus:refs/remotes/mine/*' invalid
+test_refspec fetch 'refs/heads*/for-linus:refs/remotes/mine/*'
+test_refspec push 'refs/heads*/for-linus:refs/remotes/mine/*'
 
 test_refspec fetch 'refs/heads/*/*/for-linus:refs/remotes/mine/*' invalid
 test_refspec push 'refs/heads/*/*/for-linus:refs/remotes/mine/*' invalid
 
+test_refspec fetch 'refs/heads/*g*/for-linus:refs/remotes/mine/*' invalid
+test_refspec push 'refs/heads/*g*/for-linus:refs/remotes/mine/*' invalid
+
 test_refspec fetch 'refs/heads/*/for-linus:refs/remotes/mine/*'
 test_refspec push 'refs/heads/*/for-linus:refs/remotes/mine/*'
 
-- 
2.5.0-rc3-352-g936684d
