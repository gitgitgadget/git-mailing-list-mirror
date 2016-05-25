From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add: add --chmod=+x / --chmod=-x options
Date: Wed, 25 May 2016 00:51:42 -0700
Message-ID: <xmqq1t4q378x.fsf@gitster.mtv.corp.google.com>
References: <20160525020609.GA20123@zoidberg>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Edward Thomson <ethomson@edwardthomson.com>
X-From: git-owner@vger.kernel.org Wed May 25 09:51:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5Tba-0008Cv-Io
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 09:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895AbcEYHvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 03:51:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55318 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752293AbcEYHvq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 03:51:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 70B3318BDF;
	Wed, 25 May 2016 03:51:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=04l2BsFX3by/zMMJMSW40DPcJgQ=; b=DqQrcL
	bVDfIc+l6bPV+6UUPEYaqd2jfu258+c56Ft5o7rJJdHegSmro7XYY8RnCXOUl9VV
	ZdpGVFDkVRKbNxL3Z00TsENtrnZKEDguRp+ofcRVXluzZqxKh5YsblWdiOnnmxaL
	KQDgAaUzYTUeuyQaA/t/eoEaSRjsrika8jcPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tJRdwPMQDp0W0YrlacCB+qtalWVO9ZQA
	0JSIZq8jOtel/fUBiz1EcQd27YszzaCdO9WvkU7Yms4KwJi2sXK3ZDwr7VpGRaaj
	zXYTN2TYEDlGsawyNnAr+wJ81XiYFxXrAEY8Jmbg3DVh76JzS2Gdq0DnBTY40FgF
	Djw9wQ5aV88=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6718C18BDD;
	Wed, 25 May 2016 03:51:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C4CC818BDC;
	Wed, 25 May 2016 03:51:44 -0400 (EDT)
In-Reply-To: <20160525020609.GA20123@zoidberg> (Edward Thomson's message of
	"Tue, 24 May 2016 21:06:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 86A5771E-224D-11E6-A805-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295568>

Edward Thomson <ethomson@edwardthomson.com> writes:

>  	if (trust_executable_bit && has_symlinks)
>  		ce->ce_mode = create_ce_mode(st_mode);
> +	else if (force_executable)
> +		ce->ce_mode = create_ce_mode(0777);
> +	else if (force_notexecutable)
> +		ce->ce_mode = create_ce_mode(0666);
>  	else {
>  		/* If there is an existing entry, pick the mode bits and type
>  		 * from it, otherwise assume unexecutable regular file.

I would rather do this part more like:

	if (S_ISREG(st_mode) && (force_executable || force_nonexecuable)) {
        	if (force_executable)
			ce->ce_mode = create_ce_mode(0777);
		else
			ce->ce_mode = create_ce_mode(0666);
	} else if (trust_executable_bit && has_symlinks) {
        	ce->ce_mode = create_ce_mode(st_mode);
	} else {
        	... carry the existing mode over ...

which would make sure that the new code will not interfere with
symbolic links and that forcing will be honored even on filesystems
whose executable bit can be trusted (i.e. "can be trusted" does not
have to mean "must be trusted").
