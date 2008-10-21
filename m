From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-fetch should not strip off ".git" extension
Date: Tue, 21 Oct 2008 16:35:30 -0700
Message-ID: <7v8wshwmgt.fsf@gitster.siamese.dyndns.org>
References: <ee2a733e0810180459m5fd20365s3c27bea5c1f3f704@mail.gmail.com>
 <48FC5F1B.1050608@op5.se> <7vzlkz2jv7.fsf@gitster.siamese.dyndns.org>
 <ee2a733e0810210323j249c3460x881af6d6aefc647c@mail.gmail.com>
 <7vej29zy2r.fsf@gitster.siamese.dyndns.org>
 <81b0412b0810211506y400ba750k2613ba19f01fb57@mail.gmail.com>
 <7vd4htwp6v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SLONIK.AZ@gmail.com, "Andreas Ericsson" <ae@op5.se>,
	git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 01:37:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsQmY-00036B-RO
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 01:36:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbYJUXfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 19:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbYJUXfq
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 19:35:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35119 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbYJUXfp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 19:35:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F1AC5723A2;
	Tue, 21 Oct 2008 19:35:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E8F01723A1; Tue, 21 Oct 2008 19:35:37 -0400 (EDT)
In-Reply-To: <7vd4htwp6v.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 21 Oct 2008 15:36:40 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FABA5BCA-9FC8-11DD-BBC6-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98824>

Junio C Hamano <gitster@pobox.com> writes:

> More importantly, the behaviour is consistent with the way how "git fetch"
> and "git clone" DWIMs the repository name by suffixing .git when the input
> lacks it.  And this DWIMmery comes from the expectations that:
>
>  (1) people name their repository project.git; and
>
>  (2) people like using and seeing short names (iow, "clone
>      git://$somewhere/project" is preferred over "clone
>      git://$somewhere/project.git");
>
> If a repository whose real location is git://$somewhere/project.git is
> cloned/fetched as git://$somewhere/project by people, recording the merge
> source using the shorter name used by people to fetch from it is more
> consistent.  The patch breaks this consistency [*1*].
> ...
> [Footnote]
>
> *1* It would be a different matter if the patch at the same time removed
> the fetch/clone DWIMmery.  At least such a patch would be internally self
> consistent.

Actually, after looking at what the involved codepaths do, I am inclined
to change my mind.  Somehow I thought the transport.c infrastructure DWIMs
and uses the result of DWIMmery throughout the program (iow, at the point
in the codepath the patch touches, we cannot tell what the user originally
asked for), which is not the case at all.  That changes everything.

The current behaviour is Ok if you match your behaviour to the original
expectations, but:

 * if you clone from "git://$somewhere/project" originally, your
   remote.origin.url will not end with ".git";

 * or equivalently, if your remote.origin.url does not end with ".git".

and when you fetch in such a repository with or without the patch, the
results are the same.  URL without trailing ".git".

So the change in the behaviour is only when you originally explicitly
asked to clone "git://$somewhere/project.git".  With the change, that wish
is preserved.  Without the change, ".git" is unconditionally dropped.

The situation is the same if you explicitly ask to fetch from a URL that
ends with ".git" (or "/.git").  With the change, the explicit ".git" is
preserved; without it, it is dropped.

So I now think the patch (if it were massaged into an applicable shape
with proper log message and sign-off) is an improvement.

Alex, thanks for sanity checking ;-)
