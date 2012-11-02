From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: bisect: "Needed a single revision" message is confusing
Date: Fri, 02 Nov 2012 15:10:27 +0100
Message-ID: <5093D453.3050907@drmicha.warpmail.net>
References: <CAO5QaZkZYxvSYoAQGgrrH1ULM8rnwX5=0Ln-_zfh8OwdegNNoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Daniel Bonniot <bonniot@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 15:10:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUHxL-00082o-5u
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 15:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762868Ab2KBOKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 10:10:30 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:35746 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752606Ab2KBOK3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Nov 2012 10:10:29 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id CA98B20C86;
	Fri,  2 Nov 2012 10:10:28 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 02 Nov 2012 10:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=wvnRSma0ga6MQfL7SSz/++
	/+m1w=; b=bppAJdqxgq+co3I4mHBU+MZPCJD/OtFT9mdA+GnH1TaHfjrDiBXiLJ
	TnbR7logV2WkiCCMx+W7oY2wQjRZm7GivSTuST1jEBCTnj11Of27jJBiMO3IOhR6
	v4HbhlYidJD4qMmW5KWG5K7BBC1lB0efvVbrfwN0VF9c+hPWBrqpE=
X-Sasl-enc: kfU8ys3X8D2QGLuzT5gwDdcddQD7ii32GwLpCnFSbScj 1351865428
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 58ABC8E04AF;
	Fri,  2 Nov 2012 10:10:28 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
In-Reply-To: <CAO5QaZkZYxvSYoAQGgrrH1ULM8rnwX5=0Ln-_zfh8OwdegNNoA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208936>

Daniel Bonniot venit, vidit, dixit 02.11.2012 14:23:
> Hi,
> 
> Suppose I'm doing a git bisect, say:
> 
> $ git bisect good 8c7a786b6c8eae8eac91083cdc9a6e337bc133b0
> 
> That works fine. The sha1 could also be a substring, as long as it's
> unambiguous, e.g.:
> 
> $ git bisect good 8c7a786b6c
> 
> Now if it's ambiguous, I get an error message:
> 
> $ git bisect good 8
> fatal: Needed a single revision
> Bad rev input: 8
> 
> All fine and good. But what if I somehow input a non-existing sha1 (in
> my case see [1]), e,g:
> 
> $ git bisect good 8c7a786b6c8eae8eac91083cdc9a6e337bc133b1
> fatal: Needed a single revision
> Bad rev input: 8c7a786b6c8eae8eac91083cdc9a6e337bc133b1
> 
> I understand that technically both "no revision" and "multiple
> revisions" qualify as "not a single revision", but they correspond to
> quite different situations. I think it would be more helpful to get
> different error messages, something like:
> 
> Bad rev input: 8 refers to multiple revisions
> Bad rev input: 8c7a786b6c8eae8eac91083cdc9a6e337bc133b1 does not refer
> to a valid revision
> 
> (and avoid outputing the "fatal: Needed a single revision" message).
> 
> Is this a good idea? Anybody can think of better error messages?
> 
> I'm not familiar with the code base at all, but I could give a try at
> implementing it, unless it's trivial enough that someone does it
> earlier. After a quick look, it looks like either git-bisect itself or
> rev-parse would need to be touched, any pointers and hints welcome.
> 
> Cheers,
> 
> Daniel
> 
> [1] if you want to know, I got a sha1 from one repository and used it
> in another, which probably should work, except that when using git-svn
> they don't. And the "single revision" error message lead me on a
> tangent.
> 

The error comes from rev-parse, which is called by bisect. The problem
is that

git rev-parse deadbeef
git rev-parse --verify deadbeef

give two very different error messages (if there's no dead beef there),
and that "git ref-parse --verify" gives the same error message for
non-existing as for ambiguous revs.

There are 3 places in builtins/rev-parse.c which call
die_no_single_rev(), and at least some of them should probably choose
the error message more carefully.

Cheers,
Michael
