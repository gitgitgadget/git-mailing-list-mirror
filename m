From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/16] repack: consider bitmaps when performing repacks
Date: Tue, 25 Jun 2013 16:00:40 -0700
Message-ID: <7vbo6tztgn.fsf@alter.siamese.dyndns.org>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
	<1372116193-32762-14-git-send-email-tanoku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vicent Marti <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 26 01:00:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrcED-0005Jg-Mp
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 01:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901Ab3FYXAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 19:00:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61138 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751244Ab3FYXAn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 19:00:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B061E2B0AF;
	Tue, 25 Jun 2013 23:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rrBRCrpa02ruo7Uuykkzte2w6iw=; b=NOHRBY
	t/QFfDBmN9LyV9Z8vK8cBsPy/eDJ7HFZLBBgW2saI12HaGduUqbE8L2udOt+PhGD
	jtmaNsEviCOGDrvPkCuVVL8211CSN/jtbhB+1SXjSh5jrY9H8GmO2dnmKiF+ydXp
	i1sbP7a9V1tI1TOIUqyGa9cYsb6jU2G21hVyM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HmpHbruee5pTSlRqBpVHZaAgkG31Poat
	5vLBpbzCQqwOJwx/kfaIh1VyQTkL5pS3//bJvuZdWwd966emmJ9e+Mfuia4kj64Y
	JxAiS+FXBbXm7fbb1yRZTLKb391s90k7uJPEBxgCtlF2M7s6yvtIv2skapb9s6rL
	/24WSt0gRXI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A52CC2B0AE;
	Tue, 25 Jun 2013 23:00:42 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 276B62B0AB;
	Tue, 25 Jun 2013 23:00:42 +0000 (UTC)
In-Reply-To: <1372116193-32762-14-git-send-email-tanoku@gmail.com> (Vicent
	Marti's message of "Tue, 25 Jun 2013 01:23:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F8118EA-DDEB-11E2-9947-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229012>

Vicent Marti <tanoku@gmail.com> writes:

> @@ -156,6 +156,11 @@ do
>  	fullbases="$fullbases pack-$name"
>  	chmod a-w "$PACKTMP-$name.pack"
>  	chmod a-w "$PACKTMP-$name.idx"
> +
> +	test -f "$PACKTMP-$name.bitmap" &&
> +	chmod a-w "$PACKTMP-$name.bitmap" &&
> +	mv -f "$PACKTMP-$name.bitmap" "$PACKDIR/pack-$name.bitmap"

If we see a temporary bitmap but somehow failed to move it to the
final name, should we _ignore_ that error, or should we die, like
the next two lines do?

>  	mv -f "$PACKTMP-$name.pack" "$PACKDIR/pack-$name.pack" &&
>  	mv -f "$PACKTMP-$name.idx"  "$PACKDIR/pack-$name.idx" ||
>  	exit
