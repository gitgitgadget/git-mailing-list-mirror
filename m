From: Jim Cromie <jim.cromie@gmail.com>
Subject: request - trailing # comments are silently non-functional in .gitignore
Date: Mon, 05 May 2008 07:36:24 -0600
Message-ID: <481F0D58.50204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 05 15:37:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt0sa-0000Og-9M
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 15:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755714AbYEENgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 09:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755680AbYEENgb
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 09:36:31 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:41789 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755579AbYEENga (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 09:36:30 -0400
Received: by wr-out-0506.google.com with SMTP id c48so1189285wra.1
        for <git@vger.kernel.org>; Mon, 05 May 2008 06:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        bh=IIKVVWcWBdaSzktr8zxx2m92aTVxqb+WTVBzApfQwzM=;
        b=JldtmV3/6n64e+dOYPzFhGkZRsBrie5q/q4EiM998FnxlEp22oKPqtAT6d4lOiIaXuyaBBaOdoOKw9waPgzlEfQA3XGlPB/FLWyWiN0CI3DeFSYaOo+SV4CgQOMbgD9JcYJq3K0n3ReAw55PoQB/hns1NgKdHpbT1P5UC6VNhKc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=Yfbs1SsqoVKakh2sr5pUe2x19aAoQMGG93VUiAgt0Tp0NkEdOZ5uYzTrb83CcVs3HWOqCsfqf9Qa278WL2+t2ZZtsfI2DmsVF/YQpSPb5KMxyPop4TbEOOPlYZSEzUsEYa3HQIt67ey+F9bgqu2bkpOwLYQ6pKj1C9ayMbwYz9s=
Received: by 10.114.132.5 with SMTP id f5mr5665551wad.125.1209994588949;
        Mon, 05 May 2008 06:36:28 -0700 (PDT)
Received: from harpo.jimc.earth ( [24.8.147.90])
        by mx.google.com with ESMTPS id q18sm12894401pog.2.2008.05.05.06.36.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 May 2008 06:36:27 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81279>


perl is starting to use git, so Im a new user.

I wrote a script to generate .gitignore from a MANIFEST,
so I used a universal ignore, followed by explicit *attends*

# ignore everything
*
# watch these files
!perl.h
...

while testing this, I discovered that trailing comments silently
invalidate the rule, so this line is ineffective:

*  # ignore everything. We attend to MANIFEST entries next...



Explicit MANIFEST support / file inclusion

    !<MANIFEST

the above could mean dont-ignore all files named in MANIFEST (1st field: 
/^(\S+)/)


This describes use of other .gitignores (but Im not suggesting this be 
supported)

    <`find . -name .gitignore`

However, this might be useful

    !<`cut -d\  -f2 MANIFEST-odd`

Id accept that this might be too much shell-ish magic for your tastes,



Preprocessor Support

Perl uses XS to interface to C libs etc, and needs to process foo.xs -> 
foo.c
which is then compiled to make foo.o.  Heres an excerpt from a makefile


# --- MakeMaker xs_c section:

.xs.c:
        $(XSUBPPRUN) $(XSPROTOARG) $(XSUBPPARGS) $(XSUBPP_EXTRA_ARGS) 
$*.xs > $*.xsc && $(MV) $*.xsc $*.c




It would be nice if this kind of dependency were usable as an 
ignoral-directive,
ignore foo.c if foo.xs exists.

some alternatives:

:*.c:*.xs:
    - colons signal different kind of line, and delimit 2 specs
    - the 2 * must match same literals (perhaps why make dev's left them 
out)

*.c!*.xs
    - here '!' serves as separator of 2 fields
    - also suggests attend to the 2nd field (which is arguably desirable)
       if so, it needs to be attended even if *.c is missing (it is 
until built)
