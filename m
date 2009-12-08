From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-apply fails on creating a new file, with both -p and
 --directory specified
Date: Mon, 07 Dec 2009 19:20:30 -0800
Message-ID: <7v3a3mqhhd.fsf@alter.siamese.dyndns.org>
References: <20091123194523.GZ15966@cl.cam.ac.uk>
 <7vws1e3ma1.fsf@alter.siamese.dyndns.org>
 <loom.20091207T222449-752@post.gmane.org>
 <7vk4wyqigf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: James Vega <vega.james@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 04:20:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHqd4-0000c3-5J
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 04:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935793AbZLHDUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 22:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935811AbZLHDUe
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 22:20:34 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47039 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935116AbZLHDUd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 22:20:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3052686C72;
	Mon,  7 Dec 2009 22:20:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AazlAMaqNnh6ePnriLCKcqaSoWE=; b=JKqBWk
	TdKY0m6Soqvu03FY4Y/tPMhdxBAE/IUAm5cDqbo/xy0FKY+7Tcmihl1L+HNy5x5l
	NxDI/X5Q/utammEAApfS2tx/GmySfR3h9R7A2PiXtNSjscGjj7TKy6UMrlVTmhKv
	zX+ksGNv0Wo7rcvVdlpiotfoW+hyAMEO7lcEo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OLA9WiPIeiKrdywHEqWlzNaSrrzE35s0
	NUCrrS1ioyRzXDiR+9+t67E2EYZqKtFKjS9iG6v/bIvf2tfPT+SwDmZkFhyPAWwy
	lsn2sco9TZn9NGX35q8k4B9h5pRxD6tzT3kzqIzhyqTuhQFBzLO3g6+Z6SRD76lT
	Ox1O2+ZUuJs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 03DBC86C71;
	Mon,  7 Dec 2009 22:20:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3681686C70; Mon,  7 Dec
 2009 22:20:32 -0500 (EST)
In-Reply-To: <7vk4wyqigf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 07 Dec 2009 18\:59\:28 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A6C78BA8-E3A8-11DE-900E-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134809>

Junio C Hamano <gitster@pobox.com> writes:

> James Vega <vega.james@gmail.com> writes:
>
>> It looks like this may have introduced a bug when staging a file
>> removal.  Here's an example git session showing the issue:

An update.  I tried your reproduction recipe with 1.6.5.2 and it doesn't
reproduce, but with 1.6.5.3 it does.

$ git init test
Initialized empty Git repository in /local_disk/tmp/test/.git/
$ cd test
$ echo "foo" > foo
$ git add foo
$ git commit -m 'Add foo'
[master (root-commit) 3643b5d] Add foo
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 foo
$ mv foo bar
$ git add -p
diff --git a/foo b/foo
index 257cc56..0000000
--- a/foo
+++ /dev/null
@@ -1 +0,0 @@
-foo
Stage this hunk [y,n,q,a,d,/,e,?]? y

$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD ..." to unstage)
#
#       new file:   dev/null
#       deleted:    foo
#

A quick bisection of the original issue points at

24ab81a (add-interactive: handle deletion of empty files, 2009-10-27)
