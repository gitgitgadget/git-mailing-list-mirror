From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "sha1 information is lacking or useless" when rebasing with a
 submodule pointer conflict
Date: Thu, 31 Jan 2013 20:01:21 -0800
Message-ID: <7vboc4d6ni.fsf@alter.siamese.dyndns.org>
References: <CAFyOhY8YAO4zx6jKQxrEW=-Vbo-TTjU6wJ7UgNVEjA7B2dasng@mail.gmail.com>
 <20130130215615.GA1053@book.hvoigt.net>
 <20130130224904.GB1053@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Sims <michael.h.sims@gmail.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Feb 01 05:01:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U17oy-0001Ih-0l
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 05:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446Ab3BAEB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 23:01:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44209 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752424Ab3BAEBY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 23:01:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAC38BC61;
	Thu, 31 Jan 2013 23:01:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gmENOHqNRIdF6L0NaT9aVBDgXcM=; b=ZPOhrs
	c9UcDqBUoy+BGSF/Jas1IiZxTsYsJm9lkw8DqKkCZcXBWSK7GRhsn8m1q87mxkB6
	0LMbQ2prszS1jEow+udbpGYnBkcTwGCJ0MWb8k5yypdqbvyxB7qIYOUVrWZ4Or15
	TYPMhoFO/49HhtayhXQ7029sq88HO7MD+QTr8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qyob20R9dIB0OnAsOE/9pVrye8N41+DW
	Q8I9gm0n5AM4id1E5y9+dOyTBTgyalU7CR3inb/mfJ720FWyb+VSbgPQFjgCbTug
	LSaqhhOFfyGEamzhVLwPza3ZZBPCcIglUMRiMkg+bqGPKzZjSM62qbCEg2IRX8c6
	ZFbGg86lqQg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BEF99BC60;
	Thu, 31 Jan 2013 23:01:23 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38064BC5E; Thu, 31 Jan 2013
 23:01:23 -0500 (EST)
In-Reply-To: <20130130224904.GB1053@book.hvoigt.net> (Heiko Voigt's message
 of "Wed, 30 Jan 2013 23:49:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0AEBC8A4-6C24-11E2-B39E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215198>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> Maybe Martin or Junio immediately see whats going wrong here? I would
> need to further dig into the git-am code to find out how to fix it.

Thanks.  I think the minimum fix is this, but there are some nits to
pick around this area as well.


diff --git b/git-am.sh a/git-am.sh
index b4d95f5..202130f 100755
--- b/git-am.sh
+++ a/git-am.sh
@@ -664,7 +664,7 @@ do
 			sed -e '1,/^$/d' >"$dotest/msg-clean"
 			echo "$commit" >"$dotest/original-commit"
 			get_author_ident_from_commit "$commit" >"$dotest/author-script"
-			git diff-tree --root --binary "$commit" >"$dotest/patch"
+			git diff-tree --root --binary --full-index "$commit" >"$dotest/patch"
 		else
 			git mailinfo $keep $no_inbody_headers $scissors $utf8 "$dotest/msg" "$dotest/patch" \
 				<"$dotest/$msgnum" >"$dotest/info" ||
