From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] filter-branch: strip pgp signature in commit messages
Date: Thu, 8 Oct 2015 12:00:54 +0200
Message-ID: <56163ED6.2030403@drmicha.warpmail.net>
References: <20151008050122.GA21369@freya.jamessan.com>
 <56162634.2010800@drmicha.warpmail.net> <56162C96.80108@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>
To: James McCoy <vega.james@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 08 12:01:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zk80T-0000BR-WD
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 12:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbbJHKA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 06:00:57 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:33074 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751039AbbJHKA4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Oct 2015 06:00:56 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id C52FD20453
	for <git@vger.kernel.org>; Thu,  8 Oct 2015 06:00:55 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 08 Oct 2015 06:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=JbalWYPA6ux5k0tgEtsV9HoP5bU=; b=BUFbRu
	DQA3cwWi+4WJBZIM+6tnlt7vaamhPNvph2S3T95YPnuGeQCt22rb3HbWILO6qBeR
	xMDR5NC8jU2JmgZ/TztF5GP6ftbsO85dXwhl9qtLbkb17PHzHVzIDGmmkiZ0sBTH
	nJLqYyZPig0lF3XHF9dni+Y4cRWj7L28j8YSg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=JbalWYPA6ux5k0t
	gEtsV9HoP5bU=; b=s/IJn5GkZubvt2Alrm8+kzfGzejt+uEz8zAMUl5mZh/Yhea
	AJQiw/ux8eVi2cXp/487p9k86xvoWR97DLvAWBLz2c+d7XPhSUpQibc0OGYrb8NC
	g/eRPcW5HSOLnGjnj22KqKvHddOd19tlmzzctHl+mzcnVvtjSqJ7g/iUGdcw=
X-Sasl-enc: XCKWMYOr3zbvjGcc3n6A93Udp+irGLzi8zq2o1el/tQG 1444298455
Received: from dickson.math.uni-hannover.de (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 2628A6801B9;
	Thu,  8 Oct 2015 06:00:55 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <56162C96.80108@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279235>

Michael J Gruber venit, vidit, dixit 08.10.2015 10:43:
> Michael J Gruber venit, vidit, dixit 08.10.2015 10:15:
>> James McCoy venit, vidit, dixit 08.10.2015 07:01:
> ...
>> [No, this does not alleviate my dislike for the commit signature
>> implementation, and I have not checked the patch - the test looks good
>> to me, though.]
> 
> OK, now grumpy ol' Mike actually tested the patch with all our tests
> that filter-branch something. All is good, and the new test catches the
> regression when run without the patch.
> 
> I do think that the parser still has a problem that it had before
> already: it does not distinguish between an empty line and an all white
> space line (or else we didn't have a problem here at all).
> 
> In that sense, the patch is wrong, it does not correct the parser
> deficiency. But it alleviates it for the special case of embedded
> signatures, which currently is the only exceptional case that I am aware
> of. It's not guaranteed to stay like that, of course. So maybe, one
> should amend the commit message by saying that.
> 
> Michael
> 

... or do the right thing:


diff --git i/git-filter-branch.sh w/git-filter-branch.sh
index 5777947..27c9c54 100755
--- i/git-filter-branch.sh
+++ w/git-filter-branch.sh
@@ -377,7 +377,7 @@ while read commit parents; do
 	fi

 	{
-		while read -r header_line && test -n "$header_line"
+		while IFS='' read -r header_line && test -n "$header_line"
 		do
 			# skip header lines...
 			:;


Not tested for POSIX etc., maybe we need a bare IFS inside a {} block
instead. In any case, we need to tell read not to split by words.

Michael
