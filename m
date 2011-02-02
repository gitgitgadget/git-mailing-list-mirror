From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] t9010-svn-fi: Add tests for svn-fi
Date: Tue, 1 Feb 2011 21:18:12 -0600
Message-ID: <20110202031812.GB15285@elie>
References: <1296570403-9082-1-git-send-email-artagnon@gmail.com>
 <1296570403-9082-3-git-send-email-artagnon@gmail.com>
 <20110201185817.GG3771@burratino>
 <20110202024944.GA11339@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 02 04:19:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkTFP-0001nO-7Z
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 04:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853Ab1BBDST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 22:18:19 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49652 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815Ab1BBDSS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 22:18:18 -0500
Received: by gyb11 with SMTP id 11so2783684gyb.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 19:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=89oBMFFVunYNO/vEWKO1Mj3mnvfTLTHT+ExMcPTy1p0=;
        b=wM96c4Ph1/jsVpRCFBFH0p0wgfgf7wykpZ5r/uvR1KYiJ1KBl05SyyZxBkt63XtlSY
         3M2NIAyprTqX2E1+3gyYI/kYgG1ZO2UG60AlxWKv78kAYFet15f+urCJlLU/BDtXhiLN
         L/J5XnS2SrqZr+sG2PL8bAhHdC2yGEtrNzQ5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xoydp1AvPtyrON2mePKFy67LEMDI3TZfwFX5e0HO68FXJ8utYZOLbo7EmzieUfsQq1
         /129wMDrXdlwkGlzxtQS7Z2VajpeqLVyqTqrC6uFBJv3ZF0b8p3/dQGNRfw4LNoZmlQ1
         FLYbqLhvHzJmXx5oe3EceqZ0qDNYpkIUNWiT0=
Received: by 10.90.249.31 with SMTP id w31mr11504000agh.169.1296616697852;
        Tue, 01 Feb 2011 19:18:17 -0800 (PST)
Received: from elie (adsl-69-209-75-28.dsl.chcgil.ameritech.net [69.209.75.28])
        by mx.google.com with ESMTPS id 17sm28059246anx.33.2011.02.01.19.18.14
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Feb 2011 19:18:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110202024944.GA11339@kytes>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165891>

Ramkumar Ramachandra wrote:
> Jonathan Nieder writes:
>> Ramkumar Ramachandra wrote:

>> Is it impossible to test without svn present or otherwise speed
>> these up?  Some random ideas:
[...]
> Hm, I'm not entirely convinced -- the final verdict is always dictated
> by whether or not the emitted dumpstream loads. Many streams that look
> alright to the eye don't actually load because of small intricacies
> like missing newlines. It'll be awfully complicated reverse-engineer
> all these intricate rules and write them in terms of sed/ awk
> commands. Yes, svnrdump will be faster, but it'll only be available
> with the later versions of Subversion (same problem with fixing
> svnadmin bottlenecks).

If svnrdump is fast enough, wouldn't something like

 if svnrdump --help >/dev/null 2>&1
 then
	load_dump () {
		svnrdump load "file://$1"
	}
	test_set_prereq SVN
 elif svnadmin --help >/dev/null 2>&1
 then
	load_dump () {
		svnadmin load "$1"
	}
	test_set_prereq SVN
 else
	: no usable svn installation
 fi

do it?

>>> +svn_look () {
>>> +	subcommand=$1 &&
>>> +	shift &&
>>> +	svnlook "$subcommand" "$svnrepo" "$@"
>>> +}
[...]
> Just a convinience: I am using svn_look to look at the properties of
> nodes in several tests.

Ah, I missed the implicit $svnrepo argument.  Makes sense then (might
be good to have a comment to explain the purpose, though).

>>> +test_expect_success 'normal empty files' '
>>> +	reinit_svn &&
>>> +	cat >expect.tree <<-\EOF &&
>>> +	/
>>> +	 foo
>>> +	 bar
>>> +	EOF
>>> +	cat >input <<-\EOF &&
>>> +	reset refs/heads/master
>>> +	commit refs/heads/master
>>> +	mark :1
>>> +	author nobody <nobody@localhost> 1170199019 +0100
>>> +	committer nobody <nobody@localhost> 1170199019 +0100
>>
>> Where do the dates come from?  Why should I (the reader) expect
>> them?
>
> What do you suggest? I need some valid "generic" timestamp + offset.

	test_tick
	...
	author nobody <nobody@localhost> $GIT_AUTHOR_DATE

[...]
> Okay, I'll try this. Is there no other way? Can we whip up a shell
> script to convert the timestamp?

Maybe the standard "date" utility can help with conversions?

I'm not sure what kinds of validation you're doing on the dates, hence
the vague answers.  For examples of fuzzing out the unimportant bits,

 git grep fuzz t/*.sh

can help.

>>> +test_expect_success 'malformed fast-import stream: author 2' '
[...]
>>> +	try_load input must_fail
>> 
>> What's wrong with this stream?
>
> author nobody <localhost>
>                         ^
> Parse error there, since build_svn_author tries to use the part of the
> email address appearing before the '@'. This is just a temporary test
> -- we should make the svn_author generation logic configurable.

So the stream is not malformed?  In that case, I guess the
intent is

 test_expect_failure 'does something reasonable with email address without @' '
	...
	try_load input
 '

Thanks again.
Jonathan
