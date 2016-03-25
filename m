From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] submodule--helper list: lose the extra prefix option
Date: Fri, 25 Mar 2016 10:25:04 -0700
Message-ID: <xmqqh9fu4gi7.fsf@gitster.mtv.corp.google.com>
References: <1458862468-12460-1-git-send-email-sbeller@google.com>
	<1458862468-12460-4-git-send-email-sbeller@google.com>
	<xmqqmvpn5awo.fsf@gitster.mtv.corp.google.com>
	<xmqqegay5yw0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, Jens.Lehmann@web.de,
	jacob.keller@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 18:25:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajVU5-0007cZ-1C
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 18:25:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820AbcCYRZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 13:25:09 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:55297 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753853AbcCYRZI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 13:25:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D75774E7E4;
	Fri, 25 Mar 2016 13:25:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YONVWuxTQZogagnJDG3A0dAtvXk=; b=tEiIN3
	V40VENRn1HE4OpyuM4Ed7pU09eZ2HzmfKfSZVAJkXe1Ddizp2sInwikcBxle+p5F
	C+J+sAwICXzUaYooVW42I4RPSNbBre03CgqtqRAEKee7DkKdf4DdN3B9ZVY6mKsK
	DxIJgiDFOvEO2R4nskbCHfp2E98cu3Tr01a+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K+MYm6Ov7MBm6BxuG4x3n5A7C7TAliiC
	nHUgiHFji2ILtaglwVeDKWlkqKQEOqRqSlSbuqQNYYR3DaXqksm8E3Ye0Xc7gnrw
	ZP4ijO+jB6ayPBkQRWfUY6R4cvD9eElAWchxyK7Q9E1RIv1ZIr7Y/chp/Tgk+XdL
	vhUY7XJAErA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CDC534E7E3;
	Fri, 25 Mar 2016 13:25:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 18D5D4E7E2;
	Fri, 25 Mar 2016 13:25:06 -0400 (EDT)
In-Reply-To: <xmqqegay5yw0.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 25 Mar 2016 09:02:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 843872F2-F2AE-11E5-BA5F-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289910>

Junio C Hamano <gitster@pobox.com> writes:

> The way all the subcommand written in C works is
>
>  - The start-up sequence does the repository discovery, which
>    involves crawling up to the top-level of the working tree, and
>    compute "prefix", where the end-user was when the command was
>    invoked;
>
>  - The subcommand implementation is called with this "prefix";
>
>  - When the subcommand implementation interprets the command line
>    arguments and option arguments, it prefixes the "prefix" as
>    needed.  If, for example, "git grep -f patterns" is invoked
>    inside "sub/" subdirectory, when the command line and option
>    arguments are processed, the process is already at the top level
>    of the working tree, so it needs to read the patterns from
>    "sub/patterns" file.  "git ls-files 'Makefil*'" invoked inside
>    "sub/" subdirectory needs to limit the output to those that match
>    not "Makefile", but "sub/Makefil*".
>
> The hope of doing an incremental rewrite of the whole thing by
> enriching submodule--helper is that the bulk of the code there will
> be reusable when the entirety of "git submodule" is rewritten in C,
> so they need to take the "prefix" the same way, whether the caller
> is calling from "git-submodule.sh" script via submodule--helper, or
> the eventual C implementation of "git submodule" is making direct
> calls to them.  As long as the correct "prefix" is passed to the
> routines that are driven via submodule--helper, it does not matter
> and I do not care how it is done.
>
> The current code of "git submodule" whose higher parts are still in
> shell would would:
>
>  - The start-up sequence in shell does the cd_to_toplevel and finds
>    the prefix;
>
>  - "git submodule--helper list --prefix=$prefix $other_args" is
>    called; as this is called from the top-level of the working tree,
>    internally its "prefix" is empty, but $other_args must be
>    interpreted relative to the $prefix passed with --prefix option.
>
> If we instead call "git -C "$prefix" submodule--helper list $other_args",
> then
>
>  - This command first does another chdir(2) back to $prefix;
>
>  - The start-up sequence of "submodule--helper" does the usual
>    repository discovery again, which involves crawling up to the
>    top-level of the working tree, and compute "prefix".  This
>    happens to match what -C "$prefix" gave the command.
>
> Making calls to submodule--helper via "git -C" feels a little bit
> roundabout because of this "caller tells to chdir, and then it has
> to again chdir back up" only to rediscover the same information.

Just to make sure that the discussion is complete.

Another way a script can use the "prefix" information is to use the
"prefix" as such.  Knowing that the cd_to_toplevel() took you to the
root level of the working tree, instead of "git -C $prefix" or
"--prefix $prefix", it could do "git $cmd $prefix$filename".

One consideration when choosing among the approaches is how the
$filename is reported back to the user (e.g. as part of an error
message).  "git $cmd $prefix$filename" invocation would complain
about the full "$prefix$filename" path, but what the user gave it
may only be $filename part.
