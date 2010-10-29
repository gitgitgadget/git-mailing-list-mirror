From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: support --root --cached combination
Date: Fri, 29 Oct 2010 10:06:07 -0700
Message-ID: <7vhbg56i9s.fsf@alter.siamese.dyndns.org>
References: <1288346087-20263-1-git-send-email-pclouds@gmail.com>
 <20101029101959.GA27662@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 19:06:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBsPI-0001Vq-AP
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 19:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427Ab0J2RGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 13:06:19 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59687 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524Ab0J2RGR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 13:06:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A5001F11;
	Fri, 29 Oct 2010 13:06:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZWkQJ9P7hWQO4tyDYImysmUeIbQ=; b=hDhjxk
	BgnzMl6pVbIQq0lj2NH0IW+oLr0omnsXc/NPmsUlCKniI+/ngCDi3fc9G+h8SBeo
	f6cJ33Y+y6ewyi4Q7JL1w25YLPwhXvArdQpdmQQKtSPXwT9Ym/Sd1DV58etm44o/
	mk7nKTEvI1Ju/HmiOvx/JK23vdjsO/BlKcVls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ysp/VbZ+i/o3HO6bhaleFKgCKqCATuQC
	dl+keVAceOxX9pvlvhopK4xTmnFBN9YWfPdJcd2gXg6aZow9MaYJ8upb7aaSqZ8+
	QdqgHahv0FmroB4XzPCrXurBE3NWzWpFTRJDxawrojTBUwDMvSpaO2sYm/AybYmj
	jg0QcU40o2Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C93631F0D;
	Fri, 29 Oct 2010 13:06:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D4A621F0C; Fri, 29 Oct
 2010 13:06:08 -0400 (EDT)
In-Reply-To: <20101029101959.GA27662@burratino> (Jonathan Nieder's message of
 "Fri\, 29 Oct 2010 05\:19\:59 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D545705E-E37E-11DF-B4E9-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160341>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Using --root as the backward-compatibility option seems like
> an abuse of language, anyway.  "git diff --cached" has two
> meanings:
>
>  1. show changes to be committed
>
>     1b. show what git show --format=" " would say after a commit
>
>  2. show differences between the index and the commit named by the
>     (implicit) HEAD argument
>
> With interpretation (1b), --root should be respected, and the output
> should be empty (!), not an error, when "[log] showroot" is false.
>
> With interpretation (2), --root should not be respected, and an
> attempt to diff --cached in an unborn branch should be an error.
>
> (1a) and (1b) are the only useful interpretations.  So for simplicity,
> would it make sense to drop the "if ()" for --root and make
>
>> +test_expect_success 'diff --cached' '
>> +	test_must_fail git diff --cached
>> +'
>
> fail?

I don't see 1a up above, but I agree.

Let's explain the patch this way (yes, I am writing a proposed commit log
message Duy should have written):

    "git diff --cached" (without revision) used to mean "git diff --cached
    HEAD" (i.e. the user was too lazy to type HEAD).  This "correctly"
    failed when there was no commit yet.  But was that correctness useful?

    This patch changes the definition of what particular command means.
    It is a request to show what _would_ be committed without further "git
    add".  The internal implementation is still the same "git diff
    --cached HEAD" when HEAD exists, but when there is no commit yet, it
    compares the index with an empty tree object to achieve the desired
    result.

Unlike "diff-index --cached HEAD" that must fail when HEAD does not name a
valid rev, we do not have to be so strict in "git diff" Porcelain,
especially when the end user does not even explicitly say HEAD.

To put it in another way, we should strive to define the behaviour of the
plumbing precisely in terms of the mechanism and machinery (e.g. if you
ask for an operation between a tree and the index, and if you incorrectly
specified the tree, you _should_ get an error, instead of a result that
somebody randomly chose, saying "we thought it would be more useful for
you this way").  But we should try to define the behaviour of the
Porcelain commands in terms of the use case and the workflow we try to
encourage and support.
