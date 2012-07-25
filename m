From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] allow recovery from command name typos
Date: Wed, 25 Jul 2012 10:57:35 -0700
Message-ID: <7vtxwvbu5s.fsf@alter.siamese.dyndns.org>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
 <1343232982-10540-1-git-send-email-rctay89@gmail.com>
 <1343232982-10540-2-git-send-email-rctay89@gmail.com>
 <1343232982-10540-3-git-send-email-rctay89@gmail.com>
 <1343232982-10540-4-git-send-email-rctay89@gmail.com>
 <1343232982-10540-5-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Jeff King" <peff@peff.net>, Thomas Rast <trast@student.ethz.ch>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 19:57:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su5qB-0001tt-G3
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 19:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808Ab2GYR5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 13:57:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42703 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372Ab2GYR5h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 13:57:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CD5190D8;
	Wed, 25 Jul 2012 13:57:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a1SBnRbdNXv3TQCfM8wjrxfeoiU=; b=tOMPVV
	mskX/tciuz1YWQ0s3d0YIj2Ku7iC+CIj6eFU2ssCPHsb6xm405Vcb/UOSlU10bJP
	2ejtbmi2hLvJPHQUOb7XNeuOuaaEEz+a/Ajbly3MM5fIzeHQqKao34QDcEtb/aif
	N+nPd8b0fjdCPmlth7Kcn2/4rWtqn1RgaAeJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lla2phsR9WKKRMM8JjF8A9cJsjRq9iK0
	Dvd8gOESo0VeoNQIr/iv7xJzuyDHg+vzrS2QWyHHHIzHYzoweI2hqo2+cTSwjDQi
	5dVN1wISO2cvHZmtIajkSdGvhuUI/38gcm+XkAajRgq7PoOZ2MjYA/BkS70IPNWH
	NYTBPw6THhg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AF8E90D7;
	Wed, 25 Jul 2012 13:57:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5B6490D6; Wed, 25 Jul 2012
 13:57:36 -0400 (EDT)
In-Reply-To: <1343232982-10540-5-git-send-email-rctay89@gmail.com> (Tay Ray
 Chuan's message of "Thu, 26 Jul 2012 00:16:22 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 37BA1616-D682-11E1-ADE6-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202181>

Tay Ray Chuan <rctay89@gmail.com> writes:

> If suggestions are available (based on Levenshtein distance) and if the
> terminal isatty(), present a prompt to the user to select one of the
> computed suggestions.

The way to determine "If the terminal is a tty" used in this patch
looks overly dangerous, given that we do not know what kind of "git"
command we may be invoking at this point.

Perhaps we should audit "isatty()" calls and replace them with a
helper function that does this kind of thing consistently in a more
robust way (my recent favorite is Linus's somewhat anal logic used
in builtin/merge.c::default_edit_option()).

> +static int shall_advise = 1;
> +static int shall_prompt;

Naming "shall_foo" is a first here.  It is not wrong per-se, but I
think we tend to call these "do we use/perform/etc X" do_X in our
codebase (see builtin/{config.c,fetch-pack.c,notes.c} for examples).
