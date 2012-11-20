From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] git-submodule add: Add -r/--record option
Date: Mon, 19 Nov 2012 16:49:09 -0800
Message-ID: <7vd2z9t7y2.fsf@alter.siamese.dyndns.org>
References: <20121117153007.GB7695@book.hvoigt.net>
 <20121117192026.GI22234@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Tue Nov 20 01:49:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tac1u-00082R-5f
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 01:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189Ab2KTAtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 19:49:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55734 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753049Ab2KTAtO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2012 19:49:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1118660C6;
	Mon, 19 Nov 2012 19:49:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=PeM3BgaezGhnCmt2z1h023yHtWI=; b=Ai4eoIJIWCVjcdU8Ghfo
	SkkT16hGLZ4Sl7aQQEQiC9GimciUaEMyUHWz8BoJjh6Dnz8/4kgI8QDLkU811YQe
	60D6ex9XBLH/zk2vW41RaLif12KrSTDMcZGGoS9N6JeZTvbUwKrLh3ufGlXXamF8
	VKRG5iQUOoi+Gfifv+768SM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=pSL38xRM+Vua6/J7bGy10UgM8nuq6rXD25sSALNd8+p+YY
	jmLXZy0vLlY/TLl2jG+McMq1p+YgwEQJ33FBcXoP8zldFCmNwS4noLRCeFtPahT6
	Bz8gFsBgTknzFrI1RhFaR4BmgaqG8W1YqO60+zUZbLJi1Zsa55nStIgoyEdFA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF32260C5;
	Mon, 19 Nov 2012 19:49:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A132F60BD; Mon, 19 Nov 2012
 19:49:10 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 18D746B6-32AC-11E2-B02F-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210073>

"W. Trevor King" <wking@tremily.us> writes:

>> From what I have heard of projects using this: They usually still have
>> something that records the SHA1s on a regular basis. Thinking further,
>> why not record them in git? We could add an option to update which
>> creates such a commit.
>
> I think it's best to have users craft their own commit messages
> explaining why the branch was updated.  That said, an auto-generated
> hint (a la "git merge") would probably be a useful extra feature.

I am not quite sure I agree.  When the project says "Use the tip of
'bar' branch for the submodule 'foo'" at the top-level, does an
individual user who is not working on the submodule 'foo' but merely
is using it have any clue as to why the submodule's 'foo' branch
'foo' moved, or does he necessarily even care?

For such a user working at the top-level superproject, or working on
one part of the project, possibly on a submodule other than 'foo',
wouldn't the natural thing to do would be to run "git pull" at the
top-level, maybe with "--recursive" to update the top-level and all
the submodules to start the day.

Now, since somebody created the top-level commit you have just
pulled and checked out, other people may have worked on submodule
'foo' [*1*].  What should happen on "git submodule update foo"?  It
would notice that the submodule 'foo' is set to float, and would
check out the tip of the branch 'bar', not the commit recorded in
the top-level superproject, in the working tree for 'foo', no?

What should appear in "git diff"?  The working tree taken as a whole
is different from what the superproject's commit describes (which is
the state the person who created the superproject wanted to record)
even though this user does not have anything to do with the change
at 'foo' from the recorded commit to the current tip of 'bar'.  What
would his description for the reason why the branch was updated?

I think I would agree that "git diff" should not hide such changes
(after all, when this user records his change to the overall project
in the top-level supermodule, he will be recording the state with
the commit at the tip of 'bar' checked out in the working tree of
the submodule 'foo'), but I am not sure if the user can say anything
sensible, other than "tip of 'bar' branch in submodule 'foo' was
changed by others", in the resulting commit.


[Footnote]

*1* This may look like a non-issue if you assume that the person who
updates the 'bar' branch of submodule 'foo' always updates the
gitlink in the superproject's commit to point at that updated
commit, but that assumption is flawed; the submodule project is a
project on its own and can be worked on without what other projects
bind it as their submodules.
