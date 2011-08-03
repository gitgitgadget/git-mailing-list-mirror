From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 17/18] revert: Introduce --continue to continue the
 operation
Date: Wed, 03 Aug 2011 10:30:27 -0700
Message-ID: <7v4o1ycsi4.fsf@alter.siamese.dyndns.org>
References: <1311871951-3497-1-git-send-email-artagnon@gmail.com>
 <1311871951-3497-18-git-send-email-artagnon@gmail.com>
 <201107311751.52965.chriscool@tuxfamily.org>
 <CALkWK0mrx+3jdCQD9xya3AWMsPpSiZzEz+Z9XVxZNzw3UdKMVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 19:30:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QofHE-0004kh-FP
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 19:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879Ab1HCRab convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Aug 2011 13:30:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45646 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752146Ab1HCRaa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2011 13:30:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAEA755AA;
	Wed,  3 Aug 2011 13:30:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Zpb3yRbTrieK
	ZTaeJhPqUyXn7pI=; b=MFCvkiYlI0q/tmHZ48MuwSI67i1/8g/jJh4HEDYy1NKX
	h+gP0DzgDzx8Smy0KjSEYl4g8hCYo4EKoqwdRYYqmtMtQhIy62iJsraHQu87BpK9
	L84AbO05cjsf9psH+RlnbNgievo1TUlCCIZWkn02v0AFy3SvMdAKukAvX1ysDTw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QrlWdZ
	rfwQE2nR+aRiUqDVo3ZJWPKvee9cr4A8z9E0kDMRgSN3+quns8cQ2ab9iTdmJF4Q
	dh/tvwuTqUeM69pQaBIUC4Ut0pdivMpFLeMiheNIGzhQlWOLTHRgudVTGH3XFDrE
	oyH7mm720E6WaC3W2BQFkNxBJgw0Fi0BU3nUM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1B0455A9;
	Wed,  3 Aug 2011 13:30:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76AAD55A8; Wed,  3 Aug 2011
 13:30:28 -0400 (EDT)
In-Reply-To: <CALkWK0mrx+3jdCQD9xya3AWMsPpSiZzEz+Z9XVxZNzw3UdKMVw@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Mon, 1 Aug 2011 23:18:14 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 47C797E0-BDF6-11E0-A969-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178599>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>>> + =C2=A0 =C2=A0 for (p =3D buf.buf; *p; p =3D strchr(p, '\n') + 1) =
{
>>
>> This relies on a "\n" at the end of the last line...
>
> Yes, that was intentional.  Every editor I know of inserts a '\n' at
> the end of the last line,...

Why do you think "diff" has a special codepath to report "No newline at
end of file"? Because some editors do leave an incomplete line incomple=
te.

When working on a "buf" with an incomplete line at the end, the last ro=
und
of the loop will assign "(char *) 1" to "p", try to see "*p" is NUL and
segfault, no?
