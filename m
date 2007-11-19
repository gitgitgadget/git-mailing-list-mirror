From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] Flush progress message buffer in display().
Date: Mon, 19 Nov 2007 14:09:38 -0800
Message-ID: <7vk5odnazh.fsf@gitster.siamese.dyndns.org>
References: <200711192048.58864.johannes.sixt@telecom.at>
	<7voddqm0l7.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.99999.0711191549510.19105@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Nov 19 23:11:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuEq6-00025E-9v
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 23:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757158AbXKSWJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 17:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757278AbXKSWJs
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 17:09:48 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:35005 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757166AbXKSWJr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 17:09:47 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 2F9312EF;
	Mon, 19 Nov 2007 17:10:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id A4186967BF;
	Mon, 19 Nov 2007 17:10:01 -0500 (EST)
In-Reply-To: <alpine.LFD.0.99999.0711191549510.19105@xanadu.home> (Nicolas
	Pitre's message of "Mon, 19 Nov 2007 15:54:05 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65506>

Nicolas Pitre <nico@cam.org> writes:

> On Mon, 19 Nov 2007, Junio C Hamano wrote:
>
>> The standard error stream is not "fully buffered":
>> 
>>     http://www.opengroup.org/onlinepubs/000095399/functions/xsh_chap02_05.html#tag_02_05
>> 
>> Not "fully buffered" means either "unbuffered" or "line
>> buffered".  Because the progress display does not terminate its
>> line, it means that the additional fflush(stderr) you added are
>> needed if the stream is line buffered (still conforming).
>
> Maybe stdio on Linux considers \r as a line termination.

Or totally unbufferred.  Running strace on this:

        #include <stdio.h>

        int
        main(int ac, char **av)
        {
                fprintf(stderr, "foo");
                fprintf(stderr, "bar");
                return 0;
        }

will tell you.  I bet you will see two write(2) of 3 bytes
each.

> Flushing stderr should not hurt anyway.

True, especially if the rate is limited, which it is.
