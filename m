From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [BUG?] Fresh clone of jquery.git shows modifications?
Date: Wed, 18 Aug 2010 15:18:26 +0200
Message-ID: <2F030CF4-995A-4BA2-9D79-DA2A71F9FF79@gmail.com>
References: <1282135226.24584.92.camel@wpalmer.simply-domain>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 15:18:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OliXS-0005GY-Pk
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 15:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973Ab0HRNSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 09:18:33 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60982 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752827Ab0HRNSb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 09:18:31 -0400
Received: by eyg5 with SMTP id 5so293738eyg.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 06:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:in-reply-to
         :mime-version:content-type:message-id:content-transfer-encoding:cc
         :from:subject:date:to:x-mailer;
        bh=Os1slOfkWpTcVbYS6YViXIpy5gmV4AgyQV7xFUBtAOY=;
        b=Elce5GALKdWIeTLZ1Uh5bpCIQaVH+t4rIzb31kLylKvYFW5EFcUw55DtYYk6WkRRfm
         aSibG1g7AbvYsQjpIuW2nTikS0/t3QAp8xZ4eDXcWz4QUxURm3s9M5Cshts0ezlJ9I92
         npJf+f65g/J+9lmZvteQK8kL3v/fYV8oLCKlA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-type:message-id
         :content-transfer-encoding:cc:from:subject:date:to:x-mailer;
        b=OKMO/1EkZKJTuF/fefmUFB6rM9PRllwYTiYeBBFXCnGf8H5pfsBxY7l0NZ2JahZGNr
         Wp6YtwETwicfpWTJpcwgq3XwX0Q5pHwFeUqbK09oofFs6Ul2eV3GDK0HP4kVeq6N0GNF
         K0+1lDJ+5yWqLjgEZrAyxXnxSbSsONkqj7oxc=
Received: by 10.213.47.70 with SMTP id m6mr266267ebf.63.1282137510460;
        Wed, 18 Aug 2010 06:18:30 -0700 (PDT)
Received: from [10.36.80.159] ([62.113.137.5])
        by mx.google.com with ESMTPS id v59sm462197eeh.10.2010.08.18.06.18.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 06:18:28 -0700 (PDT)
In-Reply-To: <1282135226.24584.92.camel@wpalmer.simply-domain>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153841>

On 18. aug. 2010, at 14.40, Will Palmer wrote:

> I am on Linux, and core.autocrlf is not set. .gitattributes in the
> JQuery repository contains:
> * crlf=input

That's a strange setting; in older versions of git, it means something like "if core.autocrlf is enabled, only convert CRLF on input"; that is, it effectively turns core.autocrlf=true into core.autocrlf=input.  I'm not sure why anybody would want that.

In any case, it doesn't appear to have prevented CRLFs from entering the repository, which is what's causing the behaviour you see.

> Bisect reveals:
> fd6cce9e89ab5ac1125a3b5f5611048ad22379e7  v1.7.0-3-gfd6cce9
> Add per-repository eol normalization
> 
> is the first git commit which shows this problem.

That's because from that commit, "crlf=input" turns on autocrlf implicitly (it is equivalent to "eol=lf").  Previously, the crlf attribute would only have an effect with core.autocrlf turned on.

> I am confused as to why I am seeing what I am seeing, though. I was
> under the impression that "crlf=input" meant: "convert crlf to lf on
> input", which I would take to mean that it would never have any effect
> whatsoever on "git status"'s output.

Files containing CRLFs in your repository keep the CRLFs in the working tree.  If you check them in now git will convert CRLF to LF, so they are marked as modified.
 
> If I clone using a version of git before v1.7.0-3-gfd6cce9, then "git
> status" from a newer git, then everything also appears to work normally
> (though I haven't dug much into this aspect)

If you turn on core.autocrlf=input or core.autocrlf=true you should get the same behaviour with older gits as well.  Note that msysgit has had autocrlf enabled by default for years, so no positive action is required to do this.

> Is there a git option for "just give me what's in the repository, don't
> ever perform any conversions, one way or the other, just act sane" ?

Not with that .gitattributes :)  If you don't want conversion, don't set the crlf, eol or text attributes.

> I thought I had finally understood all this autocrlf nonsense, but once
> again I see this as being only an "act stupid mode". I have no idea
> what's going on here, and I just want to be able to rely on the
> following:
> - git clone someproj.git && cd someproj && git status;
>   should NEVER report changes
> - git reset --hard HEAD && git status;
>   should NEVER report changes
> 
> and, why I ran into this situation this time around:
> - git clone someproj.git && cd someproj && git checkout sometag;
>   should ALWAYS work
> 
> Can anyone explain why these aren't valid assertions? If they're not,
> then what is the proper way to tell git "give me a real pristine copy"?

Git _is_ giving you a real pristine copy, it's just informing you that your repository is not consistent with the attributes you have set.

> Below is a log of the problem in-action.

[...]

> #	modified:   build/google-compiler-20091218.jar
> #	modified:   build/js.jar

Heh.  I was about to ask if there was anything funny about these presumably binary files, but then I realized that .gitattributes is forcing crlf=input for _all_ files.  I suggest removing the crlf setting from .gitattributes.

- Eyvind
