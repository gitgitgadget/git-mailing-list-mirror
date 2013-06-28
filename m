From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: Skip pack-*.keep files when cloning locally
Date: Fri, 28 Jun 2013 13:38:28 -0700
Message-ID: <7vvc4ym0mz.fsf@alter.siamese.dyndns.org>
References: <1372430538-19216-1-git-send-email-jl@opera.com>
	<7vvc4ynkrx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johan@herland.net
To: Jens Lindstrom <jl@opera.com>
X-From: git-owner@vger.kernel.org Fri Jun 28 22:38:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsfRE-0002P5-QJ
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 22:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601Ab3F1Uib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 16:38:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64515 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006Ab3F1Uib (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 16:38:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9444A2C2F3;
	Fri, 28 Jun 2013 20:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=acKjmK9I13d1KfiCA4ID0j1Eo08=; b=mh4iOA
	SWR+sFb0KAZsg0z+3HiNi24rxI+HbwEbxH7pX9caCTIIdLZx9cFOxTWL0jYTgGiV
	nd5SBbIhlGSzB9A/CWjwYYLFWaUJOuWUKbYprj8/bSBrksBBD/duYniZXZXISclW
	Gsv/apkjlPhRwmq+gezj53GDqht2rEojDfSuI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VSkfrCCyuIrMvFGNtkh99GIJ4cLpFG/l
	lekao2g/DWeP/ohrWGWbw/Tao3MF84kuWUAChzUOaoMStduHqu8/rW9wkBXFr50v
	mldzWbNEFkdnSt5mWb9tjKPmUJaoET6CvmTAcqfWCyS6PTxi2wth1pMkslHQsAAx
	pjAHPcxLvPg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A3042C2F2;
	Fri, 28 Jun 2013 20:38:30 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E77FE2C2F0;
	Fri, 28 Jun 2013 20:38:29 +0000 (UTC)
In-Reply-To: <7vvc4ynkrx.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 28 Jun 2013 11:38:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B125C56C-E032-11E2-A6F2-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229236>

Junio C Hamano <gitster@pobox.com> writes:

> I am perfectly fine with a change that allows a local clone to skip
> and not error out when such a "keep" marker cannot be copied, I do
> not know if it is a good idea to unconditionally skip and not even
> attempt to copy it.

That is, something like this, perhaps?

We could even create an empty file, as it is only the presense that
matters for ".keep" files, but I found it a bit too much special
casing to my taste.

 builtin/clone.c        |  9 ++++++++-
 t/t5701-clone-local.sh | 15 +++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 66bff57..4b7cd9b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -356,8 +356,15 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 				die_errno(_("failed to create link '%s'"), dest->buf);
 			option_no_hardlinks = 1;
 		}
-		if (copy_file_with_time(dest->buf, src->buf, 0666))
+		if (copy_file_with_time(dest->buf, src->buf, 0666)) {
+			if (!strncmp(src->buf + src_baselen, "/pack/pack-", 11) &&
+			    !suffixcmp(src->buf, ".keep"))
+				goto skip;
+
 			die_errno(_("failed to copy file to '%s'"), dest->buf);
+		skip:
+			warning("skipping %s", src->buf);
+		}
 	}
 	closedir(dir);
 }
diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
index 7ff6e0e..bb5dddd 100755
--- a/t/t5701-clone-local.sh
+++ b/t/t5701-clone-local.sh
@@ -134,4 +134,19 @@ test_expect_success 'cloning a local path with --no-local does not hardlink' '
 	! repo_is_hardlinked force-nonlocal
 '
 
+test_expect_success SANITY 'clone --no-hardlinks with unreadable .keep' '
+	mkdir strictsrc &&
+	(
+		cd strictsrc &&
+		git init &&
+		git commit --allow-empty -m initial &&
+		git repack -a -d &&
+		packname=$(echo .git/objects/pack/pack-*.idx) &&
+		keepname=${packname%.idx}.keep &&
+		>"$keepname" &&
+		chmod a= "$keepname"
+	) &&
+	git clone --local --no-hardlinks strictsrc dst
+'
+
 test_done
