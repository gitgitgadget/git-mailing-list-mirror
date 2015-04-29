From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/5] setup: sanity check file size in read_gitfile_gently
Date: Wed, 29 Apr 2015 08:42:22 -0700
Message-ID: <xmqqy4lb54bl.fsf@gitster.dls.corp.google.com>
References: <xmqqfv7nzf56.fsf@gitster.dls.corp.google.com>
	<1430030985-14499-1-git-send-email-erik.elfstrom@gmail.com>
	<1430030985-14499-3-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Erik =?utf-8?Q?Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 17:42:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnU8B-00049b-Ec
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 17:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966360AbbD2Pm0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2015 11:42:26 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60991 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966307AbbD2PmZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Apr 2015 11:42:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 53C854C248;
	Wed, 29 Apr 2015 11:42:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ExQi42kUq44i
	7abqCmVuy8a+4oE=; b=LFSjXD8TURWDNledBVzsKbckIXEsM/7Pw8z3uuaXIvX6
	Wg+YSgJGtKTvA9O+5ABRjEOEI7y2ZGm20Bh+sfFI2To3DBzteeKdasjCY8hUxhmm
	c1Mh8Mq05rUjaVu3e7KpXiiXoDlkBr8Z8QTM2mzhO8oJFgQdLNnFd+YqVTHH8As=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qfx1Lo
	jEER1kZWvFtabCFAXTAejasXzyy6Brkk2D1drzrqYq+ZoxmjNUAEcDl6hSXWanxh
	TmHtSppaec1n3XZGZnsE1ZXYXkrSDHgGEuSx18LtJlvyU4onoxVQ2KQtBrEEz03T
	cBvTSvx3x8SgpzlretXfL0XpYSef1b0lgmjwo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C5D74C246;
	Wed, 29 Apr 2015 11:42:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C3A504C243;
	Wed, 29 Apr 2015 11:42:23 -0400 (EDT)
In-Reply-To: <1430030985-14499-3-git-send-email-erik.elfstrom@gmail.com>
	("Erik =?utf-8?Q?Elfstr=C3=B6m=22's?= message of "Sun, 26 Apr 2015 08:49:42
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 547893A8-EE86-11E4-B13C-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267975>

Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com> writes:

> diff --git a/setup.c b/setup.c
> index c4538ca..792c37b 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -364,6 +364,10 @@ const char *read_gitfile_gently(const char *path=
, int *return_error_code)
>  		error_code =3D READ_GITFILE_ERR_OPEN_FAILED;
>  		goto cleanup_return;
>  	}
> +	if (st.st_size > PATH_MAX * 4) {
> +		error_code =3D READ_GITFILE_ERR_TOO_LARGE;

You have fd already open for the path at this point.  When you
reroll, please do not forget to close(fd) here.

> +		goto cleanup_return;
> +	}
