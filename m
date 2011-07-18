From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] config: Introduce functions to write non-standard
 file
Date: Mon, 18 Jul 2011 16:54:20 -0700
Message-ID: <7vr55n9mc3.fsf@alter.siamese.dyndns.org>
References: <20110713190724.GA31965@sigill.intra.peff.net>
 <1311025032-835-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 01:54:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qixds-0007pr-5d
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 01:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036Ab1GRXyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 19:54:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44458 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750829Ab1GRXyX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 19:54:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71F0A441C;
	Mon, 18 Jul 2011 19:54:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/zcDVTBIAUdgPvoJb0JLMSJnbsM=; b=ZkhhZi
	M9P+Av2pIuXeSelAABF8SBu1QMTDnyjOuL5yi/gsi2rJmXbmMm4S+9kibRcq0lZB
	LNUDt02/BU58S1t/M21xWEUuhZ1kfZH7KUBbeP/xcJ4BX+ksAYY21HnEudMG5VjN
	a9GxjjxUTiEnfG8AhsxrKl/Bh62z602+9cvfs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lTE9DEKXOYwiS2VFl8iOB4zvYAz3GikT
	oJRrjH7KutEWfgCAoulPwgiF7M+qJU3ywDXE2jAYGGyHN1fb4CIzACjTl2028xMu
	qZRp2DQxjXiZiMl3PdzLTOPXOxa6bW8gdBElfjOT+ALZijHSkX9lOXSGYjdSOoDx
	SBOCU8+Fw04=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 685F0441B;
	Mon, 18 Jul 2011 19:54:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2CF54419; Mon, 18 Jul 2011
 19:54:21 -0400 (EDT)
In-Reply-To: <1311025032-835-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Tue, 19 Jul 2011 03:07:12 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 42268274-B199-11E0-9857-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177430>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> +int git_config_set_in_file(const char *key, const char *value,
> +			const char *filename)
> +{
> +	const char *saved;
> +	int ret;
> +
> +	saved = config_exclusive_filename;
> +	config_exclusive_filename = filename;
> +	ret = git_config_set_multivar(key, value, NULL, 0);
> +	config_exclusive_filename = saved;
> +	return ret;
> +}

Yuck, what an ugly hack when you are so close.  Why not restructure the
code in such a way that the updated config-set-multivar and set-in-file
share the code better?  If the former takes a hardcoded logic to decide
which file to write to while the latter takes the filename to write to as
its argument, wouldn't it be a lot more natural to make config-set-multivar
call set-in-file after computing what filename parameter to pass?
