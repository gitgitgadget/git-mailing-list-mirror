From: Jonathon Mah <jmah@me.com>
Subject: Re: segmentation fault (nullpointer) with git log --submodule -p
Date: Thu, 24 Jan 2013 23:32:44 -0800
Message-ID: <FE6CC927-1915-4486-BBB8-4C109F7B5295@me.com>
References: <20130123143816.GA579@krypton.darkbyte.org> <20130123200222.GB19832@sigill.intra.peff.net> <510124F5.9090505@atlas-elektronik.com> <CACsJy8B9O=A26_=sv1JEYdtazsWa4khZkqpTgFSSTs_RGGPZqQ@mail.gmail.com> <51013FDD.5030004@atlas-elektronik.com> <CACsJy8CEofqi9S8-SDx_O+Ko0i56aRZ4KEJrVnbFum6zzsJrJg@mail.gmail.com> <20130124232721.GA16036@sigill.intra.peff.net> <7va9ry87a0.fsf@alter.siamese.dyndns.org> <7vzjzx7w01.fsf@alter.siamese.dyndns.org> <20130125055331.GC26524@elie.Belkin>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Duy Nguyen <pclouds@gmail.com>,
	=?iso-8859-1?Q?Stefan_N=E4we?= <stefan.naewe@atlas-elektronik.com>,
	Armin <netzverweigerer@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 08:33:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tydmq-0000dH-9U
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 08:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305Ab3AYHcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 02:32:52 -0500
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:57598 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751185Ab3AYHct convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 02:32:49 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AsIhABg0AlFHynyrPGdsb2JhbAANN4p+s2oDAQEBATiCUwEBBDo/EAsOOEMUBhOyT5NCkF1hA4hhoQw
Received: from c-71-202-124-171.hsd1.ca.comcast.net (HELO [192.168.120.29]) ([71.202.124.171])
  by ipmail04.adl6.internode.on.net with ESMTP; 25 Jan 2013 18:02:45 +1030
In-Reply-To: <20130125055331.GC26524@elie.Belkin>
X-Mailer: Apple Mail (2.1499)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214509>

Just to note, the proposals so far don't prevent a "smart-ass" function from freeing the buffer when it's called underneath the use/release scope, as in:

with_commit_buffer(commit); {
	fn1_needing_buffer(commit);
	walk_rev_tree_or_something();
	fn2_needing_buffer(commit);
} done_with_commit_buffer(commit);

walk_rev_tree_or_something() might need to read commits to do its thing, and it could still choose to free their buffers (as in rev-list.c finish_commit()). If those commits includes the one being "retained", the call to fn2 will still see NULL despite it being in a 'protected scope'.

Are the objections to using a reference count?



Jonathon Mah
me@JonathonMah.com
