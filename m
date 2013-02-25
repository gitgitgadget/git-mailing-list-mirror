From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible regression in ref advertisement
Date: Mon, 25 Feb 2013 13:16:11 -0800
Message-ID: <7vfw0kt7qc.fsf@alter.siamese.dyndns.org>
References: <1361811516.3212.14.camel@centaur.cmartin.tk>
 <7vvc9gxn2y.fsf@alter.siamese.dyndns.org>
 <1361819916.24515.5.camel@centaur.cmartin.tk>
 <7vip5gxkgy.fsf@alter.siamese.dyndns.org>
 <1361822092.30765.12.camel@centaur.cmartin.tk>
 <7v1uc4ximl.fsf@alter.siamese.dyndns.org>
 <1361824519.31692.12.camel@centaur.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, peff@peff.net
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Mon Feb 25 22:16:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA5Pc-0006F4-8w
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 22:16:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757943Ab3BYVQP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2013 16:16:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64436 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755140Ab3BYVQO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Feb 2013 16:16:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D332EB2F5;
	Mon, 25 Feb 2013 16:16:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=a1To5LBcBMWk
	CYs/OZuc6sX+IIQ=; b=M3lWJsuOav6gkXeNVs7NCsCQQezWX03QiHZRsPUL/7tw
	+hvcr6UpRr/w/bwxKUgO/9zvyrTNbaaQNJTh0Y+cDpOl+pHxd7dE0Q3HUu8BsGho
	18CDLRdZr6X3X26UBPn2ULeRdK0ZMZBDAYstyyU0eJ3QIgNz7khJbkyc5b4vvL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Vn5dEq
	YYMvQL5VbTHScWAnAmaI+WRKLbfpyV29ccUirpDLYr5hjXGwtIMglf4HBk6Nq2o0
	nvTxeakDmKGEfe3yxtemY9Wv0erShOgm73fg9ELju+mg5y5NBarInq72ljaYYjIC
	eYRatw7x9+1HK2RRWzEnC5jTXzQk79Von5F0Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C801AB2F4;
	Mon, 25 Feb 2013 16:16:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DF45B2F3; Mon, 25 Feb 2013
 16:16:12 -0500 (EST)
In-Reply-To: <1361824519.31692.12.camel@centaur.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Mon, 25 Feb 2013 21:35:19
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 95418A14-7F90-11E2-A6FD-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217107>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

>> As packed-refs file is expected to be a text file, it is not
>> surprising to get an undefined result if the it ends with an
>> incomplete line.
>
> I guess that depends on what you mean by incomplete.

I used that word in the POSIX sense, i.e.

  http://pubs.opengroup.org/onlinepubs/9699919799/xrat/V4_xbd_chap03.ht=
ml#tag_21_03_00_67

Unless the user edited the file, an incomplete line may indicate
that the file has been truncated when (or after) it was written, and
we have to suspect not just that the last "line" may have been
truncated (in this case, not having the full 40-hex object name),
but other records that should have been after that line were lost.

We may want to detect such corruption at runtime, at least at
strategic places; making it a hard runtime error will make it
difficult to use Git itself to recover from such an corruption
(e.g. you may have a healty mirror from which you can recover refs
with "fetch --mirror").

We should at least refrain from running repack/gc to make things
worse, for example.
