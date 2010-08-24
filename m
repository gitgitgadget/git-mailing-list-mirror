From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t2017: redo physical reflog existance check
Date: Mon, 23 Aug 2010 23:03:47 -0500
Message-ID: <20100824040347.GA19817@burratino>
References: <1279763190-32757-1-git-send-email-erick.mattos@gmail.com>
 <7vlj93h120.fsf@alter.siamese.dyndns.org>
 <AANLkTilt5gx3Wj4eANfkIFm869Olns1rsMpCS81hS2BV@mail.gmail.com>
 <7vsk3bey1e.fsf@alter.siamese.dyndns.org>
 <AANLkTin76s-ONFuP+OWdxB5LJNf2D1Du+hKxB2s_WhTa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 06:06:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnkmW-00055U-Lr
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 06:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187Ab0HXEFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 00:05:47 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:50289 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752293Ab0HXEFi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 00:05:38 -0400
Received: by gwj17 with SMTP id 17so2393814gwj.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 21:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=MqKtawvF8C7eNOs1C97ORoaF9z1PTwSPajN35lXwFcE=;
        b=OO2vK7BPK4DJ65vNH4LfXWQqfOy0cx8RVYLXmTIBk6v8NeO8aFGMDAZtuhB/ZXYi9U
         kgu7c1p1M/w4ZXyQrsRo2p1wZN2r6iA0snrxJirL+s00JLv0hHqht6uRwWOoUp2O5+TS
         Bwvz81YkyYHDhrkzOTmCfaziVrncn77qdt7Ko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=i0OH8T2cgouTWoK1hS09fgu9pAN89iWiCgI1ZrqD+wYXN3wgDWwpCkpmYbT4Gv37Po
         WAX5H1X6acgvuGL1AVCOvupxWNXsMX5RwlboI4aZeaOVkc+Jzgt/UKGAU4HOLzgkULx7
         HLMy3euVWAI6Hvv4j0JtePzvRaE4R+INhnYw8=
Received: by 10.151.43.17 with SMTP id v17mr5984198ybj.431.1282622735288;
        Mon, 23 Aug 2010 21:05:35 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id q31sm8051674ybk.13.2010.08.23.21.05.33
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 21:05:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTin76s-ONFuP+OWdxB5LJNf2D1Du+hKxB2s_WhTa@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154283>

Hi Erick,

First, thanks for checkout --orphan.  I was a skeptic but now that I
have seen it being used for things similar to "going open source" (and
the related "simplifying logs while working privately on a patch
series") it looks to be a pretty nice tool.

Erick Mattos wrote:

> I don't see a need for so much reluctance: "test -f" is not a taboo
> inside a script in t folder and the added tests don't change anything
> about the design and implementation which IMHO is well fit.

The principle (though we do not always adhere to it) is that test
scripts should pass or fail based only on advertised behavior, not
implementation details.  That way, _later_ any person who wants to
improve the implementation will not be impeded by tests.

The behavior that "test -f .git/logs/refs/heads/eta" checks for is not
part of the advertised behavior and though it does affect the
observable behavior, it is not immediately obvious how.  Wouldn't it
be best if the test described that advertised behavior while checking
for it?

e.g.:

	git config core.logallrefupdates false &&
	test_when_finished "git config core.logallrefupdates true" &&

  	git checkout master &&
  	git checkout -l --orphan eta &&
	test_must_fail git rev-parse --verify eta@{0} &&

	test_tick &&
	git commit -m "initial commit" &&
	git rev-parse --verify eta@{0}

Happily, I am not the man in charge, so feel free to take my words
at whatever value you choose. :)

Regards,
Jonathan
