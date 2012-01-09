From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] index-pack: eliminate unlimited recursion in
 get_delta_base()
Date: Mon, 09 Jan 2012 14:51:50 -0800
Message-ID: <7vvcokcwvt.fsf@alter.siamese.dyndns.org>
References: <1324901080-23215-1-git-send-email-pclouds@gmail.com>
 <1326081546-29320-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 09 23:51:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkO4M-0001v1-CV
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 23:51:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933491Ab2AIWvx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jan 2012 17:51:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51355 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933335Ab2AIWvx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jan 2012 17:51:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07F5C681E;
	Mon,  9 Jan 2012 17:51:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XNwmGCWd9TEl
	ogXZ7gf02aTtf78=; b=xxiZRH8uq6AE0KogyAJCbyJUUmHYADk4ghM4PPFYGOqG
	uF1+rNT8MVtr7pVE0UOpQ5nG1V3SRiAlUXBEwOM7dmONTl8JuF6xercKWRQK4SiA
	yPT4GSCGuEllD2BhHhWU1V+sdLbBGtFDU7pAfqwzrcukotczSbFQLQ9NoR31M+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=e6aKVd
	xKilXsZcbMqD2JAp9gkOx/hLbQANVkA7IRXwf5nXPWOps6tlLwfQcHSnTrfecKIJ
	bgCWX54eRgelnqWo2flhnHTR5tyPYn2wTWD+clH+hiWXJh6j9jsAnnWewAmzKHsi
	kQbnVOP+YXnCJ6NDrupd3sZxYf9urKAKxswMs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F06A0681D;
	Mon,  9 Jan 2012 17:51:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80C9A681C; Mon,  9 Jan 2012
 17:51:51 -0500 (EST)
In-Reply-To: <1326081546-29320-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 9 Jan
 2012 10:59:06 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 850C3F84-3B14-11E1-A47A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188197>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Revert the order of delta applying so that by the time a delta is
> applied, its base is either non-delta or already inflated.
>
> get_delta_base() is still recursive, but because base's data is alway=
s
> ready, the inner get_delta_base() call never has any chance to call
> itself again.

I suspect s/Revert/Reverse/ here, but I have a feeling that the structu=
re
of the resulting code is a bit too complex and subtle.

In parse_pack_objects(), we have two passes. The first pass scans to
enumerate the objects that appear in the pack and sift them into base a=
nd
delta objects, and the second one starts from a base object, resolves i=
ts
immediate children with find_unresolved_daltas(), but that function rec=
urses
many times, bound only by the number of objects in the pack, which is t=
he
issue you are trying to address with this series.

I wonder if a cleaner approach is to change the loop in the second pass=
 in
such a way that (1) the function it calls resolves _only_ the immediate
children of the object we know its final shape (either because the obje=
ct
was recorded in the deflated form in the pack, or we have already resol=
ved
it in earlier iteration), and (2) the loop goes over the objects[] arra=
y
not just once, but until we stopped making progress.

It would require us to be able to tell, by looking at objects[i], if th=
e
object itself has already been handled (perhaps you can look at its
idx.sha1 field for this purpose) and if we have already handled its
immediate delta children (you may need to add a bit to struct object_en=
try
for this).
