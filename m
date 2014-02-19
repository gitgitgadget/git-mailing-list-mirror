From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 24/25] prune: strategies for linked checkouts
Date: Wed, 19 Feb 2014 12:42:59 -0800
Message-ID: <xmqqy5167s18.fsf@gitster.dls.corp.google.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-25-git-send-email-pclouds@gmail.com>
	<xmqq38je9739.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 19 21:43:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGDz4-0007bF-Ku
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 21:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867AbaBSUnF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Feb 2014 15:43:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45709 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753503AbaBSUnE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Feb 2014 15:43:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 032A96C058;
	Wed, 19 Feb 2014 15:43:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tV7kn6PPgnaE
	WRBHAtQBF4v7uzY=; b=j9VMfPdjrpU1ow5ZS3ryD73PNT5X6ZaH/tHtsYToa4At
	oG6VB1TSZMMWj9K52zPltHUmHGk5qomVtpq+mHcZCUxnP+wsTbq1b+tBapUjQCCP
	J7qsUyqiQVHU2OvTMxsOMDmS69w7fS54VDKkjd8PHrm8DHNP1Jppc0L/FG0qxqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PrSf34
	VY+BiBO7WgSZ/H31fJS0zkqYEXFwAr+n4OITL6CxVYEvtaTcka1gZZ/q60kvmebb
	7kDgV6gCoBWiY50/JXKaofqltR5j2NMmDKW+S3GaXneDEsDmnKDLMZDOwwOerMKZ
	q8imVFMhO7JWve6iLlWLEo/8VXebOq40f/64E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E51D16C057;
	Wed, 19 Feb 2014 15:43:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E98A46C053;
	Wed, 19 Feb 2014 15:43:01 -0500 (EST)
In-Reply-To: <xmqq38je9739.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 19 Feb 2014 12:32:26 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6CC41CCE-99A6-11E3-8CA7-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242410>

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
> (Only nitpicks during this round of review).
>
>> +	if (get_device_or_die(path) !=3D get_device_or_die(get_git_dir()))=
 {
>> +		strbuf_reset(&sb);
>> +		strbuf_addf(&sb, "%s/locked", sb_repo.buf);
>> +		write_file(sb.buf, 1, "located on a different file system\n");
>> +		keep_locked =3D 1;
>> +	} else {
>> +		strbuf_reset(&sb);
>> +		strbuf_addf(&sb, "%s/link", sb_repo.buf);
>> +		link(sb_git.buf, sb.buf); /* it's ok to fail */
>
> If so, perhaps tell that to the code by saying something like
>
> 		(void) link(...);
>
> ?
>
> But why is it OK to fail in the first place?  If we couldn't link,
> don't you want to fall back to the lock codepath?  After all, the
> "are we on the same device?" check is to cope with the case where
> we cannot link and that alternate codepath is supposed to be
> prepared to handle the "ah, we cannot link" case correctly, no?

In other words, couldn't that part more like this?  That is, we
optimisiticly try the link(2) first and if it fails for whatever
reason fall back to whatever magic the lock codepath implements.

+	strbuf_reset(&sb);
+	strbuf_addf(&sb, "%s/link", sb_repo.buf);
+	if (link(sb_git.buf, sb.buf) < 0) {
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "%s/locked", sb_repo.buf);
+		write_file(sb.buf, 1, "located on a different file system\n");
+		keep_locked =3D 1;
+	}
+
