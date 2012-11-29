From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git describe not matching git log
Date: Thu, 29 Nov 2012 15:06:43 +0100
Message-ID: <50B76BF3.1090104@drmicha.warpmail.net>
References: <CAAXzdLWNb7E1qincviX5y_uEsT71bbepuUtLR7Q_+Exm8Od6yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Steven Penny <svnpenn@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 15:07:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te4lY-0005n7-Qu
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 15:07:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469Ab2K2OGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 09:06:45 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:49523 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752364Ab2K2OGo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Nov 2012 09:06:44 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id C479621880;
	Thu, 29 Nov 2012 09:06:43 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 29 Nov 2012 09:06:43 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=6/vca09OweCyxYqfALbQK7
	OUBdY=; b=czkMKjbaGcAI40hVTFkqjGY0v0oYEWzumdztWVDhuYwEWdktCK9eZa
	3uivyeiBzQC9Xko+q0bXxrE4n+XbJj9yW5F7joKyaYpAxFmIO0QPX06Tg6pfW8sn
	C6Yx6YNs3SO0KBWfwi4lKq0MczlDyvbdvXw2md9Nk2C0JM9YBlWlM=
X-Sasl-enc: th4sApASeUCCOzQ1STnY+Uhg8LNGfR7OiRNeYubRMkYC 1354198003
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 2EFB148279B;
	Thu, 29 Nov 2012 09:06:43 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <CAAXzdLWNb7E1qincviX5y_uEsT71bbepuUtLR7Q_+Exm8Od6yw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210835>

Steven Penny venit, vidit, dixit 29.11.2012 10:04:
> It seems "git describe" is not matching "git log" as detailed in the help, in
> some cases. From git describe --help
> 
>   [torvalds@g5 git]$ git describe parent
>   v1.0.4-14-g2414721
> 
>   The number of additional commits is the number of commits which would
>   be displayed by "git log v1.0.4..parent".
> 
> GOOD
> 
>   $ git clone git://github.com/antirez/redis.git
> 
>   $ cd redis
> 
>   $ git describe unstable
>   with-deprecated-diskstore-1050-g7383c3b
> 
>   $ git log --oneline with-deprecated-diskstore..unstable | wc
>      1050   11779   78709
> 
> BAD
> 
>   $ git clone git://github.com/git/git.git
> 
>   $ cd git
> 
>   $ git describe master
>   v1.8.0.1-264-g226dcb5
> 
>   $ git log --oneline v1.8.0.1..master | wc
>       260    1650   14154
> 

This is due to date skew: git-describe uses "insert_by_date" when it
traverses the dag, and this can go wrong.

Interestingling, this seems to get fixed by using Jeff's generation
numbers and "insert_by_generation" instead, so it does seem go wrong for
226dcb5~60 or so. git-describe's logic is a bit convoluted and may
depend on how we insert when generation numbers are the same... Have to
do more testing.

Michael
