From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] run-command: Add checks after execvp fails with
 EACCES
Date: Fri, 09 Dec 2011 09:23:50 -0800
Message-ID: <7vaa71hd5l.fsf@alter.siamese.dyndns.org>
References: <op.v5e8mgbc0aolir@keputer>
 <1323207503-26581-1-git-send-email-fransklaver@gmail.com>
 <1323207503-26581-2-git-send-email-fransklaver@gmail.com>
 <7vpqg1e3au.fsf@alter.siamese.dyndns.org> <op.v56xbxqs0aolir@keputer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Frans Klaver" <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 18:25:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ4C0-0004OL-9H
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 18:25:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730Ab1LIRXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 12:23:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57014 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752301Ab1LIRXy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 12:23:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC44364A4;
	Fri,  9 Dec 2011 12:23:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V/BckiT+GsJq3st6OGKE0A96gvE=; b=OEr9Jy
	4a8SvrGNO9Dmce+HhBqEtPK36Ve5Y6+vMZyxbk7fsmtfGH/jpVe9FXm9bsqY55s/
	tuOGTdGw82PfA04HP1wG3D4A94dvseVU1qAgyrGSewThhdNxUqjQmrJrFyCqsDLJ
	8KifjqVEwelpHYycU1JEjlGxA8OhbMEH3M3aI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lAxCTP4m1J07fMXPuHdq2XX0lNr+0RTc
	couLG8kQc8LzZ/i9Bo74iaKFqi0ibQbD4j1YR8BZ+yoIkJuAHpyx4TBBWPv9koFC
	72BTUvMvip4MX7NB53qkiTZMYI4vUXiv1Y0856vxfe5ef2fIJNaUfRyv2HiCOw0J
	f5OB4rsC0a4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3B1F64A3;
	Fri,  9 Dec 2011 12:23:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 179D764A2; Fri,  9 Dec 2011
 12:23:51 -0500 (EST)
In-Reply-To: <op.v56xbxqs0aolir@keputer> (Frans Klaver's message of "Thu, 08
 Dec 2011 22:44:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 90631BFC-228A-11E1-9302-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186653>

"Frans Klaver" <fransklaver@gmail.com> writes:

>> Wouldn't access(2) with R_OK|X_OK give you exactly what you want without
>> this much trouble?
>
> I just had a good look through the man page of access(2), and I think
> it depends. access works for the real uid, which is what I attempted
> to implement in the above check as well. However, do we actually need
> to use the real uid or do we need the set uid (geteuid(2))?

Does it matter? We do not use seteuid or setegid ourselves and we do not
expect to be installed as owned by root with u+s bit set.

access(2) checks with real uid exactly because it would not make a
difference to normal user level programs _and_ it makes it easier for a
suid programs to check with the real identity, and our use case falls into
the former, no?
