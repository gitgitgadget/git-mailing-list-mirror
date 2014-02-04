From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame.c: prepare_lines should not call xrealloc for every line
Date: Tue, 04 Feb 2014 13:44:55 -0800
Message-ID: <xmqqr47i7dt4.fsf@gitster.dls.corp.google.com>
References: <1391544367-14599-1-git-send-email-dak@gnu.org>
	<xmqqd2j28w3h.fsf@gitster.dls.corp.google.com>
	<874n4ewouz.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 04 22:45:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAnoP-0002ao-B3
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 22:45:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934349AbaBDVpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 16:45:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39532 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934433AbaBDVpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 16:45:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F1C367D0C;
	Tue,  4 Feb 2014 16:45:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=At/l1ypYzLRHH3+qJVamU35z0+A=; b=RCqVAI
	sWHztxID5FPHpJ1l0v9InqWh3hdc+WRIv94v9YEaOLANrklAoMedQFFKegbHUNaZ
	eoVmtHxf39DtJNfCywTr7osPbSKJVV7SxCndi8oCBDzqiLisK8drh6IYDJ6w+5V8
	Ug9OSprtKralsV8uI7sXITEsXqtTI+fvyvu0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uNjZ4TjCyty3SuTxTtDtExvNfDXvTTw2
	vXPBjh4cPJyus5pK7zhU675T8l+/fFmWiUO0BZUsG/j7BDqVumOvomm8EXwdIDrZ
	03tjilDoht35qOSdzIP+GhZ2ll0eeV+4jDdssNi9g8SIxcpk5kx1KXy6Zc4jM3Hp
	p7NydZDXj8c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09E3767D09;
	Tue,  4 Feb 2014 16:45:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D8EA67CBC;
	Tue,  4 Feb 2014 16:45:03 -0500 (EST)
In-Reply-To: <874n4ewouz.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Tue, 04 Feb 2014 22:27:00 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9AA2A312-8DE5-11E3-A779-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241560>

David Kastrup <dak@gnu.org> writes:

> Ok, I now wrote
>
> 	for (p = buf;; num++, p++) {
> 		p = memchr(p, '\n', end - p);
> 		if (!p)
> 			break;
> 	}

Looks still wrong (perhaps this is a taste issue).

	num++ is not "loop control", but the real action of this
	loop to count lines.  It is better left inside.

	p++ is "loop control", and belongs to the third part of
	for(;;).

	Isn't the normal continuation condition "p < end"?

so something like

	for (p = buf; p < end; p++) {
        	p = find the end of this line
                if (!p)
                	break;
		num++;
	}

perhaps?
