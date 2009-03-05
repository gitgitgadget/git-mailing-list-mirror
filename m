From: Junio C Hamano <gitster@pobox.com>
Subject: Re: orthogonal cases of log --date option
Date: Thu, 05 Mar 2009 14:21:27 -0800
Message-ID: <7vy6vjy5js.fsf@gitster.siamese.dyndns.org>
References: <buo8wnnrpcf.fsf@dhlpc061.dev.necel.com>
 <7vtz6bdmfi.fsf@gitster.siamese.dyndns.org>
 <20090305104304.GA17760@coredump.intra.peff.net>
 <76718490903051304j6d8138f7qa5492ac15edd6460@mail.gmail.com>
 <20090305211120.GB20157@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 05 23:23:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfLy7-00031i-A5
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 23:23:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754331AbZCEWVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 17:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754286AbZCEWVj
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 17:21:39 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61028 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754205AbZCEWVh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 17:21:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D2F519FFAC;
	Thu,  5 Mar 2009 17:21:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 37E4D9FFA5; Thu,
  5 Mar 2009 17:21:29 -0500 (EST)
In-Reply-To: <20090305211120.GB20157@coredump.intra.peff.net> (Jeff King's
 message of "Thu, 5 Mar 2009 16:11:20 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FD329BEA-09D3-11DE-B35D-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112352>

Jeff King <peff@peff.net> writes:

> Yep, it is more invasive. But I consider it more maintainable in the
> long run.

Why do you think it is more confusing to ask "--date=local --date=iso"
than asking "--local-time --date=iso"?  If the patch under discussion were
not mine, I would have said that --date=local that flips the "lie about
timezone" bit and tells us to use the "default" format is a brilliant and
elegant solution.

I honestly do not see the point of what you are proposing to make
"selector" and "format" independent; unless you are shooting for
"--use-tz=Indian/Christmas --date=iso", that is.

The "--use-tz=zonename" might make some sense.  The required change would
look more like:

 (1) Introduce:

        const char *force_output_tz;

     that defaults to NULL;

 (2) Option parser for --use-tz=Indian/Christmas would store
     arg+9 to force_output_tz;

 (3) Option parser for --date=local would set the date format to
     "default", and store "localtime" to force_output_tz.  We discard
     DATE_LOCAL enum.

 (4) In show_date(), instead of 

	if (mode == DATE_LOCAL)
		tz = local_tzoffset(time);

     you'd do:

	if (forced_output_tz)
		tz = zonename_to_tzoffset(time, force_output_tz);

     zonename_to_tzoffset() would look up the zoneinfo database and
     compute the offset in our internal (hour*100+min) format.

But I do not think that is what you were proposing.
