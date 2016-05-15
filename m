From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 3/3] convert: ce_compare_data() checks for a sha1 of a path
Date: Sun, 15 May 2016 15:14:11 -0700
Message-ID: <xmqq7fev55qk.fsf@gitster.mtv.corp.google.com>
References: <20160513134953.GE2345@dinwoodie.org>
	<1463294299-20256-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Mon May 16 00:14:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b24Iq-0000Uh-7c
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 00:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbcEOWOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 18:14:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50514 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751798AbcEOWOP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 18:14:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FF65196E9;
	Sun, 15 May 2016 18:14:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0MbtaiO4jxZXGZocVLJk2I2pq/Y=; b=DH1rkP
	MRK4X6MI6237pxpB/iYC1wyKpwUEQ6MpPPs55+hGyEIEj1o+yyeNfGBhh5VHMZAC
	AzEV42NNMZsfkyMu2PY+nje0x+Q+rYqp3s7hRzfYTLfcrxSWXtiUGBDDHI3oWWcr
	Vg5M6+VLuE/Q96FKV6ZFTf9PBlMUN5J1R5h5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lehft4Yf+H3ZwG778fdRzINcOl7wedpZ
	nUlnot/RdHfo4MO2IXzp23lg0kdCObUvugRnUVPA9VPVw/4Ix7+OLUxUAcF0jyh+
	jy9CrdmCwTqwvHSj3D2j4sdDw6AoHTPQIRhG5Qy7w53abVAAxr3Bsy63SY4NmFOn
	EAE4LGFK410=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 887D6196E8;
	Sun, 15 May 2016 18:14:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C4F2196E7;
	Sun, 15 May 2016 18:14:12 -0400 (EDT)
In-Reply-To: <1463294299-20256-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Sun, 15 May 2016 08:38:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5ADF5E16-1AEA-11E6-88B8-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294688>

tboegi@web.de writes:

> -static int has_cr_in_index(const char *path)
> +static int has_cr_in_index(const char *path, const unsigned char *sha1)
>  {
>  	unsigned long sz;
>  	void *data;
>  	int has_cr;
> -
> -	data = read_blob_data_from_cache(path, &sz);
> -	if (!data)
> +	enum object_type type;
> +	if (!sha1)
> +		sha1 = get_sha1_from_cache(path);
> +	if (!sha1)
> +		return 0;
> +	data = read_sha1_file(sha1, &type, &sz);
> +	if (!data || type != OBJ_BLOB) {
> +		free(data);
>  		return 0;
> +	}
> +
>  	has_cr = memchr(data, '\r', sz) != NULL;
>  	free(data);
>  	return has_cr;
>  }

Does this really need 2/3?  Wouldn't this be equivalent to

	if (!sha1) {
        	data = read_blob_data_from_cache(path, &sz);
	} else {
        	data = read_sha1_file(sha1, &type, &sz);
	}
	if (!data || type != OBJ_BLOB) {
        	free(data);
                return 0;
	}

        has_cr = ...
