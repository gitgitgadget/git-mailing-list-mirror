From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] tests: turn on test-lint-shell-syntax by default
Date: Sun, 27 Jan 2013 01:31:21 -0800
Message-ID: <20130127093121.GA4228@elie.Belkin>
References: <201301120650.46479.tboegi@web.de>
 <7vvcb37xfe.fsf@alter.siamese.dyndns.org>
 <50F28BB5.9080607@web.de>
 <20130113173207.GC5973@elie.Belkin>
 <7v4nikiu81.fsf@alter.siamese.dyndns.org>
 <50F5B83E.9060800@web.de>
 <7vk3re2ncb.fsf@alter.siamese.dyndns.org>
 <51037E5F.8090506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	kraai@ftbfs.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Jan 27 10:31:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzOai-0006PL-CU
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 10:31:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756323Ab3A0Jbe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Jan 2013 04:31:34 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:47980 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756300Ab3A0Jba convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Jan 2013 04:31:30 -0500
Received: by mail-pb0-f45.google.com with SMTP id rq13so943648pbb.32
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 01:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=LVVR1T1SfER9Rx9rBheQbtVmemDDvmabknRtz9PrU68=;
        b=E1SV4R5Cy1w44kI4CNHaps3TS6QySA6TvX00uI4xap15v6HP7Rzsb4MBKAu58kaWgP
         G52qyM3UY4WeFvh4LVjISfvL77SCQ4Svu0YlZXTHaTHY++VPjJMFMXaOyPDFtvOv1Q3L
         OW2assPp4K+RsMwNCcqkyQkqtLpcUIFzFWkiR6XZc3P2SqJ7GqddfenxQhn4wAgAro9d
         sARu7mBx1buuYPDwhRRUImUN14144tyjI656nAVxPQJEyDfKFqDEpPteCKOGVfVfv4ic
         D8BnCY6w/YDUeKNE6oYPqJQRaFKPNwNjSM9lENmOexILL69YAp1vjZLy+yoOCs5RvC82
         hHRQ==
X-Received: by 10.68.203.198 with SMTP id ks6mr28341214pbc.35.1359279089508;
        Sun, 27 Jan 2013 01:31:29 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id sy1sm4090054pbc.66.2013.01.27.01.31.27
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 01:31:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <51037E5F.8090506@web.de>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214689>

Hi,

Torsten B=C3=B6gershausen wrote:
> On 15.01.13 21:38, Junio C Hamano wrote:
>> Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>>> What do we think about something like this for fishing for which:
[...]
>>> +which () {
>>> +       echo >&2 "which is not portable (please use type)"
>>> +       exit 1
>>> +}
[...]
>> 	if (
>> 		which frotz &&
>>                 test $(frobonitz --version" -le 2.0
>> 	   )

With the above definition of "which", the only sign of a mistake would
be some extra output to stderr (which is quelled when running tests in
the normal way).  The "exit" is caught by the subshell and just makes
the "if" condition false.

That's not so terrible --- it could still dissuade new test authors
from using "which".  The downside I'd worry about is that it provides
a false sense of security despite not catching problems like

	write_script x <<-EOF &&
		# Use "foo" if possible.  Otherwise use "bar".
		if which foo && test $(foo --version) -le 2.0
		then
			...
		...
	EOF
	./x

That's not a great tradeoff relative to the impact of the problem
being solved.

Don't get me wrong.  I really do want to see more static or dynamic
analysis of git's shell scripts in the future.  I fear that for the
tradeoffs to make sense, though, the analysis needs to be more
sophisticated:

 * A very common error in test scripts is leaving out the "&&"
   connecting adjacent statements, which causes early errors
   in a test assertion to be missed and tests to pass by mistake.
   Unfortunately the grammar of the dialect of shell used in tests is
   not regular enough to make this easily detectable using regexps.

 * Another common mistake is using "cd" without entering a subshell.
   Detecting this requires counting nested parentheses and noticing
   when a parenthesis is quoted.

 * Another common mistake is relying on the semantics of variable
   assignments in front of function calls.  Detecting this requires
   recognizing which commands are function calls.

In the end the analysis that works best would probably involve a
full-fledged shell script parser.  Something like "sparse", except for
shell command language.

Sorry I don't have more practical advice in the short term.

My two cents,
Jonathan
