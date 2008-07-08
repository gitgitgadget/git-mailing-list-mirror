From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] fix "git-submodule add a/b/c/repository"
Date: Mon, 07 Jul 2008 23:26:12 -0400
Message-ID: <4872DE54.5010804@gmail.com>
References: <20080701150025.GD5852@joyeux> <7vd4lro7ct.fsf@gitster.siamese.dyndns.org> <20080706161101.GB23385@jhaampe.org> <48711782.6090609@gmail.com> <20080707063424.GB5506@jhaampe.org> <4872CF86.5050702@gmail.com> <7v7ibxxfje.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sylvain Joyeux <sylvain.joyeux@dfki.de>,
	Lars Hjemli <hjemli@gmail.com>, Ping Yin <pkufranky@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 05:27:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG3rF-0003Ez-AL
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 05:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756044AbYGHD0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 23:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756043AbYGHD0P
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 23:26:15 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:59079 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755999AbYGHD0O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 23:26:14 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1684478wri.5
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 20:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=mUtA0xNlAD8JXzB4std9tXGtVhgrx2copsh8V0yYzm0=;
        b=N/7IzQqnU5igbRyNCTTlzpDq2Gth/Ov/FzklpUV3o3WwgS5rVh4/4jB2cPULeeTSGO
         il0IugN8RRzXUjeApIwPWqTU534+Ueb0VA3R2XQmgNiQIZjV2pNfbxg6flddcmMRdDls
         EIkvh3ipufyNazQsyzCs93olyH+pTTRepkIxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=UiOwiat5IIqEYP3rHAF8IBGl81Qdb3AbPD5W6NFU2dxWODBWL/fV7aZ/MIqPhAg2PB
         vIZPd/kOeA8ADosOJOM+Cb3KTpOKQS3czN4nDmhv06M9lG8lDzWVE/gvuDN6HovjdRJZ
         LM2j1hpZnPxmsFw+rFtlU03D/3fHpZgsphm5k=
Received: by 10.90.115.17 with SMTP id n17mr6209196agc.90.1215487573569;
        Mon, 07 Jul 2008 20:26:13 -0700 (PDT)
Received: from ?192.168.1.117? ( [71.246.235.165])
        by mx.google.com with ESMTPS id 6sm8812587ywp.3.2008.07.07.20.26.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Jul 2008 20:26:12 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <7v7ibxxfje.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87694>

Junio C Hamano wrote:
> I'd like to hear clarifications on two counts, please?
>  (1) If Sylvain wanted to have that appear at dir0/dir1/init not init,
>      would it have been sufficient to give that path twice (once for
>      <repository> and another for <path> parameter) to make things work as
>      expected?
>   
git-submodule really requires two arguments:

    $ git submodule add <URL> <relative-path-to-module-in-tree>

and supports two modes:

1) relative-path exists and is a valid repo: just add the module, it was 
created in tree, the user is expected to eventually push this to the 
given URL so other users will get this as normal. This exists to 
simplify the process of creating a repo to begin with.

2) relative-path doesn't exist: clone from the URL. This is the normal use.
submodule supports adding a module in one of two ways:

So,

    $ git submodule add   dir0/dir1/init   dir0/dir1/init

will add the repo, but also makes the repo its own origin. I don't think 
this makes sense.
>  (2) Is it generally considered a sane use case to specify an existing
>      repository inside the working tree of a superproject as a submodule
>      using "git submodule add" like Sylvain's example did?
>
>      I would have understood if the command were "git add dir0/dir1/init",
>      but I have this vague recolleciton that "git submodule add" is about
>      telling our repository about a submodule that comes from _outside_.
>
>
>   
Adding an existing in-tree repo, ala

 $ git submodule add <intended-URL> <path>

is there to ease the initial creation of a submodule. It can be created 
and registered in-tree, and later pushed to the server. This is sane, 
but is not the normal usage (makes sense only on creation).

Mark
