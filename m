From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Try harder in parse_tag; perhaps it was given ambiguous name
Date: Wed, 05 Dec 2007 13:14:23 -0800
Message-ID: <7vmysoondc.fsf@gitster.siamese.dyndns.org>
References: <200712010245.29204.jnareb@gmail.com>
	<200712051113.40654.jnareb@gmail.com>
	<7v7ijsq5zm.fsf@gitster.siamese.dyndns.org>
	<200712052202.27111.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Guillaume Seguin <guillaume@segu.in>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 22:15:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J01a5-000645-9h
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 22:14:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbXLEVOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 16:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbXLEVOc
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 16:14:32 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:55073 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791AbXLEVOb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 16:14:31 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 62CE32F0;
	Wed,  5 Dec 2007 16:14:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id CE2BD9D31A;
	Wed,  5 Dec 2007 16:14:46 -0500 (EST)
In-Reply-To: <200712052202.27111.jnareb@gmail.com> (Jakub Narebski's message
	of "Wed, 5 Dec 2007 22:02:26 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67194>

Jakub Narebski <jnareb@gmail.com> writes:

> Well, actually that is even better idea. We can go for one of the three
> levels of HTTP status checking:
>
> 1. Check if we got "Status: 200 OK" when we expect it, and not have it
>    when we expect other HTTP status, e.g. when requesting nonexistent
>    file. The above code is enough for that.
>
> 2. We can check if we got expected status number, for example 200 for
>    when we expect no error, or 404 when object is not found, or 403
>    if there is no such object etc. I was thinking about using this version
>    the need to check not full first line, but fragment of it.
>
> 3. We can check full first line, for example
>      Status: 200 OK
>      Status: 403 Forbidden
>      Status: 404 Not Found
>      Status: 400 Bad Request
>    but this might tie gitweb test too tightly with minute details of
>    gitweb output. The above code is good for that too.
>
> What do you think, which route we should go in test?

4. We should check for what we expect in the parts of gitweb output we
   care about.  E.g.

   * If we are making sure it refuses to serve incorrect request
     (e.g. no such repository), we should check for the status, which is
     what we care about (we may not care about how the actual error
     message is stated).

   * Otherwise (and I suspect this is "most of the tests"), we obviously
     expect to have "200 OK", and check for that;

   BUT IN ADDITION

   * If we want to make sure that a specific aspect of the output was
     buggy and a patch fixed it (e.g. an href used a short refname
     without having refs/heads or refs/tags prefixed, causing
     ambiguity), we also should check that part of output in generated
     HTML, not just the HTTP status header.
