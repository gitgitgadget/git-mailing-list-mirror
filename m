From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: ensure correct permissions of the commit message
Date: Sun, 20 Dec 2015 17:31:48 -0800
Message-ID: <xmqq7fk8io3f.fsf@gitster.mtv.corp.google.com>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de>
	<20151220074559.GF30662@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Yaroslav Halchenko <yoh@onerussian.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 21 02:32:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aApKS-0000Fw-OU
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 02:32:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbbLUBb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Dec 2015 20:31:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57801 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750835AbbLUBb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2015 20:31:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 52F6236636;
	Sun, 20 Dec 2015 20:31:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oU00WGUy1TaIrdTgNwxDHWR4roo=; b=Zpji02
	om/rpqG2VhDZ6etOab17YM0Un10poE+PkznpfiFVbYWoP9S3b9Lcwg5+Yy2lhDsr
	5JXGMRY7iU4jy1efvzoK9fNGb1sTde+LDbAsCf56ofSRTfBPTDzwQHsaJoNI+F3R
	PcEn59OB2YVC0IIvXzE8ybNJgnKeDWW8zBt58=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n6rDNvhuelSVzdm0stYjEfgH6lPvOrmm
	2npDWk+dxyCrHCQjVsu4eco2tXQcqcM1ZoFjd5pZUn1jxa4Rb7ahHsLrVd6sk8zE
	QQ4YQiJ6iuB4DUi7wobMGfrRpNJuukrDSPOaQDNvUTUmAgAFYt7z7CdkguVoVzbZ
	BxLZwCr2imM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4AD5136635;
	Sun, 20 Dec 2015 20:31:50 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C061136632;
	Sun, 20 Dec 2015 20:31:49 -0500 (EST)
In-Reply-To: <20151220074559.GF30662@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 20 Dec 2015 02:45:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9B5087EE-A782-11E5-82C6-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282782>

Jeff King <peff@peff.net> writes:

> So I don't have any real problem with this, but I suspect it's just the
> tip of the iceberg. We might want something like:
>
>   FILE *fopen_shared(const char *path, const char *mode)
>   {
> 	FILE *ret = fopen(path, mode);
> 	if (!ret)
> 		return NULL;
> 	if (adjust_shared_perm(path)) {
> 		fclose(ret);
> 		return NULL;
> 	}
> 	return ret;
>   }

Actually, we do not even _need_ a sharedness for this ephemeral
file.  The additional "adjust-shared-perm" is merely a workaround
for the fact the next person cannot write into it when it is left
behind, and because we do not want to remove it when we are done.

That does not measn that the next person cannot remove it when she
finds there is a file there left behind.  So alternatively, we could
do something like this, perhaps?

        FILE *fopen_forcibly(const char *path, const char *mode)
        {
                FILE *ret = fopen(path, mode);

                if (!ret && errno == EPERM) {
                        if (!unlink(path))
                                ret = fopen(path, mode);
                        else
                                errno = EPERM;
                }
                return ret;
        }
