From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 18/27] setup.c: support multi-checkout repo setup
Date: Wed, 05 Mar 2014 11:42:31 -0800
Message-ID: <xmqqlhwoh1p4.fsf@gitster.dls.corp.google.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1393675983-3232-1-git-send-email-pclouds@gmail.com>
	<1393675983-3232-19-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 20:42:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLHiH-00008U-G6
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 20:42:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757138AbaCETmi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2014 14:42:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41203 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753753AbaCETmg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2014 14:42:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E359F70F3E;
	Wed,  5 Mar 2014 14:42:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=M9v1/fcUead3
	dJmtlNWoLZbDU0w=; b=Q7VTeTCHnJ/5+YIDly5oBb5iyUUM5XQWX+Bt+6QsJQGL
	lpvR9S7VSCwHlbSeSEIRXt949gek+JtL2GbYgcDyCc2HRiT6YdXjn5mcMDB2tH/J
	Yd1lwz7f/aFfSRcnPp626Rr8JbZL8VjKzIGcHpCflccS8PVcmTQVVO4KjyAANO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=l4pNA6
	fHpb07hdJ7CQt3wHw8b0DFrkWB53J6Si8zGz4kHH18AlYb3fdHf9WujvOYZCVOnQ
	onPqexoYEOTjLZfM3P/pU5JtFBfDDvZAssHGYE5yduUQyO8pVzcNw/EuKIUugj0+
	eLNS+FHCUn2uNr3a2zWZqaiiYyefC6GrVNHfU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD2FE70F3D;
	Wed,  5 Mar 2014 14:42:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F409870F3A;
	Wed,  5 Mar 2014 14:42:33 -0500 (EST)
In-Reply-To: <1393675983-3232-19-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 1 Mar
 2014 19:12:54 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4CB6E5C6-A49E-11E3-8999-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243472>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

>  core.worktree::
>  	Set the path to the root of the working tree.
> +	If GIT_COMMON_DIR environment variable is set, core.worktree
> +	is ignored and not used for determining the root of working tree.

Just thinking aloud to see if I got the full implication of the
above right...

If we find ourselves in the multi-checkout mode because we saw
=2Egit/commondir on the filesystem, it is clear that the root of the
working tree is the parent directory of that .git directory.

If the reason we think we are in the multi-checkout mode is not
because of .git/commondir but because $GIT_COMMON_DIR is set, should
we assume the same relationship between the root of the working tree
and the GIT_DIR (however we find it) when the environment variable
$GIT_WORK_TREE is not set?  Or should that configuration be an error?
With $GIT_DIR set without $GIT_WORK_TREE set, the user is telling us
that the $cwd is the root of the working tree, so perhaps we should
do the same?
