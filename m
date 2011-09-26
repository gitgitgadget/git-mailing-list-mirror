From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Add js=1 before an URI fragment to fix line
 number links
Date: Mon, 26 Sep 2011 16:06:31 -0700
Message-ID: <7vaa9q29ag.fsf@alter.siamese.dyndns.org>
References: <1317060642-25488-1-git-send-email-peter@stuge.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Peter Stuge <peter@stuge.se>
X-From: git-owner@vger.kernel.org Tue Sep 27 01:06:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8KFz-0006eU-IJ
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 01:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741Ab1IZXGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 19:06:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61038 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884Ab1IZXGe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 19:06:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B053B42BB;
	Mon, 26 Sep 2011 19:06:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JfMxIXKqLjrIFjuxD//9E1z/5/I=; b=rQ6CfO
	Mv7B730WXr3d0ZnZYKOydtfyHtpVV0OtYllCAkCHrqbS8N9qocgMc5L96IfUcPz9
	1Z764fCyEFh2UispSLlpbUc+rVSD/sHfqv2Stv1VRYOj01rdRbjAfKG5Qg+nk2S2
	SfszT1AYKn9XZbiN9m0NuulLNtQgE7Fss+K/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P/zK/sDDEXHWjv0IDt6grUSdk8NM3W5t
	vTVfdmDNCFBVbjSq8CF+4tdAc2Jpr3dBI5uyiMHexlp1Oj5MHQEDMUAOclIuTnED
	QCRbLfZ9PIy4abMAUzpGTLq3R2abQjERUq8Lc4wImDz9fVfkOnuFC6NKI0xkBoZR
	Ezbpu/+RAxw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5EE742BA;
	Mon, 26 Sep 2011 19:06:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C94842B8; Mon, 26 Sep 2011
 19:06:33 -0400 (EDT)
In-Reply-To: <1317060642-25488-1-git-send-email-peter@stuge.se> (Peter
 Stuge's message of "Mon, 26 Sep 2011 20:10:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2D387EC6-E894-11E0-B5E3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182181>

Peter Stuge <peter@stuge.se> writes:

> -var jsExceptionsRe = /[;?]js=[01]$/;
> +var jsExceptionsRe = /[;?]js=[01](#.*)?$/;
>  
>  /**
>   * Add '?js=1' or ';js=1' to the end of every link in the document
> @@ -33,9 +33,9 @@ function fixLinks() {
>  	var allLinks = document.getElementsByTagName("a") || document.links;
>  	for (var i = 0, len = allLinks.length; i < len; i++) {
>  		var link = allLinks[i];
> -		if (!jsExceptionsRe.test(link)) { // =~ /[;?]js=[01]$/;
> -			link.href +=
> -				(link.href.indexOf('?') === -1 ? '?' : ';') + 'js=1';
> +		if (!jsExceptionsRe.test(link)) { // =~ /[;?]js=[01](#.*)?$/;

Let's not repeat the regexp in the comment (badness you inherited from the
original).

Regarding the "we already have the js=0 or js=1 in the URL" check here...

> +var jsExceptionsRe = /[;?]js=[01](#.*)?$/;

... I am wondering who guarantees that this js=[01] is the last parameter
before the fragment identifier. The answer obviously is "the way the
current code is written using replace() method on link.href", but that is
somewhat disturbing, because it is not clear what should happen, short of
total rewrite of the code around this, when somebody needs to include
another variable, say xx=[01], just like the js=[01] you are fixing here,
in the resulting URL. In other words, this fixLinks() logic does not seem
to scale and also looks brittle.

The patch itself looks correct as a short-term fix, though.

Thanks.
