From: Josh Micich <josh.micich@gmail.com>
Subject: Re: [PATCH 2/3] added --batch option to mktree
Date: Thu, 14 May 2009 02:24:20 -0700
Message-ID: <a644352c0905140224g41f645c1l734bee791656ea1d@mail.gmail.com>
References: <loom.20090514T050424-673@post.gmane.org>
	 <loom.20090514T051004-665@post.gmane.org>
	 <7vhbzoxl5k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 14 11:24:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4XAz-00011r-BR
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 11:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbZENJYW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 05:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbZENJYV
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 05:24:21 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:50609 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbZENJYU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 05:24:20 -0400
Received: by an-out-0708.google.com with SMTP id d40so2347585and.1
        for <git@vger.kernel.org>; Thu, 14 May 2009 02:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=6xdSG8Jl8RaXZ4+n+KTI/5poorKQzW3QisKuMgQsdig=;
        b=frpa8HqZ8yAaQ71aEUGSumdwa6Gp6KJrrZKa64hxprB3wCiFeUVV7BGxCzRZ7OLqEX
         bqf0VPCE+odcLjr4nxmNCVzJ9iRoHLc6HWbonWQdSeqHR6fByeYa91oYKajEw0tRFKDh
         UFbnhxQlcswFsEvI32gHvad6JwyfPSyhdbTJE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=hIXh5srcGEXTHTwxiOpEC57AOlRP7BCJb3trRiH1fVSKFOx9EzeQhvTvqg8lisD7kE
         Wj7/GVnxdTrQxecuTtZtijhym02tjQMvckNMwZJ2cEOexPh1hVlJoDX+VLgEndAcuNCP
         aJg6jUSP13U9r0XaRo4TLoPFOg1TON//Yy0Yk=
Received: by 10.100.205.11 with SMTP id c11mr2793030ang.72.1242293060951; Thu, 
	14 May 2009 02:24:20 -0700 (PDT)
In-Reply-To: <7vhbzoxl5k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119174>

On Wed, May 13, 2009 at 11:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> This option enables creation of many tree objects with a single process
>
>... which is desirable in what way?  how does this justify the cost of
>maintenance?  what is it used for?

I have been writing a few of my own utilities on top of basic git
commands and got mild performance gains from using the existing
'--batch' option with "git cat-file" instead of executing new "git
cat-file -p <sha>" processes for each object I wish to read.  Later I
was writing a utility for mirroring another SCM (creates many trees),
and I faced a similar performance issue with "git mktree".  After
adding the '--batch' option, I experienced about a 30% speed increase.

If you find this logic persuasive, I can fix all the other issues and
re-submit this patch.

>> +--batch::
>I think you want an blank line before this.
right


>> @@ -125,20 +125,42 @@ int cmd_mktree(int ac, const char **av, const char
>> *prefix)
>
>Linewrapped and would not apply.
sorry - gmane web interface did that.  BTW - does git have a coding
standard for maximum line length?


>What do you mean by "interactively"?  Does anybody type from the standard
>input?
I guess I was trying to stress the point that the created tree object
ids are output immediately as the complete text for each tree is
received.  Other (bad) applications I have seen wait for EOF on stdin
before sending anything to stdout, and this is exactly what I had
avoided in the impl.  Perhaps you could suggest better phrasing.


>Decl-after-statement.
>No C++ comment please;
>Lose excess {} pair;
>Style: have an explicit ";" for an empty statement.
>used = 0; /* .... */
sorry - bad habits. gotta work out how to get my compiler to warn me about these


>> +             if (is_batch_mode && got_eof && used < 1) {
>> +                     // allow input to finish with a new-line (or not)
>
>Style: have an explicit ";" for an empty statement.
>
>But more importantly, what does this comment mean?  Why do you want to be
>loose in input format validation?

I agree with your implied suggestion that tight input validation is
better.  I was actually trying to keep consistent with the way I
believe mktree works today.  The final \n is optional as far as I can
tell.
