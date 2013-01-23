From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Revoke write access to refs and odb after importing
 another repo's odb
Date: Wed, 23 Jan 2013 09:01:06 -0800
Message-ID: <7v1udbj0kt.fsf@alter.siamese.dyndns.org>
References: <1358948067-2792-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 18:01:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty3hb-0004Ys-Lb
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 18:01:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756580Ab3AWRBL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jan 2013 12:01:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62850 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756275Ab3AWRBJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jan 2013 12:01:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B3FF0CE90;
	Wed, 23 Jan 2013 12:01:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jyM5MPHMWBHu
	5t5j9JoCJRP5OeA=; b=utsTd9CaQ9Y4hsHg3fIqrtckgX9v++CalaONFyHRgDVx
	VXNZyLWDepT4t3JbBMWaM8drOBwp8rN4IyBPzRamgP8ZUmqA4P+LD3P155dqnYay
	Vv6qkP+VroUuyO+Rv7q+UUDrCBXyGt9DCbZVsvhSyPW0YZorOlO2+tzwVtVFbHw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cPoq/5
	JYfYPSxO5oPSo0TGzgUNEwqSQm2ehW4IpHu2BtJHQXcECvQ2yktj/kH5kTSkX/dk
	P7ngzbltBgxSrh/W+likETfLA5UOoBfrQdWI47FFlH6mhdOA5dNs+i3wyzB5l6Fl
	2CqG87iDrV4hEKtNaPK6QL/lrhMY9bm5cf8Qg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6F8FCE8E;
	Wed, 23 Jan 2013 12:01:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12168CE88; Wed, 23 Jan 2013
 12:01:07 -0500 (EST)
In-Reply-To: <1358948067-2792-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 23 Jan
 2013 20:34:27 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7B24AE9E-657E-11E2-B262-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214335>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> add_submodule_odb() can be used to import objects from another
> repository temporarily. After this point we don't know which objects
> are ours, which are external. If we create an object that refers to a=
n
> external object, next time git runs, it may find a hole in the object
> graph because the external repository may not be imported. The same
> goes for pointing a ref to an external SHA-1.
>
> To protect ourselves, once add_submodule_odb() is used:
>
>  - trees, tags and commits cannot be created
>  - refs cannot be updated
>
> In certain cases that submodule code knows that it's safe to write, i=
t
> can turn the readonly flag off.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  I think this is a good safety check.

Two step implementation to bring "read-only" support into a testable
shape and then flip that bit in add_submdule_odb() would be a
sensible approach.

I however have this suspicion that this will become a losing battle
and we would be better off getting rid of add_submodule_odb();
instead operations that work across repositories will be done as a
subprocess, which will get us back closer to one of the original
design goals of submodule support to have a clear separation between
the superproject and its submodules.
