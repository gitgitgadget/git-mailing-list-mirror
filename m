From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH for-maint] apply: gitdiff_verify_name(): accept "/dev/null\r"
Date: Tue, 23 Sep 2014 14:35:32 -0700
Message-ID: <xmqqoau6gguz.fsf@gitster.dls.corp.google.com>
References: <1411434583-27692-1-git-send-email-lersek@redhat.com>
	<xmqq1tr2jhg2.fsf@gitster.dls.corp.google.com>
	<5421CAA6.3040107@redhat.com>
	<xmqqsijihzrb.fsf@gitster.dls.corp.google.com>
	<5421D8C4.2080009@redhat.com>
	<xmqqfvfihy7i.fsf@gitster.dls.corp.google.com>
	<5421DCE3.9090500@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jordan.l.justen@intel.com,
	matt.fleming@intel.com
To: Laszlo Ersek <lersek@redhat.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 23:35:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWXkL-0000k1-SU
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 23:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbaIWVfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 17:35:37 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61529 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932525AbaIWVfg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 17:35:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 287063C15F;
	Tue, 23 Sep 2014 17:35:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o9vKME3rF4NS54Hq1mnEcFfexhI=; b=RmNRHO
	sge04CO6/qp8atovuTZWyYYoWW1WfkuA6PGetI88xR5SD8B7k7fVzyDT117xTZ9r
	50PxYnbTnkssSb1GFHTPtQiza9OzNwQ/3gAnoyVzdcninkceLAAIy5koYXQHcYbq
	XR2Hg2L8tNPqPQn7h5O5hSBgdayF6M0ARHhcI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CUV8dRIwu9ITXsjb8pxrg+P8rOkXms3W
	mmWkSFl/FwUQL59NoOkgmC7Ze3Ouy0RC3JGhwF+ChWoW7l7cIFJJ8wrLas63AyX4
	QyyCQgetUPHkgCQHFclNetoPU2warPmJfbfWemGmL7qybU/mcWCIkacl6vOADcRS
	xdxmwrDgpJA=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CCD573C15E;
	Tue, 23 Sep 2014 17:35:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CE3AE3C15B;
	Tue, 23 Sep 2014 17:35:33 -0400 (EDT)
In-Reply-To: <5421DCE3.9090500@redhat.com> (Laszlo Ersek's message of "Tue, 23
	Sep 2014 22:49:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8CAA007C-4369-11E4-B120-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257445>

Laszlo Ersek <lersek@redhat.com> writes:

> In summary:

This is not entirely correct, though.  But it suggests an avenue for
a possible enhancement.

> - the email infrastructure turns all line terminators into CRLFs

Yes, but that is within MTAs and is expected to be invisible at MUA
level.  Typically mailbox files are stored in platform's native
format (e.g. I see LF endings in my mailbox), be it CRLF of LF.

The important thing to note here is that use of text/plain for
patches, if you want to have distinction between CRLF and LF in your
payload, is not designed to work over e-mails.

> - git-am strips these by default, from source code lines and from git
>   diff header lines alike,

On a platform whose native line endings are LF, the stripping may
not even happen (i.e. "am/apply" may not see CRLF in the mailbox in
the first place).

On a platform whose mbox has CRLF, or if you "unix2dos" a mbox on a
platform whose mbox has LF to manufacture a mbox with CRLF line
endings, you would have an opposite issue.  Information is lost in
MTAs while your e-mail is in transit and you cannot tell patch to
which paths had CRLF line endings and patch to which paths had LF
line endings.  If all files you are tracking uniformly use CRLF, you
can assume that everything had CRLF but it is still an assumption
and that is a special case that is not particularly interesting.

Applying such a CRLF patch with your "/dev/null\r\n" patch applied
to "am" will _add_ unwanted CR before LF to files that are meant to
use LF line endings.

Now if we accept that this issue is coming from lossy nature of
transporting patches via e-mails, we would realize that the right
place to solve this is not in "apply"'s parsing of structural part
of the "diff" output (e.g. "diff --git ...", "rename from ..." or
"--- filename"), but the payload part (i.e. " " followed by context,
"-" followed by removed and "+" followed by added).  Removal of CR
by "am -> mailsplit -> mailinfo -> apply" callchain is not losing
any information, as the input does not have useful information to
let us answer "are the lines in this path supposed to end with
CRLF?" in the first place; "/dev/null\r" patch is barking up a wrong
tree.

Our line-endings infrastructure (e.g. core.autocrlf configuration
variable, `eol` attribute) is all geared toward supporting cross
platform projects in that the BCP is to use LF line endings as the
canonical line endings for in-repository data and convert it to CRLF
for working tree files when necessary.  We do not have direct
support (other than declaring contents for paths as "binary" aka "no
conversion") to use CRLF in in-repository data (and that is partly
deliberate).

But it is conceivable to enhance the attribute system to allow us to
mark certain paths (or "all paths", which is a trivial special case)
as using CRLF line endings in in-repository and in-working-tree.  It
could be setting `eol` attribute to `both-crlf` or something.

Then "am -> mailsplit -> mailinfo -> apply" chain could:

 * "mailsplit" and "mailinfo" does not have to do anything special,
   other than stripping CR and make sure "apply" only sees LF
   endings;

 * "apply" is taught a new option "--fix-mta-corruption" which
   causes it to pay attention to the `eol` attribute set to
   `both-crlf`, and when it reads a patch

	diff --git a/one b/one
        --- one
        +++ one
        @@ -4,6 +4,6 @@
         common1
	 common2
        -old1
        -old2
        +new1
        +new2
         common3
         common4

   and notices that path "one" is marked as such, it pretends as if
   the input were

	diff --git a/one b/one
        --- one
        +++ one
        @@ -4,6 +4,6 @@
         common1^M
	 common2^M
        -old1^M
        -old2^M
        +new1^M
        +new2^M
         common3^M
         common4^M

   to compensate for possible breakage during the mail transit.

 * "am" is taught to pass "--fix-mta-corruption" to "apply" perhaps
   by default.

Because code paths that internally run "git am", e.g. "git rebase",
work on data that is *not* corrupt by mta (we generate diff and
apply ourselves), these places need to tell "am" not to use the
"--fix-mta-corruption" when running "apply".
