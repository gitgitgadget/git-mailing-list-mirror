From: Nix <nix@esperi.org.uk>
Subject: Re: [PATCH 2/2] Support sizes >=2G in various config options accepting 'g' sizes.
Date: Tue, 06 Sep 2011 10:13:20 +0100
Message-ID: <87ty8qjaof.fsf@spindle.srvr.nix>
References: <1315223155-4218-1-git-send-email-nix@esperi.org.uk>
	<1315223155-4218-2-git-send-email-nix@esperi.org.uk>
	<CAGdFq_gFNHq9Cgv4F4Q6VQ=G7odfUJ5pUFWn=OYE-BfXzP=Enw@mail.gmail.com>
	<87ty8rm6th.fsf@spindle.srvr.nix> <20110906074421.GB28490@ecki>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Sep 06 11:13:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0ris-0008RA-QA
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 11:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753791Ab1IFJNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 05:13:31 -0400
Received: from icebox.esperi.org.uk ([81.187.191.129]:51352 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709Ab1IFJN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 05:13:29 -0400
Received: from esperi.org.uk (nix@spindle.srvr.nix [192.168.14.15])
	by mail.esperi.org.uk (8.14.4/8.14.3) with ESMTP id p869DKO1011646;
	Tue, 6 Sep 2011 10:13:20 +0100
Received: (from nix@localhost)
	by esperi.org.uk (8.14.4/8.12.11/Submit) id p869DKMj012570;
	Tue, 6 Sep 2011 10:13:20 +0100
Emacs: the road to Hell is paved with extensibility.
In-Reply-To: <20110906074421.GB28490@ecki> (Clemens Buchacher's message of
	"Tue, 6 Sep 2011 09:44:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-DCC-URT-Metrics: spindle 1060; Body=3 Fuz1=3 Fuz2=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180780>

On 6 Sep 2011, Clemens Buchacher uttered the following:

> On Mon, Sep 05, 2011 at 02:56:10PM +0100, Nix wrote:
>> 
>> Well, we're parsing longs, not ints. If sizeof(long)>sizeof(int), or we
>> have long long and sizeof(long long)>sizeof(int), then we can always
>> detect overflows when saving into the appropriate type: but if we don't
>> have long long, or if we have neither strto(u)ll() nor strto[ui]max(),
>> we could only detect overflow by looking at the raw text string and
>> checking it by hand to see if it would fit. I judged this pointless
>> extra complexity for a very rare edge case (machines with neither
>> strot(u)ll() nor strto[ui]max() are generally quite old and people
>> aren't going to be specifying sizes in gigabytes on such machines
>> anyway.)
>
> Is this also true for Windows and other platforms?

There, uintmax_t is 'long long' and is longer than 'long', let alone
'int', so this holds there too, or should.

> And I don't think it's about whether or not people are likely to
> specify sizes in gigabytes on old machines. People are bound to
> blindly copy configuration files from one machine to another. In
> any case, my expectation would be for the configuration options to
> do what I tell them, or error out if they do not make sense.

Yeah, and we do that whenever practically possible: but fixing
this for the case that int/long is the largest available type
(which among other things implies that we're not using GCC or
any other C99 compiler or any of the myriad C89 compilers that
implmented 'long long') amounts to writing our own strtol()
specifically for this one case, to see if the parsed number is
too long. And that is probably a maintenance burden too far.

The failure mode if you put a huge number in on such a platform is
better than it used to be, too, especially for core.bigfilethreshold. We
used to get a negative number that was latched to zero, which then
disabled compression entirely (I had an 83Mb pack turn itself into an
837Mb one when that happened). Now we get a number that, while positive,
is less positive than we expect, but still likely up in the hundreds of
millions.

-- 
NULL && (void)
