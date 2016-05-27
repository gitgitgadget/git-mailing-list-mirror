From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/2] rev-parse: fix some options when executed from subpath of main tree
Date: Fri, 27 May 2016 11:50:35 -0700
Message-ID: <xmqqa8jbqqro.fsf@gitster.mtv.corp.google.com>
References: <1464261556-89722-1-git-send-email-rappazzo@gmail.com>
	<1464261556-89722-3-git-send-email-rappazzo@gmail.com>
	<20160526132611.GA2736@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Rappazzo <rappazzo@gmail.com>, git@vger.kernel.org,
	pclouds@gmail.com, szeder@ira.uka.de, sunshine@sunshineco.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri May 27 20:50:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6MqJ-0001RO-Q4
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 20:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754998AbcE0Suj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 14:50:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52038 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754774AbcE0Suj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 14:50:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 176501EA4E;
	Fri, 27 May 2016 14:50:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MCrKMAbhkla8vn3YQqinP9OpAak=; b=mm4Djl
	LrEfMkCHS1YVJy5H+Ih2sMpmC1nDS4mRVwEYzKZ8lth1E96OBrlX51RVfyBMneoI
	Hjx6XptpRaXzJQUWOXsXleE8DiSEqJeAMLIP6sIWqw47zt7RwVIKs5YFA+825FGw
	F88nV2JIe88b5PmaDB7PyZWiZEupdYCaH0vsA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HAL8fgtAG2H2ss2a1ulH9njPvkq6F32y
	jOtIfGeMwPxwnISehTKR7+G8abE3wtft5Axv86XlQ/Jr5i99EE3jH4FPivuSdXAG
	1jb776vMot6mjT6fg0zMqBIQt5azz/hiNyHhlClTL2sNlN6YyeDfaajorqpM5vNW
	NQ9kGe6yAO8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 07C511EA4D;
	Fri, 27 May 2016 14:50:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6D0621EA4C;
	Fri, 27 May 2016 14:50:37 -0400 (EDT)
In-Reply-To: <20160526132611.GA2736@glandium.org> (Mike Hommey's message of
	"Thu, 26 May 2016 22:26:11 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E6CBD27E-243B-11E6-9C09-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295785>

Mike Hommey <mh@glandium.org> writes:

> On Thu, May 26, 2016 at 07:19:16AM -0400, Michael Rappazzo wrote:
>> Executing `git-rev-parse` with `--git-common-dir`, `--git-path <path>`,
>> or `--shared-index-path` from the root of the main worktree results in
>> a relative path to the git dir.
>> 
>> When executed from a subdirectory of the main tree, it can incorrectly
>> return a path which starts 'sub/path/.git'.  Change this to return the
>> proper relative path to the git directory.
>> 
>> Related tests marked to expect failure are updated to expect success
>
> As mentioned previously (but late in the thread), I don't get why this
> one case of --git-common-dir should not return the same thing as
> --git-dir, which is an absolute directory. Especially when there is
> other flag telling you whether you are in the main or another worktree,
> so comparing the output for --git-dir and --git-common-dir is the
> easiest way to do so, but then you have to normalize them on their own
> because git returns different values pointing to the same directory.

Sounds like a sensible line of thought.

A possible/plausible counter-argument from Michael's side that would
be equally sensible might run along the lines of:

    An expected use of "git rev-parse --commit-dir" is to store the
    output in $GIT_DIR/$X so that the layout the worktree machinery
    expects can be set up by scripted Porcelains without using "git
    worktree".  Making the value stored in $GIT_DIR/$X relative to
    $Y would help for such and such reasons.

While making it easier to build a competing UI like that is a
sensible goal, I do not think of what that $X or $Y are, and I do
not think of what that "such and such reasons" are, either.

And the cost of having to compare absolute --git-dir output with
relative --git-common-dir (i.e. the justification for Mike's
proposal to make --git-common-dir absolute) and the cost of having
to turn absolute output from --git-common-dir to a path relative to
$Y (i.e. the justification of making it relative in the hypothetical
counter-argument) would be about the same, so it does not sound very
compelling after all.
