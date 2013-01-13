From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 0/8] Initial support for Python 3
Date: Sun, 13 Jan 2013 12:34:04 +0000
Message-ID: <20130113123404.GJ4574@serenity.lan>
References: <cover.1358018078.git.john@keeping.me.uk>
 <20130112234304.GC23079@padd.com>
 <20130113004129.GH4574@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sebastian Morr <sebastian@morr.cc>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Jan 13 13:34:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuMlp-0004Xc-WB
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 13:34:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793Ab3AMMeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 07:34:18 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:35446 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754722Ab3AMMeR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 07:34:17 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id A2D55198002;
	Sun, 13 Jan 2013 12:34:16 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CXfNcWFOIgah; Sun, 13 Jan 2013 12:34:16 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id B6477198001;
	Sun, 13 Jan 2013 12:34:15 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id A84BF161E551;
	Sun, 13 Jan 2013 12:34:15 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L+HiEAeXYK+9; Sun, 13 Jan 2013 12:34:15 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id B125A161E327;
	Sun, 13 Jan 2013 12:34:06 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20130113004129.GH4574@serenity.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213339>

On Sun, Jan 13, 2013 at 12:41:30AM +0000, John Keeping wrote:
> On Sat, Jan 12, 2013 at 06:43:04PM -0500, Pete Wyckoff wrote:
>> Can you give me some hints about the byte/unicode string issues
>> in git-p4.py?  There's really only one place that does:
>> 
>>     p4 = subprocess.Popen("p4 -G ...")
>>     marshal.load(p4.stdout)
>> 
>> If that's the only issue, this might not be too paniful.
> 
> The problem is that what gets loaded there is a dictionary (encoded by
> p4) that maps byte strings to byte strings, so all of the accesses to
> that dictionary need to either:
> 
>    1) explicitly call encode() on a string constant
> or 2) use a byte string constant with a "b" prefix
> 
> Or we could re-write the dictionary once, which handles the keys... but
> some of the values are also used as strings and we can't handle that as
> a one-off conversion since in other places we really do want the byte
> string (think content of binary files).
> 
> Basically a thorough audit of all access to variables that come from p4
> would be needed, with explicit decode()s for authors, dates, etc.

Having thought about this a bit more, another possibility would be to
apply this transformation once using something like this (completely
untested, I haven't looked up the keys of interest):

-- >8 --

def _noop(s):
    return s

def _decode(s):
    return s.decode('utf-8')

CONVERSION_MAP = {
    'user': _decode,
    'data': _decode
}

d = marshal.load(p4.stdout)
retval = {}
for k, v in d.items():
    key = k.decode('utf-8')
    retval[key] = CONVERSION_MAP.get(key, _noop)(v)
return retval

-- 8< --

Obviously this isn't ideal but without p4 gaining a Python 3 output mode
I suspect this would be the best we could do.


John
