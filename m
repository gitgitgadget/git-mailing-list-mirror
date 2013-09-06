From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/7] replace: forbid replacing an object with one of a different type
Date: Fri, 06 Sep 2013 13:29:21 -0700
Message-ID: <xmqqmwnpwv6m.fsf@gitster.dls.corp.google.com>
References: <20130906050702.6657.25651.chriscool@tuxfamily.org>
	<20130906051100.6657.41248.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Sep 06 22:29:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI2eq-0006Bc-AR
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 22:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322Ab3IFU32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 16:29:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34751 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827Ab3IFU31 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 16:29:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E00083F8B0;
	Fri,  6 Sep 2013 20:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EMeLv2YWaey54NNEhyjpnSLEFLs=; b=Ddk592
	rq4JmxEeHs/YqqFDuABNnuZlwm/oV1BPfscXot2VbHA4oWRLSE1bhaIhfVTfypYo
	IioQ9lGy9sWmo+7RtVSOiZDcA9KE1+AreXf5LJpYQbizB1AtK+sD3cO2W1POL5fZ
	HfsPhamywqjLXusPP7iwOtHK1fP1pRdMLX1MY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mra+45H/7dHZGLWXxLkVlOWTY2gWC8wo
	bv61JPez90ALpPCHxabt799k4ocZFF2TqZIZDpM6FhGWdJbnicQ3CBtZShAj09Cy
	TTj25/z0LsYQYsdvBggVVvQHbBBGvTQtePJpIqezzNNQHtbiQBeVktWyI7GMLVM6
	0NRSBO88B+Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 859823F8AF;
	Fri,  6 Sep 2013 20:29:25 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B9763F8A7;
	Fri,  6 Sep 2013 20:29:23 +0000 (UTC)
In-Reply-To: <20130906051100.6657.41248.chriscool@tuxfamily.org> (Christian
	Couder's message of "Fri, 06 Sep 2013 07:10:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0487A810-1733-11E3-80D9-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234095>

Christian Couder <chriscool@tuxfamily.org> writes:

> +	obj_type = sha1_object_info(object, NULL);
> +	repl_type = sha1_object_info(repl, NULL);

That we can do this is somewhat curious.  If an object is replaced
with a different one, would it mean that this code snippet is
totally bogus?

        type1 = sha1_object_info(sha1, &size1);
        area = xmalloc(size1);
        orig = read_sha1_file(sha1, &type0, &size0);
	memcpy(area, orig, size1);
	free(orig);

> +	if (!force && obj_type != repl_type)
> +		die("Objects must be of the same type.\n"
> +		    "'%s' points to a replaced object of type '%s'\n"
> +		    "while '%s' points to a replacement object of type '%s'.",
> +		    object_ref, typename(obj_type),
> +		    replace_ref, typename(repl_type));
> +
>  	if (read_ref(ref, prev))
>  		hashclr(prev);
>  	else if (!force)
