From: Junio C Hamano <gitster@pobox.com>
Subject: Re: PATH modifications for git-hook processes
Date: Tue, 14 Apr 2015 10:17:26 -0700
Message-ID: <xmqqk2xe39zt.fsf@gitster.dls.corp.google.com>
References: <CAKuTQSGEmHHr-c+Tc2jM-JPkx6+_f3gp8Zjj8EuQy_e4=PvMzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Matthew Rothenberg <mroth@khanacademy.org>
X-From: git-owner@vger.kernel.org Tue Apr 14 19:17:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi4Sr-0004F1-QU
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 19:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932989AbbDNRRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 13:17:30 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63547 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932176AbbDNRR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 13:17:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 38C1047585;
	Tue, 14 Apr 2015 13:17:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZrAfOivGa0oZZYwJU5qX4b8M2QE=; b=V4j0JZ
	B0ZpjP5D80FqsypnE6groNc5u0weMh0iZTnjVgSvB6aHu2pajClvoA/DS30cfqHx
	CX5zUfB1V8rvT7okVY0wto3+GS+QekSD8r6p2c+VtbfevOAas4v1I4R/tW1GJOiT
	pZtPPLBuxZK6iND/bBVYot6qdelQhX5XPnQ7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wjdjuvk0aWOYr8UOnja5bLZjOKzWkKbX
	zL4kQOf69LgkR9luDZdI3l+3w7IvJ7AnI/QdW4bY4eAkC9XtmIHgnfSY5xtN12nK
	3J3hFWClKPYv174/oQqzaN7dA//vGaiDZOzJjx+ijja/p/5C5EkzdWniHd/XTgHL
	byz7EPCi4Es=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 30E2547584;
	Tue, 14 Apr 2015 13:17:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A85A647583;
	Tue, 14 Apr 2015 13:17:27 -0400 (EDT)
In-Reply-To: <CAKuTQSGEmHHr-c+Tc2jM-JPkx6+_f3gp8Zjj8EuQy_e4=PvMzg@mail.gmail.com>
	(Matthew Rothenberg's message of "Tue, 14 Apr 2015 12:04:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 200E34B4-E2CA-11E4-B67D-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267150>

Matthew Rothenberg <mroth@khanacademy.org> writes:

>  - what is the expected PATH modification behavior for subprocesses of
> git-hooks? Is this documented anywhere?
>  - what would be causing /usr/local/bin to be prepended here, and can
> it be adjusted via preference?

This is not limited to hooks and very much deliberate, I think.  In
order to make sure anything that is called from "git" wrapper gets
picked up from GIT_EXEC_PATH so that the matching version of the git
subprogram is used, "git <cmd>" does this before running "git-<cmd>"
(in git.c):

	/*
	 * We use PATH to find git commands, but we prepend some higher
	 * precedence paths: the "--exec-path" option, the GIT_EXEC_PATH
	 * environment, and the $(gitexecdir) from the Makefile at build
	 * time.
	 */
	setup_path();

And setup_path() is defined in exec_cmd.c to start the new PATH with
git-exec-path, and then the path to the running "git" itself, and
then finally the external PATH.
