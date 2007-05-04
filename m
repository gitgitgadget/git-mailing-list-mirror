From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] Support ent:relative_path
Date: Fri, 4 May 2007 01:45:17 -0700
Message-ID: <56b7f5510705040145k781da6farff3d02c3c1a5f3f9@mail.gmail.com>
References: <463ADE51.2030108@gmail.com>
	 <56b7f5510705040022x2e4903d3hbe4ac1ee1a2e096f@mail.gmail.com>
	 <7v7irpuhhr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 04 10:45:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjtQ9-0005My-5h
	for gcvg-git@gmane.org; Fri, 04 May 2007 10:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933020AbXEDIpW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 04:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932929AbXEDIpV
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 04:45:21 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:29815 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933020AbXEDIpS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 04:45:18 -0400
Received: by wr-out-0506.google.com with SMTP id 76so825133wra
        for <git@vger.kernel.org>; Fri, 04 May 2007 01:45:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YXtTp8hGR07VKKNd4y5BuryOHIZYlkbr5g3QsIgKFrVSSWRMhF2jx60O8hw3d3YUG4Lx6tEG5bfeDEiU7V8wxWzo0QQMmbSNuh3ro5TNzoLcdDP6bhD2V9B+auSG9engqDd92QOp0UFDNezm+4LUKwE4eLqjOIG4bv2pqEZeeJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iSrSN6E+o46MFxtoHchGlxahAuOMYBUcgGt9DIKRuexkdo/WIX14c8U4eofxpC+7UkbcSorR7xCTXjekb4p7z8xO7aMIdLEVP67Hl6KnaPgqi36TU9fK77aNBrb0f4AwIytJqP0386U+atgFTWj2RMM1vgiHAi3IqJQEC17x0Ag=
Received: by 10.115.55.1 with SMTP id h1mr1017776wak.1178268317927;
        Fri, 04 May 2007 01:45:17 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Fri, 4 May 2007 01:45:17 -0700 (PDT)
In-Reply-To: <7v7irpuhhr.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46146>

On 5/4/07, Junio C Hamano <junkio@cox.net> wrote:
> I do not think it is wrong per-se, to want to make this hold true:
>
>         A=$(git rev-parse :somedir/file)
>         B=$(cd somedir && git rev-parse :file)
>         test "$A" = "$B"
>
> One thing I am reasonably certain however is that this should
> NOT be conditional to a config setting.  Doing so would force
> scripts that take (or compute) path and commit and concatenate
> them to make "${commit}:${path}" to name a blob (or tree) to
> first inspect the current setting of core.relativepaths and undo
> what the new code does by prefixing/subtracting the prefix
> string depending on the config.
>
> In other words, having that config is not really helping scripts
> or compatibility.
>
> I think the choices are:
>
>  (1) we say it was a mistake that we did not make it relative to
>      the current directory when we introduced the X:<path>
>      syntax (X could be empty or :[0-3]: for index, or a commit
>      or tree object name), and change the semantics in a future
>      major release for everybody, apologizing for potentially
>      breaking existing scripts; or
>
>  (2) keep the current behaviour as is, and come up with a
>      different syntax to use relative; or
>
>  (3) do nothing.
>
> My preference is (2), (3) and then (1), but I do not have
> offhand a suggestion for a good metacharacter we could use.

Let us require:
* No config settings as you prefer
* Current interpretations are unchanged.

The current path supports
  :fullpath
  :/string
  :./relpath
[assuming core.relativepaths=no always since it goes away].
(:/string is the "find string in commit msg" feature.)

A new metacharacter lets us drop the "./" ,
and I think that's desirable.
How about = ? It's not even shifted on my keyboard:
 ent=relpath
 ent=2=relpath
 ent=/fullpath

1. We would accept the same new metacharacter before stage if any.
2, You could still use ent:/string , or ent:fullpath .

The patch should also be extended so relpath can start
with a sequence of ./ or ../ prefixes,
which is easily handled in prepend_prefix()..

What do you think of "=" ?
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
