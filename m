From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-apply fails on creating a new file, with both -p and
 --directory specified
Date: Mon, 07 Dec 2009 18:59:28 -0800
Message-ID: <7vk4wyqigf.fsf@alter.siamese.dyndns.org>
References: <20091123194523.GZ15966@cl.cam.ac.uk>
 <7vws1e3ma1.fsf@alter.siamese.dyndns.org>
 <loom.20091207T222449-752@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: James Vega <vega.james@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 03:59:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHqIk-0003OQ-CI
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 03:59:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934370AbZLHC7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 21:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934115AbZLHC7b
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 21:59:31 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45265 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934230AbZLHC7a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 21:59:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5818BA5C7D;
	Mon,  7 Dec 2009 21:59:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DM9nXNbtdZONYMloxooXzr29jIU=; b=bodCTm
	AscvhP5kPupEcKSMoDWhJvNfoMApJ0k7l31GN1VWZysQayYYvCF93f70J3pmYz+y
	+rQXAhlm6jwZwF/RTyEmmsk+Hk5XQUnEqa9N/qUDfmfgr3LiBIFLcWTKmjHPO5kg
	vPFC0Xubwe1H0XpT9ah+DFZ2bpelqJZHm7Gw4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I7jdTpDxSxtWkN4uHgL+cuz+Ad3Yailh
	xiLJ+YS4JNZwmmhTR599KU9HF1r0UbUH5vKSOIlL0juHkXwg3WTR0j81vFM78xbP
	5Ww93uogiY/ps3FKJzKEDQ8PrZAXX2z04tpDm6kI3gYweXxjMnRo2IrdmLqnLuYd
	a7446sR+d+4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 36921A5C7C;
	Mon,  7 Dec 2009 21:59:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3449EA5C7B; Mon,  7 Dec 2009
 21:59:30 -0500 (EST)
In-Reply-To: <loom.20091207T222449-752@post.gmane.org> (James Vega's message
 of "Mon\, 7 Dec 2009 21\:35\:36 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B6B0195C-E3A5-11DE-8C53-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134806>

James Vega <vega.james@gmail.com> writes:

> It looks like this may have introduced a bug when staging a file
> removal.  Here's an example git session showing the issue:
> <<snipped>>

Thanks for a report, but I cannot get the evidence that the said patch has
anything to do with the issue you illustrated.

$ cat >patch0 <<\EOF
diff --git a/foo b/foo
deleted file mode 100644
index 257cc56..0000000
--- a/foo
+++ /dev/null
@@ -1 +0,0 @@
-foo
EOF
$ git apply --numstat patch0
0	1	foo
$ sed -e '/deleted file/d' patch0 | git apply --numstat
0	1	dev/null

The last one is showing the symptom in your message.  Git versions 1.4.0
and newer yield the same result, but 1.3.0 gives a funny message:

        ** warning: file dev/null becomes empty but is not deleted
        0       1       foo

So it appears that the bug is somewhere else not in that patch.
