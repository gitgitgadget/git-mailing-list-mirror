From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/13] refs.c: use a single exit path from transaction commit and handle onerr
Date: Tue, 22 Apr 2014 12:14:53 -0700
Message-ID: <xmqq7g6h5g7m.fsf@gitster.dls.corp.google.com>
References: <1398120811-20284-1-git-send-email-sahlberg@google.com>
	<1398120811-20284-3-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 21:15:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcg9m-0001c2-Af
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 21:15:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754357AbaDVTO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 15:14:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63739 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754251AbaDVTO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 15:14:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 021287F044;
	Tue, 22 Apr 2014 15:14:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SbS97PFeu6NbdLX1dXCI6LfPOfg=; b=g70Tu1
	Puk9AB6xsBKIAFSDQb+rZ6juNFaxO1rl80UVBuHHtQbsRQetmL+Cd6tNcZMFtRW7
	cWeXL3XMxSIWoSUTuMYOLd18uJTel40GbShZ9Lgi6TM8MiCUHUUzvB0xGPHJetkw
	KizI1+XGHNSwttAISZOumGK5Hrrhx0hCKaTC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AQmNfkW4ByUtEnepGRsRHo3sHpquOgbO
	Nib/mPQfJPoIO0VMxOH34IWzc3GxSRs79HFxZgSiWxMBTA5DOP8FU54tsrSONTpc
	aP9I0apFl0P3eL23F3+hcK7m6H0Dv0TeHjFkRZaakvFXEaZ4qjCTiqZr2rW7Lweq
	BuMnYHv45/M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9C097F042;
	Tue, 22 Apr 2014 15:14:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3BDD17F03E;
	Tue, 22 Apr 2014 15:14:55 -0400 (EDT)
In-Reply-To: <1398120811-20284-3-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Mon, 21 Apr 2014 15:53:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 63466EE0-CA52-11E3-B8D4-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246773>

Ronnie Sahlberg <sahlberg@google.com> writes:

> @@ -3481,6 +3481,14 @@ cleanup:
>  			unlock_ref(updates[i]->lock);
>  	free(delnames);
>  	ref_transaction_free(transaction);
> +	if (ret) {
> +		const char *str = "Cannot commit transaction.";
> +		switch (onerr) {
> +		case UPDATE_REFS_MSG_ON_ERR: error(str); break;
> +		case UPDATE_REFS_DIE_ON_ERR: die(str); break;
> +		case UPDATE_REFS_QUIET_ON_ERR: break;
> +		}
> +	}
>  	return ret;
>  }

Also on top of this part:

 - avoid complier warning for printf-like functions getting a non
   literal format string as their format argument;

 - style: case label and each statement on its own line.

 - Allow localizing the error message.

diff --git a/refs.c b/refs.c
index e52b6bf..35ce61a 100644
--- a/refs.c
+++ b/refs.c
@@ -3515,11 +3515,16 @@ cleanup:
 	free(delnames);
 	ref_transaction_free(transaction);
 	if (ret) {
-		const char *str = "Cannot commit transaction.";
+		const char *str = _("Cannot commit transaction.");
 		switch (onerr) {
-		case UPDATE_REFS_MSG_ON_ERR: error(str); break;
-		case UPDATE_REFS_DIE_ON_ERR: die(str); break;
-		case UPDATE_REFS_QUIET_ON_ERR: break;
+		case UPDATE_REFS_MSG_ON_ERR:
+			error("%s", str);
+			break;
+		case UPDATE_REFS_DIE_ON_ERR:
+			die("%s", str);
+			break;
+		case UPDATE_REFS_QUIET_ON_ERR:
+			break;
 		}
 	}
 	return ret;
-- 
2.0.0-rc0-187-g5842ffa
