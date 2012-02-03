From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problem pushing to a Novell share
Date: Thu, 02 Feb 2012 17:28:29 -0800
Message-ID: <7vfwesu2ma.fsf@alter.siamese.dyndns.org>
References: <CAJ4nRM0-3GWN=OYOXDdGtktU0mc8mhcoKqbo=U4Jm5AmSbPAyQ@mail.gmail.com>
 <7vmx90vlyr.fsf@alter.siamese.dyndns.org>
 <CAJ4nRM1K=sCy8_0PG-NADVn4T0XG1ELC7AvtQyW-Dc1cUMzEXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?R=C3=BCdiger?= Kessel <ruediger.kessel@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 02:28:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt7x8-0004Pd-M9
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 02:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757577Ab2BCB2d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 20:28:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61473 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754048Ab2BCB2c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 20:28:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 913AB6C37;
	Thu,  2 Feb 2012 20:28:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6P8c8EuYpf1H
	jtBeGDRIOxUp2Cg=; b=PI0ZCzo7rrMHcy+4pfWsOoX+B0MprxxeOzInebHYhXjV
	XZo6yeqJYhG6Mm0CZe2sD1yE9Mm4JMes7vBysR6H+qIu98N0g3LUu0bpfpC6YICV
	uMyt8eD68pX7qBil96dElDpq9XjQhkfXcY1fr6K9Q2njmttehQLZrPVXTGBdIBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=s0E6Xp
	UFftNdSaMWfJRCHGRqY/lmKfq4lZqM9XjfyRpduyLMjweLrNXR5YuVLhvVSLkW/R
	+fC3FK0SN19YjGG0/lDomrD6+1f3F8Nb8/p/HQVBK3ksKseR9KIDbsQqh//uA9ee
	pjGyNqzIjmS1VHuu7u3gJY757M75Xu/4LB1/4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 852C06C35;
	Thu,  2 Feb 2012 20:28:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1DD996C34; Thu,  2 Feb 2012
 20:28:31 -0500 (EST)
In-Reply-To: <CAJ4nRM1K=sCy8_0PG-NADVn4T0XG1ELC7AvtQyW-Dc1cUMzEXQ@mail.gmail.com>
 (=?utf-8?Q?=22R=C3=BCdiger?= Kessel"'s message of "Fri, 3 Feb 2012 01:49:09
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 618E9BEC-4E06-11E1-9900-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189731>

R=C3=BCdiger Kessel <ruediger.kessel@gmail.com> writes:

> Trying git_mkstemp_mode() first means trying more 16000 times to crea=
te a
> random file before realizing that something might be wrong.

Well, git_mkstemps_mode() does have such a 16k loop, and it tries to
create a unique, unused file this way:

		fd =3D open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
		if (fd > 0)
			return fd;
		/*
		 * Fatal error (EPERM, ENOSPC etc).
		 * It doesn't make sense to loop.
		 */
		if (errno !=3D EEXIST)
			break;

If you do not have a directory D and try to create D/tmp_random here,
shouldn't you get an error that is _NOT_ EEXIST and trigger this break?
