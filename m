From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Strangeness with git-add and nested repositories
Date: Thu, 28 Apr 2016 09:39:42 -0700
Message-ID: <xmqq1t5p7kmp.fsf@gitster.mtv.corp.google.com>
References: <CAH6n4TdG9LQOPaaw_H6vuCgia0-4JXhPsSiAJPa5GtjfduQoSw@mail.gmail.com>
	<CAGZ79kZhATfP1FpXnhivCa_Az-3KADSCReOo68E2Q3s29x5HNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andrew J <andj2223@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 18:39:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avoyk-0001vz-Ts
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 18:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561AbcD1Qjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 12:39:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63036 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752201AbcD1Qjq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 12:39:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 67C4114EA5;
	Thu, 28 Apr 2016 12:39:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c1jLL9YJTA3oZKzYqP4QE5To0iU=; b=XzQ6H2
	Ik7KOfyBLsSnVHDpm1UkqfBkbQNalvmUGKcFoJTkVhH1zFja1VvIq81fsFU3xcR2
	7y4FsdbLSaDC0bSfzO+RrZbmcY8BDGad8bE4B9pt0/IsXiOcPLIPryTnZkudAGEl
	ozTJlZgqdzB/KD2N2TaLS/0Yr5NDqoF2ESYiA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G6IZ7cQB1dT98Y9WQJSPBKbI6D/pzJ8A
	D30C2ursX2qo83oezr46mDZlsp9jceBvw0iho2rLOA+zaO5KhuzlCAPeI52k+/Pd
	F+W5zX0vthTEX9lrqSa8vClaOFjdtyik7nakOZj2UAAbm3zRBhHHSjD6//nUexps
	lp8hbZjO0FA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 57CAB14EA4;
	Thu, 28 Apr 2016 12:39:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C27B514E9F;
	Thu, 28 Apr 2016 12:39:43 -0400 (EDT)
In-Reply-To: <CAGZ79kZhATfP1FpXnhivCa_Az-3KADSCReOo68E2Q3s29x5HNw@mail.gmail.com>
	(Stefan Beller's message of "Wed, 27 Apr 2016 09:08:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CFA43804-0D5F-11E6-82CD-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292917>

Stefan Beller <sbeller@google.com> writes:

> I think (pure speculation), that it the error is in the context
> (repository) switching logic.
> What happens if you alter the order, i.e. give testfile first and then
> the files in the nested
> repos?
>
>     git add -- file path/to/subdir/file
>
> should do internally IMHO:
>
>     git add file
>     git -C path-to-subdir add file

My undertanding of what _should_ happen in the world order as
currently defined (not necessarily implemented) is:

 * "git add -- A B" must work the same way as "git add -- B A" and
   "git add -- A; git add -- B"

 * "git add -- path/to/subdir/file", when any of path/, path/to/,
   path/to/subdir/ is a Git repository that is different from the
   current Git repository, must fail.

IOW, if 'path' is a repository (whether it is known as a submodule
to the repository whose working tree contains it, or it is an
untracked directory from the containing repository's point of view),
the index of the containing repository cannot get path/$anything in
it.  If you managed to do so, you found a bug [*1*].

path/.git/index can of course have "to/subdir/file" in it, and from
that point of view, "git -C path/to/subdir add file" may one day
become an improved world order.  It is just we haven't discussed
that possibility or reached concensus that it is a good idea.


[Footnote]

*1* Of course, some of the bugs in this class may fundamentally be
    unfixable and would fall into the same category as "doctor, it
    hurts when I do this--don't do it then".  For example, you may
    treat path/ as the top of the working tree of another repository
    whose git-dir is not at path/.git by arranging GIT_WORK_TREE and
    GIT_DIR environment variables, but you may do so only when you
    actually are accessing the contents of path/ as its own project.
    And when you are using the enclosing project (whose .git/ would
    sit next to path/), there is no way for "git add path/to/file"
    to know that everything under "path/" does not belong to the
    current repository and instead it is part of the project rooted
    at path/, which is an obvious example of "fundamentally
    unfixable" case.
