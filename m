From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] fetch: fetch submodules in parallel
Date: Mon, 14 Sep 2015 10:55:09 -0700
Message-ID: <20150914175509.GJ8165@google.com>
References: <1442012994-20374-1-git-send-email-sbeller@google.com>
 <1442012994-20374-3-git-send-email-sbeller@google.com>
 <xmqqpp1nxxji.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaBvVWT1OPMxUAU9N2oaC5TT5wwWew5jS0k_o5J10sKfA@mail.gmail.com>
 <20150914171736.GA1548@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 14 19:55:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbXyQ-0004co-V2
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 19:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbbINRzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 13:55:15 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35904 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbbINRzN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 13:55:13 -0400
Received: by padhk3 with SMTP id hk3so149916632pad.3
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 10:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=k91jG0yUU9HNxr1BPNE3KzuGQvnPSYZ/3dyUJq+ZVok=;
        b=V6RlBe5koUNK4uyP1SrgxT4EzCLovBWh/SYTwA3ovHHrGyVhzXNdMUow6FR+8p4Hwk
         TKXF6RE4Sla2IeyAv+bvGJWhtFjyiy0D2cLdi/qzWDjRhf/B22s6of5ybeeTLC32bN/b
         Roixr762umj5vojWv18ifLHriH+jgD45ui46atw7e5cbszS9gPhh4ss2sf/A1yxQr102
         e36CBLRIH17cemkIMNL+pNOSVblLawLPUANCTfDT3RQGevH9BGOuAL/gPbjRA/nFLKSB
         4MeFWgoRvt0PMirR/ME7y6bNvVS0ys68T3a7XmeVJl8mzSj2Unnnnr0E4tZwnG8oyl12
         qHNg==
X-Received: by 10.66.100.168 with SMTP id ez8mr36738285pab.142.1442253312553;
        Mon, 14 Sep 2015 10:55:12 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:8439:59df:4be8:314e])
        by smtp.gmail.com with ESMTPSA id qe3sm17371934pbc.73.2015.09.14.10.55.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Sep 2015 10:55:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150914171736.GA1548@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277853>

Jeff King wrote:
> On Mon, Sep 14, 2015 at 09:46:58AM -0700, Stefan Beller wrote:

>> I tried implementing a buffering solution for both stdout and stderr,
>> but that doesn't really workout well if you consider interleaved output
>> on the pipes as we cannot accurately replay that later on.
[...]
>> obtaining the information is inherently racy
[...]
> I don't think you need exact timing information.  This is no different
> than running the commands themselves, with stdout and stderr writing to
> a pty that your terminal emulator will then read() from. If the program
> produces intermingled stdout/stderr that clogs up the terminal, that is
> its problem.

The difference is that when stdout and stderr write to a pty, they write
to the same pty.  That is, suppose a child process does

	write(1, "A\n", 2);
	write(2, "B\n", 1);
	write(1, "C\n", 2);

Then the output that should be echoed to the terminal is

	A
	B
	C

Now the parent might do

	for (;;) {
		int n = select(...);
		... do stuff ...
	}

If all three writes happen during the "do stuff" step, then *if* the
child's stdout and stderr went to different pipes, all the parent sees
is

	child's stdout: A\nC\n
	child's stderr: B\n

There is not sufficient information to recover the original output
order.  (Linux provides a pipe2(..., O_DIRECT) that almost provides
sufficient information --- it tells you

	child's stdout: "A\n", "C\n"
	child's stderr: "B\n"

but still doesn't give information about ordering.)

That's probably okay: in most git commands, stderr shows a combination
of diagnostic output and progress information and stdout shows the
actual result, so interleaving between the two is not too common.

One can imagine a "git grep --recurse-submodules" that wants to run a
grep in each submodule and combine their output in some appropriate
way.  It's not clear what order is best for that use case: stderr
(errors, plus progress in some imaginary future) at the beginning to
show the story of how output was generated before the output?  stderr
at the end so errors are not hidden way up on the screen?  Some kind
of interleaving that pays attention to the format of stdout?

That is more complicated than the "fetch --recurse-submodules" case
that Stefan is currently tackling, so it seems wise to me to punt for
now.

Thanks and hope that helps,
Jonathan
