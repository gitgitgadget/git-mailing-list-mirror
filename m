From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] optionally disable overwriting of ignored files
Date: Fri, 20 Aug 2010 13:35:32 -0700
Message-ID: <7v4oepaup7.fsf@alter.siamese.dyndns.org>
References: <4C6A1C5B.4030304@workspacewhiz.com>
 <7viq39avay.fsf@alter.siamese.dyndns.org> <20100818233900.GA27531@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Aug 20 22:35:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmYJZ-0005pf-At
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 22:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979Ab0HTUfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 16:35:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39950 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab0HTUfn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 16:35:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 71C22CFA40;
	Fri, 20 Aug 2010 16:35:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=NtrAklmRjU0LR+VC4gicR+kQVXI=; b=YaBImroynse49bEvzCFovhP
	Y8qWuLFNuesWNRKxLTkH34fHQvnyRjMa1o/1FvFhPX1mxxLZejCEIQNAK9if64Gp
	ibxNCwM6kWzKZOkILBcU88edsJtJYCeNwUwO7KObvLk9RgWXiwGy7rUZJwlkC2sC
	Ba7gxYDFj4TKoc5bX1UI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=PNsGz2Uk97INT+MdXl/KVquM3UIAVypIy7e1FIHclhKWSEcX0
	pNpDBMBAYRhZNAjgM4L4rmTHTe7g/We9lqD2kiiBWxRMPU7JI+1kjm6xqqWhICm2
	CRmsoS3ngei9lu2o0IrBrXi41qljUJAlurKlZcrb8mwtNgAZdbm/OHxYjQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F625CFA3F;
	Fri, 20 Aug 2010 16:35:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC3DDCFA3D; Fri, 20 Aug
 2010 16:35:34 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7E7F0FC0-AC9A-11DF-8595-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154079>

If (and this may be a big IF) it is reasonable to add paths to .gitignore
that you do not want to lose, then you would want to have three classes of
untracked paths: "precious but ignored", "trashable" (and by definition
ignored), and "unignored" (and by definition is not ignored and is
precious).

As I already pointed out, we don't support the "precious but ignored"
class.  So an obvious alternate solution to your particular case is not to
add such a path to the gitignore mechanism.

I have a suspicion that the approach this patch takes would not help very
much in the real life.  You just traded the lack of "precious but ignored"
with "no file is trashable, even if it is listed in .gitignore".

Granted, as long as it is not default, it won't negatively affect people
who do not enable it, other than that it may add maintenance burden on the
resulting bloated code, but I find it hard to swallow new code that does
not convincingly solve the real problem.

By the way, we seem to have a few longstanding bugs that trashes an
unignored and untracked (hence by definition precious) path during branch
switching, and does not give a correct escape hatch.

Doing this:

    $ git checkout maint
    $ echo foo >t/t2018-checkout-branch.sh
    $ git checkout master

does correctly error out because the unignored file needs to be
overwritten.  But doing this after the above still errors out, which is
probably wrong:

    $ echo t/t2018-checkout-branch.sh >>.git/info/exclude
    $ git checkout master

After doing the above:

    $ ed .git/info/exclude ;# remove the extra entry in info/excludes
    $d
    w
    q
    $ rm t/t2018-checkout-branch.sh
    $ echo foo >po
    $ git checkout pu

should error out, as "po" is a directory that has tracked contents, and we
never said the untracked regular file "po" is trashable, but the above
sequence happily checks the branch out.
