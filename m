From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make sure to use Araxis' "compare" and not e.g.
 ImageMagick's
Date: Mon, 23 Jul 2012 14:24:22 -0700
Message-ID: <7vipdejhmh.fsf@alter.siamese.dyndns.org>
References: <500CF8CE.90906@gmail.com> <500CF9D2.30102@gmail.com>
 <500CFB19.6010905@gmail.com> <7vmx2qmnfw.fsf@alter.siamese.dyndns.org>
 <500DA7F3.3000403@gmail.com> <7v4noykxvm.fsf@alter.siamese.dyndns.org>
 <CAHGBnuOz94YR9wx_goL5YaWzPt5Z9c3gBB9CtyfcE40F5amrXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 23:24:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StQ7D-0004qq-6a
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 23:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754977Ab2GWVY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 17:24:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32926 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754900Ab2GWVYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 17:24:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC5888340;
	Mon, 23 Jul 2012 17:24:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q+k5TMLec8VDEL7sPLxw/mq9z6I=; b=yI5bty
	XuPzZLL6LOa+nINfBooBDstgAHw81d6xw5JRbSpzyhb2CvabfOys9b04S2+IenNL
	Lq5tQSs1xtgyLJnXgnt2/2UONDNIT7Z6Jp/a4HboNEIAH8ohs+moHTKzdsvABpjV
	AmiIZ1hf8pYOi40IcumewZMgQhFoUXTPYIZj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vewGO5JGyomOuZcRsCoHlFJOoMMBOjhs
	PVPKyyG335Nsm9ItbDWVxnin3ppyEeKvoBajCwOzevOh3BpC24Q5vVC0tezcZ9dn
	qaa2bP8kqegZSLCWnVpPgKI38/gecgdyKPGELzl1SFbvuUVjMpHz5sP/i+ERa6N+
	7gEm/vwtLd4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9FD8833F;
	Mon, 23 Jul 2012 17:24:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3882A833C; Mon, 23 Jul 2012
 17:24:24 -0400 (EDT)
In-Reply-To: <CAHGBnuOz94YR9wx_goL5YaWzPt5Z9c3gBB9CtyfcE40F5amrXw@mail.gmail.com>
 (Sebastian Schuberth's message of "Mon, 23 Jul 2012 23:09:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C6610CDE-D50C-11E1-AE51-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201986>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> We have no such assurance. That's why you correctly call it a
> heuristics after all

ImageMagick "compare" takes "--version" and says something like
this to its standard output:

    $ compare --version
    Version: ImageMagick 6.6.0-4 2012-05-02 Q16
    http://www.imagemagick.org
    Copyright: Copyright (C) 1999-2010 ImageMagick Studio LLC

Does Araxis compare take "--version" and behave in a way that is
cheaply controllable?  If it opens a GUI window and pops up a dialog
that says "Option not understood", then it is not "controllable",
but if it quickly dies with "No such option" sent to the standard
error output, or sending its version string to the standard output,
then we could use something like:

	case "$(compare --version 2>/dev/null)" in
        "Araxis compare version"*)
        	echo compare ;;
	*)
        	echo "$1" ;;
	esac

instead, and that would be more robust than the path based
heuristics.
