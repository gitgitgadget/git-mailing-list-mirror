From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: Transparently encrypt repository contents with GPG
Date: Fri, 13 Mar 2009 14:56:22 +0100
Message-ID: <49BA6606.1070403@fastmail.fm>
References: <978bdee00903121419o61cd7a87rb55809796bd257d7@mail.gmail.com>	 <fabb9a1e0903121434u4a3d71bdi6277071f54557a7e@mail.gmail.com>	 <49BA39A1.9090203@drmicha.warpmail.net>	 <200903131215.49336.trast@student.ethz.ch> <fabb9a1e0903130417x36121bd5ya8b323e0a80bbd8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthias Nothhaft <matthias.nothhaft@googlemail.com>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 14:58:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li7to-0005TX-R2
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 14:58:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754335AbZCMN4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 09:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754148AbZCMN4j
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 09:56:39 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34208 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751852AbZCMN4i (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2009 09:56:38 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 7A3972EF65A;
	Fri, 13 Mar 2009 09:56:36 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 13 Mar 2009 09:56:36 -0400
X-Sasl-enc: o9n0lIv8VDK4J0vtrDxishokkNASnkBY4HGE3svpjRgP 1236952595
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3814815C92;
	Fri, 13 Mar 2009 09:56:34 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090313 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <fabb9a1e0903130417x36121bd5ya8b323e0a80bbd8f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113189>

Sverre Rabbelier venit, vidit, dixit 13.03.2009 12:17:
> Heya,
> 
> On Fri, Mar 13, 2009 at 12:15, Thomas Rast <trast@student.ethz.ch>
> wrote:
>> Not to mention that this makes most source-oriented features such
>> as diff, blame, merge, etc., rather useless.
> 
> I would assume that smudge takes care of this somehow, it'd seem
> like a rather useless feature otherwise :).

Sverre was being prophetic with the somehow. Here's a working setup
(though I still don't know why not to use luks):

In .gitattributes (or.git/info/a..) use

* filter=gpg diff=gpg

In your config:

[filter "gpg"]
        smudge = gpg -d -q --batch --no-tty
        clean = gpg -ea -q --batch --no-tty -r C920A124
[diff "gpg"]
        textconv = decrypt

This gives you textual diffs even in log! You want use gpg-agent here.

Now for Sverre's prophecy and the helper I haven't shown you yet: It
turns out that blobs are not smudged before they are fed to textconv!
[Also, it seems that the textconv config does allow parameters, bit I
haven't checked thoroughly.]

This means that e.g. when diffing work tree with HEAD textconv is called
twice: once is with a smudged file (from the work tree) and once with a
cleaned file (from HEAD). That's why I needed a small helper script
"decrypt" which does nothing but

#!/bin/sh
gpg -d -q --batch --no-tty "$1" || cat $1

Yeah, this assumes gpg errors out because it's fed something unencrypted
(and not encrypted with the wrong key) etc. It's only proof of concept
quality.

Me thinks it's not right that diff is failing to call smudge here, isn't it?

Michael
