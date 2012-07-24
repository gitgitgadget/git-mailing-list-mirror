From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: Recursive submodules fail when the repo path contains
 spaces
Date: Tue, 24 Jul 2012 13:26:04 -0700
Message-ID: <7va9yogb37.fsf@alter.siamese.dyndns.org>
References: <1CE02EC2D88646D48EE7B7D71AD36234@gmail.com>
 <500F00C7.4040209@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Justin Spahr-Summers <justin.spahrsummers@gmail.com>,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 22:26:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StlgO-00039C-BM
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 22:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755547Ab2GXU0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 16:26:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57525 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755426Ab2GXU0I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 16:26:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 072A56A9A;
	Tue, 24 Jul 2012 16:26:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LeYrmOFkIq17m61NiCkLEc9E66o=; b=gxwoJg
	EfGGqVv6G7wbxWL2kRWvoQQ6J7HDVpX8DP8wEOxvVd/Ihrb2iludJ5Q6jdS82wjv
	iR0DIkpPwvwkp/2gQKkfiGZ/71Gzv3eYn6m/NbqMK9k1iKaa4zQs8bC/IhFFT203
	n0B+32Rk8jjKwB+0lmnpsg8L6Casw3qHIYW9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FPuYka//WZRKxOBoGBLm43tkcUX2mBEa
	4avMlSGiKcNVQjnEl0oq4ujhbajWqTUDTqOthfqSODKL/4c1UZc5uGySJc6V/cfK
	Lj4aPaNJTpbmrA33lQZlbXQf9mnH3+w//nyAM2BpVrj1yeB8r+raVwnbRAwY7Oy2
	e46llCc08Kw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E82706A98;
	Tue, 24 Jul 2012 16:26:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8BC126A97; Tue, 24 Jul 2012
 16:26:05 -0400 (EDT)
In-Reply-To: <500F00C7.4040209@web.de> (Jens Lehmann's message of "Tue, 24
 Jul 2012 22:08:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CBC975B4-D5CD-11E1-90CD-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202065>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 24.07.2012 21:01, schrieb Justin Spahr-Summers:
>> This occurs on Mac OS X 10.7.4, on git versions 1.7.10.2 (Apple Git-33) and 1.7.11.3.
>> 
>> Steps:
>>  1. Create or clone a repository to an absolute path that contains spaces.
>>  2. Add a submodule to the repository, if it does not already have one.
>>  3. Within that submodule, attempt to add another submodule.
>> 
>> The result is an error "fatal: Not a git repository", followed by the relative path to the submodule directory within .git/modules of the top-level repository.
>> 
>> Similarly, using "git submodule update --init --recursive" in a freshly-cloned repository that matches the above configuration will fail with the same error. "git clone --recursive" does not seem to suffer from the same problem at clone time, but will still fail to add recursive submodules.
>
> Hmm, I don't understand how that is different from what t7407 does, it uses
> "git submodule update --init --recursive" in to populate recursive submodules
> in a freshly cloned repository whose path contains a space (in the trash
> directory name) in test number 8.

I can see one codepath that would behave incorrectly, especially if
the submodule path relative to the superproject has whitespaces in
it.  In module_clone(), you have:

	# We already are at the root of the work tree but cd_to_toplevel will
	# resolve any symlinks that might be present in $PWD
	a=$(cd_to_toplevel && cd "$gitdir" && pwd)/
	b=$(cd_to_toplevel && cd "$sm_path" && pwd)/
	...
	# Turn each leading "*/" component into "../"
	rel=$(echo $b | sed -e 's|[^/][^/]*|..|g')
	echo "gitdir: $rel/$a" >"$sm_path/.git"

I _think_ $sm_path is computed correctly by the codeflow leading to
this place, and $b is also computed correctly, but notice the lack
of quoting around $b when you echo it?  It will be split at $IFS, so
if b='/Program Files/My  Stupidity/', the sed script will see a
single SP between My and Stupidity, which is different from what you
wanted to feed, I presume.

Having said that, I do not think git-submodule is prepared to take
paths with path-unsafe characters in it, given that many part of it
has loops like "while read mode sha1 stage sm_path" that reads from
ls-files/ls-tree output without -z (which means it cannot handle
pathnames with LF in them).

My recommendation at this point (i.e. not a long term) for people
with problems Justin saw is "Don't do it then".
