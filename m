From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove empty ref directories while reading loose refs
Date: Fri, 10 Feb 2012 11:09:37 -0800
Message-ID: <7v39aiqzda.fsf@alter.siamese.dyndns.org>
References: <1328891127-17150-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 20:09:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvvqr-0005qq-N1
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 20:09:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759908Ab2BJTJl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 14:09:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34357 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759903Ab2BJTJk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2012 14:09:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEA3C77CD;
	Fri, 10 Feb 2012 14:09:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FnNofeKvvcuo
	rqa6kBqqTmkeYjU=; b=XQXb361x28D8sYbqGvobsnY/FpwT5c0a0N3dHO6p2g//
	ulJsGGjRQoBpc1KIIDXZf34MYzWT06iagyNxjM85mAVKtVlhVUfiQ//8WP81OGpg
	I9wavZ7aR6HaLXssq537ptvapblsq1V3XAJ4cTg83Btw7m0aY6J2Cm9amdFCtg0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Otskon
	IuBCbNamQ5qoH7mmXvTppoW+/W8ml6hLZifJgcHD/942SYbbdSEqULnLvOrVBq60
	stgrdVHcbG1ipckgY9seHGu7ZHu1Hzgh8UQ3SL5JBgTlfRVnJsDroPWr9uExJ7R8
	te+xUmH/WvmA9iMSVb+calFivES9C3b2M0JM0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E51D077CC;
	Fri, 10 Feb 2012 14:09:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C75277CB; Fri, 10 Feb 2012
 14:09:39 -0500 (EST)
In-Reply-To: <1328891127-17150-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 10 Feb
 2012 23:25:27 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7AFDB6A-541A-11E1-87A9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190437>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

>  I don't think the a few extra rmdir()s from time to time at startup
>  are going to cause any problems. Making delete_ref() delete empty
>  directories takes more effort and probably not worth it.

That reads as a very poorly phrased excuse for not solving the problem =
at
the right location.  Compared to all the codepaths that want to resolve
ref, delete_ref() is run much less often, and it is where the problem y=
ou
are solving (i.e. directories that have just become unnecessary are not
removed) originates, no?

Wouldn't it be just the matter of replacing two unlink_or_warn() calls =
in
delete_ref(), one for cleaning refs/ hierarchy and the other for cleani=
ng
logs/ hierarcy, with a new helper that calls unlink_or_warn() and then
tries rmdir going upwards until it hits the limit, perhaps using a help=
er
function that refactors dir.c::remove_path() that takes an extra parame=
ter
telling it where to stop?
