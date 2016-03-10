From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: git branch -D can be used to delete branch which is currently checked out
Date: Thu, 10 Mar 2016 09:40:10 -0800
Message-ID: <xmqqvb4udyf9.fsf@gitster.mtv.corp.google.com>
References: <CE5AE06C-0909-414E-B901-7CCF3A259465@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Marcus Kida <marcus.kida@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 18:40:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae4ZR-0003QT-Tk
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 18:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754743AbcCJRkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 12:40:16 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55161 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754466AbcCJRkO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 12:40:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D3AF5498CE;
	Thu, 10 Mar 2016 12:40:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i/9FP04Gg/7ZXeeesp7FwoZSG24=; b=FQRvMD
	VpnuGWU1f+a0WFWxG+jxSTXfR/jnn/aFJyszEC3qg7hlfpO7rgUcAU5vUIOOTMPL
	D0hvaVk0X+7lVjKancU3RQeU3wUpjGNROfs3HqwsGeEtSRFS4Ixjz7kE/r48f79m
	6gZtFb1e1eulmfVG/kVnpdKmur7XTOLSyXC8I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pKDrrWWtBsrUDAfKu5Yd/ajBOJMJMWtb
	Vj5rnQ3YzqQY5UN1BO3U/5s0TTMNhc3Vdce1h0onLaSqD4ALV2IhyEYyK7liHdjl
	+w0TKSGHTv2vifMatvJXmUu5bfScrMRtSTpAb7HNUa/iAWLqllnDFMjiPcdKRvf7
	BrmGsg0VGPY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CBC21498CD;
	Thu, 10 Mar 2016 12:40:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 28D6C498CC;
	Thu, 10 Mar 2016 12:40:12 -0500 (EST)
In-Reply-To: <CE5AE06C-0909-414E-B901-7CCF3A259465@gmail.com> (Marcus Kida's
	message of "Thu, 10 Mar 2016 19:20:21 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 241451D4-E6E7-11E5-A801-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288628>

Marcus Kida <marcus.kida@gmail.com> writes:

> Testes on: 
>
> Mac OS X 10.11.3 (El Capitan) using Git 2.6.4
>
> Issue:
>
> git branch -D can be used to delete branch which is currently checked out

There are other limitations a filesystem that is incapable of
differentiating two files with names that are only different in case
imposes on your use of Git, e.g.

 - "git fetch origin", when the origin repository has two tags 'v1'
   and 'V1', may not let you have both of these tags locally;

 - "git checkout Another", when the branch you have is 'another',
   may check it out instead of complaining (replace "checkout" with
   any other command that let you use a refname to specify an object).

It is a possibility to teach the files backend of refs API that some
filesystems are case insensitive and do something special about them,
but I think in the longer term a more productive solution would be
to use the upcoming "pluggable ref backend" subsystem and either

 - use a backend that is not the "files" backend (e.g. lmdb backend,
   or the tree-object based backend);

 - add a variant of "files" backend but encodes the refnames in a
   way that is safe on case insensitive filesystems.

That way, those on platforms with case insensitive filesystems do
not have to be artificially limited.  Git is about working together
with people potentially on other systems, and "on this system you
cannot have 'master' and 'Master' at the same time, because we have
a patch to case-fold the refnames" would not be a good longer term
solution.
