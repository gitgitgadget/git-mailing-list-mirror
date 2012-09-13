From: Jens Bauer <jens-lists@gpio.dk>
Subject: Re: CRLF, LF ... CR ?
Date: Thu, 13 Sep 2012 20:17:20 +0200
Message-ID: <20120913201720399747.156466ee@gpio.dk>
References: <20120913170943725232.01d717ef@gpio.dk>
 <1347550490.24469.54.camel@drew-northup.unet.maine.edu>
 <20120913154309.GB726@sigill.intra.peff.net>
 <20120913175300953765.9ccf790f@gpio.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Drew Northup <drew.northup@maine.edu>,
	git@vger.kernel.org
To: Jens Bauer <jens-lists@gpio.dk>
X-From: git-owner@vger.kernel.org Thu Sep 13 20:17:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCDyp-0006kX-VV
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 20:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758747Ab2IMSRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 14:17:24 -0400
Received: from [92.246.25.51] ([92.246.25.51]:62206 "EHLO mail.multitrading.dk"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750828Ab2IMSRX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 14:17:23 -0400
Received: (qmail 86460 invoked from network); 13 Sep 2012 18:17:20 -0000
Received: from unknown (HELO ?10.0.2.26?) (jb@multitrading.dk@92.246.25.51)
  by audiovideo.dk with ESMTPA; 13 Sep 2012 18:17:20 -0000
In-Reply-To: <20120913175300953765.9ccf790f@gpio.dk>
X-Mailer: GyazMail version 1.5.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205402>

Hi Jeff and Drew.

I've been messing a little with clean/smudge filters; I think I understand them partly.

Let's call the file I have on the server that have <cr> line endings, "mypcb.osm".
If I clone the project, and do the following...
$ cat mypcb.osm | tr '\r' '\n'
I can read the file in the terminal window, otherwise it's just a "one-line-file".

So far, so good.
In my home directory, I have a .gitconfig file, here's the interesting part:
[core]
        editor = nano
        excludesfile = /Users/jens/.gitexcludes
        attributesfile = /Users/jens/.gitattributes

[filter "cr"]
        clean = tr '\\r' '\\n'
        smudge = tr '\\n' '\\r'


In my home directory I added .gitattributes:
*.osm   filter=cr

I've verified that .gitattributes is read; because if I add two spaces, like "*.osm filter = cr", I get an 'invalid filter name' error.
I've also verified that the clean/smudge lines are read; if I only have '\n' for instance, I get an error.

Now, when I clone the project, make a change and then issue this command...
$ git diff mypcb.osm

...I get a strange diff. On line 3, one of the files shows a lot of control-m (<cr>) lines.
After that, I see <lf> lines, all prefixed with a '+', as if they were added.

I think I might be nearly there, just missing some obvious detail somewhere.
Any hints ?


Love
Jens

On Thu, 13 Sep 2012 17:53:00 +0200, Jens Bauer wrote:
> Hi Jeff and Drew.
> 
> Thank you for your quick replies! :)
> 
> The diffs look nasty yes; that's my main issue.
> It can be worked around in many ways; eg a simple (but time consuming) way:
> $ git diff mypcb.osm >mypcb.diff && nano mypcb.diff
> 
> -It'd be better to just pipe it into a regex, which changes CR to LF 
> on the fly.
> 
> OsmondPCB is able to read files that has mixed LF and CR. (By mixed, 
> I do not talk about CRLF)
> 
> The files do not need line-by-line diffing, but I think it would make 
> it more readable.
> Thank you very much for the hint on the clean/smudge filters. I'll 
> have a look at it. =)
> 
> 
> Love
> Jens
> 
> On Thu, 13 Sep 2012 11:43:10 -0400, Jeff King wrote:
>> On Thu, Sep 13, 2012 at 11:34:50AM -0400, Drew Northup wrote:
>> 
>>>> I've read that git supports two different line endings; either CRLF 
>>>> or LF, but it does not support CR.
>>>> Would it make sense to add support for CR (if so, I hereby request 
>>>> it as a new feature) ?
>>> 
>>> Even if Git can't do CRLF/LF translation on a file it will still store
>>> and track the content of it it just fine. In fact you probably want
>>> translation completely disabled in this case. 
>> 
>> Yeah. If the files always should just have CR, then just don't ask git
>> to do any translation (by not setting the "text" attribute, or even
>> setting "-text" if you have something like autocrlf turned on globally),
>> and it will preserve the bytes exactly. I suspect diffs will look nasty
>> because we won't interpret CR as a line-ending, though.
>> 
>> Do the files actually need line-by-line diffing and merging? If not,
>> then you are fine.
>> 
>> If so, then it would probably be nice to store them with a canonical LF
>> in the repository, but convert to CR on checkout. Git can't do that
>> internally, but you could define clean/smudge filters to do so (see the
>> section in "git help attributes" on "Checking-out and checking-in";
>> specifically the "filter" subsection).
>> 
>> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
