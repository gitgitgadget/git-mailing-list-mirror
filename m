From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Private/public branches/repos workflow
Date: Thu, 05 May 2011 21:10:51 -0700
Message-ID: <7vk4e44gfo.fsf@alter.siamese.dyndns.org>
References: <BANLkTi=TLeePH0JDvnE0XPiCzXFxid9BWQ@mail.gmail.com>
 <7v4o598164.fsf@alter.siamese.dyndns.org>
 <BANLkTimggn-E+JsXp78_a2P3eWku3oTSbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jerome Martin <tramjoe.merin@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 06:11:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QICNf-0002WB-0u
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 06:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356Ab1EFELA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 00:11:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58230 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab1EFEK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 00:10:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 132495B86;
	Fri,  6 May 2011 00:13:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=K/0CM66piOGLY0RaIl+2FMTAK7E=; b=RQG1dL94m9eKW667Mows
	R3qs43trU1rlUJj5Kba5zAsjxaHqqI1ynIGGDCyI60FBM1Zq+bh68OuE2nsac04z
	b6uvN0z/kwnxlyilktJduvNcUTvm9Iqm33mzE2Y0FKy6GmFDdI6DPsBp565nSewQ
	rDV2uLAJrzEZsU9O8mpcTEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=bYSjNM+yKkGWHLEkPAC6AwpvOZorFTn5xfbCQNnq0Ly9zb
	Jnp8K87So3KE34xvCi9vz9sqpWd3m0Z6kTSu7giEsUHkFQj6xI8aFef/z8uzczp0
	IWPrKXNzqMVk2QxQepTaebsg9WFYlxBtDNAps73pI5OTQtN2Cy3v9B3UM6M9o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DB7A35B85;
	Fri,  6 May 2011 00:12:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C2D345B84; Fri,  6 May 2011
 00:12:56 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 20FA8E42-7797-11E0-BE12-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172934>

Jerome Martin <tramjoe.merin@gmail.com> writes:

> Could you tell me how you would see usage of rebasing inside the
> workflow you describe ? I am thinking about features (mistakenly)
> implemented on top of the private branch that need later to be release
> in the public branch. Can this be the shortcut to avoid lengthy
> cherry-picks ?

Mistakes and changes of plans can happen, but it's not a big deal.

In the git project itself, even the "master" branch that corresponds to
your "private" branch is managed with topic branch workflow, so it is
entirely possible that a topic that was originally meant only for the next
release turns out to be better backported to the maintenance track.

If you have a private "feature-A" topic with many commits:

                     O   public
                      \
 ...---x---x---x---X---S  private
                        \
                         a---b---...---z  feature-A

and later it turns out that it is better to release them also to the
public, instead of cherry-picking the commits to the public, you could at
that point do something like this:

    $ git checkout -b public-feature-A feature-A
    $ git rebase --onto public private

which will first create a new branch "public-feature-A" that points at the
same tip of "feature-A", and then rebases the commits on that branch that
were made since the topic was forked from "private" on top of the tip of
the "public" branch, resulting in:

                       a'--b'--...--z' public-feature-A
                      /
                     O   public
                      \
 ...---x---x---x---X---S  private
                        \
                         a---b---...---z  feature-A

and then you may choose when to merge that to the "public" branch.
By the time you do this, perhaps the original "feature-A" may have already
been merged to "private" after fully tested and audited, like this:

                       a'--b'--...--z' public-feature-A
                      /
                     O   public
                      \
 ...---x---x---x---X---S---x---x---x-----*  private
                        \               / 
                         a---b---...---z  feature-A

and then after you merged "public-feature-A" to "public":

                       a'--b'--...--z' public-feature-A
                      /              \  
                     O---o---...---o--*   public
                      \
 ...---x---x---x---X---S---x---...---x---*  private
                        \               / 
                         a---b---...---z  feature-A

merging "public" back to "private" hopefully may have too many conflicts
between the feature-A and public-feature-A branches, as they are supposed
to be patch equivalent, to produce this:


                       a'--b'--...--z' public-feature-A
                      /              \  
                     O---o---...---o--*---.   public
                      \                     \
 ...---x---x---x---X---S---x---...---x---*---*   private
                        \               / 
                         a---b---...---z  feature-A

After this you could even garbage collect the two topic branches ;-).
