From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] help.c: Add support for htmldir relative to
 git_exec_path()
Date: Fri, 04 Jul 2008 02:26:54 -0700
Message-ID: <7vk5g2uhi9.fsf@gitster.siamese.dyndns.org>
References: <394A4A6F-3D31-4E38-A312-B49DE54FBBDD@zib.de>
 <1215162566-16062-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Jul 04 11:28:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEhal-0003Pv-1Q
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 11:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924AbYGDJ1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 05:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753883AbYGDJ1L
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 05:27:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44758 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342AbYGDJ1K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 05:27:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 209E914DDE;
	Fri,  4 Jul 2008 05:27:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 55FEE14DDD; Fri,  4 Jul 2008 05:27:03 -0400 (EDT)
In-Reply-To: <1215162566-16062-1-git-send-email-prohaska@zib.de> (Steffen
 Prohaska's message of "Fri, 4 Jul 2008 11:09:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 60151682-49AB-11DD-9F8F-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87380>

Steffen Prohaska <prohaska@zib.de> writes:

> If htmldir (in the Makefile) is a relative path, this path will be
> interpreted relative to git_exec_path.  This can be used to create an
> installation that can be moved to a different directory without
> re-compiling.  The Windows installer (msysgit) is an example for such
> a setup.
> ...
> +	const char* html_path = GIT_HTML_PATH;

Style.  Asterisk sticks to the variable, not type.

> +	if (!is_absolute_path(html_path)) {
> +		struct strbuf d = STRBUF_INIT;
> +		strbuf_addf(&d, "%s/%s", git_exec_path(), html_path);
> +		html_path = strbuf_detach(&d, NULL);
> +	}

I've seen similar "if $this (which is usually an absolute) is relative, it
is taken as relative to git_exec_path" solution employed elsewhere in the
MinGW series, and I think it makes sense, even though initially I thought
it was somewhat hacky.

Could you check if there are copy-and-pasted duplicated code you can
factor out before continuing this direction?  I suspect templates and
etc/gitconfig are specified in similar fashion, and it would probably be
easier to maintain if you define once:

	char *system_path(const char *specified)
        {
        	if (is_absolute_path(specified))
	                return specified;
		... strbuf dance ...
                return strbuf_detach(...);
        }

and use it like this:

	const char *html_path = system_path(GIT_HTML_PATH);
