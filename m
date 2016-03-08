From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Adding RFC 3161 timestamps to git tags
Date: Tue, 8 Mar 2016 14:28:54 +0100
Message-ID: <56DED396.5070009@drmicha.warpmail.net>
References: <9bf0ad940a5ce20c0c3742a3dfca70f8.squirrel@faumail.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: i4passt@cs.fau.de, phillip.raffeck@fau.de,
	Junio C Hamano <gitster@pobox.com>
To: Anton Wuerfel <anton.wuerfel@fau.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 08 14:29:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adHh9-00022l-66
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 14:29:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbcCHN27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 08:28:59 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:50571 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750843AbcCHN26 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Mar 2016 08:28:58 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 2896E20F32
	for <git@vger.kernel.org>; Tue,  8 Mar 2016 08:28:57 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Tue, 08 Mar 2016 08:28:57 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=tQ1KJhyZQXRUcetrPNeY3Eyq/Rc=; b=E8/R8I
	KC5JBswskqndzvTAFBxxNc9z1s07dBEDkyShWhLy0LBfMFpjDacD0QGNHdjTU3R3
	Z3Iqt8BJF4x8rE5sTGlNlfxZRu9IZHeZqt2pVjflKt4tulM0e4YMVnW1vrauI82M
	lFdq3jCiUq0WChakgn08PQB2ryHkOn8O0SErI=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=tQ1KJhyZQXRUcet
	rPNeY3Eyq/Rc=; b=lr2GQruBVEnW9qttmflvkkbSOAH2P2Ohdcjj6bHlqFvKz+P
	T7QnwMSeBr7KqMOZFXbujupeeNvKosoW7dm2hj/9f14sq8sHJLNbySbKPyH2s1Hq
	VlAImZY3HdGTQV3OpbMTY9isDTuVJQ9jA8UQCidoAv6QjeQHvpih5GZPjIiY=
X-Sasl-enc: ggOWMKuGlxgDL8Eu/yarXMusRE49YKm/gyfMLFGb3ruW 1457443736
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 41988680169;
	Tue,  8 Mar 2016 08:28:56 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <9bf0ad940a5ce20c0c3742a3dfca70f8.squirrel@faumail.uni-erlangen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288433>

Anton Wuerfel venit, vidit, dixit 07.03.2016 15:15:
> Hello,
> 
> as part of an university project we plan to implement time stamp
> signatures according to RFC 3161. This enables users to create and verify
> cryptographic time stamp signatures to prove that a commit existed at a
> certain point in time.

Before talking about a specific header format (and, possibly, repeating
mistakes of the past) we should take a step back to exactly here: What
is the goal that you are trying to achieve?

"prove that a commit existed at a certain point in time" is a good
definition for that goal.

Based on our standing assumption that a commit SHA1 is unique, it is
sufficient to "prove that a SHA1 existed[was known] at a certain point
in time".

In particular, this does not need to take into account the DAG (beyond
what is determined through the SHA1) nor any prior timestamps.
Consequently, I don't think that warrants extending the object format in
any way - it is information in addition to what is in the DAG.

Also, it is conceivable that more than one user of the timestamp service
requests a timestamp for the same SHA1, and does so for a commit which
has children already, without wanting to (and without any intrinsic need
to) rewrite history.

To me, this means timestamps have no place in commit objects.

As for adding additional information to the DAG without altering it, we
have two means: tags and notes. Tags suffer from a "merge problem",
notes from a "transport" problem; for both of them you have to know how
to set up your refspecs.

So, I think a proper first step would be to make our "metadata handling"
(default notes refspec, merging) more use friendly, i.e. work out of the
box for the common use case (whatever that is).

That would serve timestamps well, and many other use cases.

> As a long-term goal, we would like to get this new feature accepted into
> upstream, so we are very interested in your opinions and suggestions for
> our approach described in the following.
> 
> We plan to add new command line options to git tag and call openssl
> similar to how "git tag -s" is calling gpg. The time stamp query generated
> by openssl will be sent to the time stamping authority via libcurl.
> Verification of timestamps will be possible via git verify-tag.
> 
> In order to store time stamp signatures, the file format for git tags
> needs to be extended. Similar to how gpg signatures are stored, we would
> store the signed time stamp responses in base64 surrounded by BEGIN and
> END tags:
> -----BEGIN RFC3161-----
> Issuer: [issuer-name]
> [time stamp response in base64]
> -----END RFC3161-----
> 
> We plan to offer git config options to configure, which timestamping
> authority to use and where trusted certificates are stored.
> 
> Regards,
> Phillip Raffeck
> Anton Wuerfel
> 
