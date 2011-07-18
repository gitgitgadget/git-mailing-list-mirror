From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: git-archive and tar options
Date: Mon, 18 Jul 2011 13:13:53 -0500
Message-ID: <4E2477E1.5090406@gmail.com>
References: <ivla29$liu$1@dough.gmane.org> <20110714015656.GA20136@sigill.intra.peff.net> <4E1F2468.6080409@lsrfire.ath.cx> <20110714172718.GA21341@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>,
	Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 18 20:14:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QisKU-0008P5-4u
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 20:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367Ab1GRSOA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jul 2011 14:14:00 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49019 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446Ab1GRSN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 14:13:59 -0400
Received: by gxk21 with SMTP id 21so1423531gxk.19
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 11:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=gee8SP7GIBebYihNbJySJlvLZGCRybQvQH2UMGdIo/w=;
        b=U1VZncU/xf/eSy/5tc55YOKTBhA5b7mCvYSTZ6Dz/HTI/NIf9kNm3Lm0ivbg7W0FJ2
         9D4R7Abhaove0OK26IVsJ8Qq7+wkZJg67xbq95VXBiVz0tIDXdlKRSe0aNUZqXbzUBnk
         chvJZnoI7/xLO9agPkQm4DG7O/LHuDOVZN6ns=
Received: by 10.236.144.232 with SMTP id n68mr2533581yhj.451.1311012839154;
        Mon, 18 Jul 2011 11:13:59 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id p50sm19533yhj.28.2011.07.18.11.13.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Jul 2011 11:13:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20110714172718.GA21341@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177394>

On 7/14/2011 12:27 PM, Jeff King wrote:
> On Thu, Jul 14, 2011 at 07:16:24PM +0200, Ren=C3=A9 Scharfe wrote:
>
>>>> git archive --format=3Dtar -o my.tar --transform
>>>> 's,^Web/Templates/,myPath/myWeb/Templates/,' HEAD
>>>> WebPortal/Templates/ error: unknown option `transform'
>>>
>>> Yeah, that won't work, because there is no such option. We do
>>> have "--prefix", but I suspect that's not flexible enough for
>>> what you want.
>>
>> If you only need a single subdirectory with a custom prefix you
>> could do something like this (variables only used to keep the lines
>> short):
>>
>> $ subdir=3DWebPortal/Templates $ prefix=3DmyPath/myWeb/Templates/ $ =
(cd
>> "$subdir"&&  git archive --prefix=3D"$prefix" HEAD)>my.tar
>>
>> The output file can be specified with -o as well, of course, but
>> you'd either need to use an absolute path or add "../" for each
>> directory level you descend into (-o ../../my.tar in this case).
>
> Couldn't you also do:
>
> git archive --prefix=3D$prefix HEAD:$subdir>my.tar
>
> ? I guess that loses the pax header with the commit sha1 in it,
> though, because you are feeding a straight tree instead of a commit.
>
> We didn't when git-archive was written, but these days we have
> get_sha1_with_context to remember incidental things about an object
> we look up. It should perhaps remember the commit (if any) we used to
> reach a treeish, and then the above command line could still insert
> the pax header.
>
HEAD:$subdir worked on my bare repo.  I ran it for each transformant=20
pathspec and then combined the archives with tar --catenate:

# git archive --format=3Dtar --prefix=3DmyWeb/myRoot/myAPP/Templates/
HEAD:WebPortal/Templates/ >myAPP.myTag.tar
# git archive --format=3Dtar --prefix=3Dopt/mySTUFF/v01/SCRIPTS/
HEAD:SCRIPTS/ >SCRIPTS.tar
# tar --file=3DmyAPP.myTag.tar -A SCRIPTS.tar

However, the permissions also need to change to 777 and tar --mode woul=
d=20
not effect this in combination with --catenation or -x.  Is there a way=
=20
I can change the permissions without having to untar->chmod->retar, and=
=20
without having to use a non-bare repo as an intermediary?

v/r,
neal
