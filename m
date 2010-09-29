From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC PATCH 3/3] grep: add support for grepping in submodules
Date: Wed, 29 Sep 2010 16:47:39 -0700
Message-ID: <4CA3D01B.6060600@gmail.com>
References: <1285792134-26339-1-git-send-email-judge.packham@gmail.com> <1285792134-26339-4-git-send-email-judge.packham@gmail.com> <4CA3BBD7.3090006@web.de> <7v4od8ma0j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 01:47:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P16Mv-0006EG-RP
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 01:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023Ab0I2XrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 19:47:20 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44798 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918Ab0I2XrU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 19:47:20 -0400
Received: by pvg2 with SMTP id 2so324954pvg.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 16:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=YvQmmS1oJsTbWcUTsfcd+YSuxxBw9POouZhfvdOQM7w=;
        b=sZDSNn2+bTITp031JruVD8+QmYgY2aHqpIEd1HsgO5EqP0fWoSMvXEt9gTXYNktkSQ
         yyZM3YaNSG07f1pcmSEsAVRAosK0zl0fbRHB+mutZuXrAcBYv95AX0hky4nObwrByot4
         2ubXp9gjru7wbDtK+U0bvupHDM5OFjROAD3uY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=oZ3kpZ2GJJrzOXq9s3lQ+kqv6kRQhJ5PZejEi9crCeOLtw2fWPcOisE0s+YA47YEQ1
         JxBhKAzCph3tgapW+fHvWpsPMEBT+8SAh3+C/nbAx3+mBnzyBAWVw2BGt9kCV28sJMj/
         OxK2Py7o/dJMCxeakroqLRtd/HEBIi1Qf4Xg0=
Received: by 10.114.103.6 with SMTP id a6mr2925262wac.199.1285804039643;
        Wed, 29 Sep 2010 16:47:19 -0700 (PDT)
Received: from laptop.site (209-234-175-66.static.twtelecom.net [209.234.175.66])
        by mx.google.com with ESMTPS id o17sm15442707wal.21.2010.09.29.16.47.18
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 29 Sep 2010 16:47:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.1.11) Gecko/20100714 SUSE/3.0.6 Thunderbird/3.0.6
In-Reply-To: <7v4od8ma0j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157622>

On 29/09/10 15:59, Junio C Hamano wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Hm, at a quick glance it might be much easier to copy argc & argv
>> in cmd_grep() before parse_options() starts manipulating it.
> 
> Yes, I think that is a much saner direction to go.  Otherwise, you would
> need to unparse grep boolean expressions as well.

I've got some of that working in my quest to not use saved_argv[0]. If
we follow some of your points below about handling ref names then
rebuilding the args actually starts to make life easier. I guess the
same is true for just making these manipulations on the grep_opts. The
only thing that is really clear is that saving the original argv is not
going to help us.

> A few more things to think about.
> 
> 1. What does this mean:
> 
>     $ git grep --recursive -e frotz master next
> 
> It recurses into the submodule commits recorded in 'master' and 'next'
> commits in the superproject, right?
> 
> How do the lines output from the above look like?  From the superproject,
> we will get lines like these:
> 
>     master:t/README:  test_description='xxx test (option --frotz)
>     master:t/README:  and tries to run git-ls-files with option --frotz.'
> 
> What if we have a submodule at git-gui in the superproject, and its README
> has string frotz in it?  Should we label the submodule commit we find in
> 'master' of superproject as 'master' as well, even if it is not at the tip
> of 'master' branch of the submodule?  Or do we get abbreviated hexadecimal
> SHA-1 name?  IOW, would we see:
> 
>     master:git-gui/README: git-gui also knows frotz
> 
> or
> 
>     deadbeef:git-gui/README: git-gui also knows frotz
> 
> where "deadbeaf...." is what "git rev-parse master:git-gui" would give us
> in the superproject?
> 
> I tend to think the former is preferable, but then most likely you would
> need to pass not just submodule-prefix but the original ref name
> (i.e. 'master') you started from down to the recursive one.

Passing the ref name is doable. There is a little potential for
confusion between who's "master" that actually is (the same confusion is
in theory possible with an abbreviated SHA-1). Maybe we should color the
submodule ref's differently

> 2. Now how would this work with pathspecs?
> 
>     $ git grep --recursive -e frotz -- dir/
> 
> This should look for the string in the named directory in the superproject
> and if there are submodules in that directory, recurse into them as well,
> right?
> 
> What pathspec, if any, will be in effect when we recurse into the
> submodule at dir/sub?  Limiting to dir/ feels wrong, no?
> 
> 3. Corollary.
> 
> Is it reasonable to expect that we will look into all shell scripts, both
> in the superproject and in submodules, with this:
> 
>     $ git grep --recursive -e frotz -- '*.sh'
> 
> Oops?  What happened to the "we restrict the recursion using pathspec, and
> we do not pass down the pathspec" that was suggested in 2.?
> 

This is a bit of a grey area, I'm not sure what is the sensible thing to do.

Maybe we could pop a directory level per recursion e.g.
  user enters 'dir/sub/subsub/*.sh'
  first level recursion is passed 'sub/subsub/*.sh'
  second level recursion is passed 'subsub/*.sh'
  subsequent levels of recursion are passed '*.sh'

But that's not quite what the user thought they asked for (i.e. they
will end up with dir/sub/subsub/subsubsub/file.sh).

Or we could alter the behaviour based on whether their original pathspec
had an explicit trailing /.
