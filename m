From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 00/19] Introduce an internal API to interact with the
 fsck machinery
Date: Tue, 03 Feb 2015 17:33:39 +0100
Organization: gmx
Message-ID: <2313893ae2200229ccdeb8f71b629445@www.dscho.org>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1422737997.git.johannes.schindelin@gmx.de>
 <060e1e6a5530dfb311074b0aa854b281@www.dscho.org>
 <54CF70DA.5090506@alum.mit.edu>
 <d5ebe9aeb5f4dd5cbe8673ae2076ba04@www.dscho.org>
 <54D0E50A.5030601@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, peff@peff.net
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Feb 03 17:33:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIgQC-0006DT-Vb
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 17:33:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756009AbbBCQds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 11:33:48 -0500
Received: from mout.gmx.net ([212.227.15.18]:62191 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754501AbbBCQdr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 11:33:47 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LmbVT-1XkB0x0ezT-00aFeN; Tue, 03 Feb 2015 17:33:40
 +0100
In-Reply-To: <54D0E50A.5030601@alum.mit.edu>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:L0UFCzg3qPY7zs1KauXEZHc+9PdMSuK5IQPmJY4w0uIBH3mUoo8
 FYu0UjJmibobOWB6o/XP2PDtq6P7eYNpxeX4cLZ5fGgk6R9JSa4y60xALaBJcTO+ZiKfPHb
 +hdCMY7cs4iMwPI7EfCI1xaoqJlEFHrMD/Ix97cyPoNP38J282KnmaD5OxzdOUtPt8MWBDC
 +FCFsXXz82Ohy2lw1jNvQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263324>

Hi Michael,

On 2015-02-03 16:11, Michael Haggerty wrote:
> On 02/02/2015 05:48 PM, Johannes Schindelin wrote:
>> On 2015-02-02 13:43, Michael Haggerty wrote:
>>> On 02/02/2015 12:41 PM, Johannes Schindelin wrote:
>>>> Hi all (in particular Junio),
>>>>
>>>> On 2015-01-31 22:04, Johannes Schindelin wrote:
>>>>
>>>>> [...] switch to fsck.severity to address Michael's concerns that
>>>>> letting fsck.(error|warn|ignore)'s comma-separated lists possibly
>>>>> overriding each other partially;
>>>>
>>>> Having participated in the CodingStyle thread, I came to the
>>>> conclusion that the fsck.severity solution favors syntax over
>>>> intuitiveness.
>>>>
>>>> Therefore, I would like to support the case for
>>>> `fsck.level.missingAuthor` (note that there is an extra ".level." in
>>>> contrast to earlier suggestions).
>>>
>>> Why "level"?
>>
>> "Severity level", or "error level". Maybe ".severity." would be better?
> 
> Sorry, I should have been clearer. I understand why the word "level"
> makes sense, as opposed to, say, "peanut-butter". What I don't
> understand is why a middle word is needed at all. In the config file it
> will look like
> 
> [fsck "level"]
>         missingAuthor = error
> 
> , which looks funny. "level" is a constant, so it seems superfluous.
> 
> If anything, it might be more useful to allow an optional middle word to
> allow the strictness level to be adjusted based on which command
> encounters the problem. For example, if you want to tolerate existing
> commits that have missing authors, but not allow any new ones to be
> pushed, you could set
> 
> [strictness]
>         missingAuthor = ignore
> [strictness "receive-pack"]
>         missingAuthor = error
> 
> (There's probably a better word than "strictness", but you get the idea.)

Ah. Well, the idea of the middle constant is to separate the severity levels from all other fsck (or receive.fsck) settings. The 'fsck.skiplist' setting that I introduce in this patch series, for example, looks pretty much the same as 'fsck.missingauthor', but they have different roles.

This becomes important when I want to catch obvious problems such as 'fsck.missingautor': if I have an extra '.level', I can be certain that it is a typo rather than a config setting unrelated to the severity levels.

>>>> The benefits:
>>>>
>>>> - it is very, very easy to understand
>>>>
>>>> - cumulative settings are intuitively cumulative, i.e. setting
>>>> `fsck.level.missingAuthor` will leave `fsck.level.invalidEmail`
>>>> completely unaffected
>>>>
>>>> - it is very easy to enquire and set the levels via existing `git
>>>> config` calls
>>>>
>>>> Now, there is one downside, but *only* if we ignore Postel's law.
>>>>
>>>> Postel's law ("be lenient in what you accept as input, but strict in
>>>> your output") would dictate that our message ID parser accept both
>>>> "missing-author" and "missingAuthor" if we follow the inconsistent
>>>> practice of using lowercase-dashed keys on the command-line but
>>>> CamelCased ones in the config.
>>>>
>>>> However, earlier Junio made very clear that the parser is required to
>>>> fail to parse "missing-author" in the config, and to fail to parse
>>>> "missingAuthor" on the command-line.
>>>>
>>>> Therefore, the design I recommend above will require two, minimally
>>>> different parsers for essentially the same thing.
>>>>
>>>> IMHO this is a downside that is by far outweighed by the ease of use
>>>> of the new feature, therefore I am willing to bear the burden of
>>>> implementation.
>>>
>>> I again encourage you to consider skipping the implementation of
>>> command-line options entirely. It's not like users are going to want to
>>> use different options for different invocations. Let them use
>>>
>>>     git -c fsck.level.missingAuthor=ignore fsck
>>>
>>> if they really want to play around, then
>>>
>>>     git config fsck.level.missingAuthor ignore
>>>
>>> to make it permanent. After that they will never have to worry about
>>> that option again.
>>
>> Unfortunately, I have to pass the `receive.fsck.*` settings from
>> `git-receive-pack` to `git-unpack-objects` or `git-index-pack` via the
>> command-line, because it is `git-receive-pack` that consumes the config
>> setting, but it is one of `git-unpack-objects` and `git-index-pack` that
>> has to act on it...
> 
> Wouldn't that work automatically via the GIT_CONFIG_PARAMETERS
> mechanism? If I run
> 
>     git -c foo.bar=baz $CMD
> 
> , then git-$CMD is invoked with GIT_CONFIG_PARAMETERS set to
> "'foo.bar=baz'", which causes child processes to treat that value as a
> configuration setting. I don't have a lot of experience with this but I
> think it should do what you need.

This is true, but please remember that the receive.fsck.* settings should be heeded by index-pack/unpack-objects *only* if one of the latter programs is called by receive-pack. It would therefore be a little funny (or wrong, depending on your point of view) if, say, index-pack would respect the receive.fsck.* settings.

That is why receive-pack adds a `--strict` command-line option when receive.fsckobjects is set to true instead of letting index-pack (or unpack-objects) look at the config variable receive.fsckobjects itself.

In the same spirit, I extend the `--strict` command-line option with an optional list of severity level overrides (e.g. `--strict=missing-author=ignore,...`) if receive-pack was configured to override those levels.

Now, as this optional argument is intended for internal use only, we could declare that it is okay to pass CamelCased stuff there, even if it disagrees with our command-line option conventions. If it is not okay, I will have to write a rewriter that consumes the CamelCased config settings and rewrites them as lowercase-dashed settings, to be passed to index-pack or unpack-objects, which in turn parses the lowercase-dashed settings.

It might be seen as unnecessarily complicated, which is why I argued in favor of letting the parser accept both forms (which incidentally would heed Postel's law, too). But I understand if Junio does not want that, because it technically violates the conventions he wants to see established. I just need a definitive statement which way to go so I can implement it.

Ciao,
Dscho
