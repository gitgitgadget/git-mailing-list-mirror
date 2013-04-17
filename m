From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rev-list --pretty=format:"" issue
Date: Wed, 17 Apr 2013 15:11:21 -0700
Message-ID: <7vk3o0erjq.fsf@alter.siamese.dyndns.org>
References: <CAH2yXXYggB=Wv-w4B9qU=ZxAuqjPVa5WRNZRnMRrWShkTp0UFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Forrest Galloway <f.galloway@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 00:11:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USaZe-0002GX-R1
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 00:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966867Ab3DQWL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 18:11:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52525 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966831Ab3DQWLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 18:11:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C28B17D46;
	Wed, 17 Apr 2013 22:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2Ge2AX2JYUJhL/pZCRn7cS1Bg/s=; b=Dp+Let
	Tb9hxQQNk1TknZX/OYSDkntpRmj+fjnoyh7hX2nlogSmdy+VPFIqx+haT4p1gCKz
	smsYS06l99D8txVe7SNxqojF+SUYH1Ra7+64pnGe+vkuMDcq1SHNRp8nNn3hlxKX
	nUshgUMd34h3qNR5fr9g1J20BA43avsBeFQoM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qYcmUZw9aNjqW5M9QMsbQHou/5agXd0i
	3OfCkaBpizq2SJYbdxGgW/SbJzs1aDX4c3GaobeDNljmw6HPaeaiVoDAsHepcn3U
	WYxiRA3f+4jZ91qlzs2+w4orkzWwQIF2tua3LeDcW5KmJ+bD0FPnaEgbvoH9mjc9
	YGXyuY9WbLI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1118B17D45;
	Wed, 17 Apr 2013 22:11:24 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E54917D43;
	Wed, 17 Apr 2013 22:11:23 +0000 (UTC)
In-Reply-To: <CAH2yXXYggB=Wv-w4B9qU=ZxAuqjPVa5WRNZRnMRrWShkTp0UFg@mail.gmail.com>
	(Forrest Galloway's message of "Wed, 17 Apr 2013 16:11:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BD6F1996-A7AB-11E2-BB78-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221579>

Forrest Galloway <f.galloway@gmail.com> writes:

> git 1.8.2.1 on OSX(Mountain Lion) installed with Homebrew
>
> I am seeing an issue when trying to format the output from rev-list command.
> git log --pretty=format:"%H - %an, %ar : %s" When I attempt the above
> string, instead of printing to the shell, LESS is opened and the
> output is displayed there.
>
>
> Got the command from here:
> http://git-scm.com/book/en/Git-Basics-Viewing-the-Commit-History
>
> git log --pretty=format:"%h - %an, %ar : %s" The string above works
> fine when I change the %h to %H the issue shoes up.

Actually, less is running in both cases.

We give --quit-if-one-screen (-F) and --chop-long-lines (-S) by
default when we run "less", unless you have your own LESS
environment variable to override our choice, if your history is
shorter than one screenful *and* if your output lines are narrower
than your terminal, it exits after showing the output.

By passing %H instead of %h, you make the output wider, and when
viewing output with --chop-long-lines, less refuses to implicitly
exit with --quit-if-one-screen, because you may want to look at the
RHS end of the output with right/left arrow keys, and it cannot do
so if it exits after showing the last line.

If you do not want pager, run it with no-pager, like this:

	git --no-pager log ...your other parameters...
