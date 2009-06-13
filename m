From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] http.c: prompt for SSL client certificate password
Date: Fri, 12 Jun 2009 17:31:49 -0700
Message-ID: <7vk53h3rey.fsf@alter.siamese.dyndns.org>
References: <1243480563-5954-1-git-send-email-lodatom@gmail.com>
	<ca433830906111600n2d45b5bdg3fb6e7c0a537ec78@mail.gmail.com>
	<20090612084209.6117@nanako3.lavabit.com>
	<alpine.DEB.2.00.0906120943560.5566@yvahk2.pbagnpgbe.fr>
	<ca433830906121626q52c15f6cjdb91ffee1f2d8652@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Stenberg <daniel@haxx.se>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 02:32:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFHAl-0001K1-1y
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 02:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757986AbZFMAbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 20:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755090AbZFMAbs
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 20:31:48 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:46597 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714AbZFMAbs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 20:31:48 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090613003149.WNXW20430.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Fri, 12 Jun 2009 20:31:49 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 3CXp1c00E4aMwMQ03CXpRQ; Fri, 12 Jun 2009 20:31:49 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=ZkqYN0c8iNwA:10 a=Z2nhhV3jvI0A:10
 a=pGLkceISAAAA:8 a=-fFU1-8EK4uGshFYZh0A:9 a=8JyYGRHLt3Vq0k5-2TYV_Qf0Z7cA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <ca433830906121626q52c15f6cjdb91ffee1f2d8652@mail.gmail.com> (Mark Lodato's message of "Fri\, 12 Jun 2009 19\:26\:45 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121474>

Mark Lodato <lodatom@gmail.com> writes:

>> And for the libcurl not supporting this, I figure it _could_ be done by
>> simply letting libcurl prope the remote and see if it can access it without
>> a passphrase as that would then imply that isn't necessary.
>>
>> I'm not familiar enough with the code and architecture to deem how suitable
>> such an action would be.
>
> I don't think it is possible to check to see if it is encrypted from
> within git (without calling OpenSSL directly).

I think what Daniel is suggesting is to attempt making a test connection
(that does not have to have anything to do with the real object transfer)
without passphrase to see if it fails.  If it doesn't, you know you do not
need a passphrase to unlock the key/cert.

While I still think that kind of automated detection would be necessary in
the longer term (in other words, we do not necessarily have to have it in
the initial implementation that appears in our official release), until that
materializes, I think it is more prudent to follow the approach below.

>> <snip...> If you can't do that, probably you can introduce a config var that says
>> "this certificate is encrypted", and bypass your new code if that config var isn't set.

I think I've said this already in another message, but "I break your
working setup with my patch, but you can add this configuration to unbreak
it" should not be done lightly, certainly without a good reason.  And the
reason here as far as I can see is that the code chooses not to bother
with the autodetection of encryptedness of the cert/key.  So...
