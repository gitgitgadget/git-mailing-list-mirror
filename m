From: Andreas Ericsson <ae@op5.se>
Subject: Re: git mailinfo strips important context from patch subjects
Date: Mon, 29 Jun 2009 11:53:11 +0200
Message-ID: <4A488F07.10002@op5.se>
References: <20090628193858.GA29467@codelibre.net>	<20090628200259.GB8828@sigio.peff.net> <7vfxdkez96.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Roger Leigh <rleigh@codelibre.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 11:53:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLDYO-0003CN-7o
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 11:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754454AbZF2JxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 05:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754063AbZF2JxO
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 05:53:14 -0400
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:34027 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753327AbZF2JxN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Jun 2009 05:53:13 -0400
Received: from source ([209.85.220.215]) by na3sys009aob108.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSkiPC/TXGLz5W7ZJ3WgYqH4evYEic7sB@postini.com; Mon, 29 Jun 2009 02:53:17 PDT
Received: by fxm11 with SMTP id 11so1788934fxm.5
        for <git@vger.kernel.org>; Mon, 29 Jun 2009 02:53:14 -0700 (PDT)
Received: by 10.86.90.13 with SMTP id n13mr1770615fgb.45.1246269194791;
        Mon, 29 Jun 2009 02:53:14 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 12sm5542510fgg.29.2009.06.29.02.53.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Jun 2009 02:53:14 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <7vfxdkez96.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122433>

Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> On Sun, Jun 28, 2009 at 08:38:58PM +0100, Roger Leigh wrote:
>>
>>> In most of the projects I work on, the git commit message has
>>> the affected subsystem or component in square brackets, such as
>>>
>>>   [foo] change bar to baz
>>>
>>> [...]
>>>
>>> The [sbuild] prefix has been dropped from the Subject, so an
>>> important bit of context about the patch has been lost.
>>>
>>> It's a bit of a bug that you can't round trip from a git-format-patch
>>> to import with git-am and then not be able to produce the exact same
>>> patch set with git-format-patch again (assuming preparing and applying
>>> to the same point, of course).
>> As an immediate solution, you probably want to use "-k" when generating
>> the patch (not to add the [PATCH] munging) and "-k" when reading the
>> patch via "git am" (which will avoid trying to strip any munging).
>>
>> However:
>>
>>> Would it be possible to change the git-mailinfo logic to use a less
>>> greedy pattern match so it leaves everything after
>>> ([PATCH( [0-9/])+])+ in the subject?  AFAICT this is cleanup_subject in
>>> builtin-mailinfo.c?  Could this rather complex function not just do a
>>> simple regex match which can also take care of stripping ([Rr]e:) ?
>> Yes, I think in the long run it makes sense to strip just the _first_
>> set of brackets. I don't think we want to be more specific than that in
>> the match, because we allow arbitrary cruft inside the brackets (like
>> "[RFC/PATCH]", etc). But if format-patch always puts exactly one set of
>> brackets, and am strips exactly one set, then that should retain your
>> subject in practice, even if it starts with [foo].
> 
> I think it may still make sense to insist that PATCH appears somewhere in
> the first set of brackets, but I have stop and wonder if it is even
> necessary.
> 
> Because git removes [sbuild] at the beginning, Roger is unhappy.
> 

[ and a lot more ]

> 
> _An_ established (note that I did not say _the_ nor _best current_)
> practice supported well by git to note the area being affected in a
> project of nontrivial size is to prefix the single line summary with the
> name of the area followed by a colon.  There is no difference between
> "[sbuild] foo" and "sbuild: foo" at the information content point-of-view,
> but the latter has an advantage of being one letter shorter and less
> distracting in MUA.  He does not have a very strong reason to choose
> something different only to make his life harder, does he?
> 

True, but it seems wrong to have am remove more of the subject than
format-patch prepends. Imagine a commit subject looking like this:
  "Allow [ and ] in the blurble.foostuff table".

Should am strip the subject all the way up to the last ']'? I think
not, and I'd be very vexed if it did.

> Users can take advantage of this established practice when running
> shortlog with "--grep=^area:" to limit the birds-eye-view to a specific
> area.  If this turns out to be useful, we could even add an option to "git
> log --area=name" that limits this kind of match to the first paragraph of
> the commit log message, for example.
> 
> Supporting a slightly different convention may seem to be accomodating and
> nice, but if there is no real technical difference between the two (and
> again, "area:" is one letter shorter ;-), letting people run with
> different convention longer, when they can switch easily to another
> convention that is already well supported, may actually hurt them in the
> long run.  "[sbuild]" will not match "--area=sbuild" that will internally
> become "--grep-only-first-line=sbuild:" so either he will miss out
> benefiting from the new feature, or the implementation of the new feature
> unnecessarily needs more code.
> 
> It is not about discouraging a wrong workflow or practice, because there
> is nothing _wrong_ per-se in [sbuild] prefix.  It is just that it makes
> things harder in the long run.  In this particular case, it is only very
> slightly harder, but these things tend to add up from different fronts.

Agreed, but there are valid use-cases orthogonal to subsystem naming to
place [] in the patch subject. I still feel that since format-patch only
adds one set, am (mailinfo) should really only remove one set, too. It's
what makes sense, really.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
