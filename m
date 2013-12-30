From: Junio C Hamano <gitster@pobox.com>
Subject: Re: aborted 'git fetch' leaves workspace unusable
Date: Mon, 30 Dec 2013 11:37:25 -0800
Message-ID: <xmqq8uv2ruyy.fsf@gitster.dls.corp.google.com>
References: <7adcf8024c435b9b7178b86f01e447bb@stephe-leake.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: stephen_leake@stephe-leake.org
X-From: git-owner@vger.kernel.org Mon Dec 30 20:37:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vxiec-000556-47
	for gcvg-git-2@plane.gmane.org; Mon, 30 Dec 2013 20:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119Ab3L3Th3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Dec 2013 14:37:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36059 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932094Ab3L3Th3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Dec 2013 14:37:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 473BC5F6D7;
	Mon, 30 Dec 2013 14:37:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XYJDy3cdWrSyYzD4BmicikA/w7Y=; b=myyWKC
	o3OupGzbSHVs2JDOo/b4yoGMk1vaB3XalZEqZRgT/ejb+ioCPff0zsViNwDq7cTU
	GSEvIpnJgBLJ0sto2v1WTBraXuLqBI4aP5k9gGgY0QK/wyjFF7NKy7qEWmjbNtnt
	5U6UGx3oaDhp0Vc6VfiG3aQIs/M9+NFtG1NkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TBQyT7OSQEjocSDNuaHRPv+EVZk8+279
	IiTeTl21aNCcOJ8Khsb9TZlg8LbiuxUbhFUUqc62wvX5YStA2fb0yw/ZVDfujlDF
	U41lvvs0LtqaAGYdH9Qk4pGNkVcR+RUicfZo7fR4i9TDwNaHEq3lOe72JGbzCaAZ
	trxob+E3A+c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 337F15F6D6;
	Mon, 30 Dec 2013 14:37:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9209C5F6D5;
	Mon, 30 Dec 2013 14:37:27 -0500 (EST)
In-Reply-To: <7adcf8024c435b9b7178b86f01e447bb@stephe-leake.org> (stephen
	leake's message of "Mon, 30 Dec 2013 10:07:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D0A30132-7189-11E3-AD96-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239817>

stephen_leake@stephe-leake.org writes:

> That left the workspace unusable:
>
> - .git/FETCH_HEAD is empty
>
>     that causes 'git rev-parse FETCH_HEAD' to fail with a confusing
>     error message.

This is not limited to your Cygwin environment.  I can see that we
leave an empty file there after a failed fetch with

	$ git fetch ssh://no.such.place/

But I would not call it leaving "the workspace unusable".  If you
ask "git rev-parse" "What is in FETCH_HEAD?", you would get "that is
not even a revision", which is what you would get.

Similar operations that try to use FETCH_HEAD as if there is a valid
revision, e.g. "git merge FETCH_HEAD", would also not work, which is
very much expected.  I wouldn't think that needs something drastic
as "this workspace is unusable, let's start from a new clone".

If it really bothers you, you can always safely do

	$ rm -f .git/FETCH_HEAD

but of course, after that, nothing that tries to use FETCH_HEAD as
if there is a valid revision, e.g. "git show FETCH_HEAD", would not
work until you fetch from somewhere, so there isn't that much to be
gained by doing so.

> - 'git fetch' just hangs after outputting:
>
> remote: Counting objects: 15, done.
> remote: Compressing objects: 100% (8/8), done.
> remote: Total 9 (delta 5), reused 0 (delta 0)

This looks more serious, but I suspect it is totally unrelated to
your previous fetch failing and leaving FETCH_HEAD there.  Is this
"'git fetch' hangs" reproduce in a clean clone _without_ first
encountering the failure (due to the forgotton "ssh-add")?
