From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/4] git mailinfo: added a --recode-patch parameter
Date: Mon, 29 Nov 2010 12:23:41 -0800
Message-ID: <7veia33mlu.fsf@alter.siamese.dyndns.org>
References: <1290971417-4474-1-git-send-email-r0bertz@gentoo.org>
 <1290971417-4474-4-git-send-email-r0bertz@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "ZHANG\, Le" <r0bertz@gentoo.org>
X-From: git-owner@vger.kernel.org Mon Nov 29 21:24:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNAGi-0001ZM-Pa
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 21:24:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475Ab0K2UXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 15:23:50 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47836 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250Ab0K2UXt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 15:23:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A34063781;
	Mon, 29 Nov 2010 15:24:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=JW2ZJJV4/9YXOrNElc9a24uwoS8=; b=W3T+nzGaqE3k0dlT8vbpF+R
	7poour05GpY44UuQxEsWShIXNwIvtIiAozX74ESRhCmtahFlvbyZ0wqz8zpJcj2Q
	BSFnzNBYxxepjrzCNj+wm0ijWcqep5bSeZ2uDrcyDstiWs9CMTIKnCLToO2EysLa
	mWfx6CZ3iR4Fdp9zV+38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=xR7XKOIb+NeePVPjW66+nPxFAa84zGZCwGdNjk9jFsZdCNQ8D
	RUXRwInpQHfWw6dOgAjrlFRs6KQboXnJvTqd33aLfLhsWPnxPZGhMyHIA4koIQjN
	ER4/IDMcf0qed9Q6XRn6kZxywbV81oMKsSmpVjcumlbyZOGoy984X9+r/k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8141E3780;
	Mon, 29 Nov 2010 15:24:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3898C377B; Mon, 29 Nov 2010
 15:24:00 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9C28553A-FBF6-11DF-8191-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162424>

"ZHANG, Le" <r0bertz@gentoo.org> writes:

> When this parameter is specified, patch will be converted to a target
> encoding before applied.  The target encoding defaults to UTF-8. It
> could also be specified by i18n.patchencoding.
>
> Signed-off-by: ZHANG, Le <r0bertz@gentoo.org>
> ---

Ah, please forget (most of) what I said in my review of 2/4.  This series
is not about incoming e-mails that misidentify their content encoding, but
is about accepting patches from e-mails that are in different encoding and
correctly says which encoding they are in.  We make mailinfo convert the
payload to UTF-8 or "i18n.patchencoding".

The above is a clear indication that "i18n.patchencoding" is grossly
misnamed.  It sounds as if it is about the encoding of patches, and
because we are discussing "mailinfo", I mistook that is about the encoding
used in the incoming patches.

But it is not.

It is about encoding of blobs and paths used in the repository.  With your
series, the mailinfo codepath that deals with incoming patches happens to
become the first user to pay attention to the repository data encoding,
but that is not a good reason to name it "i18n.patchencoding".

In the longer run, it is entirely plausible that we will want to know
about different encodings used for these things:

 - encoding in which blobs and tree paths are stored in the repository.
   This is what you called "i18n.patchencoding".

 - encoding in which the log messages of the commits are stored in the
   repository.  We have "i18n.commitencoding" variable for that.

 - encoding in which incoming patches are given to "mailinfo".  This is
   read from the e-mail message.

 - encoding in which blobs are checked out to the working tree.  In a
   distant future, we may want to re-encode blobs from the repository
   encoding to this encoding while checking out, and the other way while
   checking in.

 - encoding in which readdir(3) returns paths from the working tree.  In a
   distant future, we may want to re-encode paths from the repository
   encoding to this encoding while checking out, and the other way while
   checking in.

I think as a short-term solution to your immediate issue, your series may
be good enough, but if we are to go this route, we really should make it
"the repository encoding".  And the variable that replaces your
"patch_charset" should be declared in cache.h, defined in environment.c,
parsed by git_default_config(), and be accessible to everybody.

An alternative is to use i18n.commitencoding for that purpose, but that
will cause issues with existing repositories---they have been happy
without us recoding the payload, and they will get upset if we suddenly
start doing so.  So I'd say that a new "i18n.repositoryencoding"
configuration variable and repository_encoding variable would be a better
design in the longer term.  They

 (1) default to "binary" (or "bytestring", "literal", "verbatim",
     whatever) to tell us _not_ to do any encoding conversion to the
     contents when accepting patches, generating patches, checking out,
     checking in, or running git-archive; and

 (2) when set, certain operations will pay attention to it; in your
     situation, "mailinfo" will convert incoming e-mails to its value
     (presumably "UTF-8").

Yet even longer term, we probably would need to make the blob encoding
into an attribute to the path (e.g. think about an i18n documentation
project, where different translations may need to be stored in different
encodings).

This will open another big can of worms, though.  Unless the incoming
e-mail is split into a MIME multipart that contains one-patch per file
with each part in different encoding, a single plaintext message needs to
be in a single encoding, so your mailinfo patch would most likely need to
encode to one canonical encoding (i.e. "UTF-8"), and then reencode to per
path encoding when feeding the patch.  Then there is another issue of what
to do with the tree paths that appear in "diff --git" and "rename from ..."
headers which most likely to be a single canonical encoding in the project.

But we need to start from somewhere, so let's make the first step "a
single project wide blob and tree path encoding".

Opinions?
