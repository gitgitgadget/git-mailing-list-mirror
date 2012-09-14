From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: fix refspec on "--single-branch" option
Date: Fri, 14 Sep 2012 11:42:05 -0700
Message-ID: <7vhar04fb6.fsf@alter.siamese.dyndns.org>
References: <CAN0XMOKszADpeaCG7VhL-AZ3m7_hSWV3NhEmPuH6FETzs=eDNg@mail.gmail.com>
 <1347599357-15533-1-git-send-email-ralf.thielow@gmail.com>
 <7vr4q56uae.fsf@alter.siamese.dyndns.org>
 <7vipbh6qxa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 20:42:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCaqJ-0002fQ-Hs
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 20:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759875Ab2INSmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 14:42:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44834 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759859Ab2INSmI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 14:42:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 950FC889D;
	Fri, 14 Sep 2012 14:42:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JuepY+kIaVrGsEcotbA/pVZjMxA=; b=SUEj3X
	l1FNyCgVb9zYpZjtYoG80Y8+BJUU/1FFSah2U9PGp2DBaL/0tyoOLUEq5LfsiUX0
	n960b/M5nSEFiEH8CK8NvkvvlNUOqgvAW53aENP9IZgmdZSu0pvJGXhV1qd17SZL
	L19ZF+9cmKd4mX/R6oAHM+dukVc8hassBUJ6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jAoi/sjLSH1nVZdZyUiVxMe+OGy3GpQb
	AFkEmZLcXbXcHrB3YGLmu9a4gryEXk2RSMfKpv8B+3Lvvo5YkiK/VCZoZGxhkTHV
	E8AmJhNMJdXo5W8v7XGdUrxcVsncj0fqRThRxAbjtMeNrvXyGSa+0vGRsEKxfWT1
	GK+jDWPxs4A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80F1F889C;
	Fri, 14 Sep 2012 14:42:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D8A28889B; Fri, 14 Sep 2012
 14:42:06 -0400 (EDT)
In-Reply-To: <7vipbh6qxa.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 13 Sep 2012 23:48:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E25CECD8-FE9B-11E1-837C-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205525>

Junio C Hamano <gitster@pobox.com> writes:

> Alternatively, if you can move the logic to set up this
> configuration further down so that it happens after we talked to the
> other side and figured out remote_head_points_at, you could instead
> set it up to keep a single remote tracking branch.
>
> Even if you did so, guess_remote_head() may not find any branch when
> the other repository's HEAD is detached, so you would need to decide
> what to do in such a case, and "fetch and integrate their HEAD
> without using any remote tracking branch" may be a reasonable thing
> to do in such a case.

Along the lines of this, perhaps.

 builtin/clone.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git i/builtin/clone.c w/builtin/clone.c
index 5e8f3ba..c9e099d 100644
--- i/builtin/clone.c
+++ w/builtin/clone.c
@@ -853,6 +853,22 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 					      "refs/heads/master");
 	}
 
+	if (option_single_branch) {
+		/* Fix up the refspec for fetch */
+		strbuf_reset(&value);
+		if (!remote_head_points_at)
+			strbuf_addf(&value, "HEAD");
+		else
+			strbuf_addf(&value, "%s:%s%s",
+				    remote_head_points_at->name,
+				    branch_top.buf,
+				    skip_prefix(remote_head_points_at->name, "refs/heads/"));
+
+		strbuf_reset(&key);
+		strbuf_addf(&key, "remote.%s.fetch", option_origin);
+		git_config_set_multivar(key.buf, value.buf, NULL, 1);
+	}
+
 	if (is_local)
 		clone_local(path, git_dir);
 	else if (refs && complete_refs_before_fetch)
