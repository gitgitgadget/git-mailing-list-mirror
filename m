From: "Dana How" <danahow@gmail.com>
Subject: Re: log/show: relative pathnames do not work in rev:path
Date: Tue, 18 Dec 2007 14:30:40 -0800
Message-ID: <56b7f5510712181430w798d4a65x20a24f061c5d0eb6@mail.gmail.com>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201>
	 <20071218204623.GC2875@steel.home>
	 <200712182224.28152.jnareb@gmail.com>
	 <alpine.LFD.0.9999.0712181347140.21557@woody.linux-foundation.org>
	 <7vejdjy79y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	danahow@gmail.com
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 23:31:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4kyQ-0006IH-5F
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 23:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756061AbXLRWao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 17:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756029AbXLRWao
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 17:30:44 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:61267 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755855AbXLRWan (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 17:30:43 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1478125nfb.21
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 14:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=hbOuiv2gZxuEPwZV8CCrmSTiZ5qOO8vY0ZBod96zKtE=;
        b=WOR62NHK/hMw1D7jvjbm3RjLw2Xe3wip05lnWN98PVqHnjTTJjrqzL9CzZ9TcsOfV4bOoKXDE7519/NwqE//A4+mCSaR/Qyw1Tq6SCqhODO9WSyR5iTtSu7qFsI+xXKSfdu19sCGynY3/eGdx0FRiSkHVAiu6lzObYelAfKustw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IYx7PJxGXOKEl64zB+rzTDC9dWeU99xpaX2FoLjJ4IpOETCkVOOd/U2JM99QGSTSQmRnkmdzU8hpAu3lgytO4zmcfT9F93EmfBnw7pFBiBaga1z3zk0RsTM+9v2sRsSngVjP/p8aauvLpMrNe7IV/I+aKkZzT3NK3Kaeaso220s=
Received: by 10.78.205.7 with SMTP id c7mr11286750hug.29.1198017040756;
        Tue, 18 Dec 2007 14:30:40 -0800 (PST)
Received: by 10.78.130.1 with HTTP; Tue, 18 Dec 2007 14:30:40 -0800 (PST)
In-Reply-To: <7vejdjy79y.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68837>

On Dec 18, 2007 2:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> > where the magic is *not* done by any "SHA1 path lookup" at all, but is
> > simply done by the commit->tree lookup. At least at that point it would
> > make logical sense (although it would probably be quite painful to
> > implement).
>
> It is not just painful to implement.
>
> Although I can buy that purely from the user (read: people who do not
> know how the world works) experience point of view, you have to be extra
> careful if you do this.  There are existing codepaths that take a string
> that names a treeish from the end user, appends "^{tree}" to that
> string, and passes the result to get_sha1() to obtain a tree object name
> they want to operate on (the alternative is parse_tree_indirect() but it
> forces them to go through the object layer).  You will need to update
> these callers to keep them working from subdirectories.

Thanks,  I didn't know about those "^{tree}" codepaths.

How about this:
<tree-ish>:./path -> NEW: relative
<tree-ish>:../path -> NEW: relative
<tree-ish>:?pattern -> NEW: same as next (current :/ )
<tree-ish>:/pattern -> unchanged (sha1_name_oneline IIRC)
<tree-ish>:path -> unchanged: absolute
This shouldn't need to know if tree-ish references a commit or not.

Someday later,  the last 2 cases could be changed to be more
like the Unix command line if desired.  This is very similar to
Junio's response last May (by memory).

Typing an extra "./" is a big improvement over a long path prefix.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
