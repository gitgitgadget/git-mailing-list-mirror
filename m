From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Hacking git for managing machine readable "source" files
Date: Mon, 12 Oct 2015 10:07:12 +0200
Message-ID: <561B6A30.4060406@drmicha.warpmail.net>
References: <561B29DA.9050101@gna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Christian Gagneraud <chgans@gna.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 12 10:07:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlY8i-0008Nn-4k
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 10:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbbJLIHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 04:07:17 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:51235 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750806AbbJLIHO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Oct 2015 04:07:14 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 100FE2049C
	for <git@vger.kernel.org>; Mon, 12 Oct 2015 04:07:14 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute4.internal (MEProxy); Mon, 12 Oct 2015 04:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=l9QMEp8yy0OWZdirDslwW2nC3YQ=; b=E5odcj
	xRXuJf8hrpQ4cUyYvMl8JaYLjDMfZ3hX2HawdAmzeFlfr2RuZHFUIq1S8tmqs8ym
	goIMY1H7/V7yaxlssllrHedANLSUCbkvYkCAxF2V/StKwaOf+XFyhhR9eIxjd8dy
	oTr4QU7ShX3Cd5N/ovSUb16XWaTzAv/KNMH5g=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=l9QMEp8yy0OWZdi
	rDslwW2nC3YQ=; b=hoAFxmZ4BISXXIv0kn2fp1TM9kIfpUX37Zzy7h4mU5vtd3q
	MI/W9FeqbukMedgC03o2li+Mf5cZAm5NhF4vjLGWiHzpJogYYyoE3xfVP9jwRVOV
	8jdGd8EdwdRbqbDGpTl0gM05O0sc66AHh+7jdXuNI87H40XUrqucikjBhpw4=
X-Sasl-enc: RsBwtDG0OhZz48pc+Mydu7tQ+LGrIm0zk6vSF9JWPQLc 1444637233
Received: from dickson.math.uni-hannover.de (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 82328C00018;
	Mon, 12 Oct 2015 04:07:13 -0400 (EDT)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <561B29DA.9050101@gna.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279366>

Christian Gagneraud venit, vidit, dixit 12.10.2015 05:32:
> Hi git hackers,
> 
> I have been scratching my head since quite a few weeks to see if and how 
> I could hack git to manage non-software-source-code files. Theses files 
> might be text-based (XML, JSON, custom format, ...) but are not intended 
> for humans, thus diffing and merging them using standard git features 
> doesn't really make sense (and so the whole "pack" stuff seems useless 
> as well). These files represent a non-software project developed using a 
> graphical SW application. I'm talking here about designing and 
> simulating electronic projects, but it could be apply to any sort of 
> engineering (mechanical design comes second to me)
> 
> I would like to provide support for diffing, merging, branching and 
> forking such electronics projects.

[wall of text snipped]

I don't think you need to map the tree structure of your project to that
of git's object store, nor am I sure you would benefit from it. (In case
you do want to do it - look at the git-notes implementation.)

There are four handles in git's interface that you can use (and that
have been used):

A) clean/smudge filters: They are meant to transform your working tree
copy into a "standard/canonical form" which is stored in the repo (and
back).

As an example, uncompressing compressed file formats, removing
superfluous comments or time-stamps, sorting in default order (for
unordered files) produces objects in the repo which are a better fit for
packing and possibly also for git's default diff.

B) textconv filters: Possibly lossy filters that produce a human
readable form of an object which possibly also lends itself to a
meaningful git diff (but no way back). Can be cached.

C) external diff drivers: They are supposed to produce a meaningful diff
in cases where textconv+default diff are not enough. They simply receive
both objects to diff.

D) external merge drivers: They are supposed to merge (non-text) files
that git cannot merge.

You'll find pointers in the manual pages for git-diff, git-merge and
gitattributes.

Michael
