From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make http-backend REMOTE_USER configurable
Date: Thu, 29 Mar 2012 15:02:52 -0700
Message-ID: <7vzkazoyk3.fsf@alter.siamese.dyndns.org>
References: <1333051139-14262-1-git-send-email-willsk@bnl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, spearce@spearce.org
To: William Strecker-Kellogg <willsk@bnl.gov>
X-From: git-owner@vger.kernel.org Fri Mar 30 00:03:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDNQr-0004gX-Hp
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 00:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754311Ab2C2WC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 18:02:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52150 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753478Ab2C2WCz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 18:02:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED60B65E3;
	Thu, 29 Mar 2012 18:02:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yFHqI5YHIgGiHet0zr+sMTO30/w=; b=JajTR2
	6FINvhY77OaQG5v1mWPL/pVJei2jfIr8+B8JHkpJN/ziYFBUGSQV9+ZPj/KXQPNj
	IXVrQpRy/jzTHu/QhKTuR0CT4Tkv954hG8d9cu+vuDxENEp5joaqBDLth0lVUBgo
	Gv+/Rv6r2UP/68vnW2lWI0d6lKvjXM2v7BAzE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yMKLNQk7xegwq23Q2+hBfLWezPECbFBC
	tFI2q9ruqj16Uh0ar7b8WTxo6S4u+21LnFhUEy7SbgO3563Gr748SbZ+ygG0sn8G
	VkRC42ZKGmIIWWLRl5QnODHy+Gx861sEqFIIT6ZT9kVkbAGAU9eGLxP1Nu/vXRl3
	aj9iLYqYc9c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E317C65E2;
	Thu, 29 Mar 2012 18:02:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7333D65E1; Thu, 29 Mar 2012
 18:02:54 -0400 (EDT)
In-Reply-To: <1333051139-14262-1-git-send-email-willsk@bnl.gov> (William
 Strecker-Kellogg's message of "Thu, 29 Mar 2012 15:58:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EF793402-79EA-11E1-B431-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194297>

William Strecker-Kellogg <willsk@bnl.gov> writes:

> The http-backend looks at $REMOTE_USER and sets $GIT_COMMITTER_NAME to
> that for use in the hooks. At our site we have a third party
> authentication module for our proxy (Shibboleth) which sets an alternative
> environment variable that our backend sees instead of REMOTE USER.
>
> This patch adds the config option http.remoteuser which changes what
> environment variable is inspected by the http-backend code (it defaults
> to REMOTE_USER).

What is the chain of systems that pass the authenticated ident down to
this CGI program?  Can another part of that chain stuff the value of
SHIBBOLETH_USER (or whatever) to REMOTE_USER before running it?

As a design, I am not convinced this is a good change.  

What if the next person wants to interoperate with an authentication
system that passes the same information via a mechanism different from
environment variables?  This change does not help him at all, as it is
still married to "the information has to come from an environment
variable" limitation.

What if an authentication system can supply more appropriate committer
ident information other than just the uesrname part?

If it were a patch to teach the CGI program a new command line parameter,
e.g. --log-as="C O Mitter <committer@example.xz>", it may have made a lot
more sense, though.
