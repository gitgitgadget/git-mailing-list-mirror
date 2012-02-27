From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/11] Factor out and export large blob writing code to
 arbitrary file handle
Date: Mon, 27 Feb 2012 09:29:10 -0800
Message-ID: <7v4nucb2xl.fsf@alter.siamese.dyndns.org>
References: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
 <1330329315-11407-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 18:29:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S24Ny-0000X0-WA
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 18:29:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561Ab2B0R3N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 12:29:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54013 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753004Ab2B0R3N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2012 12:29:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FA6368D4;
	Mon, 27 Feb 2012 12:29:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0bi/uFrzUaZr
	ytm9wpfDatm+lCw=; b=XInk4FCIk2IUmGjm4fbXTTwJ7WLMoy+wKvDEjTLlyH39
	BPFVZiFUj6wT+2ObeqSEZVQ2L8fNvOEACj2Tkye1tkEtKKjJdfaHxv7zXsKREpGN
	yupTXIR3aJr99a0eslNC42/lhHiIXZCpUpbRUrrBcrv8Y+dhSDeenefsS3As7KU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dAju1r
	CMJsysCVLPDet+85Yyqg5yrpAs9iiL0CyiYgLcuimx93AFsjvI4gqiKbt3Xmg+F9
	eD0c4bCRDTu7jbkDSdGcriRaWjJADfyxSmSMMLe/Dsnb2hqwk6t/Fk7if+sl06J6
	HAPM3hwRZY+6GNgzNTun6cxEA3qJzFm4OBZiY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 787FD68D3;
	Mon, 27 Feb 2012 12:29:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D21B868D2; Mon, 27 Feb 2012
 12:29:11 -0500 (EST)
In-Reply-To: <1330329315-11407-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 27 Feb
 2012 14:55:06 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9007381A-6168-11E1-9E97-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191632>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  cache.h |    3 +++
>  entry.c |   39 ++++++++++++++++++++++++++-------------
>  2 files changed, 29 insertions(+), 13 deletions(-)

It was the goal of the original streaming output topic to helping more
callers stream the data out directly from the object store in order to
reduce memory pressure, and this series is very much in line with its
spirit.

The static version of streaming_write_entry() in entry.c was very speci=
fic
to writing out an index entry out to the working tree, and it made perf=
ect
sense to have the function in that file, but its interface was limited =
to
the original context the function was used in.

The whole point of your refactoring in this patch is to make it availab=
le
for callers outside that original context; e.g. archive that finds blob
SHA-1 from a tree and writes the blob out to its standard output.  They
should not have to work with an API that takes a cache-entry and writes=
 to
a working tree file.  And your result is much more generic.

So I think the external declaration and the definition should move to a
more generic place, namely streaming.[ch].  It does not belong to entry=
=2Ec
anymore.

Thanks for working on this.
