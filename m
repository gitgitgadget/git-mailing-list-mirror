From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: print format-patch usage if there are no arguments
Date: Tue, 13 Jan 2015 14:28:13 -0800
Message-ID: <xmqqiogaco3m.fsf@gitster.dls.corp.google.com>
References: <1421171662-12164-1-git-send-email-kuleshovmail@gmail.com>
	<xmqq387eed30.fsf@gitster.dls.corp.google.com>
	<CANCZXo7UtCXF_bJe9exT1pUwwsgUuYs5mvHHGtDORoJew_UXnQ@mail.gmail.com>
	<xmqqppaicwww.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYJ+XNktc7_C81xz=BfCP4_hrE=pWW5QGJ1kdXKMf4Jjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 23:28:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YB9wp-0007T0-K6
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 23:28:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024AbbAMW2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 17:28:18 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59923 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751122AbbAMW2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 17:28:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6249630887;
	Tue, 13 Jan 2015 17:28:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QDxSoSUanCqdFfQxpRCWDb5OnMU=; b=dtGQdK
	jVM2JZcWvBcwnNQZ4SKtNnSqsbxN6bjqRRyU1WNn2XgDQJ74Px41yZbTIutoGzep
	5vdzgF2Zccj7OLZYZuiPTL7XI8fetBx8fc4qKHnmqiS9T0xjZR+kMrP589Fckd0u
	thjrS05aUeX1kmWTe+1lO669PkcbhUq1hX7G4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qszFRcqFMtTUwMgdhvbQvRB/NT+h21OT
	2rmvlllTYYkgRRik8tD3/BVMwkJsosJSCrWOVu5l7uv81/vnM9dFE9jMhUa0L+5M
	9AUFOTuLLi83GlkyM/SnYuJFqs+nhSwGpdX7hrEThv9FXU8YOuAErO5Anack1c/t
	dhZTWIvbDB8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 58CD230886;
	Tue, 13 Jan 2015 17:28:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D561430885;
	Tue, 13 Jan 2015 17:28:14 -0500 (EST)
In-Reply-To: <CAGZ79kYJ+XNktc7_C81xz=BfCP4_hrE=pWW5QGJ1kdXKMf4Jjw@mail.gmail.com>
	(Stefan Beller's message of "Tue, 13 Jan 2015 12:00:18 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 770CBD2E-9B73-11E4-850D-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262356>

Stefan Beller <sbeller@google.com> writes:

> Another idea would be to take the first commit which is pointed to by
> another branch as the first commit in the commit range.

Trying to figure out what happened from the topology of the history
is certainly attractive proposition, but I suspect that it would be
too fragile to be practically useful.  The other topic you may have
based your work on may have advanced independently (e.g. a "oops, I
forgot this one" bugfix), resulting in a fork like this:

 ---o---o---o---o (fixed reflog-expire)
             \
              x---x---x (atomic-push)

and the fork-point is no longer at the tip of anything.  "Excluding
anything that is on another branch" would cover the forked case much
better, but that is only true if there is no integration branch like
'pu' or 'next', in which case, only an early part of atomic-push may
already be part of another branch 'next' while the remainder is not,
or the entirety of atomic-push may be part of another branch 'pu'.

On the other hand, "I am forked from building on this one" done with
"checkout -t" is an explicit mark the user leaves, so it would serve
as a better hint to base the default heuristics on, I think.

But nobody is asking for such a feature ;-)
