From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC Redux] strbuf: Add method to convert byte-size to human
 readable form
Date: Fri, 19 Sep 2008 15:37:26 -0700
Message-ID: <7vod2jpxsp.fsf@gitster.siamese.dyndns.org>
References: <1221279997-9336-1-git-send-email-marcus@griep.us>
 <7v1vzfrebs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Sat Sep 20 00:38:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kgocb-00060o-65
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 00:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbYISWhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 18:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbYISWhd
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 18:37:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53130 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbYISWhc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 18:37:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2BC6562E57;
	Fri, 19 Sep 2008 18:37:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 472E962E55; Fri, 19 Sep 2008 18:37:28 -0400 (EDT)
In-Reply-To: <7v1vzfrebs.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 19 Sep 2008 14:55:03 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8BA1BD5A-869B-11DD-AED8-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96321>

Junio C Hamano <gitster@pobox.com> writes:

> Marcus Griep <marcus@griep.us> writes:
>
>>  This is a redux of a prior patch as part of a series on count-objects
>>  but is now split off and submitted on its own as an RFC for a library
>>  function to be added to strbuf.
>
> Ok, so I looked at the patch again.
>...
> For example, if I hand 1638 to you, you would give 1.599Ki back to me, but
> if I give you only 4 digits to work with, you do not want to say 1.59Ki;
> instead you would rather say 1.60Ki, right?

This also takes me back to this part...

>/*
> * strbuf_append_human_readable
> *
> * 'val': value to be metrically-reduced to a human-readable number
> * 'maxlen': maximum number of characters to be taken up by the reduced 'val'
> *           not including the sign or magnitude (i.e. 'Ki') characters;
> *           when 'maxlen' is 0 length is controled by 'scale'
> * 'scale': when 'val' is greater than 'scale', 'val' is reduced by the
> *          period (default 1024, see 'flags') until it is less than 'scale';
> *          when 'scale' is 0, 'val' is reduced until it fits in 'maxlen';
> *          when 'scale' and 'maxlen' are both zero, 'scale' defaults to 1000
> * 'flags': HR_USE_SI: uses a period of 1000 and uses SI magnitude prefixes
> *          HR_SPACE: inserts a space between the reduced 'val' and the units
> *          HR_PAD_UNIT: instead of an empty string for singles, pads with
> *                       spaces to the length of the magnitude prefixes
> *
> * Returns 0 if 'val' is successfully reduced and fits in 'maxlen', otherwise
> * returns -n where n is the number of additional characters necessary to
> * fully fit the reduced value.
> */

The lines are overlong but that is not my main complaint.

I do not see how the above definition of "scale" can be useful.

First, for the case of scale=0, if I tell you to format 1638 into 7 spaces
(without HR_PAD_UNIT), you could give me one of:

           1638
        1.560Ki
        0.002Mi
        0.000Gi
        ...

It is clear that 1638 is better than 1.560Ki which in turn is better than
0.002Mi, because the earlier ones give the information in better precision
with a shorter string than the later ones.  Typically the smaller unit
would give you the better answer but does that match "reduced repeatedly
until it fits in 'maxlen'" rule?  I do not think so ("1638  " is more
precise than "1.56Ki", even with HR_PAD_UNIT on).

Second, why is the default of "scale" independent from "period"?  Scale
that defaults to 1000 in binary system would mean that you would give

        ...
   998  998.0000
   999  999.0000
  1000  0.976562Ki
  1001  0.977539Ki
        ...

I have this feeling that the "scale" knob does not match well with human
expectations.  Admittedly, "most precision within the allocated space"
rule may not match human expectation either (e.g. when you have a
sequence of three numbers "520", "1048", "9999" and you are expecting to
see approximation in binary system, you would probably expect to see
0.51k, 1.02k, and 9.76k, instead of the original integers), but I think it
at least matches human expectations better than the "scale" system.

By the way, about the internal math you do for "repeatedly reduce", I do
not think repeatedly dividing with "period" is kosher.  I'd very much
prefer seeing something like:

	double magnitude = fabs(value);
        double scaler;

        for (unit = 0, scaler = 1.0;
             scaler < magnitude && unit < max_units;
             unit++)
             scaler *= period;

	printf("%f%s", value / scaler, unit_names[unit]);

modulo the terminating condition --- it may make more sense to stop one
step before "scaler < magnitude" happens so that we won't see "0.9765Ki"
but instead see "1000".

After thinking about this longer, I unfortunately have to say that the
only thing I like about the current iteration of the patch is the name of
the function "strbuf_append_human_readable" and what goal (at the abstract
level) it wants to achieve.
