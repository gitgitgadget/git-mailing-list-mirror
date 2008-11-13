From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 1/9 v4] bisect: add "git bisect replace" subcommand
Date: Thu, 13 Nov 2008 17:41:07 +0100
Message-ID: <491C58A3.2000609@gnu.org>
References: <20081111063904.7da4df94.chriscool@tuxfamily.org> <7v8wrpyhhs.fsf@gitster.siamese.dyndns.org> <200811121515.48277.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Nov 13 17:42:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0fH1-0005ov-JF
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 17:42:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbYKMQlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 11:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbYKMQlM
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 11:41:12 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:38018 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbYKMQlL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 11:41:11 -0500
Received: by ey-out-2122.google.com with SMTP id 6so409268eyi.37
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 08:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=BbaJntOi2HUlYJ3+6NP5TouxsECNAcuXIIMxYaKbgLs=;
        b=VjCkEVfJZyTzqtIvnTE1BnuEpezr1U3BNNQqb8ShB+oUN5d/57Gd1AlghWb1EiQjh0
         yLqvxTUXkjUA1uAcUAza2hweShKtL0m+79ipIJK8tdX6adDV+yIsGgI/gLUqSEp+mo4C
         4OY7J+Wa06vNYMhi1cmvPBtcRKdahSe9piXj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=QqRM6+e+22t/Q8Ho8B7umva6M3PBhKhIWZuprdtR2OYgU1jw5S4R0N+xJgg68bLrgq
         /OjpP3IyYgyW9ZZGD1rfmVJNPyd5LYwUJGa4V32/DrXVUFCqLN80Q0KCNyCWULAKBQ07
         QWtadQwUuY+3OK9BgeOCSRrD82fdJIRdza20E=
Received: by 10.86.79.19 with SMTP id c19mr10081869fgb.66.1226594469537;
        Thu, 13 Nov 2008 08:41:09 -0800 (PST)
Received: from scientist-2.lan (89-96-108-150.ip12.fastwebnet.it [89.96.108.150])
        by mx.google.com with ESMTPS id e11sm1095733fga.9.2008.11.13.08.41.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 Nov 2008 08:41:08 -0800 (PST)
User-Agent: Thunderbird 2.0.0.17 (Macintosh/20080914)
In-Reply-To: <200811121515.48277.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100883>


> Of course it also depends on how often people use "git bisect", but it seems 
> that there are people out there bisecting very frequently and that these 
> people care very much about bisectability of the tree.

What about "git bisect cherry-pick COMMIT" which would do a "cherry-pick
-n" of COMMIT after every bisection unless COMMIT is in the ancestry of
the current revision?  So if you have to bisect between A and B, and you
know that a bug present between A and B was fixed by C, you could do

  git bisect good A
  git bisect bad B
  git bisect cherry-pick C

This would subsume Junio's proposal: users could also set up a few
special bisect/set-debug-to-1, bisect/remove-cflags-o2 and so on patches
that you could use for purposes other than ensuring known bugs are fixed.

Finally, you could have a [bisect] configuration section with entries
like "cherry-pick = BROKEN-SHA1 FIX-SHA1" and "git bisect" would apply
FIX-SHA1 automatically if the bisect tip were in BROKEN-SHA1..FIX-SHA1.

>> Things like paranoid update hook
>> needs to become very careful about refs/replace/ for security reasons,
>> but I think this would make the grafts much easier to use.
> 
> I agree that it would make grafts much easier to use (and would be very 
> security sensitive).

Not so much.  People with public servers could create refs/replace in
the server and give it 400 permissions, and/or git would refuse to
create the refs/replace directory, forcing users to create it manually
unless it is already in the server.

Paolo
