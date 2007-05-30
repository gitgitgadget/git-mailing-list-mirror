From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] Don't ignore write failure from git-diff, git-log, etc.
Date: Wed, 30 May 2007 09:12:53 +0200
Message-ID: <874pluss22.fsf@rho.meyering.net>
References: <87bqg724gp.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705260910220.26602@woody.linux-foundation.org>
	<87odk6y6cd.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705270904240.26602@woody.linux-foundation.org>
	<87sl9hw0o0.fsf@rho.meyering.net>
	<20070528154630.GA9176@fiberbit.xs4all.nl>
	<87646cx13d.fsf@rho.meyering.net>
	<7v4plwd6f0.fsf@assigned-by-dhcp.cox.net>
	<87veebs84i.fsf@rho.meyering.net>
	<7v646b5gw5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Roeland <marco.roeland@xs4all.nl>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 30 09:13:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtIMf-0001rk-EW
	for gcvg-git@gmane.org; Wed, 30 May 2007 09:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbXE3HMz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 03:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbXE3HMz
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 03:12:55 -0400
Received: from mx.meyering.net ([82.230.74.64]:34702 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222AbXE3HMy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 03:12:54 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 2B31628CB8; Wed, 30 May 2007 09:12:53 +0200 (CEST)
In-Reply-To: <7v646b5gw5.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Tue\, 29 May 2007 16\:50\:18 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48750>

Junio C Hamano <junkio@cox.net> wrote:
>> -		exit(p->fn(argc, argv, prefix));
>> +		status = p->fn(argc, argv, prefix);
>> +
>> +		/* Close stdout if necessary, and diagnose any failure
>> +		   other than EPIPE.  */
>> +		if (fcntl(fileno (stdout), F_GETFD) >= 0) {
>> +			errno = 0;
>> +			if ((ferror(stdout) || fclose(stdout))
>> +			    && errno != EPIPE) {
>> +				if (errno == 0)
>> +					die("write failure on standard output");
>> +				else
>> +					die("write failure on standard output"
>> +					    ": %s", strerror(errno));
>> +			}
>
> This makes the final write failure trump the breakage p->fn()
> already diagnosed, doesn't it?

Yes.  Are there circumstances in which a nonzero status from
some cmd_* function would mean something so grave that you
wouldn't also want to know that standard output is incomplete
or corrupt (and possibly use a different exit status)?
So far, after a quick and incomplete survey, I haven't found any.

However, if some git command is documented to exit with
status N for some listed values of N, e.g.,
    1 A happened
    2 B happened
    3 any other failure
then the above choice of dying with "die" would be wrong.

E.g. git-diff's --exit-code comes close:

       --exit-code
           Make the program exit with codes similar to diff(1). That is, it
           exits with 1 if there were differences and 0 means no differences.

but doesn't say how it handles errors.

[ OT: Perhaps that documentation should be changed to look more like diff's,
  so that it says there is a different exit code for the third
  case (some failure):

    $ diff --help|tail -3|head -1
    Exit status is 0 if inputs are the same, 1 if different, 2 if trouble.
]

> Maybe if (fcntrl(...) >=0 )
> should read if (!status && fcntrl(...) >= 0).

No, because then something like git-diff's --exit-code could hide
a write error.

If you want to preserve the exit status, then it should be enough
to call set_die_routine with a function that will work just like
"die" but exit with a specified (status) value.
