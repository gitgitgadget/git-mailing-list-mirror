From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC/PATCH] ignoring a fetch that overwrites local symref
Date: Tue, 11 Dec 2012 11:46:45 -0800
Message-ID: <7v62488j8a.fsf_-_@alter.siamese.dyndns.org>
References: <1271694343-31876-2-git-send-email-jaysoffian@gmail.com>
 <1271714912-56659-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O . Pearce" <spearce@spearce.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	Stefan Zager <szager@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 11 20:47:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiVnG-0004P8-S4
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 20:47:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754515Ab2LKTqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 14:46:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41593 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754415Ab2LKTqt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 14:46:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36082AF29;
	Tue, 11 Dec 2012 14:46:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yx+D03l/vymgRC5uD7NGmybm8KY=; b=cT/0fi
	MImI6qjEd0uE84oz46fIXCcz362yHGB0a/jk9NWTCg9JDnLZ/Wh6GoTqP1Tu+pcZ
	0mPCsF/knRR2OKFB59Q9XCdtHOWdib13lORH/aghTFbYxrNcojQShJVALwVsvhMv
	gsVkkS+NYzwNSx7hHeNaiMXKEnSbepo2hfUDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UGLCuBD5YpwPp8qJtcsnHEjs1VQuvE//
	MIq7VY9ROt2JZr0k3FAei3sl8xq+lxSaNlmCxkOI7pl5REaDS704ycKBjs4dKaQx
	E2RQOzyJaDh2OY21owcQ03OVGWMeTD6yaRGTre+eQsfmAJfwGbzAjr1/lCw/78Bj
	3hq0Ad0vpO8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22282AF27;
	Tue, 11 Dec 2012 14:46:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59A4BAF26; Tue, 11 Dec 2012
 14:46:47 -0500 (EST)
In-Reply-To: <1271714912-56659-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Mon, 19 Apr 2010 18:08:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7FA9319E-43CB-11E2-BA18-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211297>

This is a companion to an ancient thread

    http://thread.gmane.org/gmane.comp.version-control.git/145311/focus=145337

in which an error was dealt with while pushing into a "mirror"
repository that has a symbolic reference refs/remotes/origin/HEAD
pointing at refs/remotes/origin/master with "git push --mirror".
The issue was that the receiving end was told to update origin/HEAD
and origin/master separately; if origin/HEAD is updated, that would
update origin/master at the same time, and then when attempting to
update origin/master, it would notice that it no longer has the
expected old value and barf.  After the series, we started ignoring
such pushes to HEAD on the receiving end.

But you can suffer from a similar issue transferring objects in the
opposite direction.  If you run "fetch --mirror" in to such a
"mirror" repository, the other side would advertise both 'master'
and 'HEAD' under refs/remotes/origin/ hierarchy, and refs/*:refs/*
wildcard would try to grab both of them.

Work it around by noticing a wildcard match that attempts to update
a local symbolic ref and ignoring it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * While I do not think it is sane to have symbolic refs in the
   receiving ref hierarchy (e.g. refs/remotes/origin/) that has a
   matching ref in the corresponding ref hierarchy in the sending
   side (e.g. the same, or refs/heads/ if you are doing a mirror) in
   the first place, we addressed the issue brought by such a setting
   on the push side, so it is probably a good idea to do it on the
   fetch side.

   This is marked RFC as it cheats by ignoring symrefs that were not
   explicitly asked, instead of doing the "is the underlying thing
   going to be updated with the same operation?" logic the old patch
   did in da3efdb (receive-pack: detect aliased updates which can
   occur with symrefs, 2010-04-19). I think this simpler logic is
   sufficient but there may be corner cases that merit the more
   elaborate one, hence RFC.

 remote.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git i/remote.c w/remote.c
index 6aa49c0..ca1f8f2 100644
--- i/remote.c
+++ w/remote.c
@@ -1370,6 +1370,16 @@ int branch_merge_matches(struct branch *branch,
 	return refname_match(branch->merge[i]->src, refname, ref_fetch_rules);
 }
 
+static int ignore_symref_update(const char *refname)
+{
+	unsigned char sha1[20];
+	int flag;
+
+	if (!resolve_ref_unsafe(refname, sha1, 0, &flag))
+		return 0; /* non-existing refs are OK */
+	return (flag & REF_ISSYMREF);
+}
+
 static struct ref *get_expanded_map(const struct ref *remote_refs,
 				    const struct refspec *refspec)
 {
@@ -1383,7 +1393,8 @@ static struct ref *get_expanded_map(const struct ref *remote_refs,
 		if (strchr(ref->name, '^'))
 			continue; /* a dereference item */
 		if (match_name_with_pattern(refspec->src, ref->name,
-					    refspec->dst, &expn_name)) {
+					    refspec->dst, &expn_name) &&
+		    !ignore_symref_update(expn_name)) {
 			struct ref *cpy = copy_ref(ref);
 
 			cpy->peer_ref = alloc_ref(expn_name);
