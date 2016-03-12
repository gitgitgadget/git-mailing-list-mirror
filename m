From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] clone: add `--shallow-submodules` flag
Date: Fri, 11 Mar 2016 16:41:54 -0800
Message-ID: <xmqqa8m4a5nx.fsf@gitster.mtv.corp.google.com>
References: <1457739683-1972-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, larsxschneider@gmail.com, jrnieder@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Mar 12 01:42:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeXd9-00049u-Kb
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 01:42:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbcCLAl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 19:41:59 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61670 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750980AbcCLAl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 19:41:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 39A2E4D800;
	Fri, 11 Mar 2016 19:41:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QtqQgIOjpij+47QqOFtVhmC+T/k=; b=rDHtbp
	KslPP2cFzvndo2KzlEmvcfSXe50qBZIn9Biv1hH+xYJz3wcs6M6z2qfNtV3Irxi4
	a830Rd6CfWDgvEVdSRuTAfRM9CnlYzYFv+pNLeaG1ihbSnzZu1dL0V+znhfwFGsg
	m/8bJbtBJXiNm+jtJ1LCXqP8Km6pKzvt9yAco=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nzrLvPrHG8UU7ByOOiQgex8/KjJqDmxc
	tlQIbxJMWl+yuxaoBC3/0k1c0Qubi0ldfoEBhg29luln66yxM9jNbDCX+isJUCnK
	o1nphvPh0hOGz2DiK312IVTUag971dSgZFEWdwWDqkvTe62yqqGmyD2IqXZqqWj9
	JEPBRz+TAw0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 308034D7FF;
	Fri, 11 Mar 2016 19:41:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 96F614D7FE;
	Fri, 11 Mar 2016 19:41:55 -0500 (EST)
In-Reply-To: <1457739683-1972-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 11 Mar 2016 15:41:23 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 38865A04-E7EB-11E5-A0CE-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288721>

Stefan Beller <sbeller@google.com> writes:

> When creating a shallow clone of a repository with submodules, the depth
> argument does not influence the submodules, i.e. the submodules are done
> as non-shallow clones. It is unclear what the best default is for the
> depth of submodules of a shallow clone, so we need to have the possibility
> to do all kinds of combinations:
>
> * shallow super project with shallow submodules
>   e.g. build bots starting always from scratch. They want to transmit
>   the least amount of network data as well as using the least amount
>   of space on their hard drive.
> * shallow super project with unshallow submodules
>   e.g. The superproject is just there to track a collection of repositories
>   and it is not important to have the relationship between the repositories
>   intact. However the history of the individual submodules matter.
> * unshallow super project with shallow submodules
>   e.g. The superproject is the actual project and the submodule is a
>   library which is rarely touched.
>
> The new switch to select submodules to be shallow or unshallow supports
> all of these three cases.

I think something like this is necessary to prime the well, but the
more important (and intereseting) bit is how this shallowness is
going to be maintained and carried forward across the future updates
to the top-level supermodule.  A submodule that was cloned at depth=1
initially along with its supermodule when the latter was initially
cloned does not have to be indefinitely kept at depth=1, and there
would be a lot of creative ways to make it useful, but the creative
and useful logic would need a piece of information to tell the
future "submodule update" why the submodule repository is shallow to
take into account, I would imagine.

It is somewhat curious that there is no hint left in the submodule
repositories (e.g. their configfile) that they are originally
created with an explicit user request "I said that I want these
submodules to be cloned with depth=1", from that point of view.
