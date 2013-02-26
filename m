From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] config: factor out config file stack management
Date: Tue, 26 Feb 2013 14:10:03 -0800
Message-ID: <7vobf6loas.fsf@alter.siamese.dyndns.org>
References: <cover.1361751905.git.hvoigt@hvoigt.net>
 <6c69068b4e6a72a2cca5dc6eaffa9982032a7f2a.1361751905.git.hvoigt@hvoigt.net>
 <7v4nh13plo.fsf@alter.siamese.dyndns.org> <20130226193050.GA22756@sandbox-ub>
 <20130226193850.GB22756@sandbox-ub>
 <20130226195449.GA13830@sigill.intra.peff.net>
 <20130226200940.GF22756@sandbox-ub>
 <20130226201518.GC13830@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 26 23:10:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UASjL-0004XY-B2
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 23:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757589Ab3BZWKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 17:10:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54105 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757034Ab3BZWKG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 17:10:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2854B7FA;
	Tue, 26 Feb 2013 17:10:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C/VlN4qqyi5chA7ImypkHFMxod4=; b=qfdYXr
	8/uQ73Ojijz+qWcbbAqbs2M1gpqnfvlt3g5pYtaf7ArNfLxRE9d1CoV/Gf2zIap2
	Dx3TXqvFJeLEOU7mVokoBo18GUACziK8SOzm8c5Ca+LQW0zkC0/hMT/a/DeoMpnb
	ooopEcqD9J84BoP8sEB4pxztowXOFy2aVb2IU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jERzNbxuYg6cW0o7pWFgtHQz9K3U4lLC
	1tWzPCWn1b7DdRkOUH8EIG2UYt6VV8UafZo7RhqbAdm/UWRpulJ2ZpuMIzSLarg2
	pMTnZMNTutA7avs7kFzlaooyKtVqdemcB2doBWmF+W0dxVoLuOPvnHdXJ/1xtMRs
	VVyQuVsGSxo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6CBCB7F6;
	Tue, 26 Feb 2013 17:10:05 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0F47BB7F4; Tue, 26 Feb 2013
 17:10:04 -0500 (EST)
In-Reply-To: <20130226201518.GC13830@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 26 Feb 2013 15:15:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 46186026-8061-11E2-90D5-F3C82E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217185>

Jeff King <peff@peff.net> writes:

> I wonder if it would be more obvious with the more usual OO-struct
> functions, like:
>
>   struct config_source {
>           ...
>   };
>   void config_source_init_file(struct config_source *, const char *fn);
>   void config_source_init_strbuf(struct config_source *,
>                                  const struct strbuf *buf);
>   void config_source_clear(struct config_source *);
>
>   int config_source_parse(struct config_source *);
>
> and then the use would be something like:
>
>   struct config_source top;
>   int ret;
>
>   config_source_init_file(&top, "foo");
>   ret = config_source_parse(&top);
>   config_source_clear(&top);
>
>   return ret;
>
> I.e., "init" constructors, a "clear" destructor, and any methods like
> "parse" that you need.

Yup, that cocincides with my first impression I sent out for the
previous RFC/PATCH round.
