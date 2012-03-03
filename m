From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Use startup_info->prefix rather than prefix.
Date: Sat, 03 Mar 2012 13:44:13 -0800
Message-ID: <7vbood742a.fsf@alter.siamese.dyndns.org>
References: <cover.1330740964.git.jaredhance@gmail.com>
 <b564d95b1efcd91874beb6d410253f86617f8fa6.1330740964.git.jaredhance@gmail.com> <7v8vji87kg.fsf@alter.siamese.dyndns.org> <CACsJy8DtZLCLfeHNP_eq9kVZxjV3xh3gs6pgQCi=FDZ_Je7_Gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jared Hance <jaredhance@gmail.com>,
	Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 22:44:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3wkY-0008Lm-Gv
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 22:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472Ab2CCVoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 16:44:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57455 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752510Ab2CCVoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 16:44:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB17E7BE2;
	Sat,  3 Mar 2012 16:44:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JkyrlWkdZrzGu7UTAWQ+UfnMt8g=; b=pbwF+C
	ovM8jgBYLFhvsRxuNVmmXCyOC8/Uf/5BzCRjUjaFDuw7qM9x04aho76V0vuV8cCt
	DoAJMx0awGMVkRqxNSLQa0mq/mYBSLgB6wC6CNNpXI5FVkigziNZUrIP2DSPCcEw
	FhZ4O9d/2e3a04aZHuaqTFQYKIpX3PoSGWcXA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=edg5EobfJKTpB4O8xi9LmbY538ghbNvc
	R4qbmvOWiD3XkL8yPbWkiwd9EyX+62bHURnBT1pt+E2koa6MZpYddaX9ilZGi1kI
	koihBtFQ9+WWHlRmlhvnNMMnWpWdOr6hUyu4ZGlBFNw/AOFS6/GLyCvKFCcKJuLZ
	fa4NhG/Efvg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2D217BE1;
	Sat,  3 Mar 2012 16:44:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 781017BE0; Sat,  3 Mar 2012
 16:44:15 -0500 (EST)
In-Reply-To: <CACsJy8DtZLCLfeHNP_eq9kVZxjV3xh3gs6pgQCi=FDZ_Je7_Gw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sat, 3 Mar 2012 16:50:33 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 05C4ECAE-657A-11E1-B199-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192136>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> This patch makes this function only usable when startup_info pointer
> is initialized. As "git" binary is the only caller, the change is ok.
> If non-builtin commands want to use this function, they need to
> initialize startup_info first.

Hrm, that explanation is understandable, but it strongly makes me suspect
that this change is making the code _more_ error prone in the longer term.

When somebody wants to add a new caller to a non-builtin, they need to
think about what prefix to pass, and would realize that they need to call
setup_git_directory() to get it. With the updated code, they can totally
forget and call it without any initialized startup_info.

Adding a totally new command is rare, new non-builtin is rarer, and adding
trace to it is even more so, so it may not be worth worrying about, but I
wonder if there is a cheap way to check such a programming mistake.
