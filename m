From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 0/8] Initial support for Python 3
Date: Sun, 13 Jan 2013 17:35:57 +0000
Message-ID: <20130113173557.GN4574@serenity.lan>
References: <cover.1358018078.git.john@keeping.me.uk>
 <20130112234304.GC23079@padd.com>
 <20130113004129.GH4574@serenity.lan>
 <20130113164045.GA30371@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sebastian Morr <sebastian@morr.cc>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Jan 13 18:36:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuRTz-0005uL-NI
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 18:36:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104Ab3AMRgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 12:36:11 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:58184 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825Ab3AMRgL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 12:36:11 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 3CF4560653C;
	Sun, 13 Jan 2013 17:36:10 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -11
X-Spam-Level: 
X-Spam-Status: No, score=-11 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C0-IGD0d1gx0; Sun, 13 Jan 2013 17:36:09 +0000 (GMT)
Received: from aardwolf.aluminati.org (aardwolf.aluminati.org [10.0.7.189])
	by coyote.aluminati.org (Postfix) with ESMTP id C73FD606500;
	Sun, 13 Jan 2013 17:36:09 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by aardwolf.aluminati.org (Postfix) with ESMTP id 9AB7133092B;
	Sun, 13 Jan 2013 17:36:09 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from aardwolf.aluminati.org ([127.0.0.1])
	by localhost (aardwolf.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H3BabkzSO32g; Sun, 13 Jan 2013 17:36:09 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by aardwolf.aluminati.org (Postfix) with ESMTPSA id 3F504330E3F;
	Sun, 13 Jan 2013 17:35:59 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20130113164045.GA30371@padd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213391>

On Sun, Jan 13, 2013 at 11:40:45AM -0500, Pete Wyckoff wrote:
> john@keeping.me.uk wrote on Sun, 13 Jan 2013 00:41 +0000:
>> On Sat, Jan 12, 2013 at 06:43:04PM -0500, Pete Wyckoff wrote:
>> > Can you give me some hints about the byte/unicode string issues
>> > in git-p4.py?  There's really only one place that does:
>> > 
>> >     p4 = subprocess.Popen("p4 -G ...")
>> >     marshal.load(p4.stdout)
>> > 
>> > If that's the only issue, this might not be too paniful.
>> 
>> The problem is that what gets loaded there is a dictionary (encoded by
>> p4) that maps byte strings to byte strings, so all of the accesses to
>> that dictionary need to either:
>> 
>>    1) explicitly call encode() on a string constant
>> or 2) use a byte string constant with a "b" prefix
>> 
>> Or we could re-write the dictionary once, which handles the keys... but
>> some of the values are also used as strings and we can't handle that as
>> a one-off conversion since in other places we really do want the byte
>> string (think content of binary files).
>> 
>> Basically a thorough audit of all access to variables that come from p4
>> would be needed, with explicit decode()s for authors, dates, etc.
> 
> Your auto-conversion snippet in the follow-up mail would work
> fine for most keys and values.  A few perforce docs and some
> playing around convince me that it is mostly utf-8, except for
> file data for particular types.
> 
> I'd still rather handle each command separately, and think about
> the conversions, to do it right in the long run.

I sent that on the assumption that the same key would have similar
semantics wherever its used, but I don't use git-p4 or know much about
perforce.

It would be interesting to know whether there is any likelihood of p4
gaining a Python 3 output mode (since the documentation currently say
not to use "p4 -G" with Python 3).  If it does then I would assume that
it will make a sensible choice about unicode/bytes such that the
existing git-p4 would Just Work with only a small change to the
invocation of p4 to add the new argument.

>> > I hesitated to take Sebastian's changes due to the huge number of
>> > print() lines, but maybe a 2to3 approach would make that aspect
>> > of python3 support not too onerous.
>> 
>> I think we'd want to change to print() eventually and having a single
>> codebase for 2 and 3 would be nicer for development, but I think we need
>> to be able to say "no one is using Python 2.5 or earlier" before we can
>> do that and I'm not sure we're there yet.  From where we are at the
>> moment I think 2to3 is a good answer, particularly where we're already
>> using distutils to generate a release image.
> 
> Agreed.  The 2to3 diff is large but straightforward.  But these
> p4 -G interface errors require a lot of thought and work.  I'm
> not too eager to work on this yet.

Fair enough.  As I don't use git-p4, it's not something I intend to
tackle either (given the scale of the changes involved).

Given the minimal scope of the changes needed for everything else, I
sent this series wondering whether it's sensible to move forward on the
basis of "Python scripts except git-p4 work with Python 3.  You must use
Python 2 if you want to use git-p4".


John
