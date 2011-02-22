From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] do not overwrite untracked symlinks
Date: Mon, 21 Feb 2011 22:54:38 -0800
Message-ID: <7v62scftjl.fsf@alter.siamese.dyndns.org>
References: <201102022025.06140.j6t@kdbg.org>
 <7v7hdixkys.fsf@alter.siamese.dyndns.org> <201102022324.22123.j6t@kdbg.org>
 <201102051918.44848.j6t@kdbg.org> <20110205183351.GA25717@localhost>
 <20110220121343.GA21514@localhost> <7vaahpluy9.fsf@alter.siamese.dyndns.org>
 <20110221194623.GA31181@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Feb 22 07:54:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Prm99-0006Zg-C2
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 07:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368Ab1BVGyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 01:54:50 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48250 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578Ab1BVGyt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 01:54:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D460B28CD;
	Tue, 22 Feb 2011 01:56:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T11dzQSprd1/or9zlvnccUzVkkE=; b=JVesy9
	vinpM5ejqJQjt+X/FixxKpbBI8K/TEmPzNoXFkCTw+NYQHgRGSCASSEsEBDSSo01
	b3iHQVqARwrjQIEMokRI5tNwSwgSG+tShSrZeE2yPHCyln/QX9yvicIJn/VyE36q
	qjU28pieQQfbrecGJpyX+YMiINY3FKK5EzT0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wtRNqvohF+aYv9lXUPMUiEPOdC4Sc4rC
	gnxwzeYDBx0y9pPZOavGXrLa6n2ZWWip8NNyEji17eo3Mjp6Xf9oGtlB0wFqGBCw
	mVLPO5g3rgK2CLyLzNU724N35ROTG2N1cnXooo2LGFvxvMAbfKNZlTQGcPbLoy/S
	nH+Ic//D9j4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A2B2528C9;
	Tue, 22 Feb 2011 01:55:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4F36E28C5; Tue, 22 Feb 2011
 01:55:53 -0500 (EST)
In-Reply-To: <20110221194623.GA31181@localhost> (Clemens Buchacher's message
 of "Mon\, 21 Feb 2011 20\:46\:23 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CCD9D5A4-3E50-11E0-931A-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167528>

Clemens Buchacher <drizzd@aon.at> writes:

> I didn't write the test, but to me it looks like the test wants to
> make sure that while the symlink is removed, the tree it's pointing
> to is not removed.

Yes, I agree with that reading.  I'd squash in this on top, first making
sure that "do not overwrite untracked symlinks" (which is the title of
this patch) won't be broken, and then the original test that wanted to
make sure that checking out a/b/c/d when a/b is pointing to an unrelated
part of the tree does not nuke whatever is pointed at that symbolic link.

Thanks.

My unhappiness with the undescriptive "check_leading_path()" still
remains, though...

diff --git a/t/t6035-merge-dir-to-symlink.sh b/t/t6035-merge-dir-to-symlink.sh
index 1de285b..2599ae5 100755
--- a/t/t6035-merge-dir-to-symlink.sh
+++ b/t/t6035-merge-dir-to-symlink.sh
@@ -17,13 +17,21 @@ test_expect_success SYMLINKS 'create a commit where dir a/b changed to symlink'
 	git commit -m "dir to symlink"
 '
 
-test_expect_success SYMLINKS 'keep a/b-2/c/d across checkout' '
+test_expect_success SYMLINKS 'checkout does not clobber untracked symlink' '
 	git checkout HEAD^0 &&
 	git reset --hard master &&
 	git rm --cached a/b &&
 	git commit -m "untracked symlink remains" &&
-	 git checkout -f start^0 &&
-	 test -f a/b-2/c/d
+	test_must_fail git checkout start^0
+'
+
+test_expect_success SYMLINKS 'a/b-2/c/d is kept when clobbering symlink b' '
+	git checkout HEAD^0 &&
+	git reset --hard master &&
+	git rm --cached a/b &&
+	git commit -m "untracked symlink remains" &&
+	git checkout -f start^0 &&
+	test -f a/b-2/c/d
 '
 
 test_expect_success SYMLINKS 'checkout should not have deleted a/b-2/c/d' '
