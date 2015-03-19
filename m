From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] diff-lib.c: adjust position of i-t-a entries in diff
Date: Wed, 18 Mar 2015 23:00:43 -0700
Message-ID: <xmqqlhitle5w.fsf@gitster.dls.corp.google.com>
References: <1425910445-27383-2-git-send-email-pclouds@gmail.com>
	<1426514206-30949-1-git-send-email-pclouds@gmail.com>
	<5506F3A9.1020704@drmicha.warpmail.net>
	<xmqqa8zdrkpy.fsf@gitster.dls.corp.google.com>
	<20150317140704.GA7248@lanh>
	<xmqq1tknpkwd.fsf@gitster.dls.corp.google.com>
	<CACsJy8Beoz=qcHrOG=akCR+gOQRjBcsQHaXdL_=PW70BOf4q3g@mail.gmail.com>
	<xmqqtwxikpz6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 07:00:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYTVk-00061B-2L
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 07:00:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbbCSGAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 02:00:47 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750840AbbCSGAq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 02:00:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F30B3A1A0;
	Thu, 19 Mar 2015 02:00:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FEAhlSRICEdu6tZ7pYT7KpmJ5N0=; b=OZcpOZ
	vdATV2UUaMFlZp8S0j6xgWi2j3RMT9zIfO9UA3Nhy7c46YF3y3h0AI8utx4jvcz1
	/QAJCUhFi0oG3SLItwriJ57xfufchp/fOt6UIjqJSO5XhGMzrpImlqn8lzaSr2jp
	px/xpyR3Nplt0Es2Ia1rEni03ZnlxgmYDEaaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CRcxU/tICotU+G+SBqjyYiAm5Zt53+U2
	hoPV4nJRsPIa0LrySUEUjNRyRgOf9/kjowhfviWmNhd7e/sdXPpvH7LNqes6SB7b
	kitl01OjUtHGUD0U4dGe+ALxdIeiRm/TmUes6rf9cjHwS6UQKhOiuOZXWJ3nLto0
	AGmPWRjKlKM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 19D4C3A19F;
	Thu, 19 Mar 2015 02:00:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5DB6D3A19E;
	Thu, 19 Mar 2015 02:00:44 -0400 (EDT)
In-Reply-To: <xmqqtwxikpz6.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 18 Mar 2015 13:30:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 47DBDDD4-CDFD-11E4-8520-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265786>

Junio C Hamano <gitster@pobox.com> writes:

> Ah, wait.
>
> I suspect that it all cancels out.
> ...
> Now, as you mentioned, there _may_ be codepaths that uses the same
> definition of "what's in the index" as what diff-cache used to take
> before your patches, and they may be broken by removing the
> invalidation.  If we find such codepaths, we should treat their old
> behaviour as buggy and fix them, instead of reintroducing the
> invalidation and keep their current behaviour, as the new world
> order is "i-t-a entries in the index does not yet exist."

One potential negative consequence of the new world order I can
immediately think of is this.  In many operations, we try to be
lenient to changes in the working tree as long as the index is
clean.  "read-tree -m" is the most visible one, where we require
that the index and HEAD matches while allowing changes to working
tree paths as long as they do not interfere with the paths that are
involved in the merge.  We need to make sure that the path dir/bar
added by "add -N dir/bar", which in the new world order does not
count as "index is not clean and there is a difference from HEAD",
(1) does not interfere with the mergy operation that wants to touch
dir (which _could_ even be expected to be a file) or dir/bar, and
(2) is not lost because the mergy operation wants to touch dir or
dir/bar, for example.
