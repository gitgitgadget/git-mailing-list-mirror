From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC PATCH 3/3] grep: add support for grepping in submodules
Date: Thu, 30 Sep 2010 13:09:57 +0200
Message-ID: <4CA47005.7030102@web.de>
References: <1285792134-26339-1-git-send-email-judge.packham@gmail.com> <1285792134-26339-4-git-send-email-judge.packham@gmail.com> <4CA3BBD7.3090006@web.de> <7v4od8ma0j.fsf@alter.siamese.dyndns.org> <4CA3D01B.6060600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 13:10:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1H1d-0007qG-3k
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 13:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102Ab0I3LKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 07:10:01 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:43347 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684Ab0I3LKB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 07:10:01 -0400
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 36F78173979F4;
	Thu, 30 Sep 2010 13:10:00 +0200 (CEST)
Received: from [93.240.103.152] (helo=[192.168.178.29])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #24)
	id 1P1H1U-0007vN-00; Thu, 30 Sep 2010 13:10:00 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <4CA3D01B.6060600@gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18/WXBuho9nbgBpnWgOgSIOFYy5SL52d8XJVM/c
	pEQD6YFvWFXazI40UtWHAY/lELch0c8jsRSwIF+dpRB/svFbrK
	130qZBsejcP6hzDQsRrw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157638>

Am 30.09.2010 01:47, schrieb Chris Packham:
> On 29/09/10 15:59, Junio C Hamano wrote:
>> A few more things to think about.
>>
>> 1. What does this mean:
>>
>>     $ git grep --recursive -e frotz master next
>>
>> It recurses into the submodule commits recorded in 'master' and 'next'
>> commits in the superproject, right?
>>
>> How do the lines output from the above look like?  From the superproject,
>> we will get lines like these:
>>
>>     master:t/README:  test_description='xxx test (option --frotz)
>>     master:t/README:  and tries to run git-ls-files with option --frotz.'
>>
>> What if we have a submodule at git-gui in the superproject, and its README
>> has string frotz in it?  Should we label the submodule commit we find in
>> 'master' of superproject as 'master' as well, even if it is not at the tip
>> of 'master' branch of the submodule?  Or do we get abbreviated hexadecimal
>> SHA-1 name?  IOW, would we see:
>>
>>     master:git-gui/README: git-gui also knows frotz
>>
>> or
>>
>>     deadbeef:git-gui/README: git-gui also knows frotz
>>
>> where "deadbeaf...." is what "git rev-parse master:git-gui" would give us
>> in the superproject?
>>
>> I tend to think the former is preferable, but then most likely you would
>> need to pass not just submodule-prefix but the original ref name
>> (i.e. 'master') you started from down to the recursive one.

Me too thinks that as you grep from inside the superproject it makes
more sense to use the ref name used there and not the SHA-1 from the
submodule.

> Passing the ref name is doable. There is a little potential for
> confusion between who's "master" that actually is (the same confusion is
> in theory possible with an abbreviated SHA-1). Maybe we should color the
> submodule ref's differently

Hmm, showing somehow that the grep result is from inside a submodule
could be helpful. But using something like the following line seems a
bit like overkill, so coloring might be a good alternative:

     master/deadbeef:git-gui/README: git-gui also knows frotz

But I don't have a strong opinion here.


>> 2. Now how would this work with pathspecs?
>>
>>     $ git grep --recursive -e frotz -- dir/
>>
>> This should look for the string in the named directory in the superproject
>> and if there are submodules in that directory, recurse into them as well,
>> right?
>>
>> What pathspec, if any, will be in effect when we recurse into the
>> submodule at dir/sub?  Limiting to dir/ feels wrong, no?
>>
>> 3. Corollary.
>>
>> Is it reasonable to expect that we will look into all shell scripts, both
>> in the superproject and in submodules, with this:
>>
>>     $ git grep --recursive -e frotz -- '*.sh'
>>
>> Oops?  What happened to the "we restrict the recursion using pathspec, and
>> we do not pass down the pathspec" that was suggested in 2.?
>>
> 
> This is a bit of a grey area, I'm not sure what is the sensible thing to do.
> 
> Maybe we could pop a directory level per recursion e.g.
>   user enters 'dir/sub/subsub/*.sh'
>   first level recursion is passed 'sub/subsub/*.sh'
>   second level recursion is passed 'subsub/*.sh'
>   subsequent levels of recursion are passed '*.sh'
> 
> But that's not quite what the user thought they asked for (i.e. they
> will end up with dir/sub/subsub/subsubsub/file.sh).
> 
> Or we could alter the behaviour based on whether their original pathspec
> had an explicit trailing /.

I think we'll have to manipulate the pathspecs so we properly translate
their meaning into the context of the submodule. What about this: If
they point outside the submodule, they must be dropped. If they contain
directories, the prefix part has to be stripped from the beginning.
Examples for submodule 'dir/sub':

  * 'dir/' and 'dir/sub2/' get dropped as they point outside
  * '*.sh' should just be passed on
  * 'dir/sub/foo/*.sh' would become 'foo/*.sh'
  * 'dir/sub/' gets dropped too (as the result of stripping the
    prefix is '')

That should lead to the expected behavior.
