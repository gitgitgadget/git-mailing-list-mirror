From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [BUG] "git checkout -b" erronously thinks a branch already
 exists
Date: Sun, 05 Jun 2011 22:27:34 -0700
Message-ID: <7v1uz7bkc9.fsf@alter.siamese.dyndns.org>
References: <201106051305.13723.stefano.lattarini@gmail.com>
 <7v62ojbuyh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 07:34:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTSS6-0001Pg-PE
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 07:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756482Ab1FFF1n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2011 01:27:43 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49607 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424Ab1FFF1m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2011 01:27:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 973205EE7;
	Mon,  6 Jun 2011 01:29:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=s8m6mwNeWoHh
	4jygS7Nv1TQ4MoM=; b=sZBQCCHpE6WK3HA8COqn3V61+hT+JbfvIXLkGrTRUlGX
	QwsDTLoSndJvRZa8q2wu5fybvOTaGcPQ+2045eBiqBvZfJU65CWjEs1Kgj9MUMIy
	5T0lted4Yvlndepb6OWKrRAl+589JO3NwlmqcTJyv4lLqDfeWgCVYiJTGu/kOHk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=S7uxLe
	yg6vfWgr1Cco+V8oLygVGWDLC7Jr4SS4zeE4LbzwMkasVJVyaQsNLT6M9+eXcekR
	/UdshrGxzVZ9/Gs+IUs4rh/P/Ql/73eV1PVs7wZqvEU+QmKEWfahKGktVDo1g660
	MqnHdljeZfaBBdsB2jcmKEsyY0xVzkvAvM2Zs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7475E5EE6;
	Mon,  6 Jun 2011 01:29:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5318C5EE5; Mon,  6 Jun 2011
 01:29:45 -0400 (EDT)
In-Reply-To: <7v62ojbuyh.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 05 Jun 2011 18:38:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF4E5AA6-8FFD-11E0-A8A8-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175091>

Junio C Hamano <gitster@pobox.com> writes:

> I think the right fix is to make sure that "refs/heads/<name>" does n=
ot
> exist by checking exactly that.
>
> Perhaps something like this.  I am not sure if we want to use the "yi=
eld
> non zero to signal not an error but an early return" trick like I did=
 in
> this patch, though.

Let's do this instead. I don't know what I was thinking when I wrote th=
at
inefficient "loop refs to see if there is that one" patch.

-- >8 --
Subject: [PATCH] checkout -b <name>: correctly detect existing branch

When create a new branch, we fed "refs/heads/<proposed name>" as a stri=
ng
to get_sha1() and expected it to fail when a branch already exists.

The right way to check if a ref exists is to check with resolve_ref().

A na=C3=AFve solution that might appear attractive but does not work is=
 to
forbid slashes in get_describe_name() but that will not work. A describ=
e
name is is in the form of "ANYTHING-g<short sha1>", and that ANYTHING p=
art
comes from a original tag name used in the repository the user ran the
describe command. A sick user could have a confusing hierarchical tag
whose name is "refs/heads/foobar" (stored as refs/tags/refs/heads/fooba=
r")
to generate a describe name "refs/heads/foobar-6-g02ac983", and we shou=
ld
be able to use that name to refer to the object whose name is 02ac983.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout.c         |    2 +-
 refs.c                     |    6 ++++++
 refs.h                     |    1 +
 t/t2018-checkout-branch.sh |   11 +++++++++++
 4 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4ad7427..88708d4 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -874,7 +874,7 @@ no_reference:
 		if (strbuf_check_branch_ref(&buf, opts.new_branch))
 			die("git checkout: we do not like '%s' as a branch name.",
 			    opts.new_branch);
-		if (!get_sha1(buf.buf, rev)) {
+		if (ref_exists(buf.buf)) {
 			opts.branch_exists =3D 1;
 			if (!opts.new_branch_force)
 				die("git checkout: branch %s already exists",
diff --git a/refs.c b/refs.c
index 6f486ae..92cd0d1 100644
--- a/refs.c
+++ b/refs.c
@@ -1732,6 +1732,12 @@ int update_ref(const char *action, const char *r=
efname,
 	return 0;
 }
=20
+int ref_exists(char *refname)
+{
+	unsigned char sha1[20];
+	return !!resolve_ref(refname, sha1, 1, NULL);
+}
+
 struct ref *find_ref_by_name(const struct ref *list, const char *name)
 {
 	for ( ; list; list =3D list->next)
diff --git a/refs.h b/refs.h
index 762ce50..070a7d9 100644
--- a/refs.h
+++ b/refs.h
@@ -46,6 +46,7 @@ extern void warn_dangling_symref(FILE *fp, const char=
 *msg_fmt, const char *refn
  */
 extern void add_extra_ref(const char *refname, const unsigned char *sh=
a1, int flags);
 extern void clear_extra_refs(void);
+extern int ref_exists(char *);
=20
 extern int peel_ref(const char *, unsigned char *);
=20
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 1caffea..741d842 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -163,4 +163,15 @@ test_expect_success 'checkout -f -B to an existing=
 branch with mergeable changes
 	test_must_fail test_dirty_mergeable
 '
=20
+test_expect_success 'checkout -b <describe>' '
+	git tag -f -m "First commit" initial initial &&
+	git checkout -f change1 &&
+	name=3D$(git describe) &&
+	git checkout -b $name &&
+	git diff --exit-code change1 &&
+	echo "refs/heads/$name" >expect &&
+	git symbolic-ref HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_done
--=20
1.7.6.rc0.106.g68174
