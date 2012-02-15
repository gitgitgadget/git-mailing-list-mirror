From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3 v5] diff --stat: use the full terminal width
Date: Wed, 15 Feb 2012 10:07:22 -0800
Message-ID: <7vipj80y3p.fsf@alter.siamese.dyndns.org>
References: <7vpqdg3n7z.fsf@alter.siamese.dyndns.org>
 <1329303808-16989-1-git-send-email-zbyszek@in.waw.pl>
 <1329303808-16989-2-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	pclouds@gmail.com
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Wed Feb 15 19:07:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxjGO-0005zJ-Dd
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 19:07:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754030Ab2BOSH0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Feb 2012 13:07:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58585 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747Ab2BOSHZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Feb 2012 13:07:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F33ED6065;
	Wed, 15 Feb 2012 13:07:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Qufxlx5v6Bdz
	K6PgJY0pWkAkXmA=; b=rOsfGRK4waXRRc8JCaGwpVoAz53SYZf/dVuCVYsHvzMV
	buuiIP/5W+1Zwuk8LNkMFc7pKkx5UE0g6Aq0mkVkrT5MkgrlRZF8rzYYrLAhpDkf
	Gi1K7v4vWWbWMYH/CQ7JO65MmovzWOb372EshOpi+A5/hEZJtlN4ffQXUER0Vjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MQTB8I
	tonj6h2pSuEAIkYZfbNYzXLxqFAfugwSysm8OWXs+1x/CWKNd082Ye1Q2UjNwDGt
	T025zqc5Rwl50rmWNc42nXFc5fvZH3/lyo5q/SXcf8rVXUJEmKKnbFt8BClCYS8Q
	4g88y56JzI9WxC1tv8Pfk0xrc59WtCgXf19Gw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB00E6064;
	Wed, 15 Feb 2012 13:07:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 482CF6063; Wed, 15 Feb 2012
 13:07:24 -0500 (EST)
In-Reply-To: <1329303808-16989-2-git-send-email-zbyszek@in.waw.pl> ("Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek=22's?= message of "Wed, 15 Feb 2012
 12:03:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E9783420-57FF-11E1-B541-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190842>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> Use as many columns as necessary for the filenames and up to 40
> columns for the graph.

I started to wonder if it is a good idea to split this step further int=
o
at least two patches:

 - using term_columns() to set the default 'stat-width' instead of
   hardcoded 80, and do nothing else.  As you discovered, this step wil=
l
   not have to touch any test expectations.

 - update the logic to split the stat-width into name part and graph
   part. I think as a side-effect this will fix the corner case bugs th=
e
   new tests in your [1/3] seem to have discovered, and the fix will be
   visible to the part that will update t/t4014 in this step.

> ... I've taken the middle way:
> number_width=3D4 is hardcoded, but the fprintf is reverted to the pre=
vious
> version. I think that this way the code is most readable, independent=
ly
> if later changes.

Sensible.

> I haven't done this, because $COLUMNS and the actual terminal width i=
s always
> ignored in tests.

As long as the tests are not affected by ioctl(1) that is OK. I am not
expecting us to be automating the test of that codepath (unless somebod=
y
has clever ideas perhaps using pty, but I suspect that would be a separ=
ate
patch anyway).

After writing the attached patch that goes on top of this patch to be
squashed, I am starting to think that "maximum 40 columns for the graph=
"
may be a mild regression for a project with a shallow hierarchy, namely=
,
this part.

 cat >expect <<'EOF'
- abcd | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
+ abcd | 1000 ++++++++++++++++++++++++++++++++++++++++
 EOF

A bug used to waste space by allocating more than necessary as the mini=
mum
number of columns given for the graph part, even when the change turns =
out
to be just one line, requiring only one '+' in the graph.  The bug was =
fixed
by this patch not to waste space that way.  But now with this "maximum =
40"
limit, we can see that it wastes the space even when the stat-width is =
80.

Perhaps the maximum for garph_width should be raised to something like
"min(80, stat_width) - name_width"?

-- >8 --
Subject: [PATCH] (squash to the previous -- replace the last line of th=
e
 log with the following)

The effect of this change is visible in the patch to t4014 that fixes a
few tests marked with test_expect_failure, and the change to shorten th=
e
maximum graph width to 40 columns.
---
 t/t4014-format-patch.sh |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 0376186..88ccc5a 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -908,7 +908,7 @@ test_expect_success 'preparation' '
 cat >expect <<'EOF'
  ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
 |    1 +
 EOF
-test_expect_failure 'format patch graph width defaults to 80 columns' =
'
+test_expect_success 'format patch graph width defaults to 80 columns' =
'
 	git format-patch --stat --stdout -1 >output &&
 	grep " | " output >actual &&
 	test_cmp expect actual
@@ -917,13 +917,13 @@ test_expect_failure 'format patch graph width def=
aults to 80 columns' '
 cat >expect <<'EOF'
  ...aaaaaaaaaaaaaaaaaaaaaaaaaa |    1 +
 EOF
-test_expect_failure 'format patch --stat=3Dwidth with long name' '
+test_expect_success 'format patch --stat=3Dwidth with long name' '
 	git format-patch --stat=3D40 --stdout -1 >output &&
 	grep " | " output >actual &&
 	test_cmp expect actual
 '
=20
-test_expect_failure 'format patch --stat-width=3Dwidth works with long=
 name' '
+test_expect_success 'format patch --stat-width=3Dwidth works with long=
 name' '
 	git format-patch --stat-width=3D40 --stdout -1 >output &&
 	grep " | " output >actual &&
 	test_cmp expect actual
@@ -954,8 +954,13 @@ test_expect_success 'preparation for big change te=
sts' '
 '
=20
 cat >expect <<'EOF'
- abcd | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
+ abcd | 1000 ++++++++++++++++++++++++++++++++++++++++
 EOF
+test_expect_success 'format patch graph part width is 40 columns' '
+	git format-patch --stat --stdout -1 >output &&
+	grep " | " output >actual &&
+	test_cmp expect actual
+'
=20
 test_expect_success 'format patch ignores COLUMNS' '
 	COLUMNS=3D200 git format-patch --stat --stdout -1 >output
@@ -979,7 +984,7 @@ test_expect_success 'format patch --stat-width=3Dwi=
dth with big change' '
 '
=20
 cat >expect <<'EOF'
- ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++
+ ...aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 ++++++++++++
 EOF
 test_expect_success 'format patch --stat=3Dwidth with big change and l=
ong name' '
 	cp abcd aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa &&
--=20
1.7.9.1.237.g00b59
