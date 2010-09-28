From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Introduce pathspec struct
Date: Tue, 28 Sep 2010 02:37:18 -0700
Message-ID: <7v7hi6us35.fsf@alter.siamese.dyndns.org>
References: <1284938514-16663-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>,
	David Ripton <dripton@ripton.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 11:37:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0Wcy-0006oj-Ng
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 11:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383Ab0I1Jhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 05:37:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61002 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964Ab0I1Jha (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 05:37:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 23E34D927A;
	Tue, 28 Sep 2010 05:37:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OOmlrZVF3ORBlNt1ZlGAeyXO6/M=; b=wNTwxx
	4q/ikRwDHmVUiqqSYq/jHCxhoR9JFzWlSxa+ozmLSJV9Rq3IVvLu7Gdhw4nNef5z
	H2gHBbuEXBgjZeFL3vJNHqHy2oFRIIcuW4lYO5aCen8+IkUnpwms/ioldFfcdxoM
	jpUJL7wAYJ+oGg7uNUN0/+ARmyaOK1WiFuBA0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nalld2v5NWOwipOPotDfLsQN2Q06tmKx
	2xv2HPZ0FDtLBuxWXyrpHKI0HkCW0SRGdZlwv9hhVVVZQO33ROwAF062UtnaSFCJ
	30Fu9iRxhzGfTSAWE1BanKx7S60X9lhSlvn04IvN8k1OBwmSqTo9F5kSSedQv6dm
	QLdNVzTNdGA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CDEA0D9278;
	Tue, 28 Sep 2010 05:37:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E31ADD9275; Tue, 28 Sep
 2010 05:37:19 -0400 (EDT)
In-Reply-To: <1284938514-16663-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Mon\, 20 Sep
 2010 09\:21\:48 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0024A6D6-CAE4-11DF-9185-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157396>

Just a couple of quick notes.

 - I had to eject Bo's "log -L range path" series in order to push this
   out on 'pu' as the range stuff adds new callsites to the old pathspec
   API.

   This is tentative and does not mean Bo's series is getting rejected;
   I'd want to get its command line parsing around the pathnames fixed
   anyway but I suspect the affected codepath would overlap between the
   two series.  Help is appreciated.

 - I do not think either !pattern nor ^pattern is particularly a good way
   to express negative pathspecs.  My gut feeling is (I have not thought
   this through nor clearly enough; note the time of this message) that it
   would be the cleanest at the UI level to introduce negative patterns as
   arguments to a separate command line flag, e.g.

   $ git log --exclude "Doc*" master..pu -- '*.txt'
   $ git grep --exclude "t/" -e 'test .*-L' -- '*.sh'

 - David's "git grep --exclude-dir D" topic should be able to internally
   use the same negative pathspec mechanism.  At the command line level,
   it allows (and needs to allow) only the leading prefix (which is how
   GNU grep's --exclude-dir works), but it makes tons of sense for us to
   allow "--exclude $pattern" from the command line, and share the
   mechanism internally between the two.
