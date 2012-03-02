From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Perform cheaper connectivity check when pack is used
 as medium
Date: Thu, 01 Mar 2012 22:10:06 -0800
Message-ID: <7vwr73h6td.fsf@alter.siamese.dyndns.org>
References: <7vmx849ma8.fsf@alter.siamese.dyndns.org>
 <1330435109-4437-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 07:10:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3Lh4-0007Z6-Sb
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 07:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756952Ab2CBGKL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Mar 2012 01:10:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48923 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756754Ab2CBGKJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Mar 2012 01:10:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 401546D37;
	Fri,  2 Mar 2012 01:10:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=Ch5GfLhD8ZIo6f9BzzN3Y5ogA
	DE=; b=SP7xDQEtFPS1Vz3YkZTiiWQtWlzFbPN3X3lzFtoh20l3YXLLTLTvbdJVF
	2/VV7tzPEyels3nBUbNXroVEzMTIt5iCIfBvio7n4ExqjpI0+OH+t2YR7GxakE0t
	vP+YR5HIiUtsXBrN34hGVVQgcanf6vo2AEAd1A/eLk9bhfFb8k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=fYg3qaHQx+Zfxqik0N1
	HUvlcrffPQnd/bjVTfs0XvFDt0IWicxJ/vg6Ry1TpZm9y3C+phPYNnDQZl83gJr0
	Uxu56FmkFbrQE5reVaId89M/0AA/INdtlr2Ak3oAkeh7sDNt4ZX8Df8MIzN1VP/9
	ayInsQiJl/6PJLRjsAgE4Kd0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 373426D36;
	Fri,  2 Mar 2012 01:10:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A933F6D34; Fri,  2 Mar 2012
 01:10:07 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5C439780-642E-11E1-8EC9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192004>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> When we fetch or push, usually "git rev-list --verify-objects --not
> --all --stdin" is used to make sure that there are no gaps between
> existing refs and new refs. --verify-objects calls parse_object(),
> which internally calls check_sha1_signature() to verify object conten=
t
> matches its SHA-1 signature.
>
> check_sha1_signature() is an expensive operation, especially when new
> refs are far away from existing ones because all objects in between
> are re-hashed. However, if we receive new objects by pack, we can
> skip the operation because packs themselves do not contain SHA-1
> signatures. All signatures are recreated by unpack-objects/index-pack=
's
> hashing objects in the pack, which we can trust.
>
> Detect pack transfer cases and turn --verify-objects to --objects.

After thinking more about this patch, I do not think this "optimization=
"
is correct.

Consider a case where you have this history


    ---T       o---o---o

where 'T' is the tip of your ref (everything reachable from it is known=
 to
be good), and 'o' are "isolated islands" commits that somehow exist in
your repository but are not complete for whatever reason.

The global history may look like this, where 'X' is the tip the other e=
nd
advertised, and '.' are commits that are new to your repository.

    ---T---.---o---o---o---.---X

Upon seeing 'X' advertised and noticing 'T' is the current tip, you wou=
ld
ask for everything that is needed, i.e. "rev-list --objects T..X", to b=
e
sent to you.

But the other end could send all the trees and commits for 'X' and '.' =
but
nothing for 'o'.  You will end up with a corrupt history but the loosen=
ed
"rev-list --objects T..X" you run after the object transfer will not ca=
tch
it.  You need --verify-objects if you want to catch this mode of attack=
=2E

Admittedly, in order to mount such an attack successfully, the attacker
needs to know what "isolated islands" you happen to have in the receivi=
ng
repository, which makes it much harder than a simpler attack (e.g. send=
ing
only X but nothing else) that would have worked before we introduced th=
e
connectivity check after object transfer.

But we need to realize that the reasoning expressed in your log message
"we received new objects by pack, so everything must validate fine" is =
not
valid, and we are loosening ourselves to new attacks when we evaluate t=
his
patch.  This is because the completion of the history may be using obje=
cts
that did not come from the other side (i.e. commits 'o' and all the tre=
es
necessary for them, but their blobs may be corrupt).
