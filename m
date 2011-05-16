From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 6/9] receive-pack: Prepare for addition of the new
 'limit-*' family of capabilities
Date: Sun, 15 May 2011 23:50:28 -0700
Message-ID: <7vaaenm957.fsf@alter.siamese.dyndns.org>
References: <201105151942.29219.johan@herland.net>
 <1305495440-30836-1-git-send-email-johan@herland.net>
 <1305495440-30836-7-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 16 08:50:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLrdb-0002YS-Ud
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 08:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774Ab1EPGuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 02:50:39 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55670 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715Ab1EPGui (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 02:50:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 84DC23943;
	Mon, 16 May 2011 02:52:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ii58nTtuZairo47ijfj3jZFHiEs=; b=JFAcaQ
	9mTyCRny/htpT4l5bW+dfDGWM5ddPaUeIK/mUYCRnc2ZdEFfR/BzAbJmYDpqw4vk
	qcLiHWyAgOtPYUeoUR5K+7C9ikMIR42mempFdhTxWSIQu5XxnuHeHIO5FDQZpDg2
	GB1tssItXUd591j3sa8CruYQXX5HsZixeDWQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nfEMeCmPBIgD/9N0dwXO1FA5TU88yEaB
	Ki0+hA1Zxx+Tky3fFJEdcgnzgw5EQI5uyeUKlYaJklqUSmmv9/oZ7VQVjgM35vXo
	xGMuCQ2tTZ+CKsksZU2rk49iqi7UkEu3sn4wEkkt82HK5wxmnJ2+5pPEbc6FYSvl
	XGUVdJ/N4Yk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5244C3941;
	Mon, 16 May 2011 02:52:41 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 26A103940; Mon, 16 May 2011
 02:52:36 -0400 (EDT)
In-Reply-To: <1305495440-30836-7-git-send-email-johan@herland.net> (Johan
 Herland's message of "Sun, 15 May 2011 23:37:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1817617A-7F89-11E0-A5A4-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173710>

Johan Herland <johan@herland.net> writes:

> +const char *server_supports(const char *feature)
>  {
> -	return server_capabilities &&
> -		strstr(server_capabilities, feature) != NULL;
> +	if (server_capabilities)
> +		return strstr(server_capabilities, feature);
> +	return NULL;
>  }

I've been meaning to fix this part, but currently the feature set is given
as space separated list " featurea featureb featurec" and we check with a
token without any space around, e.g. "if (server_supports("no-done"))",
which is quite broken.

We should tighten this strstr() to make sure we are not matching in the
middle of a string, and the need to do so is even greater now that you are
going to introduce "foo=<value>" and the value could even be strings in
the future.

How about implementing rules like these:

 - feature must appear at the beginning of server_capabilities, or the
   byte immediately before the matched location in server_capabilities
   must be a SP; and

 - if "feature" does not end with an equal sign, it does not expect a
   value. The byte after the matched location in server_capabilities must
   be either the end of string or a SP. A feature that expects a value is
   checked with 'server_supports("feature=")' and the matched location in
   server_capabilities can be followed by anything (i.e. if at the end of
   string or a SP, it gets an empty string as the value, and otherwise it
   will get the stretch of bytes after the '=' up to the next SP).

Given the server_capabilities string "foo=ab bar=froboz boz=nitfol",
I would like to see these happen:

  server_supports("foo=") matches "foo=ab";

  server_supports("ab") does not match anything;

  server_supports("bar") does not match anything;

  server_supports("boz") matches boz=nitfol, without failing at
                         the end of bar=froboz that comes earlier.
