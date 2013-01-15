From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH 2/8 v2] git_remote_helpers: fix input when running
 under Python 3
Date: Tue, 15 Jan 2013 21:54:12 +0000
Message-ID: <20130115215412.GX4574@serenity.lan>
References: <cover.1358018078.git.john@keeping.me.uk>
 <a8c3aabfab64f49fa0cbb2d45bda79997a875ee8.1358018078.git.john@keeping.me.uk>
 <50F2296F.8030909@alum.mit.edu>
 <20130113161724.GK4574@serenity.lan>
 <50F38E12.6090207@alum.mit.edu>
 <20130114094721.GQ4574@serenity.lan>
 <20130115194809.GU4574@serenity.lan>
 <7vbocq2mri.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 22:54:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvET0-000331-Vh
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 22:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756351Ab3AOVy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 16:54:27 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:47331 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280Ab3AOVy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 16:54:26 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id D181A86600E;
	Tue, 15 Jan 2013 21:54:25 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vwz1sUyTco1o; Tue, 15 Jan 2013 21:54:24 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 0EC5E866007;
	Tue, 15 Jan 2013 21:54:24 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id EBB5F161E4A1;
	Tue, 15 Jan 2013 21:54:23 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qTKVy4k966vV; Tue, 15 Jan 2013 21:54:23 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id E9129161E551;
	Tue, 15 Jan 2013 21:54:14 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vbocq2mri.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213679>

On Tue, Jan 15, 2013 at 12:51:13PM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
>> Although 2to3 will fix most issues in Python 2 code to make it run under
>> Python 3, it does not handle the new strict separation between byte
>> strings and unicode strings.  There is one instance in
>> git_remote_helpers where we are caught by this, which is when reading
>> refs from "git for-each-ref".
>>
>> While we could fix this by explicitly handling refs as byte strings,
>> this is merely punting the problem to users of the library since the
>> same problem will be encountered as soon you want to display the ref
>> name to a user.
>>
>> Instead of doing this, explicit decode the incoming byte string into a
>> unicode string.
> 
> That really feels wrong.  Displaying is a separate issue and it is
> the _right_ thing to punt the problem at the lower-level machinery
> level.

But the display will require decoding the ref name to a Unicode string,
which depends on the encoding of the underlying ref name, so it feels
like it should be decoded where it's read (see [1]).

>> Following the lead of pygit2 (the Python bindings for
>> libgit2 - see [1] and [2]),...
> 
> I do not think other people getting it wrong is not an excuse to
> repeat the same mistake.
>
> Is it really so cumbersome to handle byte strings as byte strings in
> Python?

As [1] says, there is a potential for bugs whenever people attempt to
combine Unicode and byte strings.  I think it also violates the
principle of least surprise if a ref name (a string) doesn't behave like
a normal string.

[1] http://docs.python.org/3.3/howto/unicode.html#tips-for-writing-unicode-aware-programs


John
