From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a test for a problem in "rebase --whitespace=fix"
Date: Sun, 07 Feb 2010 10:38:10 -0800
Message-ID: <7vtytsevsd.fsf@alter.siamese.dyndns.org>
References: <4B6E7564.7040109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 19:38:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeC1Y-000730-EW
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 19:38:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137Ab0BGSiT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2010 13:38:19 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33040 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824Ab0BGSiR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2010 13:38:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2832C98778;
	Sun,  7 Feb 2010 13:38:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=tU3o/xlb0B4pMSeSJP+HVOBzR
	ps=; b=iJBLb4zPWYauVjCJCBiaWjPgp+uWfj1ad6d3B8+ldqmq+P30jMOBwv3kk
	p6ZWUsGK4JH3FF4FuVcF1NcQrUUFC/USGno43li00sfxKAwvH9Q4LxYqAUzP6mWD
	Vmv+peSvJUr4SxQ34ymf/hLQW7ryKKqW8p4OD84YvH+RqYDh8I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=E2ow4g9q/DDTtZ8PiCL
	2osW01Binoy99IEPjZZcvxMxa+TTm11Wv3M7hqGWqOCEeUD++RjXdXUWaUN7z9+s
	9npmpXeyG8iWDm3aecBfCA+++xc4mThq6DcxxA9dWmyDCsHJB/YRjwfBzpln2QFE
	tpi1B9GamyqUvHfvDVv2XxD8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 076D598776;
	Sun,  7 Feb 2010 13:38:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C79198775; Sun,  7 Feb
 2010 13:38:12 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F3B5D8A8-1417-11DF-8A52-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139244>

Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com> writes:

> The command "git rebase --whitespace=3Dfix HEAD~<N>" is supposed to
> only clean up trailing whitespace, and the expectation is that it
> cannot fail.

I don't know if the expectation is sound to begin with, for exactly the
reason you mention below.

> Unfortunately, if one commit adds a blank line at the end of a file
> and a subsequent commit adds more non-blank lines after the blank
> line,...

=46irst, is this a condition that we want to change the behaviour to
"succeed" later? =20

Imagine that the gap between abc and def block in your example is much
larger to exceed the number of pre-context lines of your second patch
(usually 3), and imagine you are the "git apply --whitespace=3Dfix" pro=
gram
you have updated to "fix" the preceived problem.  You know you earlier
might have stripped some blank lines at the EOF, but there is nothing t=
hat
tells you if you had only 3 blank lines, or you had even more.  How man=
y
blank lines will you be adding back?

I think one fundamental difference between stripping of blanks at EOL a=
nd
blanks at EOF is that the former, even after applying an earlier patch
with the whitespace fix, could be fudged to an unspecified number of
whitespaces while you are applying the second one, exactly because you
will strip them out from the output of the second one anyway.  But the
latter will have to _appear_ in the result, as you have demonstrated, a=
s a
gap between abc and def blocks in your example.  Simply there is not
enough information to do so.

Around 1.6.6/1.6.5.3 timeframe, we have separated blank-at-{eol,eof} ou=
t
of trailing-space to allow users to keep the traling blank lines.  Perh=
aps
you could demonstrate what is expected to work (and not bothering with
what is not ever expected to work) by changing the test like this.

I added one "trailing whitespace at EOL" example to keep the "strip
trailing whitespace" part working, by the way.

 t/t3417-rebase-whitespace-fix.sh |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/t3417-rebase-whitespace-fix.sh b/t/t3417-rebase-whitespa=
ce-fix.sh
index 55cbce7..0e366f8 100755
--- a/t/t3417-rebase-whitespace-fix.sh
+++ b/t/t3417-rebase-whitespace-fix.sh
@@ -7,9 +7,9 @@ This test runs git rebase --whitespace=3Dfix and make s=
ure that it works.
=20
 . ./test-lib.sh
=20
-# prepare initial revision of "file" with a blank line at the end
-cat >file <<EOF
-a
+# prepare initial revision of "file" with a trailing blank and a blank=
 line at the end
+sed -e 's/Z//' >file <<\EOF
+a    Z
 b
 c
=20
@@ -20,6 +20,7 @@ cat >expect <<EOF
 a
 b
 c
+
 EOF
=20
 # prepare second revision of "file"
@@ -33,7 +34,9 @@ e
 f
 EOF
=20
-test_expect_failure 'blanks line at end of file; extend at end of file=
' '
+test_expect_success 'keep blanks line at end of file' '
+	git config core.whitespace -blank-at-eof &&
+
 	git commit --allow-empty -m "Initial empty commit" &&
 	git add file && git commit -m first &&
 	mv second file &&
