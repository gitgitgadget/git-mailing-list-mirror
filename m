From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn error: Unable to parse date
Date: Tue, 17 Feb 2009 10:38:32 -0800
Message-ID: <7vd4dg6h93.fsf@gitster.siamese.dyndns.org>
References: <20090217094850.GQ7504@wouts.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Ward Wouts <ward@wouts.nl>
X-From: git-owner@vger.kernel.org Tue Feb 17 19:40:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZUrX-0000sJ-IA
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 19:40:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbZBQSij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 13:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbZBQSij
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 13:38:39 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44790 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbZBQSii (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 13:38:38 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id AA3062B560;
	Tue, 17 Feb 2009 13:38:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D83662B554; Tue,
 17 Feb 2009 13:38:33 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3095987A-FD22-11DD-A724-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110433>

Ward Wouts <ward@wouts.nl> writes:

> Unable to parse date: 2004-03-09T09:44:33.Z
>  at /usr/bin/git-svn line 3995

A very nice problem description, illustrating what the code should accept
but doesn't.

> The message goes away with this one character patch:
>
> $ diff -bru git-svn*
> --- git-svn     2009-02-17 10:23:24.000000000 +0100
> +++ git-svn.orig        2009-02-17 10:20:30.000000000 +0100
> @@ -2387,7 +2387,7 @@
>  sub parse_svn_date {
>         my $date = shift || return '+0000 1970-01-01 00:00:00';
>         my ($Y,$m,$d,$H,$M,$S) = ($date =~ /^(\d{4})\-(\d\d)\-(\d\d)T
> -                                           (\d\d)\:(\d\d)\:(\d\d).\d*Z$/x) or
> +                                           (\d\d)\:(\d\d)\:(\d\d).\d+Z$/x) or
>                                          croak "Unable to parse date: $date\n";
>         "+0000 $Y-$m-$d $H:$M:$S";
>  }

You had me scratch my head by giving a reverse patch.

I think neither regexp is quite correct, assuming that SVN timestamp is
supposed to always have decimal point after seconds, with optional
fractional part, followed by Z (presumably to mean Zulu).

-                                           (\d\d)\:(\d\d)\:(\d\d).\d+Z$/x) or
+                                           (\d\d)\:(\d\d)\:(\d\d)\.\d*Z$/x) or

The decimal point should get quoted.
