From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] receive-pack: allow for hiding refs outside the namespace
Date: Tue, 27 Oct 2015 11:18:26 -0700
Message-ID: <xmqqfv0wcgzx.fsf@gitster.mtv.corp.google.com>
References: <1445846999-8627-1-git-send-email-lfleischer@lfos.de>
	<xmqqk2q9h05h.fsf@gitster.mtv.corp.google.com>
	<20151027053916.3030.8259@typhoon.lan>
	<20151027055911.4877.94179@typhoon.lan>
	<20151027143207.18755.82151@s-8d3a2f8b.on.site.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Lukas Fleischer <lfleischer@lfos.de>
X-From: git-owner@vger.kernel.org Tue Oct 27 19:18:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr8pU-00053q-Om
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 19:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754420AbbJ0SSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 14:18:33 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52008 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964897AbbJ0SS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 14:18:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E2425245E2;
	Tue, 27 Oct 2015 14:18:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4UgYmut849pZRZhf2kpFUIQlmNc=; b=dC7SpC
	iaRJ+ElzMtp1z6/ESwR18fCpBMTDPDKd511oIautZS4oqurIMPdyK2oKdqGO5FHl
	dYeKr+SccMo+vHjwxMrmh6idaebSf2QLTG7Ykr9PrXtJA3vrL0k8xus2s6GKlKt3
	NK0AbdmDOK1uRS1sl7JCypV/TARj3IBu0/otc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ImbETTSdTp6LeVaQM8NPLX8OqGY7K+fV
	BMFQxwMV3VJ//0ZILrMarTboPnhpslq2v9NxiPAQWCdlFo2dCp+iYNM0R3i0lVHZ
	licSFW5MfK6FEN0kFKLuxbwtijTpcmD275iuCu7JwNLknv0uR+tOjDacxwumerQR
	Oc3Ei6TZm6o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D93EC245E0;
	Tue, 27 Oct 2015 14:18:27 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5F194245DB;
	Tue, 27 Oct 2015 14:18:27 -0400 (EDT)
In-Reply-To: <20151027143207.18755.82151@s-8d3a2f8b.on.site.uni-stuttgart.de>
	(Lukas Fleischer's message of "Tue, 27 Oct 2015 15:32:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1E5F1ECE-7CD7-11E5-B263-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280285>

Lukas Fleischer <lfleischer@lfos.de> writes:

> 2. transfer.hideRefs and receive.hideRefs do not seem to work with Git
>    namespaces in general. show_ref_cb() replaces each ref outside the
>    current namespace with ".have" before passing it to show_ref() which
>    in turn performs the ref_is_hidden() check. This has the nice side
>    effect that receive.hideRefs=.have does exactly what I want, however
>    it also means that hideRefs feature does not allow for excluding only
>    specific tags outside the current namespace. Is that intended? Can we
>    rely on Git always looking for ".have" in the hideRefs list in this
>    case?

When I asked 'Is transfer.hiderefs insufficient?', I wasn't
expecting it to be usable out of box.  It was a suggestion to build
on top of it, instead of adding a parallel support for something
specific to namespaces.

For example, if the problem is that you cannot tell ref_is_hidden()
what namespace the ref is from because it is called after running
strip_namespace(), perhaps you can find a way to have the original
"namespaced ref" specified on transfer.hiderefs and match them?
Then in repository for project A, namespaced refs for project B can
be excluded by specifying refs/namespaces/B/* on transfer.hiderefs.

Perhaps along the lines of this?

 builtin/receive-pack.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index bcb624b..db0a99d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -221,6 +221,15 @@ static void show_ref(const char *path, const unsigned char *sha1)
 
 static int show_ref_cb(const char *path, const struct object_id *oid, int flag, void *unused)
 {
+	const char *ns = get_git_namespace();
+
+	/*
+	 * Give the "hiderefs" mechanism a chance to inspect and
+	 * reject the namespaced ref itself.
+	 */
+	if (ns[0] && ref_is_hidden(path))
+		return 0;
+
 	path = strip_namespace(path);
 	/*
 	 * Advertise refs outside our current namespace as ".have"
