From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 0/7] Improved infrastructure for refname normalization
Date: Tue, 13 Sep 2011 06:16:13 +0200
Message-ID: <4E6ED90D.1090704@alum.mit.edu>
References: <1315637443-14012-1-git-send-email-mhagger@alum.mit.edu> <7vehzmbd0o.fsf@alter.siamese.dyndns.org> <4E6E2122.8000201@alum.mit.edu> <7vwrdd90df.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 06:16:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3KQG-00042c-Ak
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 06:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656Ab1IMEQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 00:16:30 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:47298 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714Ab1IMEQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 00:16:29 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.133] (p54BE9F1E.dip.t-dialin.net [84.190.159.30])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8D4GDSL013690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 13 Sep 2011 06:16:14 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Lightning/1.0b2 Thunderbird/3.1.13
In-Reply-To: <7vwrdd90df.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181268>

On 09/12/2011 06:44 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> OTOH I am again having serious doubts that trying to support
>> unnormalized refnames is a good idea.
> 
> Sorry, I am confused. I thought the way you are planning forward is to
> leave unnormalized ones unchecked as the current code does (and mark the
> places that do so with _unsafe()), with the eventual goal of fixing the
> caller to pass only normalized ones to make call to the "safe" version?

That was the plan, but after my experience trying to fix this problem I
have come to doubt that it is doable within a reasonable amount of work
or even that support for unnormalized refnames is desirable.  The
problem is that the API provided by refs.{c,h} is far from waterproof,
and I keep finding more code elsewhere that manipulates and parses
refnames and makes implicit assumptions (sometimes spread over many
functions) about their form.

Consistency of the UI should be the goal.  Supporting unnormalized
refnames some places, but not others, will just confuse and frustrate
users.  The only two consistent alternatives are

1. Unnormalized refnames are supported everywhere in the UI that
refnames are accepted, including clients like gitweb, gitk, egit, etc.

2. Only normalized refnames are supported; unnormalized refnames are
errors that we report on a best-effort basis.

Option (1) has a number of problems:

* Claiming to support unnormalized refnames is far from the current
situation; therefore lots of current code would have to be considered
broken.

* Fixing the code requires many new unit tests and fixes to many areas
of the code, including clients outside of the main git project.  I have
tried fixing a couple of examples ("git branch", "git rev-parse", and
the first argument of "git update-ref") and it is pretty messy.

* Some of the needed changes seem like they might conflict with other
forms of DWIM; for example, the ambiguous_path() kludge.

* The extra copying needed for normalization has a runtime cost and
complicates memory management.

* Unnormalized refnames are *themselves* a form of UI inconsistency and
therefore not a very noble goal.  It is better that people learn that
each reference has a single name, and unlearn that references were once
1:1 with files under .git/refs.

What is the benefit of (2) that justifies all of this work?  To enable
sloppy script writers to throw slashes around carelessly?

Option (1) would be far easier.  Then code only needs to treat
unnormalized refnames like any other kind of invalid refname rather than
making sure that unnormalized refnames work properly in combination with
all other features.

So I propose the following:

* Institute a policy that refnames in the UI must always be normalized

* On a best-effort basis, emit errors whenever unnormalized refnames are
encountered

* Continue to support "git check-ref-format --print", which script
writers can use to normalize refnames if they need to.

The only disadvantage of a stricter policy is that some of today's
sloppy scripts, which today might sometimes work (but not reliably),
break in a pretty obvious way that can be fixed with a single call to
"git check-ref-format --print".

I'd rather get beyond this swamp and start working on the hierarchical
reference cache, which will bring some real benefits.  (The hierarchical
reference cache requires some sanity in refname handling, which is why I
got into this mess in the first place.)

What do people think?
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
