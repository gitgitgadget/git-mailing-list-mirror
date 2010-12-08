From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2.1 3/4] describe: Store commit_names in a hash table by
 commit SHA1
Date: Wed, 08 Dec 2010 14:50:48 -0800
Message-ID: <7v1v5rkhfb.fsf@alter.siamese.dyndns.org>
References: <alpine.DEB.2.02.1011171830050.14285@dr-wily.mit.edu>
 <20101203084348.GD18202@burratino>
 <alpine.DEB.2.02.1012060149550.23348@dr-wily.mit.edu>
 <20101206073214.GA3745@burratino>
 <alpine.DEB.2.02.1012061159500.23348@dr-wily.mit.edu>
 <7vfwu9qvew.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.02.1012072204371.23348@dr-wily.mit.edu>
 <alpine.DEB.2.02.1012072341570.23348@dr-wily.mit.edu>
 <alpine.DEB.2.02.1012072343300.23348@dr-wily.mit.edu>
 <alpine.DEB.2.02.1012081319320.23348@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Thomas Rast <trast@student.ethz.ch>
To: Anders Kaseorg <andersk@ksplice.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 23:51:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQSqv-0002ao-41
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 23:51:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756455Ab0LHWvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 17:51:06 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52688 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755071Ab0LHWvF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 17:51:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9D8102343;
	Wed,  8 Dec 2010 17:51:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=ffiK7sSlBKw96dZTLriPCvEWqtk=; b=St+s9MAOKRhw4F+tgleKhzD
	IRAjVRIjwpqg7kjqLaHv/F8LfvGdFhQuF6HiSMvhGKTirjhCSTGttqaE9qhzPdqR
	WCFjXaFx/12HofN4VKDRxlc9oAwRTIevrgBkP9qxUPFalsfgyvG4LsmsHmZj+5xt
	qUegcu9VITSKJjIKTiAI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=tSVlnjCX/a/x5CkmU2D3EcvY5SJaOJEQ7G6JezicDt/w8qJMf
	+OrbbosxXcxt35z2HFKZ6x2x0HE+Zs7iJvMoPIXJiDZmCujHj03TB2qGp85COfGB
	g6spwhGoSynQuqOXsaAjPr9k/n2qJfyK5VpBZk5OgMk5GG9F3EgdOBOwgY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3BD2E232B;
	Wed,  8 Dec 2010 17:51:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 233D02320; Wed,  8 Dec 2010
 17:51:12 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ACF8ACC4-031D-11E0-ABB3-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163230>

Anders Kaseorg <andersk@ksplice.com> writes:

> @@ -44,6 +47,19 @@ static const char *prio_names[] = {
>  	"head", "lightweight", "annotated",
>  };
>  
> +static inline unsigned int hash_sha1(const unsigned char *sha1)
> +{
> +	return *(unsigned int *)sha1;
> +}

Do we know that all the archs we will be compiled on will be happy with
this potentially unaligned access?  hash_filespec() in diffcore-rename.c
is written in a way to avoid such an issue, and I would feel safer to see
this do the same.
