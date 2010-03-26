From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC/RFD] clone: quell the progress report from init
Date: Fri, 26 Mar 2010 12:32:37 -0700
Message-ID: <7veij6lvze.fsf@alter.siamese.dyndns.org>
References: <4BAB2234.4070202@drmicha.warpmail.net>
 <7b9006620fab4214ee0db53ebc9e0caffc397959.1269506526.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Neal Kreitzinger <neal@rsss.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 26 20:32:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvFH6-0002oR-Uv
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 20:32:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254Ab0CZTcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 15:32:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46941 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116Ab0CZTcu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 15:32:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 46DEAA52D7;
	Fri, 26 Mar 2010 15:32:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=UNxQvzNLQZxomTtU7K6lrlJ1MIk=; b=dJwOhAJa3BW/Y9FpWTyzd+e
	v064PV5hjK/CSv5jHbPTAVnb3Qu++3qK6zlZ/JQ2kSiwnKODE4KgkM3TMJEMS+N6
	4TDREFwKPzH2HLR6inMicecqnLgrP2KmvSBzfzut4BQG3KuB4x+BQqonze6moXEg
	kkdG9gQNUTjb+EgWY0L0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=SJ2NS1iWoUn5BbKNuYaD2MpfAEFNKoFqiLdFiMFna+ZAdqK1r
	xYORnEB6ju/QI2WYZKHc6YAyX9p+YAZeSZqax05SQc84RSNoW6kc3GeuUB0mZi6d
	9548Y/sO5Y80+XmSRELLrzWsCTC3VuHylSL32OWtXjacdK2VQPP68kqcqc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C08C6A52CF;
	Fri, 26 Mar 2010 15:32:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C7A0CA52CB; Fri, 26 Mar
 2010 15:32:38 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5A0DD018-390E-11DF-9901-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143270>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Currently, cloning a local repository results in the progress report
> "Initialized empty Git repository in ..." from init but no other output,
> leaving the user to wonder what happened to the actual cloning.

With your patch, local variant will become totally silent, but it may want
to give some feedback like real transports do; it is not entirely clear
what it should say, though.  The progress report given by the real
transports are to assure the user that we are not stuck, and the local one
is usually reasonably fast.

It's pointless to say "initialized empty" and then say "I am working hard
to clone".  As the command always creates a new directory and clones into
it, it makes sense to say only the latter, and your 1-byte patch may be a
good first step in that direction.

An alternative might be to squelch init_db() like your patch did, and then
replace it with a message of our own, perhaps like this:

 $ git clone -n /var/tmp/gomi victim-003
 Cloning into victim-003...
 done.
 $ git clone -n file:///var/tmp/gomi victim-004
 Cloning into victim-004...
 remote: Counting objects: ...
 Receiving objects: 100% (120/120), done.

Here I am assuming we would add "done." to the local codepath.

Personally I like the total silence your patch gives (i.e. no "Cloning
into" line in either case, and no "done." in local case) slightly better;
others may disagree and/or have better ideas.

> This is RFC/RFD. An actual patch will also adjust several tests to
> the new expected output.

And documentation, especially the tutorials.

"git init" as a top-level command may want to stay as-is; it is not like
you run "init" over and over again.  But we probably should make it an
independent issue from the "clone" one.

Thanks.
