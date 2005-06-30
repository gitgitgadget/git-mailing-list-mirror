From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: "git-send-pack"
Date: Thu, 30 Jun 2005 14:55:08 -0700
Message-ID: <42C46A3C.1070104@zytor.com>
References: <Pine.LNX.4.21.0506301651250.30848-100000@iabervon.org> <Pine.LNX.4.58.0506301412470.14331@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 23:48:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do6ta-0006fc-3d
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 23:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263054AbVF3Vzs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 17:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbVF3Vzs
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 17:55:48 -0400
Received: from terminus.zytor.com ([209.128.68.124]:19409 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263054AbVF3Vzj
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 17:55:39 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j5ULtDnp020484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 30 Jun 2005 14:55:13 -0700
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506301412470.14331@ppc970.osdl.org>
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.7 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

It seems to me that git always defines a DAG of objects, such that if 
you have a list of terminals (defined as objects not referenced by other 
objects), you can, given access to the same objects, figure out all 
intervening objects.

The tricky bit becomes finding the DAG both sides have in common with as 
little traffic as possible.

For producing minimum network traffic, I think something like this would 
work:

a) The sender sends a list of its terminals to the receiver.

b) The receiver sends a list of nodes it needs, plus a list of all its 
own meta-terminals, obtained by pruning its own DAG according to the 
terminals list of the sender.

c) This may have to be performed iteratively?  I need to sit down and 
work out the exact algorithm for all cases, including branch trees and 
multi-rooted DAGs.

d) Once the sender knows the subset of its own DAG available to the 
receiver, it can transmit either all objects that it has the sender does 
not, or all objects on the path to one or more specific objects (e.g. HEAD.)

	-hpa
