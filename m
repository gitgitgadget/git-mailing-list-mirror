From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 00/19] Introduce an internal API to interact with the
 fsck machinery
Date: Wed, 04 Feb 2015 12:02:45 +0100
Organization: gmx
Message-ID: <d268ca769c3813cdb600672c40e2c484@www.dscho.org>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1422737997.git.johannes.schindelin@gmx.de>
 <060e1e6a5530dfb311074b0aa854b281@www.dscho.org>
 <54CF70DA.5090506@alum.mit.edu>
 <d5ebe9aeb5f4dd5cbe8673ae2076ba04@www.dscho.org>
 <54D0E50A.5030601@alum.mit.edu>
 <2313893ae2200229ccdeb8f71b629445@www.dscho.org>
 <xmqqegq6nxmh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 12:03:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIxjh-0004LY-Dt
	for gcvg-git-2@plane.gmane.org; Wed, 04 Feb 2015 12:03:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887AbbBDLDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2015 06:03:05 -0500
Received: from mout.gmx.net ([212.227.17.21]:58745 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753206AbbBDLDB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2015 06:03:01 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lp8h6-1XgJ3S3mvU-00euZa; Wed, 04 Feb 2015 12:02:46
 +0100
In-Reply-To: <xmqqegq6nxmh.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:qYze3aw60SnKEeArS7m4NrHFBUb+nWZGpkRJOAKxV8wu4/Gzl/T
 +1ZFxq+tz0n+vWR+9E6TYGkkmzKsM/AJnCKTAMWXFqyW0DxqQiu8AaE36RnAgImHlnpK7rT
 JK5A2CfSiRtPO/og3Mz3mewbG4dTV26p/rcuAu7+iUTIaXtIt29QfYwi8TR9ch6HgNBrJmd
 LDvGhag2ELbBuqnFhJt/g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263350>

Hi Junio,

On 2015-02-04 04:50, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>>> [fsck "level"]
>>>         missingAuthor = error
>>>
>>> , which looks funny. "level" is a constant, so it seems superfluous.
> 
> Yes, it is superfluous, but is one way to avoid the ambiguity with
> "skiplist".  Structuring it like this would not be so bad, either,
> though.
> 
> 	[fsck]
>         	error = missingAuthor[, other kinds of errors...]
> 
> A small set like {ignore, warn, error} is easily maintainable not to
> conflict with "skiplist" and others.

But you augmented the case against the {ignore, warn, error} structure with this yourself:

> With "fsck.error=missingAuthor[,other kinds]", you would
> instead have to do a bit more silly post-processing
> 
> 	git config -l | sed -ne '
>         	/^fsck\./{
> 			# make it "var=,token1,token2,token3,"
> 			s/=/=,/
>                         s/$/,/
>                         s/[ 	]*//g
> 			s|^fsck\.\([^=]*\)=.*,missingAuthor,.*|\1|p
> 		}
> 	' | tail -n 1

If a script to determine the current state of affairs is already convoluted, how complicated would it be for users of this feature? No, let's go with Michael's suggestion and have a much more elegant (read: easy to grasp) configuration.

I see that the extra ".level." is universally frowned on, and therefore am convinced that it would be bad to add it.

As to the conflict with "skiplist", by your own argument ("small set ... is easily maintainable") it is not a problem at all.

>> This becomes important when I want to catch obvious problems such as
>> fsck.missingautor': if I have an extra '.level', I can be certain that
>> it is a typo rather than a config setting unrelated to the severity
>> levels.
> 
> "[fsck] error = missingAutor" would let you catch the typo in a similar
> way with the same context clue, so this does not decide which is
> better, either.

No, you are correct, this does not decide it. What decides it that `fsck.missingAuthor = error` is better than `fsck.error = missingAuthor` is that the user does not need to wrap her head around the significance of the order of mutually overriding `error`, `warn` and `ignore` settings in the former.

As to the typo handling, you are absolutely correct that it is easy to handle "skiplist" first and then expect all other fsck.* settings (or receive.fsck.* settings) to match a message ID. To make things even smoother, I think it would make most sense to only *warn* about typos instead of *erroring out*.

> I wonder if
> 
> 	[fsckError]
>         	missingAuthor = error
>                 missingTagger = warn

Hmm. I am not so sure that `fsckError` is the correct term. After all, we can also upgrade warnings to errors, not only demote errors to warnings. So I guess the `fsck.*` naming scheme is not so bad after all!

>>>> Unfortunately, I have to pass the `receive.fsck.*` settings from
>>>> `git-receive-pack` to `git-unpack-objects` or `git-index-pack` via the
>>>> command-line, because it is `git-receive-pack` that consumes the config
>>>> setting, but it is one of `git-unpack-objects` and `git-index-pack` that
>>>> has to act on it...
> 
> But receive-pack at some point decides what, if anything, needs to
> be passed when invoking unpack-objects, or index-pack, no?  Why is
> it hard to pass "-c var=val" at the beginning where it would have
> passed "--strictness=var=val" at the end?

It is not hard, it is just inelegant: 1) we would have to introduce a new function to handle the config settings in `unpack-objects`, 2) the command-line would be longer (for what benefit?), and 3) index-pack uses run_command() to launch the children [*1*] and wouldn't you find it super-ugly if that argv started with a "-c", "..."? I would.

We already have command-line handling in both index-pack and unpack-objects (and config handling only in the former), we already have --strict handling in particular, and arguably the severity levels are tightly connected to that --strict option that at least in my opinion it makes sense to understand that the severity levels are optional parameters to that command-line option.

So in short, I maintain that passing the options via the config mechanism would just make things more complicated, and in no way better.

>>> Wouldn't that work automatically via the GIT_CONFIG_PARAMETERS
>>> mechanism? If I run
>>>
>>>     git -c foo.bar=baz $CMD
>>>
>>> , then git-$CMD is invoked with GIT_CONFIG_PARAMETERS set to
>>> "'foo.bar=baz'", which causes child processes to treat that value as a
>>> configuration setting. I don't have a lot of experience with this but I
>>> think it should do what you need.
>>
>> This is true, but please remember that the receive.fsck.* settings
>> should be heeded by index-pack/unpack-objects *only* if one of the
>> latter programs is called by receive-pack. It would therefore be a
>> little funny (or wrong, depending on your point of view) if, say,
>> index-pack would respect the receive.fsck.* settings.
> 
> That means it would be fine if receive-pack invokes (when it sees
> receive.fsck.severity=missingAuthor=error,missingTagger=warn config
> meant for it and was told with receive.fsckObjects to check the
> incoming objects) a command line like this:
> 
> 	git -c fsckError.missingAuthor=error \
>             -c fsckError.missingTagger=warn \
> 		index-pack $args...
> 
> (or whatever variable names and name structure we settle on).  And
> the index-pack command does not have to even know there are
> receive.fsck.* variables at all, no?

It does not know that at all already, so yes: I agree. It does not even need to know that those settings were config variables. Even better: it should not let config settings interfere with the settings receive-pack wants index-pack to use.

So there you have it, another reason why passing the levels via command-line options is conceptually much more sound than passing them via fake config settings.

> I think either way would be fine, as this communication is an internal implementation detail between receive-pack and index-pack and is not meant to be exposed to the end users anyway.

Yeah, I think we really used enough time to discuss something as unimportant as this detail.

Just to make sure: are you okay with passing CamelCased settings (e.g. `--strict=missingAuthor=warn,...`) as part of that internal communication between receive-pack and index-pack/unpack-objects? That is my preference by now.

Ciao,
Dscho

Footnote *1*: https://github.com/msysgit/git/blob/c47d6ec67188cec2a782bc245aa7df4e3cbdbc01/builtin/receive-pack.c#L992-L1001
