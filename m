From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 15/15] ref-filter: introduce objectname_atom_parser()
Date: Tue, 05 Jan 2016 13:31:42 -0800
Message-ID: <xmqqegdviugx.fsf@gitster.mtv.corp.google.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
	<1451980994-26865-16-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 22:31:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGZCo-0001ia-1h
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 22:31:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939AbcAEVbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 16:31:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56740 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752018AbcAEVbp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 16:31:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ABD9D38ADC;
	Tue,  5 Jan 2016 16:31:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Wg18i6Try0ccgqu9we81EcdzPPo=; b=grrJnx
	VzOZkkcLqN/n4yqEDx8ZLYIT2CaZvkBEWYZaLHB+RrckkiJjHTSmSyq9HT9O46Ym
	MIU+7ImJNuxnyZ3FktPhit/If232DbhWx3OL0BVZmDAWcLx6gWR6NDGYBzrPOy2x
	FEv0/Y2RchUg0NrMMYhQxl0lYYL0EArDci2zg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PxnDaCxjOvps7jXhkJAP+TSHqYRSJ4NU
	7DPwlWfV9WzWGLQptLkwiLPgvxq4SQ1rYLeMMKhTMTdP1rq2vDSqAJafpEA2oa9z
	MXGOyYXYlhV3oxK0IUDXLH60wEBSuIPNJPvkx5ErYvs4WZslNM1r2YIBr1pOi95L
	RCG6bAomYqw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A3DC638ADB;
	Tue,  5 Jan 2016 16:31:44 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2471F38AD9;
	Tue,  5 Jan 2016 16:31:44 -0500 (EST)
In-Reply-To: <1451980994-26865-16-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Tue, 5 Jan 2016 13:33:14 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B77E7C00-B3F3-11E5-AD00-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283405>

Karthik Nayak <karthik.188@gmail.com> writes:

> @@ -467,15 +482,17 @@ static void *get_obj(const unsigned char *sha1, struct object **obj, unsigned lo
>  }
>  
>  static int grab_objectname(const char *name, const unsigned char *sha1,
> -			    struct atom_value *v)
> +			   struct atom_value *v, struct used_atom *atom)
>  {
> -	if (!strcmp(name, "objectname")) {
> -		v->s = xstrdup(sha1_to_hex(sha1));
> -		return 1;
> -	}
> -	if (!strcmp(name, "objectname:short")) {
> -		v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
> -		return 1;
> +	if (starts_with(name, "objectname")) {

The original used to reject "objectnamefoo", but the updated one is
more sloppy.  Shouldn't it be doing the same match_atom_name() here?

This comment applies to many remaining strcmp() and starts_with()
that is reachable from populate_value().
