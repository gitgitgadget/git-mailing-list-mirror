From: David Miller <davem@davemloft.net>
Subject: Re: Git and GCC
Date: Mon, 10 Dec 2007 01:57:49 -0800 (PST)
Message-ID: <20071210.015749.204978503.davem@davemloft.net>
References: <20071207063848.GA13101@coredump.intra.peff.net>
	<9e4733910712062310s30153afibc44a5550fd9ea99@mail.gmail.com>
	<20071207.045329.204650714.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, nico@cam.org, dberlin@dberlin.org,
	harvey.harrison@gmail.com, ismail@pardus.org.tr, gcc@gcc.gnu.org,
	git@vger.kernel.org
To: jonsmirl@gmail.com
X-From: git-owner@vger.kernel.org Mon Dec 10 10:58:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1fOu-0008MF-CW
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 10:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbXLJJ5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 04:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752461AbXLJJ5v
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 04:57:51 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:59407
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752286AbXLJJ5u (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Dec 2007 04:57:50 -0500
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 2BC07C8C17E;
	Mon, 10 Dec 2007 01:57:50 -0800 (PST)
In-Reply-To: <20071207.045329.204650714.davem@davemloft.net>
X-Mailer: Mew version 5.2 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67697>

From: David Miller <davem@davemloft.net>
Date: Fri, 07 Dec 2007 04:53:29 -0800 (PST)

> I should run oprofile...

While doing the initial object counting, most of the time is spent in
lookup_object(), memcmp() (via hashcmp()), and inflate().  I tried to
see if I could do some tricks on sparc with the hashcmp() but the sha1
pointers are very often not even 4 byte aligned.

I suspect lookup_object() could be improved if it didn't use a hash
table without chaining, but I can see why 'struct object' size is a
concern and thus why things are done the way they are.

samples  %        app name                 symbol name
504      13.7517  libc-2.6.1.so            memcmp
386      10.5321  libz.so.1.2.3.3          inflate
288       7.8581  git                      lookup_object
248       6.7667  libz.so.1.2.3.3          inflate_fast
201       5.4843  libz.so.1.2.3.3          inflate_table
175       4.7749  git                      decode_tree_entry
 ...

Deltifying is %94 consumed by create_delta(), the rest is completely
in the noise.

samples  %        app name                 symbol name
10581    94.8373  git                      create_delta
181       1.6223  git                      create_delta_index
72        0.6453  git                      prepare_pack
55        0.4930  libc-2.6.1.so            loop
34        0.3047  libz.so.1.2.3.3          inflate_fast
33        0.2958  libc-2.6.1.so            _int_malloc
22        0.1972  libshadow.so             shadowUpdatePacked
21        0.1882  libc-2.6.1.so            _int_free
19        0.1703  libc-2.6.1.so            malloc
 ...
