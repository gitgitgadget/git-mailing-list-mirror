From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] check-ignore.c, dir.c: fix segfault with '.'
 argument from repo root
Date: Tue, 19 Feb 2013 14:03:01 -0800
Message-ID: <7vfw0s3qsq.fsf@alter.siamese.dyndns.org>
References: <CAOkDyE9VVuFn6B=Fe4XHxGCEW0MFgndx1X0+9hO36Soxb37YQw@mail.gmail.com>
 <1361301696-11307-1-git-send-email-git@adamspiers.org>
 <7vzjz03wid.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Zoltan Klinger <zoltan.klinger@gmail.com>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 23:03:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7vHg-0006yi-A4
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 23:03:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934576Ab3BSWDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 17:03:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50519 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934567Ab3BSWDE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 17:03:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B45C0A86C;
	Tue, 19 Feb 2013 17:03:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fvfvKJuGnDqC7EldSeokOJ8hWdU=; b=Fkmjs+
	xBNUc/sceYGEsJ0+HjBJZ66qOeED/StykjlBlPSKjVOZn3feuDZi+cxnQ8lJ6vpB
	P5FquQsutlZpeWGQofyWj542ZcBx7rr12oQ44HGLW4V8IubstIVozIg1v+MxmVlg
	P/BcEK6CoXkZwwwOUshIDb3bFFd2HPVneFasg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lk92ye/siearHy1rsVTURLRx7hNUIPUW
	KU6yiqu6q9XCQwj1y1R3RAdhHt0Y8nCW41YQMVBwBI3tS7m4eknaXbDNIuySxay0
	Sg5T9APg3omIhDr12QFd0O21E1tvWOrtEYqtCEu3gfPaJZqUMOYcAQtK1OLZYCg9
	5CrXiiTF6Uw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A85BFA86B;
	Tue, 19 Feb 2013 17:03:03 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CEF71A865; Tue, 19 Feb 2013
 17:03:02 -0500 (EST)
In-Reply-To: <7vzjz03wid.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 19 Feb 2013 11:59:38 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 218B0B9A-7AE0-11E2-92A3-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216663>

Junio C Hamano <gitster@pobox.com> writes:

> And this sounds like a really bad excuse.  If it were "it does not
> make *any* sense ... because the top level is *never* ignored", then
> the patch is a perfectly fine optimization that happens to work
> around the problem, but the use of "much" and "typically" is a sure
> sign that the design of the fix is iffy.  It also shows that the
> patch is not a fix, but is sweeping the problem under the rug, if
> there were a valid use case to set the top level to be ignored.
>
> I wonder what would happen if we removed that "&& path[0]" check
> from the caller, not add the "assume the top is never ignored"
> workaround, and do something like this to the location that causes
> segv, so that it can give an answer when asked to hash an empty
> string?
>
> Does the callchain that goes down to this function have other places
> that assume they will never see an empty string, like this function
> does, which I _think_ is the real issue?

I started to suspect that may be the right approach.  Why not do this?

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Tue, 19 Feb 2013 11:56:44 -0800
Subject: [PATCH] name-hash: allow hashing an empty string

Usually we do not pass an empty string to the function hash_name()
because we almost always ask for hash values for a path that is a
candidate to be added to the index. However, check-ignore (and most
likely check-attr, but I didn't check) apparently has a callchain
to ask the hash value for an empty path when it was given a "." from
the top-level directory to ask "Is the path . excluded by default?"

Make sure that hash_name() does not overrun the end of the given
pathname even when it is empty.

Remove a sweep-the-issue-under-the-rug conditional in check-ignore
that avoided to pass an empty string to the callchain while at it.
It is a valid question to ask for check-ignore if the top-level is
set to be ignored by default, even though the answer is most likely
no, if only because there is currently no way to specify such an
entry in the .gitignore file. But it is an unusual thing to ask and
it is not worth optimizing for it by special casing at the top level
of the call chain.

Signed-off-by: Adam Spiers <git@adamspiers.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/check-ignore.c | 2 +-
 name-hash.c            | 4 ++--
 t/t0008-ignores.sh     | 5 +++++
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 709535c..0240f99 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -89,7 +89,7 @@ static int check_ignore(const char *prefix, const char **pathspec)
 					? strlen(prefix) : 0, path);
 		full_path = check_path_for_gitlink(full_path);
 		die_if_path_beyond_symlink(full_path, prefix);
-		if (!seen[i] && path[0]) {
+		if (!seen[i]) {
 			exclude = last_exclude_matching_path(&check, full_path,
 							     -1, &dtype);
 			if (exclude) {
diff --git a/name-hash.c b/name-hash.c
index d8d25c2..942c459 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -24,11 +24,11 @@ static unsigned int hash_name(const char *name, int namelen)
 {
 	unsigned int hash = 0x123;
 
-	do {
+	while (namelen--) {
 		unsigned char c = *name++;
 		c = icase_hash(c);
 		hash = hash*101 + c;
-	} while (--namelen);
+	}
 	return hash;
 }
 
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index ebe7c70..9c1bde1 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -138,6 +138,7 @@ test_expect_success 'setup' '
 	cat <<-\EOF >.gitignore &&
 		one
 		ignored-*
+		top-level-dir/
 	EOF
 	for dir in . a
 	do
@@ -177,6 +178,10 @@ test_expect_success 'setup' '
 #
 # test invalid inputs
 
+test_expect_success_multi '. corner-case' '' '
+	test_check_ignore . 1
+'
+
 test_expect_success_multi 'empty command line' '' '
 	test_check_ignore "" 128 &&
 	stderr_contains "fatal: no path specified"
-- 
1.8.2.rc0.89.g6e4b41d
