From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 00/15] git-note: A mechanisim for providing free-form after-the-fact annotations on commits
Date: Tue, 29 May 2007 12:04:06 +0100
Message-ID: <200705291204.10606.andyparkins@gmail.com>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org> <20070528213511.GB7044@spearce.org> <alpine.LFD.0.98.0705282008400.26602@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 29 13:04:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HszV4-0006cE-AO
	for gcvg-git@gmane.org; Tue, 29 May 2007 13:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbXE2LER (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 07:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753579AbXE2LER
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 07:04:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:35788 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676AbXE2LEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 07:04:16 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1830724ugf
        for <git@vger.kernel.org>; Tue, 29 May 2007 04:04:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tdEH8EM7pDz11nf3PhFXTGGeQtFK+jIdCpg5lrqf3OF4YLreuriLo0fxuwr2hm5P0OPweoWRMCivn6evH+f36mITWfJuPP/Mu9iVFB9RwaswPLHVYqIZ2h6079NeTLK0EBH+r89RqI7NT2uf9Tww5kEddEBnL/q+Mi88zm7Pr+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kRzuGR07f1U0SZtKBuPbym/+Srv7mui5A13a1KTyZ0/gIn8LMjhBsqUD7aPVnGGfc22/wWVBq3kDDxZJ1l1LpRN4n0yTQoHF9siYHR3+pIZ4f3m2E/HL0ciFob20WbOyfUER352Y/EkFLdzf0kQYlDXDpIWw9V1nUz4oaXFpkQ8=
Received: by 10.66.237.9 with SMTP id k9mr5951305ugh.1180436655207;
        Tue, 29 May 2007 04:04:15 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id y34sm11188664iky.2007.05.29.04.04.13;
        Tue, 29 May 2007 04:04:14 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <alpine.LFD.0.98.0705282008400.26602@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48682>

On Tuesday 2007 May 29, Linus Torvalds wrote:

> So you'd have to have a separate database. You could do it with a separate
> index file (or mixing it up with the "index v4" and doing it with a single
> index file that also contains normal objects), but the point is, it's
> going to be a real separate database.

This is an off-the-wall suggestion; but why not use the object database a bit 
more strongly than just for storing the notes?  The original method was to 
use the filesystem to store refs/notes/$SHA1, which was essentially annotated 
tags.  The object database has been designed for storing thousands of 
hierarchically organised files, so why not use that instead of the refs/ 
tree?

That is to say, make a "private" branch, independent of any real repository 
branches.  I'll call it "notes".  Then each commit in that branch represents 
a change to a note (or multiple notes).  The tree attached to each commit 
provides the reverse lookup that's wanted, and also maps to the object 
itself.  So where a normal tree has

100644 blob 156e952df8603c72532bcda95ddcd3bcb16ec5fd somefile

A "notes" tree would have

100644 blob 156e952df8603c72532bcda95ddcd3bcb16ec5fd $SHA1_OF_TARGET_COMMIT1
100644 blob 97e08b0ab483146cb8fff31138eaa828c24ac84f $SHA1_OF_TARGET_COMMIT2

All the "notes" tools could now use the standard git tools to look up a note.  
The notes would be version controlled (which is impressive in itself), and 
reverse lookup is the same as path-limited git-rev-list.

The tree objects are (I guess) stored alphabetically, so the reverse lookup 
could be done with a binary search.  If a user really wanted to, they could 
check out the "notes" branch and edit the files directly.

Madness?  I'm sure.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
