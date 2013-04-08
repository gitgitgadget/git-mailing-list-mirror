From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] clone: Fix error message for reference repository
Date: Mon, 08 Apr 2013 08:30:43 -0700
Message-ID: <7vip3xyr8c.fsf@alter.siamese.dyndns.org>
References: <1365376629-16054-1-git-send-email-aaron@schrab.com>
 <20130407234810.GG19857@elie.Belkin> <20130408000658.GG27178@pug.qqx.org>
 <7vhajh15w0.fsf@alter.siamese.dyndns.org>
 <20130408145749.GJ27178@pug.qqx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 18:34:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPF0n-0003oz-MV
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 18:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852Ab3DHPar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 11:30:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32823 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936341Ab3DHPaq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 11:30:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5FA61337C;
	Mon,  8 Apr 2013 15:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ULsQLtSe9UJiQAe0C6ga7S+6zNQ=; b=L3v1xt
	3FG57DB48+AhO35fzqYWNOMTsb5954/ZVpHkBghc45IDNLUvFAnEgFtMi9PUx9do
	wuXjJzwIThpJERj1HB/KsY9tAWyeORnJ1dTTnsm4sDNPJaHwDK6Ths+ycBOsqyCx
	TVZFEyYxJSxLP9y5XLUcQdKfiJjtvloBDg7Wc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GBtL0JllhtkVpAW8Kxv5WoyboxLpvyVi
	7EOIc6PKtXXBptPG+SZcUkOPYlR275E1rJ5sv7rVk5WQ16NKdZmri63mC/oiCQuQ
	xrq0HMCdjSFEw0p+mgffeYhK302ZRhAQkouBi2vrBlC+7FZZ2i+HzwPGEkdiF7lH
	AYf9ljd6hD0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AD841337B;
	Mon,  8 Apr 2013 15:30:45 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C802D13378; Mon,  8 Apr
 2013 15:30:44 +0000 (UTC)
In-Reply-To: <20130408145749.GJ27178@pug.qqx.org> (Aaron Schrab's message of
 "Mon, 8 Apr 2013 10:57:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 479D418A-A061-11E2-AB4E-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220432>

Aaron Schrab <aaron@schrab.com> writes:

> At 06:58 -0700 08 Apr 2013, Junio C Hamano <gitster@pobox.com> wrote:
>>I do agree that it would be nice to dereference .git gitfile when we
>>deal with --reference argument, but you do not want to use in-tree
>>repository of a submodule working tree.  What happens when you have
>>to check out a version of the containing superproject that did not
>>have the submodule you are borrowing from?  The directory will
>>disappear, leaving the borrowing repository still pointing at it
>>with its .git/objects/info/alternates file, no?
>
> No, submodule directories don't get removed when you checkout a
> version which didn't contain that submodule.  

In the old world order, we did not use .git gitfile.

The version of the superproject had a submodule at dirA/ and
dirA/.git used to be a real directory.  "clone --reference
/path/to/super/dirA/.git" can borrow objects from there, and will
write /path/to/super/dirA/.git/objects (which is a real object
store) to the resulting repository's objects/info/alternates.

You switch to a version of the superproject with a plain file at
dirA/ or there is nothing at dirA.  The checkout will fail and you
need to manually rectify the situation [*1*], but after that is
done, you do not have any repository at /path/to/super/dirA/.git
anymore.

That was the reason why I recommended against the practice.

In the new world order, we use dirA/.git gitfile.

"clone --reference /path/to/super/dirA/.git" does not anticipate .git
could be a gitfile, but it can be fixed to dereference it and point
at "/path/to/super/.git/modules/moduleA", which will stay there
across branch switching at the supermodule level.

"clone" has to store /path/to/super/.git/modules/moduleA in
$GIT_DIR/objects/info/alternates of the new repository by
dereferencing the value given to --reference.  By doing so, what is
in the working tree of the superproject would not matter at the time
of access in the new repository.

So you are right that we do not remove in the new world order, but
then --reference can be given to point at the real location ;-)


[Footnote]

*1* ... for which fundamental fix was made to use dirA/.git gitfile
in the submodule working tree in the new world order.
