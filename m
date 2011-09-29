From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC/PATCH] git checkout $tree path
Date: Thu, 29 Sep 2011 15:46:31 -0700
Message-ID: <7vk48rq854.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 00:46:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9PNI-0007kS-5w
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 00:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756126Ab1I2Wqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 18:46:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57979 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753491Ab1I2Wqe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 18:46:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE40E2EE6;
	Thu, 29 Sep 2011 18:46:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=R
	z97fMdKw0ENi4pAaHJd0ohyvAw=; b=rqLfUATGA3ZdcJ3cv6HE17LB2rsQZhxky
	AJvmtMVSsV04Q7EdFkSrjdruAzC2A6NmqzpyQUXLnOEHtSaLbJEfeNErg4jWyANf
	OKOr4LL3xTZ11bpEhYsSM2dyolYiRaZxM8VBRl+O+ObgPx41yw57bw8opsjdsxg+
	X/l9RXzr7U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=ktE
	pMhoPvHNjkX/S8wBaGUuLKkuUVMbUIzPSB7TgyBq/5WA11p/nky6vvHrSIwrLS3q
	L9GJgpfWqMPYZxbM/eurjxTsPS9M+D9z9POfxBEhDlaMmpgP0tjL7lcNh9XcZGsc
	LZwFW/rllOlQseNU1kvIGKsBEBZK3VN5B7aDBbcA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D54B32EE5;
	Thu, 29 Sep 2011 18:46:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D5502EE4; Thu, 29 Sep 2011
 18:46:33 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E13EA918-EAEC-11E0-A13D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182454>

Suppose you have two branches, "master" with dir/file1 and file2, and
"next" with dir/file3 and file4. You are currently on "next" branch.

    $ rm dir/file3
    $ git status -suno
     D dir/file3

Now, what should "git checkout master dir" do?

Checking paths out of a tree is (currently) defined to:

 - Grab the paths from the named tree that match the given pathspec,
   and add them to the index; and then

 - Check out the contents from the index for paths that match the
   pathspec to the working tree;

 - While at it, if the given pathspec did not match anything, suspect
   a typo from the command line and error out without updating the index
   nor the working tree.

According to that definition, because "master" has dir/file1, and the
index is unchanged since "next", we would add dir/file1 to the index, and
then check dir/file1 and dir/file3 out of the index. Hence, we end up
resurrecting dir/file3 out of the index, even though "master" does not
have that path.

This is somewhat surprising.

It may make sense to tweak the semantics a little bit. We can grab the
paths out of the named tree ("master" in this case), update the index, and
update the working tree with only with these paths we grabbed from the
named tree. By doing so, we will keep the local modification to dir/file3
(in this case, the modification is to "delete", but the above observation
hold equally true if dir/file3 were modified).

An alternative semantics could be to first remove paths that match the
given pathspec from the index, then update the index with paths taken from
the named tree, and update the working tree. "git checkout master dir"
would then mean "replace anything currently in dir with whatever is in dir
in master". It is more dangerous, and it can easily emulated by doing:

    $ git rm -rf dir
    $ git checkout master dir

so I did not go that far with this patch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is a behaviour change, but it may qualify as a bugfix. I dunno.

 builtin/checkout.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5e356a6..75dbe76 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -71,7 +71,7 @@ static int update_some(const unsigned char *sha1, const char *base, int baselen,
 	hashcpy(ce->sha1, sha1);
 	memcpy(ce->name, base, baselen);
 	memcpy(ce->name + baselen, pathname, len - baselen);
-	ce->ce_flags = create_ce_flags(len, 0);
+	ce->ce_flags = create_ce_flags(len, 0) | CE_UPDATE;
 	ce->ce_mode = create_ce_mode(mode);
 	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
 	return 0;
@@ -228,6 +228,8 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 
 	for (pos = 0; pos < active_nr; pos++) {
 		struct cache_entry *ce = active_cache[pos];
+		if (source_tree && !(ce->ce_flags & CE_UPDATE))
+			continue;
 		match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, ps_matched);
 	}
 
@@ -266,6 +268,8 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 	state.refresh_cache = 1;
 	for (pos = 0; pos < active_nr; pos++) {
 		struct cache_entry *ce = active_cache[pos];
+		if (source_tree && !(ce->ce_flags & CE_UPDATE))
+			continue;
 		if (match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, NULL)) {
 			if (!ce_stage(ce)) {
 				errs |= checkout_entry(ce, &state, NULL);
