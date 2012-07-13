From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-am: indicate where a failed patch is to be found.
Date: Fri, 13 Jul 2012 12:58:22 -0700
Message-ID: <7vipdr8mch.fsf@alter.siamese.dyndns.org>
References: <7vobnkadsw.fsf@alter.siamese.dyndns.org>
 <1342194690-31578-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 21:58:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Spm0W-0004lz-FA
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 21:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475Ab2GMT60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 15:58:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56500 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753204Ab2GMT6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 15:58:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C1E389F7;
	Fri, 13 Jul 2012 15:58:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W4bLvDD8d7NLncUjAkwuYBuT3rU=; b=qbjnfO
	lbeG/YQ1v97fvZX5y0PEG2w5r/7MnqpRGcn+5ePzq+fUpr7bDiRfyOjErXq4nU5G
	avTe36nmNAyQxfs8lme97HCl+gCn1qTSUCODtf6g11+6BsX2JPprHU5pWraFv8fN
	IZovLXEqi12imYRbbC4KJXaHJmvp6lOYif0FA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ox3C2mjsnEWMTego/4fZb+PG7dvBMNpi
	q2HVPtjh7Xke5vSZNtsdmDhiZeMMp1FXtdDDQKpElZ4hpW8+E4x3YP58T0EKTis2
	+Vw7/TXlJIIvuHNLlFkXD6X8KnzDQ5G8//ovIl0lGrHI3d25yytkjQkqXSGugurS
	gqTcZQOWm70=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1968889F6;
	Fri, 13 Jul 2012 15:58:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B8B889F5; Fri, 13 Jul 2012
 15:58:24 -0400 (EDT)
In-Reply-To: <1342194690-31578-1-git-send-email-paul.gortmaker@windriver.com>
 (Paul Gortmaker's message of "Fri, 13 Jul 2012 11:51:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1AC5BFC6-CD25-11E1-BFB4-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201421>

Paul Gortmaker <paul.gortmaker@windriver.com> writes:

> If git am fails to apply something, the end user may need
> to know where to find the patch.  This is normally known for
> a single patch, but if the user is processing a mbox with
> many patches, they may not have a single broken out patch
> handy.  So, provide a helpful hint as to where they can
> find the patch to do some sort of manual fixup, if we
> are processing a mbox with more than one patch in it.

I would rather see this done even for a single patch mbox.  The
patch that was fed to "git apply" by "git am" and failed to apply is
that one, not the one in the mbox you gave "git am".  The latter may
be ungrokkable with GNU patch or "git apply", if the original was
sent in Quoted-Printable and such MIME funnies, which is the whole
point of having a separate file there for "git am", instead of
feeding the original.

I am not sure if we should limit $patch_format to mbox, but I think
showing this unconditionally regardless of mbox/stgit/hg will teach
the user only one location to remember, so perhaps like this?

 Documentation/config.txt | 3 +++
 git-am.sh                | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0e1168c..b1f0a75 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -143,6 +143,9 @@ advice.*::
 		Advice shown when you used linkgit:git-checkout[1] to
 		move to the detach HEAD state, to instruct how to create
 		a local branch after the fact.
+	amWorkDir::
+		Advice that shows the location of the patch file when
+		linkgit:git-am[1] fails to apply it.
 --
 
 core.fileMode::
diff --git a/git-am.sh b/git-am.sh
index dc48f87..f1ae932 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -834,9 +834,9 @@ did you forget to use 'git add'?"
 	if test $apply_status != 0
 	then
 		eval_gettextln 'Patch failed at $msgnum $FIRSTLINE'
-		if test $patch_format = mbox && test "$last" -ne "1"
+		if test "$(git config --bool advice.amworkdir)" != false
 		then
-			eval_gettextln "You can find the copy of the patch that failed here:
+			eval_gettextln "The copy of the patch that failed is found in:
    $dotest/patch"
 		fi
 		stop_here_user_resolve $this
