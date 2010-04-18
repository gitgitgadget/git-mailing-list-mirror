From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] stash bug: stash can lose data in a file removed
 from the index
Date: Sun, 18 Apr 2010 16:11:15 -0700
Message-ID: <7vvdbotkz0.fsf@alter.siamese.dyndns.org>
References: <20100418182749.GA29329@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Jeff King <peff@peff.net>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Mon Apr 19 01:11:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3deX-0000y2-KV
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 01:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757287Ab0DRXLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 19:11:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34209 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662Ab0DRXLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 19:11:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FE03AC9F0;
	Sun, 18 Apr 2010 19:11:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=NYGpL5vpNKyqNoRLoT2ifi61IQ4=; b=lwEY8hYXVDdpm9ruueZXspO
	zhfMf3sIxq+KBVDjpKSPckNSep9MS0JGet5S9CgT5qlws8nJ4p46Ttp843j95K4M
	RUXGQpY7aF1Yij9IKz0qGplfF9fLr1uAD7EYSHbV5n3vwGzYNiz8DK45dHRq1RBT
	kNox96mN5Bnw7ajcAgms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=BQeH93tr1xu4lT1AkvAIYMyDcLZUvvgzSG5//sQZFLrHy5Rd6
	cRGGsWf7+yuNip2tVMrkQwVfDs/LOJ/fHTy+bPTbFt6lA6vWwiZN6D3ltz/UYpvO
	fJqJ1C8duzKio11XU2hFFVWbMylhMQsW5p0/SG22XrclDUzLjFVAkjmuXM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D36EAC9EE;
	Sun, 18 Apr 2010 19:11:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4843CAC9EC; Sun, 18 Apr
 2010 19:11:16 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B37F5584-4B3F-11DF-8BB9-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145256>

Charles Bailey <charles@hashpling.org> writes:

> +test_expect_success 'stash file to symlink' '
> +	git reset --hard &&
> +	rm file &&
> +	ln -s file2 file &&
> +	git stash save "file to symlink" &&
> +	test -f file &&
> +	test bar = "$(cat file)" &&
> +	git stash apply &&
> +	test -f file &&
> +	test file2 = "$(readlink file)"
> +'

It is likely that this needs to be protected with SYMLINKS prerequisite.
Also I am a bit unhappy about the use of "readlink" which is not even in
POSIX.1 here.  We already have one use of it in the tests but that only
happens while doing valgrind.  Traditionally this has been more portably
done by reading from "ls -l file", like so:

	case "$(ls -l file)" in *" file -> file2") :;; *) false;; esac

Also, whether "readlink file" or "ls -l file" is used to check the result,
the "test -f file" is redundant.

> +test_expect_failure 'stash directory to file' '
> +	git reset --hard &&
> +	mkdir dir &&
> +	echo foo >dir/file &&
> +	git add dir/file &&
> +	git commit -m "Add file in dir" &&
> +	rm dir/file &&
> +	rmdir dir &&
> +	echo bar >dir &&
> +	git stash save "directory to file" &&
> +	test -d dir &&
> +	test foo = "$(cat dir/file)" &&
> +	test_must_fail git stash apply &&
> +	test bar = "$(cat dir)" &&
> +	git reset --soft HEAD^
> +'

I have a feeling that this test is being a bit unfair.

What should a successful invocation of "stash apply" leave in the working
tree in this case, especially when you consider that in a real life use
case you may have other files in "dir" directory or changes to "dir/file"?
