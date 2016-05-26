From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/2] Submodule shallow recommendation [WAS: Submodules: have a depth field in the .gitmodules file]
Date: Thu, 26 May 2016 11:13:45 -0700
Message-ID: <xmqq1t4owuue.fsf@gitster.mtv.corp.google.com>
References: <20160526000633.27223-1-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 26 20:13:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5zn8-0005EJ-Tb
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 20:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650AbcEZSNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 14:13:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59225 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750727AbcEZSNs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 14:13:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AB3311EDDC;
	Thu, 26 May 2016 14:13:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HMPFyerltFv+v2GpltK5AOLsjIo=; b=ErKA+V
	1J1x8j0A5Ob8RsWSrA9SBxjN4iBp7jSIJ9+dojC8Xfo9NmQ6zgTcgeF1jvL/r5d7
	NSq5fITHf2hzIa4fFvFpGfbfxSGNFLw1E4Tkbanvjz2KEJXgZfTmOMobVWPOmIos
	HmMZuJGipoA+Pj8h1NfDorNJ9uHcHiJ26yY7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CYZHlsHhMJZbRWbP/mZH0l0Z6CFEzKql
	uUt8mYB/G87lwfKOFjuR6bQFyUzOUS9Tz+y1Mf6tyQGCqAW8kYzIposiOIbroXYl
	hyEILHNoEb8bD+LRj/Qfp4sgRP9KR40mS1qg3Nkrpbh6fPF/UADX4uoobMqXz01j
	g8RGStIxZ/0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A36D91EDDB;
	Thu, 26 May 2016 14:13:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1DAF21EDD9;
	Thu, 26 May 2016 14:13:47 -0400 (EDT)
In-Reply-To: <20160526000633.27223-1-sbeller@google.com> (Stefan Beller's
	message of "Wed, 25 May 2016 17:06:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 96E4DCDE-236D-11E6-BDC7-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295681>

Stefan Beller <sbeller@google.com> writes:

> Sometimes the history of a submodule is not considered important by
> the projects upstream. To make it easier for downstream users, allow
> a field 'submodule.<name>.depth' in .gitmodules, which can be used
> to indicate the recommended depth.

I have a design-level question.

If your project consists of 600 submodules, among which 40 of them
you would recommend making a shallow clone, are there traits, other
than "most people would not care about its history", that are shared
across these 40 subprojects?

What I am trying to get at is that after adding .shallow annotation
to these 40 submodules in .gitmodules, the project may need to add a
different annotation for the same 40 submodules to control another
operation.  Which would be cumbersome, and a level of redirection
might be a good way to solve it.

IIRC, earlier you had talked about a vision where you can just say
'submodule init --group=framework' to prepare your top-level project
tree with its submodules in a state suitable to work on 'the
framework part of the project', and the 'app' folks can substitute
'framework' with 'app' in that command.  I thought the earlier
defaultGroup work (and the attribute limited pathspec work that lays
groundwork for it) was part of that effort.

Perhaps when a user says "submodule init --group=framework", that
"framework" can choose some "developer profile" that indirectly
specifies things like which group of submodules to initialize, which
group of submodules can be shallow, etc.?

Just a strawman (without worrying about details and expressiveness
of the syntax), I am wondering if you want something like this in
your .gitmodules:

    [profile "framework"]
	initialize = $submodule_spec
        shallow = $submodule_spec
        ...

    [submodule "kernel"]
    	url = ...
        path = ...

    ...

where $submodule_spec would be a way to choose modules by various
means.  You may name them by their names.  You may name them by
their paths.  With the submodule-pathspec topic graduated, you may
use ":(attr:framework)*" to choose them by attribute limited
pathspec.
