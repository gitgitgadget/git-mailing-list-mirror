From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] completion: match ctags symbol names in grep
 patterns
Date: Tue, 18 Oct 2011 10:14:15 -0700
Message-ID: <7vipnmgr2w.fsf@alter.siamese.dyndns.org>
References: <20111018044955.GA8976@sigill.intra.peff.net>
 <20111018050105.GC9008@sigill.intra.peff.net>
 <7vd3duixdg.fsf@alter.siamese.dyndns.org>
 <20111018072655.GA22309@elie.hsd1.il.comcast.net>
 <7v8voiiwfo.fsf@alter.siamese.dyndns.org>
 <20111018075521.GB20976@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 19:14:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGDFB-0001wA-Sn
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 19:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219Ab1JRROU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 13:14:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59770 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755490Ab1JRROT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 13:14:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B6CF6D64;
	Tue, 18 Oct 2011 13:14:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=prnqzqOZPTt4rppl/4SKegkUAQc=; b=i1HTVM
	HxFdgUUhrYOCo92XDN1+75OnndXcGr0XkbAEdaHfmSGUfIV/25tVzv7j3OdX13jO
	RmDj401MwZX6+YIam8be6Qq/effYf6CHjM27TARgjtFs3v0KFjfwFjxUOp5VKpft
	cTgyqq3gzyXZ4mlChi2Zl+IQB5Wkl26qM7LVg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qj2R6hTtcj3ObjE0zFbI8PnAuGbqYQAD
	7Iu4XXKCoWq8nu9NMq8uUSmz/BGVmOnKECK9Sm2A6nX0tICJmYHdB8Qk9G5YNYSe
	zvy+z2yxaFhmgDpFnzPP9m4zFw9jIaFDB+Gcn+vlvkhXA7Vs3bZ0HZK5L3Dz6aSf
	LOVvjTa19hM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 512D86D63;
	Tue, 18 Oct 2011 13:14:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB3526D5F; Tue, 18 Oct 2011
 13:14:18 -0400 (EDT)
In-Reply-To: <20111018075521.GB20976@elie.hsd1.il.comcast.net> (Jonathan
 Nieder's message of "Tue, 18 Oct 2011 02:55:21 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9D2CFC38-F9AC-11E0-8501-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183889>

Jonathan Nieder <jrnieder@gmail.com> writes:

> In this new tags/cscope example, one could make an argument that
> running exactly once is similarly better than running as needed (as in
> (ii) above), by pointing out that
>
> 	make tags TAGS cscope
>
> would have to check for a working "git ls-files" once instead of three
> times.

I tend to agree that once instead of three times is not such an
improvement, especially given how cheap builtin-invocation of ls-files is,
but then once every invocation of $(MAKE) would also be negligible (it is
not once every internal target evaluation).

In any case, here is what I'll queue. I like the fact that your suggestion
avoids an extra "test invocation" that spends cycles to read the full
index without contributing to the end result.

By the way, did anybody know that "git ls-files >/dev/null" is more
expensive than "git ls-files '~/' >/dev/null" as a way to see if there is
ls-files command available?

-- >8 --
Subject: [PATCH] Makefile: ask "ls-files" to list source files if available

The [ce]tags and cscope targets used to run "find" looking for any paths
that match '*.[chS]' to feed the list of source files to downstream xargs.

Use "git ls-files" if it is already available to us, and otherwise use a
tighter "find" expression that does not list directories and does not go
into our .git directory.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 8d6d451..badfb77 100644
--- a/Makefile
+++ b/Makefile
@@ -2115,17 +2115,21 @@ po/git.pot: $(LOCALIZED_C)
 
 pot: po/git.pot
 
+FIND_SOURCE_FILES = ( git ls-files '*.[hcS]' 2>/dev/null || \
+			$(FIND) . \( -name .git -type d -prune \) \
+				-o \( -name '*.[hcS]' -type f -print \) )
+
 $(ETAGS_TARGET): FORCE
 	$(RM) $(ETAGS_TARGET)
-	$(FIND) . -name '*.[hcS]' -print | xargs etags -a -o $(ETAGS_TARGET)
+	$(FIND_SOURCE_FILES) | xargs etags -a -o $(ETAGS_TARGET)
 
 tags: FORCE
 	$(RM) tags
-	$(FIND) . -name '*.[hcS]' -print | xargs ctags -a
+	$(FIND_SOURCE_FILES) | xargs ctags -a
 
 cscope:
 	$(RM) cscope*
-	$(FIND) . -name '*.[hcS]' -print | xargs cscope -b
+	$(FIND_SOURCE_FILES) | xargs cscope -b
 
 ### Detect prefix changes
 TRACK_CFLAGS = $(CC):$(subst ','\'',$(ALL_CFLAGS)):\
-- 
1.7.7.388.g3a4b7
