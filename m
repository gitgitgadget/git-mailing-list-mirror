From: Max Horn <max@quendi.de>
Subject: Re: [PATCH v5 15/15] fast-export: don't handle uninteresting refs
Date: Wed, 21 Nov 2012 23:30:01 +0100
Message-ID: <0F47AA24-F5B6-4197-8D74-6DD32E253856@quendi.de>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com> <1352642392-28387-16-git-send-email-felipe.contreras@gmail.com> <CAMP44s0WH-P7WY4UqhMX3WdrrSCYXUR9yCgsUV+mzLOCK5LkHQ@mail.gmail.com> <7vd2z7rj3y.fsf@alter.siamese.dyndns.org> <20121121041735.GE4634@elie.Belkin> <7vfw43pmp7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 22:54:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbeih-0003Ws-LM
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 22:54:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932778Ab2KVVxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 16:53:50 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:43548 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932777Ab2KVVxs convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 16:53:48 -0500
Received: from ip-178-200-227-112.unitymediagroup.de ([178.200.227.112] helo=[192.168.178.27]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1TbIny-0004yM-JB; Wed, 21 Nov 2012 23:30:03 +0100
In-Reply-To: <7vfw43pmp7.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1353621228;0954f5e9;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210214>

On 21.11.2012, at 06:08, Junio C Hamano wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
>> Never mind that others have said that that's not the current interface
>> (I don't yet see why it would be a good interface after a transition,
>> but maybe it would be).  Still, hopefully that clarifies the intended
>> meaning.
> 
> Care to explain how the current interface is supposed to work, how
> fast-export and transport-helper should interact with remote helpers
> that adhere to the current interface, and how well/correctly the
> current implementation of these pieces work?

Yes, please!


> 
> What I am trying to get at is to see where the problem lies.  Felipe
> sees bugs in the aggregated whole.  Is the root cause of the problems
> he sees some breakages in the current interface?  Is the interface
> designed right but the problem is that the implementation of the
> transport-helper is buggy and driving fast-export incorrectly?  Or is
> the implementation of the fast-export buggy and emitting wrong results,
> even though the transport-helper is driving fast-export correctly?
> Something else?
> 
> I see Felipe keeps repeating that there are bugs, and keeps posting
> patches to change fast-export, but I haven't seen a concrete "No,
> the reason why you see these problems is because you are not using
> the interface correctly; the currrent interface is fine.  Here is
> how you can fix your program" from "others".

I was wondering about the same, actually... Moreover, I started to try to understand more about this, but found this a bit difficult. Apparently I am primarily supposed to learn about remote helpers by reverse engineering the (sparsely commented, if at all) existing ones. The fact that remote helpers can implement different subsets of the feature spectrum complicates this further. 

Overall, my impression is that there are two kinds of remote helpers:

1) Some are git-to-git helpers, which allow access to another git repos via some intermediate media / protocol (via http, ssh, ...). Those use either connect, or fetch+push. They do not need marks, because they can use the git sha1s. Examples (together with the capabilities they claim to implement):

- remote-curl: fetch, option, push
- remote-ext: connect
- remote-fd: connect


2) Some are interfaces to foreign systems (bzr, hg, mediawiki, ...). They cannot use sha1s and must use marks (at least that is how I understand felipe's explanation). These tools use import combined with either export, or push. Examples:

- git-remote-mediawiki: import, push, refspec
    (its capabilities command also prints "list", but that seems to be a bug?)
- git-remote-hg: import, export, refspec, import-marks, export-marks
    (both the msysgit one and felipe's
- git-remote-bzr: import, push
    (the one from https://github.com/lelutin/git-remote-bzr)
- git-remote-bzr (felipe's): import, export, refspec, *import-marks, *export-marks
    (but why the * ?)


Does that sound about right? If so, can somebody give me a hint when a type 2 helper would use "export" and when "push"?

And while I am at it: git-remote-helpers.txt does not mention the "export", "import-marks" and "export-marks" capabilities. Could somebody who knows what they do look into fixing that? Overall, that doc helped me a bit, but it is more a reference to somebody who already understands in detail how remote helpers work, and who just wants to look up some specific detail :-(. Some hints on when to implement which capabilities might be useful (similar to the "Tips and Tricks" section in git-fast-import.txt).

As it is, felipe's recent explanation on why he thinks marks are essential for remote-helpers (I assume he was only referring to type 2 helpers, though) was one of the most enlightening texts I read on the whole subject so far (then again, I am fairly new to this list, so I may have missed lots of past goodness). Anyway, it would be nice if this could be augmented by "somebody from the other camp" ;).


Cheers,
Max
