Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BACED201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 17:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbdBXRjp (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 12:39:45 -0500
Received: from pmta2.delivery5.ore.mailhop.org ([54.186.218.12]:17098 "EHLO
        pmta2.delivery5.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751403AbdBXRjm (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Feb 2017 12:39:42 -0500
X-Greylist: delayed 963 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Feb 2017 12:39:42 EST
X-MHO-User: eaab3a89-fab5-11e6-b3c2-c9f38144898e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Originating-IP: 173.50.81.193
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from io (unknown [173.50.81.193])
        by outbound2.ore.mailhop.org (Halon) with ESMTPSA
        id eaab3a89-fab5-11e6-b3c2-c9f38144898e;
        Fri, 24 Feb 2017 17:23:12 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id 5C08280202;
        Fri, 24 Feb 2017 17:23:35 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io 5C08280202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1487957015;
        bh=/xSaJwAvHklCigOckJHlKbbtic5QVfZpHi1Qf4DZhn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ZDuTS2ODZ7f+ee7AxV6tENV5q0uK+t7ruaIeMh5TmUqNjitIkq8FcL1AYqpei5VWa
         TvxdLvJ7NLxUSDBNvRgValfpcNffIgqoWQ7wd5If3+Awd4bRbx+YolQfPLjiYsPCAr
         eyG5yeePW7lVJIDoL8RwfkigKu+7nw0/0g5GKfygk9INZX+iCbVMQ983pYdkkNi423
         obyNZnXCwgcY6Ce7+ATutoLA4NmdIdx8D6iVJtAqMKld/JY5IZ86Wx2Ypf+pcfq64L
         wcI21jIwZGaNsmrv2+iSIYgxd+DZNSAFdfYv3YNWKwNuu0+TpmQcfyfMccWNJ6suIO
         0R3bMH2KGDrcA==
Date:   Fri, 24 Feb 2017 17:23:35 +0000
From:   Jason Cooper <git@lakedaemon.net>
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc:     Joey Hess <id@joeyh.name>, git@vger.kernel.org
Subject: Re: SHA1 collisions found
Message-ID: <20170224172335.GG11350@io.lakedaemon.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <22704.19873.860148.22472@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22704.19873.860148.22472@chiark.greenend.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ian,

On Fri, Feb 24, 2017 at 03:13:37PM +0000, Ian Jackson wrote:
> Joey Hess writes ("SHA1 collisions found"):
> > https://shattered.io/static/shattered.pdf
> > https://freedom-to-tinker.com/2017/02/23/rip-sha-1/
> > 
> > IIRC someone has been working on parameterizing git's SHA1 assumptions
> > so a repository could eventually use a more secure hash. How far has
> > that gotten? There are still many "40" constants in git.git HEAD.
> 
> I have been thinking about how to do a transition from SHA1 to another
> hash function.
> 
> I have concluded that:
> 
>  * We can should avoid expecting everyone to rewrite all their
>    history.

Agreed.

>  * Unfortunately, because the data formats (particularly, the commit
>    header) are not in practice extensible (because of the way existing
>    code parses them), it is not useful to try generate new data (new
>    commits etc.) containing both new hashes and old hashes: old
>    clients will mishandle the new data.

My thought here is:

 a) re-hash blobs with sha256, hardlink to sha1 objects
 b) create new tree objects which are mirrors of each sha1 tree object,
    but purely sha256
 c) mirror commits, but they are also purely sha256
 d) future PGP signed tags would sign both hashes (or include both?)

Which would end up something like:

  .git/
    \... #usual files
    \objects
      \ef
        \3c39f7522dc55a24f64da9febcfac71e984366
    \objects-sha2_256
      \72
        \604fd2de5f25c89d692b01081af93bcf00d2af34549d8d1bdeb68bc048932
    \info
      \...
    \info-sha2_256
      \refs #uses sha256 commit identifiers

Basically, keep the sha256 stuff out of the way for legacy clients, and
new clients will still be able to use it.

There shouldn't be a need to re-sign old signed tags if the underlying
objects are counter-hashed.  There might need to be some transition
info, though.

Say a new client does 'git tag -v tags/v3.16' in the kernel tree.  I would
expect it to check the sha1 hashes, verify the PGP signed tag, and then
also check the sha256 counter-hashes of the relevant objects.

thx,

Jason.
