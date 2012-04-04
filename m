From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 2/2] fast-import: tighten parsing of mark references
Date: Wed, 4 Apr 2012 00:32:37 -0500
Message-ID: <20120404053236.GA2460@burratino>
References: <20120401225407.GA12127@padd.com>
 <1333417910-17955-1-git-send-email-pw@padd.com>
 <1333417910-17955-3-git-send-email-pw@padd.com>
 <20120403142001.GD15589@burratino>
 <20120404012037.GB4124@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dmitry Ivankov <divanorama@gmail.com>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 07:33:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFIqS-00026N-VG
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 07:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380Ab2DDFcq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 01:32:46 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37309 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912Ab2DDFcp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 01:32:45 -0400
Received: by iagz16 with SMTP id z16so670732iag.19
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 22:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UCoj4kjUR7vwg5yZxLSeceA/mZmJZzyKefGfHi52xfk=;
        b=1Egimpc6VoEyVAxZMDshhtG0l2sVfE4bSZlzbffvTkFVr1WD6raZ117WAaQYkjd2wv
         ThzcKfoy3Br+eqTuw3/Vayu9Y3oMk4DBK/ZOZ0A1k2CbotiZkYd9qX+xXng5Ip9Gs9lt
         yp8NNDBip+jEcA+Vkxw76WQJfiYvJ1YA1EJj9bGa0cLY+h7jsBJ4mdUOLzeTSy9eyjaw
         I17Pr9VxU/0WuYcAU1K+AH1+nJ3bnPTFYNtlYir9xJrzZM37fYRcjOOue4k25UeC2vd2
         YwizHnz89GRlsQo99v/g9syj02WWp2A40zFskjePMIAn2EqWwQAVpSoX6dG7NX0ZFAfj
         0lxQ==
Received: by 10.50.89.234 with SMTP id br10mr543447igb.14.1333517563943;
        Tue, 03 Apr 2012 22:32:43 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id gr1sm1242591igc.1.2012.04.03.22.32.42
        (version=SSLv3 cipher=OTHER);
        Tue, 03 Apr 2012 22:32:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120404012037.GB4124@padd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194678>

Pete Wyckoff wrote:
> jrnieder@gmail.com wrote on Tue, 03 Apr 2012 09:20 -0500:

>> Simpler:
>> 
>> 	if (*p == ':') {
>> 		oe = find_mark(parse_mark_ref_space(p, &p));
>> 		hashcpy(sha1, oe->idx.sha1);
>> 	} else if ...
>
> Yes.  I thought about just passing in plain old &p.  Even though
> these approaches would work, it is a bit more difficult for
> novice C coders to read.  Figured we should err on the side of
> helping future code readers.  I can add more cleverness if you
> feel strongly.

It would be clearest with one argument, like so:

		oe = find_mark(parse_mark_...(&p));
		hashcpy(sha1, oe->idx.sha1);

[...]
> Insead of "Missing space after 'inline'", you'll get "Invalid
> SHA1".  You misspelled "inline" with "inliness"?  And would
> prefer to be told you provided an invalid SHA1?

It wasn't a great example, but what I meant is that if someone
asked me, a human, to parse

	M 100644 foobar path/to/file

I would assume that foobar is a <dataref>.  Likewise, for any
string baz in

	M 100644 baz path/to/file

including strings that start with "inline", except for "inline"
itself.

To put it another way: checking for 'inline' at the start of a word as
a way to check for typos seems odd to me.  We do not diagnose

	M 100644 Inline path/to/file

as a misspelled version of "inline", nor

	M 100644inline path/to/file

as an instance of a missing space character, and we shouldn't.

The goal in fast-import's behavior is usually predictability and
simplicity in terms of the mental model of the person writing a
frontend.  Trying to guess the user's intention on malformed input
only takes away from that goal.

Why I care: if some day git permits other kinds of <dataref> (for
example if it supports refnames some day), I do not want datarefs
beginning with "inline" to be forbidden.

[...]
> There are two cases it handles:  mark and sha1.  The mark case
> uses the handy new parse_mark_ref_space(), which does the space
> checking.  The sha1 branch had no check in this function.  So
> I hoisted the space check up to make the branches symmetrical.

I think it's ok to sacrifice symmetry here, but:

[...]
> I would prefer just to inline the whole thing.  Or new name
> parse_ls_dataref() if you have a preference.

if changing the behavior of the function that parses a treeish dataref
seems right, that's fine with me as long as its name or signature
changes.

For example, it could become

	static struct object_entry *parse_treeish(const char **p);

Hope that helps,
Jonathan
